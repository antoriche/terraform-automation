locals{
    is_github = replace(var.repository, "github", "") != var.repository
    codecommit_repo_name = local.is_github == false ? split("repos/", var.repository)[1] : null
}
resource "aws_codestarconnections_connection" "github" {
  count         = local.is_github ? 1 : 0
  name          = "${local.name}-github-connection"
  provider_type = "GitHub"
}

data "aws_codecommit_repository" "codecommit" {
    count = local.is_github ? 0 : 1 
    repository_name = local.codecommit_repo_name
}

locals {
    pipeline_source_provider = local.is_github ? "CodeStarSourceConnection" : "CodeCommit"
    pipeline_source_config = local.is_github ? {
        ConnectionArn    = aws_codestarconnections_connection.github[0].arn
        FullRepositoryId = var.repository
        BranchName       = var.branch
    } : {
        RepositoryName = local.codecommit_repo_name
        BranchName       = var.branch
        PollForSourceChanges = true
    }
}