# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
# CloudWatch Log Group for Python Lambda
resource "aws_cloudwatch_log_group" "python_lambda" {
  name              = "/aws/lambda/chewbacca-python-lambda"
  retention_in_days = 7

  tags = {
    Name        = "chewbacca-python-lambda"
    Environment = "Lab"
  }
}

# CloudWatch Log Group for Node.js Lambda
resource "aws_cloudwatch_log_group" "node_lambda" {
  name              = "/aws/lambda/chewbacca-node-lambda"
  retention_in_days = 7

  tags = {
    Name        = "chewbacca-node-lambda"
    Environment = "Lab"
  }
}