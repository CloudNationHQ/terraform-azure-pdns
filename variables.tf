variable "zones" {
  description = "contains private dns zones configuration"
  type        = any
}

variable "resourcegroup" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
