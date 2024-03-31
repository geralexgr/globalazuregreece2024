# Make sure to set the following environment variables:
#   AZDO_PERSONAL_ACCESS_TOKEN
#   AZDO_ORG_SERVICE_URL
terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
}

resource "azuredevops_project" "example" {
  name               = "Example Project"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
  description        = "Managed by Terraform"
}

resource "azuredevops_serviceendpoint_kubernetes" "example-azure" {
  project_id            = azuredevops_project.example.id
  service_endpoint_name = "Example Kubernetes"
  apiserver_url         = "https://sample-kubernetes-cluster.hcp.westeurope.azmk8s.io"
  authorization_type    = "AzureSubscription"

  azure_subscription {
    subscription_id   = "00000000-0000-0000-0000-000000000000"
    subscription_name = "Example"
    tenant_id         = "00000000-0000-0000-0000-000000000000"
    resourcegroup_id  = "example-rg"
    namespace         = "default"
    cluster_name      = "example-aks"
  }
}

resource "azuredevops_serviceendpoint_kubernetes" "example-kubeconfig" {
  project_id            = azuredevops_project.example.id
  service_endpoint_name = "Example Kubernetes"
  apiserver_url         = "https://sample-kubernetes-cluster.hcp.westeurope.azmk8s.io"
  authorization_type    = "Kubeconfig"

  kubeconfig {
    kube_config            = <<EOT
                              apiVersion: v1
                              clusters:
                              - cluster:
                                  certificate-authority: fake-ca-file
                                  server: https://1.2.3.4
                                name: development
                              contexts:
                              - context:
                                  cluster: development
                                  namespace: frontend
                                  user: developer
                                name: dev-frontend
                              current-context: dev-frontend
                              kind: Config
                              preferences: {}
                              users:
                              - name: developer
                                user:
                                  client-certificate: fake-cert-file
                                  client-key: fake-key-file
                             EOT
    accept_untrusted_certs = true
    cluster_context        = "dev-frontend"
  }
}

resource "azuredevops_serviceendpoint_kubernetes" "example-service-account" {
  project_id            = azuredevops_project.example.id
  service_endpoint_name = "Example Kubernetes"
  apiserver_url         = "https://sample-kubernetes-cluster.hcp.westeurope.azmk8s.io"
  authorization_type    = "ServiceAccount"

  service_account {
    token   = "000000000000000000000000"
    ca_cert = "0000000000000000000000000000000"
  }
}