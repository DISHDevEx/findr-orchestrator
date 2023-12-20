output "nginx_service_url" {
  description = "URL to access the nginx service"
  value       = kubernetes_service.nginx.load_balancer_ingress[0].hostname
}


