# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Data source used to grab the project under which a workspace will be created.
#
# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/project
data "tfe_project" "tfc_project" {
  name         = var.tfc_project_name
  organization = var.tfc_organization_name
}

# Runs in this workspace will be automatically authenticated
# to AWS with the permissions set in the AWS policy.
#
# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "team_workspace" {
  name         = var.tfc_workspace_name
  organization = var.tfc_organization_name
  project_id   = data.tfe_project.tfc_project.id
  auto_apply =  var.auto_apply

  working_directory = var.working_dir

  vcs_repo {
    branch                     = var.vcs_branch
    identifier                 = "${var.vcs_org}/${var.vcs_repository}"
    github_app_installation_id = data.tfe_github_app_installation.ghe_installation.id
  }
}

resource "tfe_workspace_settings" "test-settings" {
  workspace_id   = tfe_workspace.team_workspace.id
  execution_mode = "remote"
}

# The following variables must be set to allow runs
# to authenticate to AWS.
#
# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
resource "tfe_variable" "enable_aws_provider_auth" {
  workspace_id = tfe_workspace.team_workspace.id

  key      = "TFC_AWS_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable the Workload Identity integration for AWS."
}

resource "tfe_variable" "tfc_aws_role_arn" {
  workspace_id = tfe_workspace.team_workspace.id

  key      = "TFC_AWS_RUN_ROLE_ARN"
  value    = aws_iam_role.tfc_role.arn
  category = "env"

  description = "The AWS role arn runs will use to authenticate."
}

# TODO: tomorrow figure out how to configure this to use github and how to authenticate with it
# check the kodekloud vids first

# The following variables are optional; uncomment the ones you need!

# resource "tfe_variable" "tfc_aws_audience" {
#   workspace_id = tfe_workspace.my_workspace.id

#   key      = "TFC_AWS_WORKLOAD_IDENTITY_AUDIENCE"
#   value    = var.tfc_aws_audience
#   category = "env"

#   description = "The value to use as the audience claim in run identity tokens"
# }

# The following is an example of the naming format used to define variables for
# additional configurations. Additional required configuration values must also
# be supplied in this same format, as well as any desired optional configuration
# values.
#
# Additional configurations can be used to uniquely authenticate multiple aliases
# of the same provider in a workspace, with different roles/permissions in different
# accounts or regions.
#
# See https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/specifying-multiple-configurations
# for more details on specifying multiple configurations.
#
# See https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration#specifying-multiple-configurations
# for specific requirements and details for the AWS provider.

# resource "tfe_variable" "enable_aws_provider_auth_other_config" {
#   workspace_id = tfe_workspace.my_workspace.id

#   key      = "TFC_AWS_PROVIDER_AUTH_other_config"
#   value    = "true"
#   category = "env"

#   description = "Enable the Workload Identity integration for AWS for an additional configuration named other_config."
# }
