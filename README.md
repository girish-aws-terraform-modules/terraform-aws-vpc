# AWS VPC TERRAFORM MODULE
--------------------------------------------------------------------------------------------------------------


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nats](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.ig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client"></a> [client](#input\_client) | Client Tags for resources | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Env Tags for resources | `string` | n/a | yes |
| <a name="input_priv-subnets"></a> [priv-subnets](#input\_priv-subnets) | list of values to assign to subnets | <pre>map(object({<br/>    name              = string<br/>    address_prefix    = string<br/>    availability_zone = string<br/>  }))</pre> | n/a | yes |
| <a name="input_pub-subnets"></a> [pub-subnets](#input\_pub-subnets) | list of values to assign to subnets | <pre>map(object({<br/>    name              = string<br/>    address_prefix    = string<br/>    availability_zone = string<br/>  }))</pre> | n/a | yes |
| <a name="input_tag"></a> [tag](#input\_tag) | Details about the VPC. | `map(string)` | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | Details about the VPC. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ig"></a> [ig](#output\_ig) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
