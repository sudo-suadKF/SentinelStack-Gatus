output "alb-sg-id" {
  value = aws_security_group.alb-sg.id 
}

output "ecs-sg-id" {
  value = aws_security_group.ecs-sg.id
}