output "bucket_name" {
  value       = aws_s3_bucket.demo.bucket
  description = "Name des erstellten Buckets"
}

output "bucket_arn" {
  value = aws_s3_bucket.demo.arn
}

output "bucket_region" {
  value = var.aws_region
}

output "website_url" {
  value       = aws_s3_bucket_website_configuration.demo.website_endpoint
  description = "URL der statischen Webseite"
}