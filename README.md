# Enterprise 2-Tier Azure Infrastructure & Security Lab

## Overview
This repository contains Infrastructure as Code (IaC) and security configurations for a secure, 2-tier Azure cloud deployment. The architecture separates web frontend workloads from isolated backend services using custom Virtual Networks, Network Security Groups (NSGs), and Entra ID Role-Based Access Control (RBAC).

## Key Architecture Highlights
- **Frontend Subnet (`snet-frontend`):** Web server VM (`Standard_B1s`) running Windows Server 2022 / IIS accessible via HTTP (Port 80) and RDP (Port 3389).
- **Backend Subnet (`snet-backend`):** Isolated database tier VM with **Zero Public IP** exposure, accessible only via internal Jumpbox RDP from the frontend tier (`10.0.1.0/24` -> `10.0.2.0/24`).
- **Identity & Security:** Entra ID users restricted via Azure RBAC (`Virtual Machine Contributor`) scoped strictly to resource groups.
- **Observability:** Centralized Log Analytics workspace collecting VM performance metrics and audit trails using KQL queries.

## Technologies Used
- **Cloud Provider:** Microsoft Azure
- **Infrastructure as Code:** Azure Bicep & Azure CLI
- **Identity & Access Management:** Microsoft Entra ID & Azure RBAC
- **Monitoring & Operations:** Azure Monitor, Log Analytics, and Kusto Query Language (KQL)

## How to Deploy
Deploy the infrastructure automatically using Azure CLI:

```bash
# 1. Create target resource group
az group create --name rg-production-01 --location eastus

# 2. Deploy infrastructure via Bicep template
az deployment group create \
  --resource-group rg-production-01 \
  --template-file bicep/main.bicep
