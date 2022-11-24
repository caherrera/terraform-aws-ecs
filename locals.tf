locals {
  ecs_prefix                = coalesce(var.ecs_prefix, var.host)
  ecs_cluster_name          = "${local.ecs_prefix}-cluster"
  ecs_service_name          = "${local.ecs_prefix}-service"
  ecs_task_name             = "${local.ecs_prefix}-backend"
  sg_name                   = "${local.ecs_prefix}-lb-sg"
  ecs_log_group_name        = coalesce(var.ecs_log_group_name, "${local.ecs_prefix}/${local.container_name}")
  ecs_role_arn              = var.ecs_role_arn == null ? aws_iam_role.ecs_task_role[0].arn : var.ecs_role_arn
  role_prefix               = coalesce(var.role_prefix, join("-", [local.ecs_prefix, "ecs"]))
  ecs_task_role_name        = "${local.role_prefix}-role"
  ecs_task_policy_name      = "${local.role_prefix}-policy"
  ecs_task_exec_policy_name = "${local.role_prefix}-exec-policy"
  container_name            = var.container_name
  container_port            = var.container_port
  ecs_host_port             = coalesce(var.ecs_host_port, var.container_port)
  alb_port                  = coalesce(var.alb_port, local.ecs_host_port)
  alb_prefix                = coalesce(var.alb_prefix, "${local.ecs_prefix}-alb")
  alb_logs_bucket           = local.alb_prefix
}