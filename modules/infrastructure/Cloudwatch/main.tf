resource "aws_lambda_function" "s3_create" {
    filename = "../../modules/infrastructure/S3Create.zip"
    function_name = "${var.region}-s3-create"
    role = aws_iam_role.iam_for_lambda.id
    handler = "s3Create.lambda_handler"
    runtime = "python3.8"
}

resource "aws_cloudwatch_event_rule" "lamda_trigger" {
    name = "${var.region}-lambda_trigger"
    description = "Fires when ASG spin up"
    schedule_expression = ("cron(${var.cron} 0)")
}

resource "aws_cloudwatch_event_target" "terget_lambda" {
    rule = "${aws_cloudwatch_event_rule.lamda_trigger.name}"
    target_id = "s3_create"
    arn = "${aws_lambda_function.s3_create.arn}"
    input = <<EOF
{"region":${var.region}}
EOF
}

resource "aws_lambda_permission" "permissions" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.s3_create.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.lamda_trigger.arn}"
}
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
    "Action": "sts:AssumeRole",
    "Principal": {
        "Service": "lambda.amazonaws.com"
    },
    "Effect": "Allow",
    "Sid": ""
    }
]
}
EOF
}