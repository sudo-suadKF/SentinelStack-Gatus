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

variable "cluster-name" {
  description = "Contains ECS's cluster name"
  type = string
}

variable "setting-name" {
  description = "Contains setting name"
  type = string
}

variable "setting-value" {
  description = "Contains setting value"
  type = string
}

variable "cloudwatch-name" {
  description = "Contains cloudwatch group name"
  type = string
}

variable "cloudwatch-retention-days" {
  description = "Contains Cloudwatch's retention days"
  type = number
}

variable "task-family" {
  description = "Contains task's family"
  type = string
}

variable "network-mode" {
  description = "Contains task's network mode"
  type = string
}

variable "requires-compatibilities" {
  description = "Contains task's required compatibilities"
  type = string
}

variable "cpu-size" {
  description = "Contains CPU size"
  type = number
}

variable "memory-size" {
  description = "Contains memory size"
  type = number
}

variable "container-name" {
  description = "Contains container name"
  type = string
}

variable "port-app" {
  description = "Contains port 8080"
  type = number
}

variable "port-mapping-protocol" {
  description = "Contains the IP protocol for port mappings"
  type = string
}

variable "log-config-driver" {
  description = "Contains the driver for logconfig"
  type = string
}

variable "aws-region" {
  description = "Contains the region"
  type = string
}

variable "aws-stream-prefix" {
  description = "Contains stream prefix"
  type = string
}

variable "service-name" {
  description = "Contains the ecs service name"
  type = string
}

variable "desired-count" {
  description = "Contains the desired count of tasks running"
  type = number
}

variable "launch-type" {
  description = "Contains the launch type for ecs service"
  type = string
}

variable "platform-version" {
  description = "Contains the version of platform for Fargate"
  type = string
}
