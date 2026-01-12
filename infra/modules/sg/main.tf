# ALB's SG
resource "aws_security_group" "alb-sg" {
  description = var.alb-sg-description
  vpc_id      = var.vpc-id

  tags = {
    Name = var.alb-sg-tags
  }
}

# ALB's inbound & outbound rules
resource "aws_vpc_security_group_ingress_rule" "alb-sg-HTTP" {
  description = var.alb-sg-inbound-HTTP-description
  security_group_id = aws_security_group.alb-sg.id

  cidr_ipv4   = var.internet-cidr
  from_port   = var.port-80
  ip_protocol = var.ip-protocol-tcp
  to_port     = var.port-80
}

resource "aws_vpc_security_group_ingress_rule" "alb-sg-HTTPS" {
  description = var.alb-sg-inbound-HTTPS-description
  security_group_id = aws_security_group.alb-sg.id

  cidr_ipv4   = var.internet-cidr
  from_port   = var.port-443
  ip_protocol = var.ip-protocol-tcp
  to_port     = var.port-443
}

resource "aws_vpc_security_group_egress_rule" "alb-sg-outbound" {
  description = var.alb-sg-outbound-description
  security_group_id = aws_security_group.alb-sg.id

  cidr_ipv4   = var.internet-cidr
  ip_protocol = var.ip-protocol-1
}
########################################################################

# ECS's SG
resource "aws_security_group" "ecs-sg" {
  description = var.ecs-sg-description
  vpc_id = var.vpc-id

  tags = {
    Name = var.ecs-sg-tags
  }  
}

# ECS's inbound and outbound traffic
resource "aws_vpc_security_group_ingress_rule" "ecs-sg-inbound" {
  description = var.ecs-sg-inbound-description
  security_group_id = aws_security_group.ecs-sg.id

  referenced_security_group_id = aws_security_group.alb-sg.id
  from_port = var.port-8080
  ip_protocol = var.ip-protocol-tcp
  to_port = var.port-8080
}

resource "aws_vpc_security_group_egress_rule" "ecs-sg-outbound" {
  description = var.ecs-sg-outbound-description
  security_group_id = aws_security_group.ecs-sg.id

  cidr_ipv4 = var.internet-cidr
  ip_protocol = var.ip-protocol-1
}