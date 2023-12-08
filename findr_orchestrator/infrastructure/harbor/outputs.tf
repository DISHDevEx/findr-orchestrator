# outputs.tf

/**
 * The endpoint URL of the deployed Harbor instance
 */
output "harbor_endpoint" {

  description = "The endpoint URL of Harbor instance"

  value = helm_release.harbor.manifest.values["expose"]["tls"]["hosts"][0]

}

/** 
 * The namespace where Harbor was installed
*/
output "harbor_namespace" {

  description = "Namespace where Harbor was installed"

  value = var.harbor_namespace

}

/**
 * The password for the main Harbor admin user 
 */
output "harbor_admin_password" {

  description = "Password for the main admin user of Harbor"

  value = var.harbor_password

  sensitive = true

}
