resource "aws_s3_bucket" "s3_images" {
  bucket        = "s3-sample5-images1"
  force_destroy = true
  # tags          = var.tags
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.s3_images.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption_configuration" {
  bucket = aws_s3_bucket.s3_images.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# resource "aws_s3_bucket_logging" "logging" {
#   bucket = aws_s3_bucket.s3_images.id

#   target_bucket = aws_s3_bucket.s3_images.id # 今回は同じバケットを指定
#   target_prefix = "log/"
# }

resource "aws_s3_bucket_website_configuration" "static_hosting" {
  bucket = aws_s3_bucket.s3_images.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index" {
  key          = "index.html"
  bucket       = aws_s3_bucket.s3_images.id
  source       = "../files/index.html"
  content_type = "text/html"
  # kms_key_id = aws_kms_key.examplekms.arn
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_images.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.s3_images.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
