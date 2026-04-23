# Azure example projects

This repository contains several small Azure example projects that demonstrate common cloud development patterns and integrations.

## Web App example using Key Vault and Blob Storage

This project shows how to build and run an Azure Web App that uses:

- **Azure Key Vault** for key management and encryption
- **Azure Blob Storage** for persistent storage of ASP.NET Core Data Protection keys
- **Managed Identity** for secure, passwordless access to Azure resources

The example demonstrates how a web application can protect and unprotect data while storing its key ring in Blob Storage and encrypting those keys with a key stored in Key Vault.

### What this example covers

- Enabling a system-assigned managed identity for an Azure Web App
- Granting the Web App access to Blob Storage and Key Vault using Azure RBAC
- Configuring ASP.NET Core Data Protection
- Persisting Data Protection keys to Azure Blob Storage
- Protecting Data Protection keys with Azure Key Vault
- Verifying that protected data can be decrypted again by the application

### Why this matters

This setup is a realistic pattern for production applications running on Azure. It avoids storing secrets in code or configuration and ensures that cryptographic material is stored and protected using Azure-native services.

### Prerequisites

Before running this project, make sure you have:

- an Azure subscription
- Azure CLI installed
- a resource group
- an Azure Web App
- an Azure Storage Account
- an Azure Key Vault

Which can be created through the command line following this script: WebApp-DataProtection-Example\create-resources.txt.


### Notes

- The Blob container used for Data Protection must exist before the app can store its key ring.
- The Key Vault key used for Data Protection must also exist.
- The Web App managed identity must have the correct RBAC roles, such as:
  - **Storage Blob Data Contributor**
  - **Key Vault Crypto User**

### Project goal

The goal of this example is to provide a minimal but practical reference for securely integrating an Azure Web App with Blob Storage and Key Vault.





## Container example using Azure Container Instances

This project shows how to build a simple containerized Go application and run it in Azure by using:

- **Docker** for building the container image
- **Azure Container Registry** for storing and pushing the image
- **Azure Container Instances** for running the container without managing virtual machines

The example demonstrates a minimal container workflow from local build to cloud deployment. The application returns a random "Hello world" response so you can verify that the container is running correctly.

### What this example covers

- Building a Linux container image from a Go application
- Running and testing the container locally with Docker
- Creating an Azure resource group and Azure Container Registry
- Pushing the image to Azure Container Registry
- Creating an Azure Container Instance from the published image
- Retrieving the container endpoint after deployment

### Why this matters

This is a practical starter pattern for AZ-204 container topics. It shows the basic flow for packaging code into an image, publishing it to Azure, and running it as a managed container service.

### Prerequisites

Before running this project, make sure you have:

- an Azure subscription
- Azure CLI installed
- Docker installed
- a resource group

The end-to-end setup steps are documented in `Container-ACI-Example/create-resources.txt`.

