terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
}

data "azuredevops_project" "project" {
  name = "GlobalAzureGreece 2024"
}

resource "azuredevops_serviceendpoint_kubernetes" "example-azure" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "Example-AKS"
  apiserver_url         = "https://dns-calm-grub-dja0mgha.hcp.westeurope.azmk8s.io"
  authorization_type    = "AzureSubscription"

  azure_subscription {
    subscription_id   = "43709a15-a023-45e7-90a6-e30c5ffad83e"
    subscription_name = "MVP"
    tenant_id         = "4e6a568f-34d9-43a6-9c1f-32f6619147fd"
    resourcegroup_id  = "example-rg"
    namespace         = "default"
    cluster_name      = "example-cluster"
  }
}