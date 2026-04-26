# # Lambda Authorizer Function (simple JWT validator)
# resource "aws_lambda_function" "jwt_authorizer" {
#   function_name = "chewbacca-jwt-authorizer"
#   description   = "JWT Authorizer for Chewbacca API using Auth0"
#   runtime       = "nodejs20.x"
#   handler       = "index.handler"
#   role          = aws_iam_role.lambda_execution_role.arn

#   filename         = "${path.module}/lambda/jwt-authorizer/jwt_authorizer.zip"
#   source_code_hash = filebase64sha256("${path.module}/lambda/jwt-authorizer/jwt_authorizer.zip")

#   environment {
#     variables = {
#       AUTH0_DOMAIN   = var.auth0_domain
#       AUTH0_AUDIENCE = var.auth0_audience
#     }
#   }

#   tags = {
#     Name        = "chewbacca-jwt-authorizer"
#     Environment = "Lab"
#   }
# }

# # API Gateway JWT Authorizer
# resource "aws_api_gateway_authorizer" "jwt_auth" {
#   name                             = "chewbacca-jwt-authorizer"
#   rest_api_id                      = aws_api_gateway_rest_api.chewbacca_rest_api.id
#   authorizer_uri                   = aws_lambda_function.jwt_authorizer.invoke_arn
#   type                             = "TOKEN"
#   identity_source                  = "method.request.header.Authorization"
#   authorizer_result_ttl_in_seconds = 300
# }

# # Lambda Permission for API Gateway to call the Authorizer
# resource "aws_lambda_permission" "allow_apigw_authorizer" {
#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.jwt_authorizer.function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.chewbacca_rest_api.execution_arn}/*/*"
# }