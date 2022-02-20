resource "aws_ecs_cluster" "mycluster" {
  count = var.create_ecs ? 1 : 0

  name = var.ecs_name

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }

}

resource "aws_ecs_service" "backendapp"{
  name = var.ecs_service_name
  cluster = var.ecs_name
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 0
  desired_count = var.desired_count
  launch_type = var.launch_type
  task_definition = aws_ecs_task_definition.service.arn
  
  network_configuration {
    assign_public_ip = true
    security_groups = [module.ecs_sg.security_group_id]
    subnets = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]
    
  }
  load_balancer  {
    target_group_arn = "${aws_lb_target_group.pass-gen-tg.arn}"
    container_name   = "${lookup(var.lb_target_group, "container_name", var.ecs_service_name)}"
    container_port   = "${lookup(var.lb_target_group, "container_port", 8000)}"
  }
  
}
