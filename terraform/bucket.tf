# create a zip of your deployment with terraform
data "archive_file" "api_dist_zip" {
  type        = "zip"
  source_dir = "../${path.root}/${var.api_dist}"
  output_path = "../${path.root}/${var.api_dist}.zip"
}
resource "aws_s3_bucket" "dist_bucket" {
  bucket = "${var.namespace}-elb-dist"
  acl    = "private"
}
resource "aws_s3_bucket_object" "dist_item" {
  key    = "${var.env}/dist-${uuid()}"
  bucket = "${aws_s3_bucket.dist_bucket.id}"
  source = "${var.dist_zip}"
}
