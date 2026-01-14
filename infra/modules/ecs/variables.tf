variable "image-uri" {
  description = "Contains the dockerimage uri from ecr repository"
  type = string
}

variable "execution-role-arn" {
  description = "Contains the execution role's ARN"
  type = string
}

variable "ecs-sg-id" {
  description = "Contains the ECS's SG ID"
  type = string
}

variable "private-subnets-ids" {
  description = "Contains Private Subnets's IDs"
  type = list(string)
}

variable "tg-arn" {
  description = "Contains ECS TG's ARN"
  type = string
}