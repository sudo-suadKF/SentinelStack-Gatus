output "image-uri" {
  value = "${data.aws_ecr_repository.gatus-ecs.repository_url}:latest"
}