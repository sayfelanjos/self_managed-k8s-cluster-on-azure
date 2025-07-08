# Terraform-based Kubernetes Resource Management on Azure

This project provides a robust, event-driven framework for managing Azure Kubernetes Service (AKS) resources using Terraform. It is designed for automated creation, updates, and deletion of resources, making it ideal for integration with CI/CD pipelines and GitOps workflows.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [How It Works](#how-it-works)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [Usage](#usage)
- [Security](#security)
- [Contributing](#contributing)
- [License](#license)

## Overview

The core of this project is a set of Terraform configurations that declaratively manage the state of your Kubernetes infrastructure on Azure. The accompanying scripts act as wrappers around the Terraform CLI, providing a simplified interface for common operations. This event-driven approach allows for seamless integration with other automation systems.

## Features

-   **Declarative Infrastructure**: Define your Azure Kubernetes Service resources as code using Terraform.
-   **Event-Driven Automation**: Easily integrate with automation systems through event-based triggers.
-   **Modular Design**: The Terraform code is structured into reusable modules for better organization and scalability.
-   **Simplified Workflow**: Helper scripts abstract away the complexity of running Terraform commands.
-   **State Management**: Centralized and secure state management using an Azure Storage Account.

## How It Works

The management process is straightforward:

1.  An external event (e.g., a webhook from a CI/CD pipeline) triggers one of the control scripts (`create-k8s-resources.sh`, `update-k8s-resources.sh`, `delete-k8s-resources.sh`).
2.  The script initializes Terraform, selects the appropriate workspace, and applies the configuration to your Azure subscription.
3.  Terraform communicates with the Azure API to create, modify, or remove resources to match the desired state defined in the `.tf` files.

## Project Structure

```plaintext
├── .github/ # GitHub Actions or other repo metadata 
├── terraform/ 
│ ├── cluster/ # Main Terraform configuration for the Kubernetes cluster 
│ ├── modules/ # Reusable Terraform modules 
│ └── shared-state/ # Terraform backend configuration for Azure 
├── create-k8s-resources.sh # Script to create resources 
├── delete-k8s-resources.sh # Script to delete resources 
├── update-k8s-resources.sh # Script to update resources 
├── create-resources-event.json # Sample event payload for creation 
├── delete-resources-event.json # Sample event payload for deletion 
└── update-resources-event.json # Sample event payload for update
```

## Prerequisites

Before you begin, ensure you have the following installed and configured. You can verify your installations with the commands below.

-   **Terraform** (`~> 1.0`)
    ```sh
    terraform version
    ```
-   **Azure CLI**
    ```sh
    az --version
    ```
-   **kubectl**
    ```sh
    kubectl version --client
    ```
    
## Configuration

1.  **Terraform Backend:**
    Navigate to `terraform/shared-state/` and configure the `backend.tf` file to use an Azure Storage Account for remote state. This is crucial for collaboration and state locking. You must create the storage account and container first.

    *Example for Azure Storage backend:*
    ```terraform
    terraform {
      backend "azurerm" {
        resource_group_name  = "your-tfstate-rg"
        storage_account_name = "yourtfstatestorageaccount"
        container_name       = "tfstate"
        key                  = "kubernetes/terraform.tfstate"
      }
    }
    ```

2.  **Authentication:**
    Terraform needs to authenticate with Azure to manage resources.

    **For local development**, the easiest way is to log in with the Azure CLI:
    ```sh
    az login
    ```

    **For automation (CI/CD)**, it is recommended to use a Service Principal. Set the following environment variables:
    ```sh
    export ARM_CLIENT_ID="your-service-principal-client-id"
    export ARM_CLIENT_SECRET="your-service-principal-client-secret"
    export ARM_SUBSCRIPTION_ID="your-azure-subscription-id"
    export ARM_TENANT_ID="your-azure-tenant-id"
    ```

## Usage

You can run the scripts locally to manually manage resources.

### Create Resources
To provision the resources defined in the `terraform/cluster` configuration:
```sh
./create-k8s-resources.sh
```

### Update Resources
To apply changes to existing resources:
```sh
./update-k8s-resources.sh
```

### Delete Resources
To remove the resources from your cluster:
```sh
./delete-k8s-resources.sh
```

## Security

-   **State File Security**: The Terraform state file may contain sensitive data. The Azure backend encrypts data at rest by default. Ensure access to the storage account is restricted.
-   **Secrets Management**: Do not hardcode secrets like passwords or API keys in your Terraform files. Use **Azure Key Vault** to manage and inject secrets securely.
-   **Principle of Least Privilege**: Ensure the Service Principal used by Terraform has only the minimum permissions (role-based access control) required to manage the intended resources in your Azure subscription.