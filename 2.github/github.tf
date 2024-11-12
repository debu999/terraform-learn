terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  # token = use GITHUB_TOKEN env var instead
}

resource "github_repository" "terraform-learn" {
  name        = "terraform-learn"
  description = "Terraform Learning Codebase"

  visibility = "public"
}