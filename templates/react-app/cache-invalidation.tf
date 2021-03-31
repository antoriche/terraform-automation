
resource "null_resource" "cloudfront-invalidate-dist" {
  provisioner "local-exec" {
    command = "git clone https://github.com/jweyrich/cloudfront-invalidate-dist.git cloudfront-invalidate-dist && ((cd cloudfront-invalidate-dist && npx sls deploy --region ${var.region}) ; rm -r cloudfront-invalidate-dist) || exit 1 "
  }
}

data "aws_lambda_function" "cloudfront-invalidate-dist" {
  depends_on = [
    null_resource.cloudfront-invalidate-dist
  ]
  function_name = "cloudfront-invalidate-dist-dev-invalidate"
}
