variable "domain-name" {
  description = "Contains the domain name"
  type = string
}

variable "validation-method" {
  description = "Contains the validation method"
  type = string
}

variable "hosted-zone-name" {
  description = "Contains hosted zone name"
  type = string
}

variable "record-ttl" {
  description = "Contains ttl for record"
  type = number
}