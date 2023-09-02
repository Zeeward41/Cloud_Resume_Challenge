# Provider global

provider "aws" {
    alias = "global"
    region = "us-east-1"
}

# Création d'un bucket qui contiendra les fichiers du site web
variable "url_web" {}

locals {
    s3_origin_id = aws_s3_bucket.bucket_base.bucket_regional_domain_name
    // = Name : www.zeeward41.com.s3.eu-west-3.amazonaws.com
}
