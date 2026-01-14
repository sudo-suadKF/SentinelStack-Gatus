resource "aws_iam_role" "ecs-task-execution-role" {
  name = var.iam-role-name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy" {
  role = aws_iam_role.ecs-task-execution-role.name
  policy_arn = var.policy-arn
}

