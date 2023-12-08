/**
 * Output details of findr eks module
*/
output "findr_eks_details" {

  /**
   * Description of output
   */
  description = "Cluster details"

  /**
   * Value from findr eks module
   */
  value = module.findr[*]

}


/**
 * Output details of findr-edge module
*/ 
output "findr_edge_eks_details" {

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

  sensitive = true

}
