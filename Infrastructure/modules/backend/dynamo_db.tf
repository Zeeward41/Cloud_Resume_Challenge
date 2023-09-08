# Creation dynamo DB table

resource "aws_dynamodb_table" "my_table_dynamo" {
    
    name = "Table_zeeward41"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "siteID"
    attribute {
        name = "siteID"
        type = "S"
    }

    
}

# Creation de l'item NombreVisiteurs
resource "aws_dynamodb_table_item" "ma_table" {
    
    table_name = aws_dynamodb_table.my_table_dynamo.name
    hash_key = aws_dynamodb_table.my_table_dynamo.hash_key

    item = <<ITEM
    {
        "siteID": {"S": "site_zeeward41"},
        "NombreVisiteurs": {"N": "0"}
        
    }
    ITEM
}