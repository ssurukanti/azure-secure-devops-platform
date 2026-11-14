variable "project" {
  description = "Short project name used in resource naming."
  type        = string
  default     = "secure-platform"
}

variable "environment" {
  description = "Environment name: dev, qa, or prod."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "Central US"
}

variable "aks_node_count" {
  description = "AKS system node pool size (keep small for a demo)."
  type        = number
  default     = 2
}

variable "aks_node_size" {
  description = "AKS node VM size."
  type        = string
  default     = "Standard_B2s"
}

variable "tags" {
  description = "Common tags for all resources."
  type        = map(string)
  default = {
    project     = "azure-secure-devops-platform"
    environment = "dev"
    managed_by  = "terraform"
  }
}
