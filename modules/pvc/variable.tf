variable "app_zone" {
  type        = string
  default     = null
  description = "Please specify replica count"
}

variable "app_volume_size_gb" {
  description = "number of instanses"
  type        = number
  default     = null
}

variable "app_labels" {
  description = "labels to set for all resources"
  type        = map(string)
  default     = null
}
##############################

variable "db_zone" {
  type        = string
  default     = null
  description = "Please specify replica count"
}

variable "db_volume_size_gb" {
  description = "number of instanses"
  type        = number
  default     = null
}

variable "db_labels" {
  description = "labels to set for all resources"
  type        = map(string)
  default     = null
}

##

variable "project_id" {
  type        = string
  default     = null
  description = "Please specify  project_id"
}

variable "namespace" {
  type        = string
  default     = null
  description = "Please specify  namespace"
}