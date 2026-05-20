# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api
resource "aws_api_gateway_rest_api" "chewbacca_rest_api" {
  name        = "chewbacca-rest-api"
  description = "REST API for Chewbacca Lambda Lab with WAF"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = {
    Name        = "chewbacca-rest-api"
    Environment = "Lab"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_resource
# Routes and Integrations will be defined in the next steps
resource "aws_api_gateway_resource" "python" {
  rest_api_id = aws_api_gateway_rest_api.chewbacca_rest_api.id
  parent_id   = aws_api_gateway_rest_api.chewbacca_rest_api.root_resource_id
  path_part   = "python"
}

resource "aws_api_gateway_resource" "node" {
  rest_api_id = aws_api_gateway_rest_api.chewbacca_rest_api.id
  parent_id   = aws_api_gateway_rest_api.chewbacca_rest_api.root_resource_id
  path_part   = "node"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method
# Python Method + Integration
resource "aws_api_gateway_method" "python_get" {
  rest_api_id   = aws_api_gateway_rest_api.chewbacca_rest_api.id
  resource_id   = aws_api_gateway_resource.python.id
  http_method   = "GET"
  authorization = "NONE"
}

# Node.js Method + Integration
resource "aws_api_gateway_method" "node_get" {
  rest_api_id   = aws_api_gateway_rest_api.chewbacca_rest_api.id
  resource_id   = aws_api_gateway_resource.node.id
  http_method   = "GET"
  authorization = "NONE"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration
# Python Method + Integration
resource "aws_api_gateway_integration" "python_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.chewbacca_rest_api.id
  resource_id             = aws_api_gateway_resource.python.id
  http_method             = aws_api_gateway_method.python_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.chewbacca_python.invoke_arn
}

# Node.js Method + Integration
resource "aws_api_gateway_integration" "node_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.chewbacca_rest_api.id
  resource_id             = aws_api_gateway_resource.node.id
  http_method             = aws_api_gateway_method.node_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.chewbacca_node.invoke_arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission
# Lambda Permissions for API Gateway
resource "aws_lambda_permission" "allow_apigw_python" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.chewbacca_python.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.chewbacca_rest_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "allow_apigw_node" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.chewbacca_node.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.chewbacca_rest_api.execution_arn}/*/*"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment
# Prod Deployment
resource "aws_api_gateway_deployment" "prod" {
  rest_api_id = aws_api_gateway_rest_api.chewbacca_rest_api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.python.id,
      aws_api_gateway_resource.node.id,
      aws_api_gateway_method.python_get.id,
      aws_api_gateway_method.node_get.id,
      aws_api_gateway_integration.python_lambda.id,
      aws_api_gateway_integration.node_lambda.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage
# Prod Stage
resource "aws_api_gateway_stage" "prod" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.chewbacca_rest_api.id
  deployment_id = aws_api_gateway_deployment.prod.id

  tags = {
    Name        = "chewbacca-prod-stage"
    Environment = "Lab"
  }
}