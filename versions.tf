provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      GithubRepo = "terraform-aws-wandb"
      GithubOrg  = "wandb"
      Enviroment = "dev"
      Example    = "PublicDnsExternal"
    }
  }
}
