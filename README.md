# Terraform AWS ECS Module

This module will create and deploy a ECS Cluster

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs"></a> [ecs](#module\_ecs) | terraform-aws-modules/ecs/aws | n/a |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_alb_listener.endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_target_group.target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_cloudwatch_log_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_ecs_service.backend_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_service.main_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ecs_task_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_route53_record.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.service_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_prefix"></a> [alb\_prefix](#input\_alb\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create things in. | `string` | `"us-east-1"` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | n/a | `string` | `"nginx:alpine"` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | n/a | `string` | `"app"` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | n/a | `number` | `8080` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | n/a | `number` | `1024` | no |
| <a name="input_ecs_client_prefix"></a> [ecs\_client\_prefix](#input\_ecs\_client\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_ecs_launch_type"></a> [ecs\_launch\_type](#input\_ecs\_launch\_type) | The launch type of the ECS Service | `string` | `"FARGATE"` | no |
| <a name="input_ecs_log_group_name"></a> [ecs\_log\_group\_name](#input\_ecs\_log\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_ecs_role_arn"></a> [ecs\_role\_arn](#input\_ecs\_role\_arn) | In case you want to run the ECS Service with a different role than the default one | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_expose"></a> [expose](#input\_expose) | n/a | `bool` | `true` | no |
| <a name="input_host"></a> [host](#input\_host) | n/a | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `number` | `2048` | no |
| <a name="input_role_prefix"></a> [role\_prefix](#input\_role\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_service_desired"></a> [service\_desired](#input\_service\_desired) | Desired numbers of instances in the ecs service | `number` | `1` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_url"></a> [alb\_url](#output\_alb\_url) | n/a |
| <a name="output_backend_url"></a> [backend\_url](#output\_backend\_url) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_containers"></a> [containers](#output\_containers) | n/a |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | n/a |
| <a name="output_task_definition_family"></a> [task\_definition\_family](#output\_task\_definition\_family) | n/a |
