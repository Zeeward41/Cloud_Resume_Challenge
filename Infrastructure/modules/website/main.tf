# Création d'un bucket qui contiendra les fichiers du site web

resource "aws_s3_bucket" "bucket_base" {
    bucket = "www.zeeward41.coma"

    tags = {
        Architecture = "website"
    }
}

# Transformation du Bucket en Static Website Hosting

resource "aws_s3_bucket_website_configuration" "bucket_website" {
    bucket = aws_s3_bucket.bucket_base.id
    
    index_document {
        suffix = "index.html"
    }
    error_document {
        key = "index.html"
    }
}

# desactivé public access block

resource "aws_s3_bucket_public_access_block" "bucket_base" {
    bucket = aws_s3_bucket.bucket_base.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}