# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# IAM Role for Lambda Execution
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Cognito SNS Role
resource "aws_iam_role" "cognito_sns_role" {
  name = "cognito-sns-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "cognito-idp.amazonaws.com"
      }
    }]
  })
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
# Lambda Basic Execution Policy Attachment
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# SNS Publish Policy Attachment for Cognito
resource "aws_iam_role_policy" "cognito_sns_policy" {
  role = aws_iam_role.cognito_sns_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = ["sns:Publish"]
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}