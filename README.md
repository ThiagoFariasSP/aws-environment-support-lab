# AWS Environment Support Lab

A conceptual AWS Cloud Engineering and Environment Support project built with Terraform and Python.

This project simulates a real-world AWS environment, including infrastructure provisioning, application hosting, database services, health monitoring, and operational reporting without requiring a live AWS subscription.

## Architecture

```text
Internet
    |
Application Load Balancer
    |
EC2 Web Server
    |
RDS MySQL Database

Project Structure
aws-environment-support-lab/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── python/
│   ├── health_check.py
│   └── analyze_reports.py
│
├── reports/
│
├── docs/
├── diagrams/
│
└── README.md

Example Report

{
  "timestamp": "2026-08-31T09:41:51",
  "cpu": {
    "value": 62,
    "status": "HEALTHY"
  },
  "memory": {
    "value": 30,
    "status": "HEALTHY"
  },
  "disk": {
    "value": 57,
    "status": "HEALTHY"
  }
}

Learning Objectives
Understand Infrastructure as Code (IaC)
Learn Terraform resource management
Simulate AWS architecture design
Build monitoring and reporting solutions with Python
Practice Git and GitHub workflows
Develop Cloud Engineering and SRE foundations
Disclaimer

This project is designed for learning purposes. AWS resources are represented conceptually and are not deployed to a live AWS environment.
