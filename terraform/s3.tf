resource "aws_s3_bucket" "bucket" {
  bucket = "${var.project}-bucket-12345"

  tags = {
    Project = var.project
  }
}
