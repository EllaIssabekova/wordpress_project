variable "google_domain_name" {
  type        = string
  default     = null
  description = "Please specify host"
}

variable "user" {
  type        = string
  default     = null
  description = "Please specify  user"
}

variable "do_u_want_ur_own_password" {
  type        = bool
  description = "Please specify bool"
}

variable "do_u_want_ur_own_root_password" {
  type        = bool
  description = "Please specify bool"
}

variable "db_user_password" {
  type        = string
  default     = null
  description = "Please specify  db_password"
}

variable "db_root_password" {
  type        = string
  default     = null
  description = "Please specify  user_password"
}