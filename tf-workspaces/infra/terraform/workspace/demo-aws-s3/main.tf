locals {
    organization = "Gnomesoft"
    project = "demo-project"
    workspace = "demo-aws-s3"
}

data "tfe_outputs" "bootstrap" {
  organization = local.organization
  workspace = "demo-project-bootstrap-auth"
}

module "tf_workspace" {
    source = "../../modules/aws-tf-workspace"
    
    tfc_organization_name = local.organization
    tfc_project_name = local.project
    tfc_workspace_name = local.workspace
    aws_oidc_provider_tfc = data.tfe_outputs.bootstrap.values.aws_oidc_provider_tfc
    aws_oidc_client_id_list_tfc =  data.tfe_outputs.bootstrap.values.aws_oidc_client_id_list_tfc
}