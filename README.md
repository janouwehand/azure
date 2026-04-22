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

### Notes

- The Blob container used for Data Protection must exist before the app can store its key ring.
- The Key Vault key used for Data Protection must also exist.
- The Web App managed identity must have the correct RBAC roles, such as:
  - **Storage Blob Data Contributor**
  - **Key Vault Crypto User**

### Project goal

The goal of this example is to provide a minimal but practical reference for securely integrating an Azure Web App with Blob Storage and Key Vault.