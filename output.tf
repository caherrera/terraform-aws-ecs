output "cluster_name" {
  value = module.ecs.cluster_name
}

output "service_name" {
  value = var.expose ? aws_ecs_service.main_service[0].name : aws_ecs_service.backend_service[0].name
}

output "task_definition_family" {
  value = aws_ecs_task_definition.backend.family
}

output "containers" {
  value = [
    {
      name  = local.container_name
      port  = local.container_port
      image = local.image_url

    }
  ]
}

output "backend_url" {
  value = var.expose ? aws_route53_record.backend[0].name : ""
}

output "alb_url" {
  value = var.expose ? aws_lb.main[0].dns_name : ""
}