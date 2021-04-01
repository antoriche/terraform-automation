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
  default = "resources/buildspecs/react-build.yml"
}

variable "env_vars" {
  description = "Environnement variables to build"
  type        = "map"
}
variable "test_before_deploy" {
  description = "Run tests before deployment"
  type        = "boolean"
  default     = false
}
variable "test_buildspec" {
  type    = "string"
  default = "resources/buildspecs/react-test.yml"
}

locals {
  name = terraform.workspace
}
