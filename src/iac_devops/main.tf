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
  org_service_url = "https://dev.azure.com/gealexiou/"
  personal_access_token ="ddfjk6zmlnckqo5j7yuemvw7hcnwc4kumnro2irsx46eupfw6oka"
}

data "azurerm_kubernetes_cluster" "cluster" {
  name                = "geralexgr-cluster"
  resource_group_name = "example-rg"
}

data "azuredevops_project" "project" {
  name = "GlobalAzureGreece 2024"
}

resource "azuredevops_serviceendpoint_kubernetes" "example-azure" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "Example-AKS"
  apiserver_url         = data.azurerm_kubernetes_cluster.cluster.kube_config[0].host
  authorize_pilelines   = true
  authorization_type    = "AzureSubscription"

  azure_subscription {
    subscription_id   = "43709a15-a023-45e7-90a6-e30c5ffad83e"
    subscription_name = "MVP"
    tenant_id         = "4e6a568f-34d9-43a6-9c1f-32f6619147fd"
    resourcegroup_id  = "example-rg"
    namespace         = "default"
    cluster_name      = "geralexgr-cluster"
  }
}