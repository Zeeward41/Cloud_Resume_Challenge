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