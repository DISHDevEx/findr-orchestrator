variable "bucket_name" {
  type    = string
  default = ""
}

variable "bucket_versioning" {
  type    = string
  default = "Enabled"
}

variable "bucket_policy_file" {
  type    = string
  default = "false"
}

variable "bucket_policy_file_path" {
  type    = string
  default = null
}