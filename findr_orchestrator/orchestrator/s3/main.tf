/*
Terraform configurations for all findr clusters.
*/

##S3 module
##findr-bucket
module "findr-bucket" {
  source                  = "git@github.com:DISHDevEx/iot.git//aws/modules/s3"
  bucket_name             = var.bucket_name
  bucket_versioning       = var.bucket_versioning
  pass_bucket_policy_file = var.bucket_policy_file
  bucket_policy_file_path = var.bucket_policy_file_path
}