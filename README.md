# Basic UI Application with Database Interaction

![image](https://github.com/user-attachments/assets/a988cd45-5ff2-41a0-8635-bbc78d22d8f5)

# Azure Application Deployment with Terraform, Docker, and CI/CD Pipeline

## Overview

This project demonstrates the complete deployment process of a web application on Microsoft Azure using Infrastructure as Code (IaC) with Terraform, containerization with Docker, and automated deployment with a CI/CD pipeline (GitHub Actions or GitLab CI).

---

## Features

- **Deploy a web application on Azure App Service**  
  The application connects to a MySQL or PostgreSQL database via a private endpoint.

- **Basic user interface**  
  Provides simple UI to store and retrieve data from the database.

- **Database connection test**  
  Includes a simple test to verify database connectivity.

- **Containerization**  
  The application is packaged into a Docker image with a provided Dockerfile for local build and run.

- **Infrastructure as Code with Terraform**  
  Terraform scripts enable provisioning infrastructure across multiple environments (dev, staging, production), including:  
  - Azure App Service  
  - Azure Database (MySQL/PostgreSQL)  
  - Virtual Network (VNet) and Subnets  
  - Private Endpoint  

- **CI/CD Pipeline**  
  Automates building and pushing Docker images, deploying Terraform infrastructure, deploying the application on Azure, and running tests.

---

## Technologies

- Azure App Service  
- Azure Database for MySQL/PostgreSQL  
- Terraform  
- Docker  
- Node.js / Python (or preferred language)  
- GitHub Actions or GitLab CI  
- Azure Container Registry or Docker Hub  

---

## Getting Started

### 1. Configure Terraform

1. Copy and update the `terraform.tfvars` file (or the environment-specific `.tfvars`) with your configuration.  
2. Run the following commands:

```bash
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
