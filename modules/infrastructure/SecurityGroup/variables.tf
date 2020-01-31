variable "ingress_ports" {
  type        = list(number)
  description = "List of ingress ports"
  default     = [22, 80]
}
variable "open-internet" {
  description = "Open web CIDR"
  default     = ["0.0.0.0/0"]
}
variable "name" {
  description = "SG name"
  default     = "Terraform"
}
variable "outbound-port" {
  description = "outbound port"
  default     = 0
}
variable "vpc_id" {

}