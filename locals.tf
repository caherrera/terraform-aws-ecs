locals {
  ecs_client_prefix         = var.ecs_client_prefix
  ecs_client_cluster_name   = "${local.ecs_client_prefix}-cluster"
  ecs_client_service_name   = "${local.ecs_client_prefix}-service"
  ecs_client_task_name      = "${local.ecs_client_prefix}-backend"
  sg_name                   = "${local.ecs_client_prefix}-lb-sg"
  ecs_log_group_name        = coalesce(var.ecs_log_group_name, "${local.ecs_client_prefix}/${local.container_name}" )
  ecs_role_arn              = var.ecs_role_arn == null ? aws_iam_role.ecs_task_role[0].arn : var.ecs_role_arn
  role_prefix               = coalesce(var.role_prefix, join("-", [var.ecs_client_prefix, "ecs"]))
  ecs_task_role_name        = "${local.role_prefix}-role"
  ecs_task_policy_name      = "${local.role_prefix}-policy"
  ecs_task_exec_policy_name = "${local.role_prefix}-exec-policy"

  container_name  = var.container_name
  container_port  = var.container_port
  image_url       = join(":", [data.aws_ecr_repository.safe_client_back.repository_url, terraform.workspace])
  alb_prefix      = coalesce(var.alb_prefix, "${local.ecs_client_prefix}-alb")
  alb_logs_bucket = local.alb_prefix
}