variable "region" {
  type    = "string"
  default = "eu-west-1"
}

variable "repository" {
  description = "CodeCommit repository to use"
  type        = "string"
}

variable "branch" {
  description = "git branch to use"
  type        = "string"
}

variable "buildspec" {
  type    = "string"
  default = "resources/buildspecs/serverless-build.yml"
}

variable "env_vars" {
  description = "Environnement variables to build"
  type        = "map"
}

locals {
  name = terraform.workspace
}
