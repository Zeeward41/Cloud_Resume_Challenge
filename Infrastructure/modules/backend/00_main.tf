# Provider global

provider "aws" {
    alias = "global"
    region = "us-east-1"
}

# Variables

variable "region_base" {}


# Creation role pour lambda --> DynamoDB

resource "aws_iam_role" "lambda_DynamoDB_Faccess" {
    name = "lambda_DynamoDB_Faccess"
    description = "Iam Role pour qu'une lambda est un acces total à DynamoDB"
    managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"]
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Action = "sts:AssumeRole",
                Effect = "Allow",
                Principal = {
                    Service = "lambda.amazonaws.com"
                }
            }
        ]
    })
}