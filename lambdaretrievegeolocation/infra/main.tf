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

resource "aws_lambda_function" "geoloc_update_lambda" {
  filename         = "lambda_retrieve_geolocation.zip"
  function_name    = "LambdaRetrieveGeolocation"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  memory_size   = 128
  timeout       = 30

  environment {
    variables = {
      foo = "bar"
    }
  }
}

