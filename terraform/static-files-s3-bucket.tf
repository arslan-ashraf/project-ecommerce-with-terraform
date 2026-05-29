resource "aws_s3_bucket" "static_files_s3_bucket" {
  bucket = "static-files-bucket-3l5ka8nb5"
}

resource "aws_s3_bucket_policy" "static_website_bucket_policy" {
  bucket = aws_s3_bucket.static_files_s3_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_files_s3_bucket.arn}/*"
      }
    ]
  })

}

resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static_files_s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_object" "index_html_page" {
  bucket       = aws_s3_bucket.static_files_s3_bucket.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
  etag         = filemd5("static-files/index.html")
}

resource "aws_s3_object" "error_html_page" {
  bucket       = aws_s3_bucket.static_files_s3_bucket.id
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
  etag         = filemd5("static-files/error.html")
}