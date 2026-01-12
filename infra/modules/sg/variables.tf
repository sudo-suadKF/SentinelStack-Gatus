variable "vpc-id" {
  description = "Contains vpc's id"
  type = string
}

variable "alb-sg-description" {
  description = "Contains ALB's SG description"
  type = string
}

variable "alb-sg-tags" {
  description = "Contains ALB's SG tag"
  type = string
}

variable "alb-sg-inbound-HTTP-description" {
  description = "Contains ALB's SG's inobund description"
  type = string
}

variable "internet-cidr" {
  description = "Contains internet's cidr block"
  type = string
}

variable "port-80" {
  description = "Contains port 80"
  type = number
}

variable "ip-protocol-tcp" {
  description = "Contains TCP as IP protocol"
  type = string
}

variable "alb-sg-inbound-HTTPS-description" {
  description = "Contains ALB's SG's inobund description"
  type = string
}

variable "port-443" {
  description = "Contains port 443"
  type = number
}

variable "alb-sg-outbound-description" {
  description = "Contains ALB's SG description"
  type = string
}

variable "ip-protocol-1" {
  description = "Contains -1 as ip protocol"
  type = string
}

variable "ecs-sg-description" {
  description = "Contains ECS's SG description"
  type = string
}

variable "ecs-sg-tags" {
  description = "Contains ECS's SG tag"
  type = string
}

variable "ecs-sg-inbound-description" {
  description = "Contains ECS's SG inbound description"
  type = string
}

variable "port-8080" {
  description = "Contains port 8080"
  type = number
}

variable "ecs-sg-outbound-description" {
  description = "Contains ECS's SG outbound description"
  type = string
}