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
 * Output details of findr-s3 module
*/ 
output "findr_s3_details" {

  /**
   * Description of output
   */
  description = "s3 bucket details"

  /**
   * Value from findr-edge module
   */
  value = module.findr-s3[*]

}
