variable "vpc-cidr" {
    description = "Contains cidr block for vpc"
    type = string
}

variable "public-subnet1-cidr" {
  description = "Contains cidr block for public subnet1"
  type = string
}

variable "az1" {
  description = "Contains AZ1"
  type = string
}

variable "public-subnet2-cidr" {
  description = "Contains cidr block for public subnet2"
  type = string
}

variable "az2" {
  description = "Contains AZ2"
  type = string
}

variable "public-subnet3-cidr" {
  description = "Contains cidr block for public subnet3"
  type = string
}

variable "az3" {
  description = "Contains AZ3"
  type = string
}

variable "private-subnet1-cidr" {
  description = "Contains cidr block for private subnet1"
  type = string
}

variable "private-subnet2-cidr" {
  description = "Contains cidr block for private subnet2"
  type = string
}

variable "private-subnet3-cidr" {
  description = "Contains cidr block for private subnet3"
  type = string
}

variable "nat-gw-availability-mode" {
  description = "Contains NAT GWs availability mode"
  type = string
}

variable "nat-gw-connectivity-type" {
  description = "Contains NAT GWs connectivity type"
  type = string
}

variable "internet-cidr" {
  description = "Contains internet's cidr block"
  type = string
}

variable "vpc-tags" {
  description = "Contains VPC's tag"
  type = string
}

variable "public-subnet1-tags" {
  description = "Contains public subnet1's tag"
  type = string
}

variable "public-subnet2-tags" {
  description = "Contains public subnet2's tag"
  type = string
}

variable "public-subnet3-tags" {
  description = "Contains public subnet3's tag"
  type = string
}

variable "private-subnet1-tags" {
  description = "Contains private subnet1's tag"
  type = string
}

variable "private-subnet2-tags" {
  description = "Contains private subnet2's tag"
  type = string
}

variable "private-subnet3-tags" {
  description = "Contains private subnet3's tag"
  type = string
}

variable "igw-tags" {
  description = "Contains IGW's tag"
  type = string
}

variable "nat-gw-tags" {
  description = "Contains NAT GW's tag"
  type = string
}

variable "public-rt-tags" {
  description = "Contains Public RT's tag"
  type = string
}

variable "private-rt-tags" {
  description = "Contains Public RT's tag"
  type = string
}