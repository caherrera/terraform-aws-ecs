variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "expose" {
  type    = bool
  default = true
}
variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "role_prefix" {
  type    = string
  default = null
}
variable "alb_prefix" {
  type    = string
  default = null
}
variable "zone_id" {
  type = string
}
variable "host" {
  type    = string
  default = "api"
}
variable "container_name" {
  type    = string
  default = "app"
}
variable "container_port" {
  type    = number
  default = 8000
}

variable "ecs_host_port" {
  type    = number
  default = null
}

variable "alb_port" {
  type    = number
  default = null
}

variable "alb_logs" {
  type    = bool
  default = false
}

variable "ecs_prefix" {
  type    = string
  default = null
}
variable "ecs_log_group_name" {
  type    = string
  default = null
}
variable "ecs_role_arn" {
  type        = string
  description = "In case you want to run the ECS Service with a different role than the default one"
  default     = null
  validation {
    condition     = var.ecs_role_arn == null || can(regex("^arn:aws:iam::[[:digit:]]{12}:role/.+", var.ecs_role_arn))
    error_message = "The ARN role is invalid. It must be in the format arn:aws:iam::<account-id>:role/<role-name> ."
  }
}

variable "ecs_launch_type" {
  default     = "FARGATE"
  description = "The launch type of the ECS Service"
  validation {
    condition     = var.ecs_launch_type == "FARGATE" || var.ecs_launch_type == "EC2"
    error_message = "The launch type must be either FARGATE or EC2."
  }
}

variable "environment" {
  type = list(object({
    name  = string
    value = any
  }))
  default = null
}

variable "cpu" {
  default = 1024
}

variable "memory" {
  default = 2048
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "service_desired" {
  description = "Desired numbers of instances in the ecs service"
  default     = 1
}

variable "container_image" {
  default = "nginx:alpine"
}

variable "record_set_identifier" {
  type    = string
  default = null
}

variable "fargate_capacity_providers" {
  description = "Map of Fargate capacity provider definitions to use for the cluster"
  type        = any
  default     = {}
}