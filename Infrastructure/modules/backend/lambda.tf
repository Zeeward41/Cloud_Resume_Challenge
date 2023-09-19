# Creation lambda get_visiteurs

resource "aws_lambda_function" "lambda_get_visiteurs" {
  function_name = "lambda_get_visiteurs"
  role          = aws_iam_role.lambda_DynamoDB_Faccess.arn
  description   = "Recupère le nombre de visiteurs dans DynamoDB"
  runtime       = "python3.9"
  filename      = "modules/backend/lambda_zeeward41_get.zip"
  handler       = "get_visiteurs.lambda_handler"
}


# Creation lambda modify_nombreVisiteurs

resource "aws_lambda_function" "lambda_modify_nVisiteurs" {
  function_name = "modify_nombreVisiteurs"
  role          = aws_iam_role.lambda_DynamoDB_Faccess.arn
  description   = "Augmente le nombre de visiteurs dans DynamoDB (+1)"
  runtime       = "python3.9"
  filename      = "modules/backend/lambda_zeeward41_modify.zip"
  handler       = "modify_nombreVisiteurs.lambda_handler"
}

# Creation permission accès lambda (GET)

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_get_visiteurs.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region_base}:585355206799:${aws_api_gateway_rest_api.zeeward41_api_gateway.id}/*/GET${aws_api_gateway_resource.zeeward41_get_visiteurs.path}"
}

# Creation permission accès lambda (POST)

resource "aws_lambda_permission" "apigw_lambda_post" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_modify_nVisiteurs.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region_base}:585355206799:${aws_api_gateway_rest_api.zeeward41_api_gateway.id}/*/POST${aws_api_gateway_resource.zeeward41_get_visiteurs.path}"
 
}