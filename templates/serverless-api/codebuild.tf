data "local_file" "buildspec" {
  filename = "${path.module}/../../${var.buildspec}"
}


resource "aws_codebuild_project" "codebuild" {
  name         = "${local.name}-codebuild"
  description  = var.buildspec
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    dynamic "environment_variable" {
      for_each = var.env_vars
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
    environment_variable {
      name  = "VARS"
      value = join("|", keys(var.env_vars))
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = data.local_file.buildspec.content
  }
}


resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-${var.region}-${local.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "AWSCodeBuildServiceRole-policy-${var.region}-${local.name}"
  role = aws_iam_role.codebuild_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "logs:*",
            "cloudformation:*",
            "s3:*",
            "iam:*",
            "lambda:*",
            "apigateway:*"
        ],
        "Resource": ["*"]
    },
    {
        "Effect": "Allow",
        "Resource": [
            "arn:aws:s3:::${aws_s3_bucket.codepipeline_bucket.bucket}",
            "arn:aws:s3:::${aws_s3_bucket.codepipeline_bucket.bucket}/*"
        ],
        "Action": [
            "s3:PutObject",
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:GetBucketAcl",
            "s3:GetBucketLocation"
        ]
    }
  ]
}
EOF
}
