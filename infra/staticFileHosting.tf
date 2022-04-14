resource "aws_s3_bucket" "staticFiles" {
  bucket = "www.matthewmcgowan.co.uk"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_acl" "staticFiles" {
  bucket = aws_s3_bucket.staticFiles.id
  acl    = "private"
}

# Using the deprecated "website" block, as below is bugged.
# The "aws_s3_bucket" resource above tries to remove the null block on next apply
#
# resource "aws_s3_bucket_website_configuration" "staticFiles" {
#   bucket = aws_s3_bucket.staticFiles.id

#   index_document {
#     suffix = "index.html"
#   }
# }

resource "aws_s3_bucket_policy" "allow_reads" {
  bucket = aws_s3_bucket.staticFiles.id
  policy = data.aws_iam_policy_document.allow_reads.json
}

data "aws_iam_policy_document" "allow_reads" {
  statement {
    principals {
      type = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.staticFiles.arn}/*"]
    effect = "Allow"
  }
}
