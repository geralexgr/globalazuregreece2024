variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "aks_name" {
  type        = string
  description = "AKS Cluster name."
}

variable "aks_node_size" {
  type        = string
  description = "AKS Cluster name."
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
}