terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=1.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.9"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

provider "azuredevops" {
  org_service_url       = var.org_service_url
  personal_access_token = var.personal_access_token
}

data "azurerm_kubernetes_cluster" "cluster" {
  name                = var.aks_name
  resource_group_name = var.resource_group_name
}

data "azuredevops_project" "project" {
  name = var.azuredevops_project_name
}

resource "azuredevops_serviceendpoint_kubernetes" "aks" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = var.serviceconnection_name
  apiserver_url         = data.azurerm_kubernetes_cluster.cluster.kube_config[0].host
  authorization_type    = "AzureSubscription"

  azure_subscription {
    subscription_id   = var.subscription_id
    subscription_name = var.azure_subscription_name
    tenant_id         = var.tenant_id
    resourcegroup_id  = var.resource_group_name
    namespace         = "default"
    cluster_name      = var.aks_name
  }
}


resource "azuredevops_resource_authorization" "authorization" {
  project_id  = data.azuredevops_project.project.id
  resource_id = azuredevops_serviceendpoint_kubernetes.aks.id
  authorized  = true
}