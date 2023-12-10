/** 
Output for LoadBalancer IP
This output provides instructions on how to retrieve the external IP address of the LoadBalancer.
This external IP is used to access the Harbor UI and API.
**/
output "harbor_url" {
  description = "Instruction to find the external IP address of Harbor's LoadBalancer"
  value       = "Use 'kubectl get svc -n harbor -o wide' to find the external IP address of Harbor's LoadBalancer service."
}

/** 
Output for Harbor's Admin Password
This output reveals the admin password set for Harbor.
It is marked as sensitive to prevent it from being displayed in Terraform's standard output.
**/
output "harbor_admin_password" {
  description = "The admin password for Harbor"
  value       = var.harbor_password
  sensitive   = true
}
