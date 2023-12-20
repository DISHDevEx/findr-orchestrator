/** 
Output for LoadBalancer IP
This output provides instructions on how to retrieve the external IP address of the LoadBalancer.
This external IP is used to access the oracle and API.
**/
output "oracle_url" {
  description = "Instruction to find the external IP address of oracle's LoadBalancer"
  value       = "Use 'kubectl get svc -n oracle -o wide' to find the external IP address of oracle's LoadBalancer service."
}