module "lb_sg" {
  source = "terraform-aws-modules/security-group/aws"
  name        = "ECS-LB-SG"
  description = "ECS-LB-SG"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp","http-80-tcp"]
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
}

module "ecs_sg" {
  source = "terraform-aws-modules/security-group/aws"
  name        = "ECS-SG"
  description = "ECS-SG"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp","http-80-tcp"]
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
  
  ingress_with_cidr_blocks = [
    {
      from_port   = 8000
      to_port     = 8000
      protocol    = "tcp"
      description = "app port"
      cidr_blocks = "0.0.0.0/0"
    }
    
  ]
}

module "rds_sg" {
  source = "terraform-aws-modules/security-group/aws"
  name        = "RDS-App-SG"
  description = "RDS-App-SG"
  vpc_id      = module.vpc.vpc_id

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
  
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "rds port"
      cidr_blocks = module.vpc.vpc_cidr_block
    }
    
  ]
}
