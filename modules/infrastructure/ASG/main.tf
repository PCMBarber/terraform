resource "aws_launch_configuration" "launch" {
  lifecycle { create_before_destroy = true }
  instance_type = "t2.micro"
  image_id = "${var.ami_id}"
}
resource "aws_autoscaling_group" "test" {
  min_size = 1
  desired_capacity = 3
  max_size = 3
  launch_configuration = aws_launch_configuration.launch.id
  default_cooldown = 300

  vpc_zone_identifier = [var.subnet_id]

  lifecycle { create_before_destroy = true }
}
resource "aws_autoscaling_schedule" "Scale-up" {
  scheduled_action_name  = "${var.region}-Scale-up"
  min_size               = 1
  max_size               = 3
  desired_capacity       = 3
  recurrence = "${var.cron}"
  autoscaling_group_name = aws_autoscaling_group.test.id
}
resource "aws_autoscaling_schedule" "Scale-down" {
  scheduled_action_name  = "${var.region}-Scale-down"
  min_size               = 0
  max_size               = 1
  desired_capacity       = 0
  recurrence = "${var.cronend}"
  autoscaling_group_name = aws_autoscaling_group.test.id
}