variable "environment" {
}
variable "region" {
}
variable "ami_id" {
}
variable "cron" {
}
variable "cronend" {
}
provider "aws" {
  version                 = "~> 2.7"
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}
module "infrastructure" {
    source        = "../../modules/infrastructure"
    environment   = var.environment
    region        = var.region
    ami_id        = var.ami_id
    cron          = var.cron
    cronend       = var.cronend
}