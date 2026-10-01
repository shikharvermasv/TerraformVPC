# Terraform VPC

A hands-on Terraform exercise for learning how to provision basic AWS VPC networking components using Infrastructure as Code.

## What this project demonstrates

This repository covers the Terraform configuration of:

* AWS VPC
* Public and private subnets
* Internet Gateway
* Public route table
* Elastic IP
* NAT Gateway
* Private route table
* Terraform AWS provider

## Architecture

The configuration creates a basic VPC with:

```text
VPC: 10.0.0.0/16
│
├── Public Subnet: 10.0.2.0/24
│   └── Internet Gateway
│       └── Public Route Table
│
└── Private Subnet: 10.0.0.0/24
    └── Private Route Table
        └── NAT Gateway
            └── Public Subnet
```

The NAT Gateway is placed in the public subnet so that resources in the private subnet can access the internet through the NAT Gateway without being directly exposed to inbound internet traffic.

## Terraform Concepts Practiced

This project was created as part of hands-on Terraform and AWS learning.

Key concepts practiced:

* Terraform provider configuration
* AWS resource dependencies
* VPC networking
* CIDR blocks and subnetting
* Internet Gateway configuration
* Route tables and routes
* NAT Gateway configuration
* Elastic IP allocation
* Terraform resource references
* `depends_on`
* Default provider tags

## Repository Structure

```text
TerraformVPC/
└── main.tf
```

The configuration is intentionally kept in a single Terraform file as a learning exercise.

## Getting Started

### Prerequisites

* Terraform
* AWS CLI
* An AWS account
* AWS credentials configured locally

### Initialize Terraform

```bash
terraform init
```

### Review the execution plan

```bash
terraform plan
```

### Apply the configuration

```bash
terraform apply
```

### Destroy the infrastructure

```bash
terraform destroy
```

## Learning Context

This repository represents an early hands-on Terraform exercise focused on understanding AWS networking resources and how Terraform manages their relationships.

For a more complete implementation of modular AWS infrastructure, see my larger project:

**[Infrastructure Provisioning & Container Deployment Platform](https://github.com/shikharvermasv/cloud-infrastructure-provisioner)**

## Note

This is a learning project and is not intended to represent a production-ready VPC architecture.
