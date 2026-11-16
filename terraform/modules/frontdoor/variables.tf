variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "app_service_host" {
  type = string
}

variable "tags" {
  type = map(string)
}
