resource "aws_ecs_task_definition" "service" {
  family = "pass-gen-service"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu    = 256
  memory = 512
  execution_role_arn = "arn:aws:iam::351683513509:role/iam-ecs-task-role"
  task_role_arn = "arn:aws:iam::351683513509:role/iam-ecs-task-role"
  container_definitions = jsonencode([{
      name      = "pass-gen-service"
      image     = local.aws_ecr_url,
      environment = [{
      "valueFrom": "arn:aws:ssm:ap-south-1:351683513509:parameter/app/dev/DATABASE_HOST",
      "name": "HOST"
    },
    {
      "valueFrom": "arn:aws:ssm:ap-south-1:351683513509:parameter/app/dev/DATABASE_NAME",
      "name": "NAME"
    },
    {
      "valueFrom": "arn:aws:ssm:ap-south-1:351683513509:parameter/app/dev/DATABASE_PASSWORD",
      "name": "PASSWORD"
    },
    {
      "valueFrom": "arn:aws:ssm:ap-south-1:351683513509:parameter/app/dev/DJANGO_SECRET_KEY",
      "name": "SECRET_KEY"
    },
    {
      "valueFrom": "arn:aws:ssm:ap-south-1:351683513509:parameter/app/dev/DATABASE_USER",
      "name": "USER"
    }
  ]
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group = "pass-gen",
        awslogs-region = "${var.aws_region}",
        awslogs-stream-prefix = "/aws/ecs/pass-gen"
      }
    }
    }
  ])
}