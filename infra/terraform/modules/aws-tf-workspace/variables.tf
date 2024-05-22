# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "tfc_workspace_name" {
  type        = string
  description = "The name of the workspace that you'd like to create and connect to AWS"
}

variable "tfc_aws_audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "The audience value to use in run identity tokens"
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance you'd like to use with AWS"
}

variable "tfc_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization"
}

variable "tfc_project_name" {
  type        = string
  description = "The project under which a workspace will be created"
}

variable "aws_oidc_provider_tfc" {
  type = string
  description = "the oidc provider arn set in in AWS for authenicating TF cloud"
}

variable "aws_oidc_client_id_list_tfc" {
  type = list(string)
  description = "The client list set up in the oidc provider in AWS"
}
