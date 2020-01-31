module "vpc" {
    source = "./vpc"

    environment = var.environment
    region = var.region
}
module "subnets" {
    source = "./subnets"

    environment = var.environment
    region = var.region
    vpc_id = module.vpc.vpc_id
    route_id = module.vpc.route_table_id
}
module "security-group" {
    source = "./SecurityGroup"
    vpc_id = module.vpc.vpc_id
    name = "${var.region}-${var.environment}-sg"
}
module "ASG" {
    source = "./ASG"

    subnet_id = module.subnets.public_subnet_id
    security-group = module.security-group.aws_wsg_id
    ami_id = var.ami_id
    subnet_id2 = module.subnets.private_subnet_id
    cron = var.cron
    cronend = var.cronend
    environment = var.environment
    region = var.region
}
module "lambda" {
    source = "./Cloudwatch"

    cron = var.cron
    region = var.region
}
