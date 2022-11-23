## ECS


module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = local.ecs_client_cluster_name

  cluster_configuration = {
    execute_command_configuration = {
      logging           = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.app.name
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

}

resource "aws_ecs_service" "main_service" {
  count           = var.expose ? 1 : 0
  name            = local.ecs_client_service_name
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = var.service_desired
  launch_type     = var.ecs_launch_type

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.target_group[0].arn
    container_name   = local.container_name
    container_port   = local.container_port
  }

}

resource "aws_ecs_service" "backend_service" {
  count           = var.expose ? 0 : 1
  name            = local.ecs_client_service_name
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = var.service_desired
  launch_type     = var.ecs_launch_type

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "backend" {
  family                   = local.ecs_client_task_name
  network_mode             = "awsvpc"
  requires_compatibilities = [var.ecs_launch_type]
  execution_role_arn       = local.ecs_role_arn
  task_role_arn            = local.ecs_role_arn

  cpu    = var.cpu
  memory = var.memory

  container_definitions = jsonencode([
    {
      cpu          = var.cpu
      memory       = var.memory
      essential    = true
      image        = var.container_image
      name         = local.container_name
      portMappings = [
        {
          containerPort = local.container_port
          hostPort      = local.container_port
        }
      ],
      environment      = var.environment,
      logConfiguration = {
        logDriver = "awslogs",
        options   = {
          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = aws_cloudwatch_log_stream.app.name

        }
      }
    }
  ]
  )

}

## CloudWatch Logs

resource "aws_cloudwatch_log_group" "app" {
  name              = "${local.ecs_log_group_name}-container"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_stream" "app" {
  log_group_name = aws_cloudwatch_log_group.app.id
  name           = local.ecs_log_group_name
}