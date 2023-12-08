/**
 * Output details of findr-orchestrator module
*/
output "findr_orchestrator_details" {

  /**
   * Description of output
   */
  description = "Cluster details"

  /**
   * Value from findr-orchestrator module
   */
  value = module.findr-orchestrator[*]

}


/**
 * Output details of findr-edge module
*/ 
output "findr_edge_details" {

  /**
   * Description of output
   */
  description = "Cluster details"

  /**
   * Value from findr-edge module
   */
  value = module.findr-edge[*]

}


/**
 * Output Kubernetes namespaces
*/
output "findr_namespaces" {

  /**
   * Value from namespace module
   */
  value = module.namespace[*]

  /**
   * Description of output
   */
  description = "The names of created Kubernetes namespace."

}


/**
 * Output details from Monitoring module
*/
output "findr_monitoring" {

  /**
   * Value from Monitoring module
   */
  value = module.monitoring[*]

  /**
   * Description of output
   */
  description = "Details about resources deployed by the Monitoring module"

}


/**
 * Output details from Vault module
*/
output "findr_vault" {

  /**
   * Value from Vault module  
   */
  value = module.vault[*]

  /**
   * Description of output
   */
  description = "Details about the Vault deployment"

  /**
   * Mark as sensitive
   */
  sensitive = true

}


/**
 * Output details from Harbor module
*/
output "findr_harbor" {

  /**
   * Value from Harbor module
   */ 
  value = module.harbor[*]

  /**
   * Description of output
   */
  description = "Details about the Harbor deployment"

  /**
   * Mark as sensitive
   */
  sensitive = true

}

