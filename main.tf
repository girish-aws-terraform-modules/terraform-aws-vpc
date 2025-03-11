resource "aws_vpc" "vpc" {
    cidr_block = lookup(var.vpc, "cidr_block")
    enable_dns_hostnames = lookup(var.vpc, "enable_dns_hostnames")

    tags = merge(
        var.tag,
        {
            "Name" = "${var.client}-VPC-${var.environment}"
        }
    )
}

resource "aws_subnet" "public" {
    for_each = var.pub-subnets
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value.address_prefix
    availability_zone = each.value.availability_zone

    tags = merge(
        var.tag,
        {
            "Name" = "${var.client}-${each.value.name}-${var.environment}"
        }

    )
}

resource "aws_subnet" "private" {
    for_each = var.priv-subnets
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value.address_prefix
    availability_zone = each.value.availability_zone

    tags = merge(
        var.tag,
        {
            "Name" = "${var.client}-${each.value.name}-${var.environment}"
        }

    )
}

# INTERNET GATEWAY so that public subnets can access the internet
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tag,
    {
      "Name" = "${var.client}-IG-${var.environment}"
    }
  )
}

# NAT GATEWAY Elastic IP so that private subnets can use outbound internet connections. 
resource "aws_eip" "nats" {
  for_each   = var.priv-subnets
  domain     = "vpc"
  depends_on = [aws_internet_gateway.ig]

  tags = merge(
    var.tag,
    {
      "Name" = "${var.client}-NAT-EIP-${each.value.name}-${var.environment}"
    }
  )
}

#NAT GW
resource "aws_nat_gateway" "nat" {
  depends_on    = [aws_internet_gateway.ig]
  for_each      = var.priv-subnets
  subnet_id     = aws_subnet.private[each.key].id
  allocation_id = aws_eip.nats[each.key].id

  tags = merge(
    var.tag,
    {
      "Name" = "${var.client}-NAT-GW-${each.value.name}-${var.environment}"
    }
  )
}

# Routing tables to route traffic for Private Subnet
resource "aws_route_table" "private" {
  for_each = var.priv-subnets
  vpc_id   = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[each.key].id
  }

  tags = merge(
    var.tag,
    {
      "Name" = "${var.client}-PRIV-ROUTE-${each.value.name}-${var.environment}"
    }
  )
}

# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "public" {
  for_each = var.pub-subnets
  vpc_id   = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = merge(
    var.tag,
    {
      "Name" = "${var.client}-PUB-ROUTE-${each.value.name}-${var.environment}"
    }
  )
}

# Route table associations for Private Subnets
resource "aws_route_table_association" "private" {
  for_each       = var.priv-subnets
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_route_table_association" "public" {
  for_each       = var.pub-subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}