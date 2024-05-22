# Workspace bootstrap

To bootstrap a new workspace do the following:

- Create a new tfvars file in the env dir
- Add workspace name to it
- Deploy terraform with:
`terraform apply --var-file env/<workspace>.tf`
