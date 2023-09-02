resource "aws_s3_bucket" "bucket_base" {
    bucket = var.url_web
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


# Creation et attribution d'une policy au bucket Zeeward41 (allow uniquement
// la distribution s3_distribution)

resource "aws_s3_bucket_policy" "zeeward41_bucket_policy" {
    bucket = aws_s3_bucket.bucket_base.id

    policy = jsonencode({
    Version = "2008-10-17",
    Id      = "PolicyForCloudFrontPrivateContent",
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal",
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.bucket_base.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.s3_distribution.arn
          }
        }
      }
    ]
  })
}