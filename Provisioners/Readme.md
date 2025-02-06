Terraform Workspaces
Terraform workspaces allow managing multiple environments using the same Terraform configuration. They help in maintaining separate state files for different deployments while using a single configuration.

Key Benefits of Terraform Workspaces:

Environment Isolation: Each workspace maintains a separate Terraform state, enabling environment-specific infrastructure management (e.g., dev, staging, prod).
Single Configuration, Multiple Deployments: Workspaces allow managing multiple environments without duplicating Terraform configurations.

State Management: Each workspace has its own state file, preventing conflicts between different environments.
Simplifies Infrastructure Management: Easily switch between environments using terraform workspace select <workspace-name>.
Managing Terraform Workspaces:

Create a new workspace:
terraform workspace new <workspace-name>

List available workspaces:
terraform workspace list

Switch to an existing workspace:
terraform workspace select <workspace-name>

Show the current workspace:
terraform workspace show
