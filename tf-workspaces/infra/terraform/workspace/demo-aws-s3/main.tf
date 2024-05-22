module "tf_workspace" {
    source = "../../modules/aws-tf-workspace"
    
    tfc_organization_name = "Gnomeosft"
    tfc_project_name = "demo-project"
    tf_workspace = "demo-aws-s3"
}

