data "aws_ecr_repository" "gatus-ecs" {
  name = var.repository-name
}