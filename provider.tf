provider "aws" {

  region = var.region
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.project_env

    }
  }

}
