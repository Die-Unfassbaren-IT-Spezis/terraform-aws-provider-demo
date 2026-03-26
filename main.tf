resource "aws_s3_bucket" "demo" {
  bucket = var.bucket_name

  tags = var.bucket_tags
}

resource "aws_s3_bucket_website_configuration" "demo" {
  bucket = aws_s3_bucket.demo.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "demo" {
  bucket = aws_s3_bucket.demo.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "demo" {
  bucket = aws_s3_bucket.demo.id

  depends_on = [aws_s3_bucket_public_access_block.demo]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.demo.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.demo.id
  key          = "index.html"
  source       = "${path.module}/demo-html-files/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/demo-html-files/index.html")
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.demo.id
  key          = "error.html"
  source       = "${path.module}/demo-html-files/error.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/demo-html-files/error.html")
}