# globalazuregreece2024
Global Azure Greece 2024 demo


![Diagram](/resources/design.png)


## About

In this demo a kubernetes application is deployed only with a couple of click. Everything is performed through automation with terraform and azure devops pipelines.  


- The AKS cluster is deployed through terraform on Azure
- The service connection is created using the terraform provider for Azure DevOps
- The application is deployed through the pipeline code and the previous components that are created.


## Links
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs  
https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs  
