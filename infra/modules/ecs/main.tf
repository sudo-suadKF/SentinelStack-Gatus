# ECS Cluster
resource "aws_ecs_cluster" "gatus" {
  name = "gatus-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# CloudWatch group for logs from ECS tasks
resource "aws_cloudwatch_log_group" "ecs-log-group" {
  name = "ecs-cloudwatch-logs"
  retention_in_days = 14
}

# ECS Task definition to run the gatus app in the docker image from ECR
# and run with Cloudwatch logs
resource "aws_ecs_task_definition" "gatus-task" {
  family = "ecs-gatus-task"
  network_mode = "awsvpc"
  requires_compatibilities = [ "FARGATE" ]
  cpu = 256
  memory = 512
  execution_role_arn = var.execution-role-arn

  depends_on = [ aws_cloudwatch_log_group.ecs-log-group ]

  container_definitions = jsonencode([
    {
      name      = "gatus-container"
      image     = var.image-uri
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
       logDriver = "awslogs"
       options = {
        awslogs-group = aws_cloudwatch_log_group.ecs-log-group.name
        awslogs-region = "eu-west-2"
        awslogs-stream-prefix = "ecs"
       } 
      }
    }
])
}

# ECS Service
resource "aws_ecs_service" "gatus-service" {
  name            = "gatus-service"
  cluster         = aws_ecs_cluster.gatus.id
  task_definition = aws_ecs_task_definition.gatus-task.arn
  desired_count   = 3
  launch_type     = "FARGATE"
  platform_version = "LATEST"
  
  #depends_on      = [var.execution-role-arn]

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  load_balancer {
    target_group_arn = var.tg-arn
    container_name   = "ecs-gatus"
    container_port   = 8080
  }

  network_configuration {
    assign_public_ip = false
    security_groups = [ var.ecs-sg-id ]
    subnets = var.private-subnets-ids
  }

}

