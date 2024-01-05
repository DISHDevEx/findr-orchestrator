/** 
Output for LoadBalancer IP
This output provides instructions on how to retrieve the external IP address of the LoadBalancer.
This external IP is used to access the ui and API.
"Use 'kubectl get svc -n ui -o wide' to find the external IP address of ui's LoadBalancer service."


output "ui_url" {
  description = "Instruction to find the external IP address of ui's LoadBalancer"
  value       = kubernetes_service.ui_service.load_balancer_ingress[0].hostname
}

**/