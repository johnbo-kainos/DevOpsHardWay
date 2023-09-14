variable "name" {
  type        = string
  default     = "devopsthehardway"
  description = "Name for resources"
}

variable "location" {
  type        = string
  default     = "uksouth"
  description = "Azure Location of resources"
}

variable "addons" {
  description = "Defines which addons will be activated."
  type = object({
    oms_agent                   = bool
    ingress_application_gateway = bool
  })
}

variable "kubernetes_cluster_rbac_enabled" {
  default = "true"
}

variable "kubernetes_version" {
}

variable "agent_count" {
}

variable "vm_size" {
}

variable "aks_admin_group_name" {
}