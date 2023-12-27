output "nginx_service_url" {
  description = "URL to access the nginx service"
  value       = kubernetes_service.nginx.status[0].load_balancer.ingress[0].ip
}
