# Basic UI Application with Database Interaction

![image](https://github.com/user-attachments/assets/a988cd45-5ff2-41a0-8635-bbc78d22d8f5)

# Azure Application Deployment with Terraform, Docker, and CI/CD Pipeline

## Overview

This project demonstrates the complete deployment process of a web application on Microsoft Azure using Infrastructure as Code (IaC) with Terraform, containerization with Docker, and automated deployment with a CI/CD pipeline (GitHub Actions or GitLab CI).

---

## Features

- **The application connects to a MySQL database via a private endpoint**

- **Provides simple UI to store and retrieve data from the database**  

- **Includes a simple test to verify database connectivity**  
  
- **The application is packaged into a Docker image with a provided Dockerfile for build and run.**  

- **Terraform scripts enable provisioning infrastructure across multiple environments (dev, staging, production), including:**  
  - Azure App Service  
  - Azure Database (MySQL/PostgreSQL)  
  - Virtual Network (VNet) and Subnets  
  - Private Endpoint  

- **Automates building and pushing Docker images, deploying Terraform infrastructure, deploying the application on Azure, and running tests.**  
  

---

## Technologies

- Azure App Service  
- Azure Database for MySQL
- Terraform  
- Docker  
- Node.js / Bash
- GitHub Actions
- Azure Container Registry

