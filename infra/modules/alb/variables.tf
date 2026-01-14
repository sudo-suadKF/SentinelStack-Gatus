variable "alb-sg-id" {
  description = "Contains ALB's SG id"
  type = string
}

variable "public-subnet1-id" {
  description = "Contains public subnet1's id"
  type = string
}

variable "public-subnet2-id" {
  description = "Contains public subnet2's id"
  type = string
}

variable "public-subnet3-id" {
  description = "Contains public subnet3's id"
  type = string
}

variable "vpc-id" {
  description = "Contains VPC's id"
  type = string
}

variable "alb-name" {
  description = "Contains ALB's name"
  type = string
}

variable "lb-type" {
  description = "Contains LB's type"
  type = string
}

variable "alb-tags" {
  description = "Contains ALB's tag name"
  type = string
}

variable "tg-name" {
  description = "Contains TG's name"
  type = string
}

variable "tg-port" {
  description = "Contains TG's port"
  type = number
}

variable "tg-protocol" {
  description = "Contains TG's protocol"
  type = string
}

variable "tg-ip-type" {
  description = "Contains TG's IP type"
  type = string
}

variable "tg-target-type" {
  description = "Contains TG's target type"
  type = string
}

variable "healthy-threshold" {
  description = "Contains health check's healthy threshold"
  type = string
}

variable "health-check-interval" {
  description = "Contains health check's interval"
  type = string
}

variable "health-check-protocol" {
  description = "Contains health check's protocol"
  type = string
}

variable "health-check-matcher" {
  description = "Contains health check's matcher"
  type = string
}

variable "health-check-timeout" {
  description = "Contains health check's timeout"
  type = string
}

variable "health-check-path" {
  description = "Contains health check's path"
  type = string
}

variable "health-check-unhealthy-threshold" {
  description = "Contains health check's unhealthy threshold"
  type = string
}

# variable "health-check-port" {
#   description = "Contains health check's port"
#   type = string
# }

variable "listener-http-port" {
  description = "Contains ALB's HTTP listener port"
  type = string
}

variable "listener-http-protocol" {
  description = "Contains ALB's HTTP listener protocol"
  type = string
}

variable "listener-http-action-type" {
  description = "Contains ALB's HTTP listener action type"
  type = string
}

variable "listener-http-action-port" {
  description = "Contains ALB's HTTP listener action port"
  type = string
}

variable "listener-http-action-protocol" {
  description = "Contains ALB's HTTP listener action protocol"
  type = string
}

variable "listener-http-action-status-code" {
  description = "Contains ALB's HTTP listener action status code"
  type = string
}

variable "listener-https-port" {
  description = "Contains ALB's HTTPS listener port"
  type = string
}

variable "listener-https-protocol" {
  description = "Contains ALB's HTTPS listener protocol"
  type = string
}

variable "listener-https-ssl-policy" {
  description = "Contains ALB's HTTPS listener ssl policy"
  type = string
}

variable "listener-https-action-type" {
  description = "Contains ALB's HTTPS listener action type"
  type = string
}

variable "tg-attach-port" {
  description = "Contains TG's attach port"
  type = number
}

variable "certificate-arn" {
  description = "Contains HTTPS certificate arn value"
  type = string
}