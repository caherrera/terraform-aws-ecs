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
  type = string
}
variable "alb_prefix" {
  type = string
}
variable "zone_id" {
  type = string
}
variable "host" {
  type = string
}
variable "container_name" {
  type    = string
  default = "app"
}
variable "container_port" {
  type    = number
  default = 8080
}
variable "ecs_client_prefix" {
  type = string
}
variable "ecs_log_group_name" {
  type = string
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

variable "environment" {}

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