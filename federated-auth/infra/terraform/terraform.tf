terraform {
  cloud {
    organization = "Gnomesoft"

    workspaces {
      name = "demo-project-bootstrap-auth"
    }
  }
}