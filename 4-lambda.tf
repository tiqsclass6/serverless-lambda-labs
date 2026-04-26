# Archive the Lambda function code for Python
data "archive_file" "lambda_python_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/python/lambda_function.py"
  output_path = "${path.module}/lambda/python/lambda_python.zip"
}

# Archive the Lambda function code for Node.js
data "archive_file" "lambda_node_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/node/index.js"
  output_path = "${path.module}/lambda/node/lambda_node.zip"
}

# Chewbacca Python Lambda Function
resource "aws_lambda_function" "chewbacca_python" {
  function_name = "chewbacca-python-lambda"
  description   = "Chewbacca Python Lambda Function"
  runtime       = "python3.12"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_execution_role.arn

  filename         = data.archive_file.lambda_python_zip.output_path
  source_code_hash = data.archive_file.lambda_python_zip.output_base64sha256

  environment {
    variables = {
      ENVIRONMENT = "lab"
    }
  }

  tags = {
    Name        = "chewbacca-python-lambda"
    Environment = "Lab"
    Runtime     = "Python"
  }
}

# Chewbacca Node.js Lambda Function
resource "aws_lambda_function" "chewbacca_node" {
  function_name = "chewbacca-node-lambda"
  description   = "Chewbacca Node.js Lambda Function"
  runtime       = "nodejs22.x"
  handler       = "index.handler"
  role          = aws_iam_role.lambda_execution_role.arn

  filename         = data.archive_file.lambda_node_zip.output_path
  source_code_hash = data.archive_file.lambda_node_zip.output_base64sha256

  environment {
    variables = {
      ENVIRONMENT = "lab"
    }
  }

  tags = {
    Name        = "chewbacca-node-lambda"
    Environment = "Lab"
    Runtime     = "Node.js"
  }
}