# API Gateway Outputs
output "api_gateway_base_url" {
  description = "REST API Base URL"
  value       = "https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod"
}

# JWT Authorizer Output
# output "jwt_authorizer_id" {
#   description = "JWT Authorizer ID"
#   value       = aws_api_gateway_authorizer.jwt_auth.id
# }

# Protected Python URL (requires JWT)
# output "protected_python_url" {
#   description = "Protected Python Endpoint (requires JWT)"
#   value       = "https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/python"
# }

# Protected Node.js URL (requires JWT)
# output "protected_node_url" {
#   description = "Protected Node.js Endpoint (requires JWT)"
#   value       = "https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/node"
# }

# Node.js Curl Command Output
output "node_curl" {
  description = "Copy & Paste curl command for Node.js"
  value       = "curl \"https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/node?name=Malgus\""
}

# Node.js Endpoint Output
output "node_endpoint" {
  description = "Node.js Lambda Full Endpoint"
  value       = "https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/node"
}

# Node.js Log Group Name Output
output "node_log_group_name" {
  description = "CloudWatch Log Group for Node.js Lambda"
  value       = "/aws/lambda/chewbacca-node-lambda"
}

# Node.js Test URL Output
output "node_test_url" {
  description = "Test URL for Node.js Lambda"
  value       = "https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/node?name=Malgus"
}

# Python Curl Command Output
output "python_curl" {
  description = "Copy & Paste curl command for Python"
  value       = "curl \"https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/python?name=Chewbacca\""
}

# Python Endpoint Output
output "python_endpoint" {
  description = "Python Lambda Full Endpoint"
  value       = "https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/python"
}

# Python Log Group Name Output
output "python_log_group_name" {
  description = "CloudWatch Log Group for Python Lambda"
  value       = "/aws/lambda/chewbacca-python-lambda"
}

# Python Test URL Output
output "python_test_url" {
  description = "Test URL for Python Lambda"
  value       = "https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/python?name=Chewbacca"
}

# WAF Outputs
output "waf_test_command1" {
  description = "Curl command to test Python endpoint with good request (should be allowed)"
  value       = "curl -k -v \"https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/python?name=Chewbacca\""
}

output "waf_test_command2" {
  description = "Curl command to test Python endpoint with good request (should be allowed)"
  value       = "curl -k -v \"https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/python?name=Malgus\""
}

output "waf_test_command3" {
  description = "Curl command to test Node.js endpoint with good request (should be allowed)"
  value       = "curl -k -v \"https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/node?name=Malgus\""
}

output "waf_test_command4" {
  description = "URL-encoded XSS test that should be blocked by WAF"
  value       = "curl -k -v \"https://${aws_api_gateway_rest_api.chewbacca_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod/python?name=%3Cscript%3Ealert(1)%3C/script%3E\""
}