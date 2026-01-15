# ECS Cluster
resource "aws_ecs_cluster" "gatus" {
  name = var.cluster-name

  setting {
    name  = var.setting-name
    value = var.setting-value
  }
}

# CloudWatch group for logs from ECS tasks
resource "aws_cloudwatch_log_group" "ecs-log-group" {
  name = var.cloudwatch-name
  retention_in_days = var.cloudwatch-retention-days
}

# ECS Task definition to run the gatus app in the docker image from ECR
# and run with Cloudwatch logs
resource "aws_ecs_task_definition" "gatus-task" {
  family = var.task-family
  network_mode = var.network-mode
  requires_compatibilities = [var.requires-compatibilities]
  cpu = var.cpu-size
  memory = var.memory-size
  execution_role_arn = var.execution-role-arn

  depends_on = [ aws_cloudwatch_log_group.ecs-log-group ]

  container_definitions = jsonencode([
    {
      name      = var.container-name
      image     = var.image-uri
      cpu       = var.cpu-size
      memory    = var.memory-size
      essential = true
      portMappings = [
        {
          containerPort = var.port-app
          protocol      = var.port-mapping-protocol
        }
      ]

      logConfiguration = {
       logDriver = var.log-config-driver
       options = {
        awslogs-group = aws_cloudwatch_log_group.ecs-log-group.name
        awslogs-region = var.aws-region
        awslogs-stream-prefix = var.aws-stream-prefix
       } 
      }
    }
])
}

# ECS Service
resource "aws_ecs_service" "gatus-service" {
  name            = var.service-name
  cluster         = aws_ecs_cluster.gatus.id
  task_definition = aws_ecs_task_definition.gatus-task.arn
  desired_count   = var.desired-count
  launch_type     = var.launch-type
  platform_version = var.platform-version
  
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  load_balancer {
    target_group_arn = var.tg-arn
    container_name   = var.container-name
    container_port   = var.port-app
  }

  network_configuration {
    assign_public_ip = false
    security_groups = [ var.ecs-sg-id ]
    subnets = var.private-subnets-ids
  }

}

