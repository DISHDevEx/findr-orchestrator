output "service_account_name" {
  value = kubernetes_service_account.findr_service_account.metadata[0].name
  description = "The name of the created service account."
}

output "role_name" {
  value = kubernetes_role.findr_role.metadata[0].name
  description = "The name of the created role."
}

output "role_binding_name" {
  value = kubernetes_role_binding.findr_role_binding.metadata[0].name
  description = "The name of the created role binding."
}
