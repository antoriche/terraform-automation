data "local_file" "test_buildspec" {
  filename = "${path.module}/../../${var.test_buildspec}"
}


resource "aws_codebuild_project" "test_codebuild" {
  name         = "${local.name}-tests-codebuild"
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
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = data.local_file.test_buildspec.content
  }
}
