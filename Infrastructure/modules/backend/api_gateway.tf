# creation d'une rest_api

resource "aws_api_gateway_rest_api" "zeeward41_api_gateway" {
    name = "zeeward41_api_gateway"
    description = "Déclenche une fonction Lambda qui récupère le nombre de visiteurs dans une table DynamoDB. Elle peut également augmenter cette valeur de 1."
    endpoint_configuration {
        types = ["REGIONAL"]
    }
}


# Creation dune resource API
resource "aws_api_gateway_resource" "zeeward41_get_visiteurs" {
    rest_api_id = aws_api_gateway_rest_api.zeeward41_api_gateway.id
    parent_id = aws_api_gateway_rest_api.zeeward41_api_gateway.root_resource_id
    path_part = "lambda-to-dynamo-zeeward41"

}

# Creation API methode GET

resource "aws_api_gateway_method" "zeeward41_get_method" {
    rest_api_id = aws_api_gateway_rest_api.zeeward41_api_gateway.id
    resource_id = aws_api_gateway_resource.zeeward41_get_visiteurs.id
    http_method = "GET"
    authorization = "NONE"
}



# Creation API integration

resource "aws_api_gateway_integration" "zeeward41_get_integration" {
    rest_api_id = aws_api_gateway_rest_api.zeeward41_api_gateway.id
    resource_id = aws_api_gateway_resource.zeeward41_get_visiteurs.id
    http_method = aws_api_gateway_method.zeeward41_get_method.http_method
    integration_http_method = "POST"
    type = "AWS_PROXY"
    uri = aws_lambda_function.lambda_get_visiteurs.invoke_arn

}

# Creation API Gateway Deployment

resource "aws_api_gateway_deployment" "zeeward41_api_deployment" {
    rest_api_id = aws_api_gateway_rest_api.zeeward41_api_gateway.id

    lifecycle {
        create_before_destroy = true
    }
    depends_on = [aws_api_gateway_method.zeeward41_get_method, aws_api_gateway_integration.zeeward41_get_integration]
}

# Creation Stage
resource "aws_api_gateway_stage" "zeeward41_api_stage" {
    deployment_id = aws_api_gateway_deployment.zeeward41_api_deployment.id
    rest_api_id =  aws_api_gateway_rest_api.zeeward41_api_gateway.id
    stage_name = "dev"
}


#############  Autre methode (POST)

# Creation API methode Post

resource "aws_api_gateway_method" "zeeward41_post_method" {
    rest_api_id = aws_api_gateway_rest_api.zeeward41_api_gateway.id
    resource_id = aws_api_gateway_resource.zeeward41_get_visiteurs.id
    http_method = "POST"
    authorization = "NONE"
}

# Creation API integration POST

resource "aws_api_gateway_integration" "zeeward41_post_integration" {
    rest_api_id = aws_api_gateway_rest_api.zeeward41_api_gateway.id
    resource_id = aws_api_gateway_resource.zeeward41_get_visiteurs.id
    http_method = aws_api_gateway_method.zeeward41_post_method.http_method
    integration_http_method = "POST"
    type = "AWS_PROXY"
    uri = aws_lambda_function.lambda_modify_nVisiteurs.invoke_arn

}