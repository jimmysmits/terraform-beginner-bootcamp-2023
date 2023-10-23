# https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html (bucket naming rules)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    UserUuid = var.user_uuid
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = var.index_html_file_path
  content_type = "text/html"

  etag = filemd5(var.index_html_file_path)
  lifecycle {
    replace_triggered_by = [ terraform_data.content_version ]
    ignore_changes = [ etag ]
  }
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = var.error_html_file_path
  content_type = "text/html"

  etag = filemd5(var.error_html_file_path)
}

# https://aws.amazon.com/blogs/networking-and-content-delivery/amazon-cloudfront-introduces-origin-access-control-oac/

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = {
            "Sid" = "AllowCloudFrontServicePrincipalReadOnly",
            "Effect" = "Allow",
            "Principal" = {
                "Service" = "cloudfront.amazonaws.com"
            },
            "Action" = "s3:GetObject",
            "Resource" = "arn:aws:s3:::${aws_s3_bucket.website_bucket.id}/*",
            "Condition" = {
                "StringEquals" = {
                    "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
                }
            }
        }
    })
}

resource "terraform_data" "content_version" {
  input = var.content_version
}