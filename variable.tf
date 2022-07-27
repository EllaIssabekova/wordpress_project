variable "namespace" {
  type        = string
  default     = null
  description = "Please specify namespace"
}

variable "google_domain_name" {
  type        = string
  default     = null
  description = "Please specify host"
}

variable "project_id" {
  type        = string
  default     = null
  description = "Please specify  project_id"
}
          ####################################### images #################################################
                                      ########### db statefull set ###############

variable "db_replicaCount" {
  type        = string
  default     = null
  description = "Please specify replica count"
}

variable "db_registry" {
  type        = string
  default     = null
  description = "Please specify image"
}


variable "db_repository" {
  type        = string
  default     = null
  description = "Please specify image"
}

variable "db_tag" {
  type        = string
  default     = null
  description = "Please specify tag"
}

variable "db_port" {
  type        = string
  default     = null
  description = "Please specify port"
}

variable "db_deployment_name" {
  type        = string
  default     = null
  description = "Please specify deployment_name"
}

variable "db_ingress_enabled" {
  type        = bool
  description = "Please specify bool"
}

variable "db_inhelm_pvc_enabled" {
  type        = bool
  description = "Please specify bool"
}

variable "db_cpu_limit" {
  type        = string
  default     = null
  description = "Please specify db_cpu_limit"
}

variable "db_memory_limit" {
  type        = string
  default     = null
  description = "Please specify db_memory_limit"
}

variable "db_cpu_request" {
  type        = string
  default     = null
  description = "Please specify db_cpu_request"
}

variable "db_memory_request" {
  type        = string
  default     = null
  description = "Please specify db_memory_request"
}
                                      ########### app deployment ###############
variable "app_replicaCount" {
  type        = string
  default     = null
  description = "Please specify replica count"
}

variable "app_registry" {
  type        = string
  default     = null
  description = "Please specify image"
}

variable "app_repository" {
  type        = string
  default     = null
  description = "Please specify image"
}

variable "app_tag" {
  type        = string
  default     = null
  description = "Please specify tag"
}

variable "app_port" {
  type        = string
  default     = null
  description = "Please specify port"
}

variable "app_ingress_enabled" {
  type        = bool
  description = "Please specify bool"
}

variable "app_deployment_name" {
  type        = string
  default     = null
  description = "Please specify deployment_name"
}

variable "app_inhelm_pvc_enabled" {
  type        = bool
  description = "Please specify bool"
}

variable "app_cpu_limit" {
  type        = string
  default     = null
  description = "Please specify app_cpu_limit"
}

variable "app_memory_limit" {
  type        = string
  default     = null
  description = "Please specify app_memory_limit"
}

variable "app_cpu_request" {
  type        = string
  default     = null
  description = "Please specify app_cpu_request"
}

variable "app_memory_request" {
  type        = string
  default     = null
  description = "Please specify app_memory_request"
}
                      ################################### pvc ###################################
                                            ########### app pvc ###############

variable "app_zone" {
  type        = string
  default     = "us-central1-c"
  description = "Please specify replica count"
}

variable "app_volume_size_gb" {
  description = "number of instanses"
  type        = number
  default     = 5
}

variable "app_labels" {
  description = "labels to set for all resources"
  type        = map(string)
  default     = {
    project     = "wordpress",
    environment = "wordpress"
  }
}
                                            ########### db pvc ###############

variable "db_zone" {
  type        = string
  default     = "us-central1-b"
  description = "Please specify replica count"
}

variable "db_volume_size_gb" {
  description = "number of instanses"
  type        = number
  default     = 5
}

variable "db_labels" {
  description = "labels to set for all resources"
  type        = map(string)
  default     = {
    project     = "wordpress",
    environment = "wordpress"
  }
}
                       ############################ wp config ############################
variable "do_u_want_ur_own_password" {
  type        = bool
  description = "Please specify bool"
}

variable "do_u_want_ur_own_root_password" {
  type        = bool
  description = "Please specify bool"
}

variable "db_name" {
  type        = string
  default     = "mysql"
  description = "Please specify  db_name"
}

variable "db_host_name" {
  type        = string
  default     = null
  description = "Please specify  db_host_name"
}

variable "db_user_password" {
  type        = string
  default     = null
  description = "Please specify  db_password"
}

variable "user" {
  type        = string
  default     = null
  description = "Please specify  user"
}

variable "db_root_password" {
  type        = string
  default     = null
  description = "Please specify  user_password"
}