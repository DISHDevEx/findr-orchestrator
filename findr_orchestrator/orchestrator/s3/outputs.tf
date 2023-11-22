#Outputs
output "s3_bucket_outputs" {
  description = "S3 bucket name and other properties"
  value       = module.s3_bucket[*]
}