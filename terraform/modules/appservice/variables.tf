variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "app_insights_connection_string" {
  type    = string
  default = null
}

variable "app_insights_instrumentation_key" {
  type    = string
  default = null
}
