# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-south-1"
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "dev"
}

variable "ecs_service_name"{
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "pass-gen-service"
}

variable "launch_type" {
    description = "The launch type that the service needs"
    default     = "FARGATE"
    
}

variable "desired_count" {
    description = ""
    type = number
    default = 1
}

variable "lb_target_group" {
  description = "The target group to connectect the container to the load balancer listerner."
  type        = map

  default = {
    container_port       = 8000
    host_port            = 8000
    protocol             = "http"
    deregistration_delay = 300
  }
}
variable "target_group_arn" {
    description = "The arn of the target group"
    type =string
    default = "app-tg"
}

variable "database_name" {
    description = "The name of the RDS "
    type =string
    default = "test-db"  
}


# VPC Input Variables

# VPC Name
variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "vpc"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

# VPC Availability Zones
variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

# VPC Public Subnets
variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Private Subnets
variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "vpc_db_private_subnets"{
  description = "VPC DB Private Subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]  
}
# VPC Enable NAT Gateway (True or False) 
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type        = bool
  default     = true
}

# VPC Single NAT Gateway (True or False)
variable "vpc_single_nat_gateway" {
  description = "Enable only single NAT Gateway in one Availability Zone to save costs during our demos"
  type        = bool
  default     = true
}

variable "ingress_rules" {
  description = "A list of ingress rule identifiers"
  type        = list(string)
  default     = []
}

variable "egress_rules" {
  description = "A list of egress rule identifiers"
  type        = list(string)
  default     = []
}

variable "ecs_name"{
  description = "ECS cluster name"
  type = string
  default = "pass-gen-dev"
}

variable "container_insights" {
  description = "Controls if ECS Cluster has container insights enabled"
  type        = bool
  default     = false
}

variable "create_ecs" {
  description = "Controls if ECS should be created"
  type        = bool
  default     = true
}

variable "kms_key_id"{
  description = "KMS for ECS"
  type = string
  default = "353463a4-efae-4071-a86a-5ac8ad7c87b0"
}

variable "docker-name" {
  description = "ECS cluster name"
  type = string
  default = "pass-gen-app"
}

variable "ecr_name" {
    description = "ECR repo name"
    type = string
    default = "pass-gen"
}

/* variable "web-sg-name" {
  description = "Name of SG"
  
 }

 variable "db-sg-name" {
  description = "Name of SG"
  
 } */
