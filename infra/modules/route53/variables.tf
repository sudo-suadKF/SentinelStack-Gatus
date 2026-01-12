variable "domain-name" {
  description = "Contains the domain name"
  type = string
}

variable "alb-dns-name" {
  description = "Contains the ALB's DNS name"
  type = string
}

variable "alb-zone-id" {
  description = "Contains the ALB's zone id"
  type = string
}

variable "hosted-zone-name" {
  description = "Contains hosted zone name"
  type = string
}

variable "record-type" {
  description = "Contains record type"
  type = string
}