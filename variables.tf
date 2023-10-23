variable "user_uuid" {
  description = "User UUID"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "index_html_file_path" {
  description = "Path to the index.html file"
  type        = string
}

variable "error_html_file_path" {
  description = "Path to the index.html file"
  type        = string
}

variable "content_version" {
  description = "The content version, a positive integer starting at 1."
  type        = number
}
