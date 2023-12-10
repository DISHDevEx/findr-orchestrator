/**
 * Namespace for Vault services
*/
variable "vault_namespace" {

  /**
   * Description of what the namespace is used for
   */
  description = "The Kubernetes namespace where Vault is deployed"

  /**
   * Variable type
   */
  type = string

  /**
   * Default namespace
   */ 
  default = "vault"

}