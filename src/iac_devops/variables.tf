variable "org_service_url" {
  description = "The URL of your Azure DevOps organization."
}

variable "personal_access_token" {
  description = "The personal access token for authentication."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "aks_name" {
  type        = string
  description = "AKS Cluster name."
}

variable "azuredevops_project_name" {
  type        = string
  description = "Azure DevOps Project Name."
}

variable "serviceconnection_name" {
  type        = string
  description = "Azure DevOps Project Name."
}

variable "azure_subscription_name" {
  type        = string
  description = "Azure DevOps Project Name."
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}