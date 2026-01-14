output "alb-dns-name" {
  value = aws_lb.alb-gatus.dns_name
}

output "alb-zone-id" {
  value = aws_lb.alb-gatus.zone_id
}

output "tg-arn" {
  value = aws_lb_target_group.ecs-tg.arn
}