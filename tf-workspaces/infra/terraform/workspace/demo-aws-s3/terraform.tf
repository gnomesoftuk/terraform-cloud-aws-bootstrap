terraform {
  cloud {
    organization = "Gnomesoft"

    workspaces {
      name = "demo-aws-s3-bootstrap-workspace"
    }
  }
}