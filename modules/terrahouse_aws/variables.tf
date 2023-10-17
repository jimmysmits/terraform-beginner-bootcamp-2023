variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx', where x is a hexadecimal digit."
  }
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "The bucket name must be between 3 and 63 characters long and can only contain lowercase letters, numbers, hyphens, and periods."
  }
}

variable "index_html_file_path" {
  description = "Path to the index.html file"
  type        = string

  validation {
    condition     = fileexists(var.index_html_file_path)
    error_message = "The specified index.html file path is not a valid file or does not exist."
  }
}

variable "error_html_file_path" {
  description = "Path to the index.html file"
  type        = string

  validation {
    condition     = fileexists(var.error_html_file_path)
    error_message = "The specified error.html file path is not a valid file or does not exist."
  }
}

