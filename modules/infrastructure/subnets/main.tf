resource "aws_subnet" "public_subnet" {
    vpc_id = var.vpc_id
    cidr_block = "10.0.0.0/24"

    tags = {
        Name = "${var.environment}-${var.region}-Public-Subnet"
    }
}
resource "aws_subnet" "private_subnet" {
    vpc_id = var.vpc_id
    cidr_block = "10.0.1.0/24"

    tags = {
        Name = "${var.environment}-${var.region}-Private-Subnet"
    }
}

resource "aws_route_table_association" "pub_subA_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = var.route_id
}