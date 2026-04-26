# 🚀 **Serverless Lab: Lambda, API, and WAF Integration**

![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge&logo=amazonaws)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge&logo=terraform)
![Lambda](https://img.shields.io/badge/Lambda-Serverless-FF9900?style=for-the-badge&logo=awslambda)
![API Gateway](https://img.shields.io/badge/API_Gateway-REST_API-4B32C3?style=for-the-badge)
![Security](https://img.shields.io/badge/Security-WAF-critical?style=for-the-badge)
![CI/CD](https://img.shields.io/badge/CI/CD-Ready-success?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Production_Validated-success?style=for-the-badge)

---

## 📌 **Executive Summary**

This project demonstrates how to design and deploy a **secure, production-minded serverless API platform** on AWS using **Terraform Infrastructure as Code**.

It showcases how modern cloud teams can protect APIs at the edge, automate deployments, reduce compute waste, and centralize observability.

---

## 🔥 **Core Capabilities**

✅ AWS WAF protects API traffic before Lambda invocation  
✅ REST API Gateway provides secure routing layer  
✅ Multi-runtime Lambda support (Python + Node.js)  
✅ CloudWatch centralized logs and monitoring  
✅ Terraform automates full lifecycle deployment  

---

## 📚 **Table of Contents**

- [**Architecture**](#️-architecture)
- [**Business Value**](#-business-value)
- [**Technology Stack**](#-technology-stack)
- [**Project Structure**](#-project-structure)
- [**Deployment Guide**](#-deployment-guide)
- [**Validation Tests**](#-validation-tests)
- [**Security Controls**](#️-security-controls)
- [**Observability**](#-observability)
- [**Cost Optimization**](#-cost-optimization)
- [**Troubleshooting**](#-troubleshooting)
- [**Teardown**](#-teardown)
- [**Lessons Learned**](#-lessons-learned)
- [**Portfolio Value**](#-portfolio-value)

---

## 🏛️ **Architecture**

![diagram.png](/images/diagram.png)

---

## 💼 **Business Value**

This architecture reflects real enterprise patterns:

- 🛡️ Reduce attack surface before compute execution
- 💰 Lower Lambda cost by blocking abusive traffic
- ⚡ Scale automatically with zero idle infrastructure
- 📈 Improve observability and operational readiness
- 🔁 Enable repeatable deployments with Terraform

---

## 🧰 **Technology Stack**

| **Layer**          | **Technology**               |
| ------------------ | ---------------------------- |
| **Cloud Provider** | **AWS**                      |
| **IaC**            | **Terraform**                |
| **Compute**        | **AWS Lambda**               |
| **API Layer**      | **REST API Gateway**         |
| **Security**       | **AWS WAF**                  |
| **Monitoring**     | **CloudWatch**               |
| **Languages**      | **Python / Node.js**         |
| **CI/CD Ready**    | **GitHub Actions / Jenkins** |

---

## 📁 **Project Structure**

```text
lesson-b/
├── deliverables/
│   ├── aws-waf-api-gateway.log
│   ├── deliverable1.jpg
│   ├── deliverable2.jpg
│   ├── deliverable3.jpg
│   └── deliverable4.jpg
│
├── images/
│   ├── diagram.png
│   ├── rest-api-node.jpg
│   ├── rest-api-python.jpg
│   ├── terraform-apply.jpg
│   ├── terraform-destroy.jpg
│   ├── terraform-init-fmt-validate.jpg
│   ├── terraform-plan.jpg
│   ├── waf-dashboard-managed-rules.jpg
│   ├── waf-dashboard-rating-rule.jpg
│   └── waf-rules.jpg
|
├── lambda/
│   ├── lambda_function.py
│   ├── index.js
│   ├── lambda_python.zip
│   └── lambda_node.zip
│
├── .gitignore
├── 0-auth.tf
├── 1-provider.tf
├── 2-variables.tf
├── 3-iam.tf
├── 4-lambda.tf
├── 5-cloudwatch.tf
├── 6-apigateway.tf
├── 7-waf.tf
├── 8-outputs.tf
└── README.md
```

---

## 🚀 **Deployment Guide**

## Prerequisites

- Terraform ≥ 1.10
- AWS CLI configured
- IAM permissions
- Git / Terminal

## Deploy

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

![terraform-init-fmt-validate.jpg](/images/terraform-init-fmt-validate.jpg)
![terraform-plan.jpg](/images/terraform-plan.jpg)
![terraform-apply.jpg](/images/terraform-apply.jpg)

---

## 🧪 **Validation Tests**

### **Test Python Endpoint**

```bash
curl "https://<api-id>.execute-api.<region>.amazonaws.com/prod/python?name=Chewbacca"
curl "https://<api-id>.execute-api.<region>.amazonaws.com/prod/python?name=Malgus"
```

![deliverable1.jpg](/deliverables/deliverable1.jpg)

### **Test Node Endpoint and WAF XXS Blocking**

```bash
curl "https://<api-id>.execute-api.<region>.amazonaws.com/prod/node?name=Malgus"
curl "https://<api-id>.execute-api.<region>.amazonaws.com/prod/python?name=%3Cscript%3Ealert(1)%3C/script%3E"
```

![deliverable2.jpg](/deliverables/deliverable2.jpg)

### **Test WAF Rate Limiting**

```bash
for i in {1..150}; do curl -s https://<api-id>.execute-api.<region>.amazonaws.com/prod/node"
done
```

![deliverable3.jpg](/deliverables/deliverable3.jpg)

### **Test Invocation URLs**

```text
https://<api-id>.execute-api.<region>.amazonaws.com/prod/python?name=Chewbacca
https://<api-id>.execute-api.<region>.amazonaws.com/prod/python?name=Malgus
https://<api-id>.execute-api.<region>.amazonaws.com/prod/node?name=Malgus
```

![deliverable4.jpg](/deliverables/deliverable4.jpg)

### **CloudWatch Logs**

- [**WAF Logs**](/deliverables/aws-waf-api-gateway.log)
- [**Lambda Node Logs**](/deliverables/chewbacca-node-lambda.log)
- [**Lambda Python Logs**](/deliverables/chewbacca-python-lambda.log)

---

## 🛡️ **Security Controls**

- AWS WAF attached to API Gateway
- Rate limiting rules enabled
- XSS / malicious payload filtering
- Least privilege IAM for Lambda
- No static servers exposed publicly
- Immutable deployments via Terraform

![rest-api-node.jpg](/images/rest-api-node.jpg)
![rest-api-python.jpg](/images/rest-api-python.jpg)
![waf-rules.jpg](/images/waf-rules.jpg)
![waf-resources.jpg](/images/waf-resources.jpg)
![waf-dashboard-managed-rules.jpg](/images/waf-dashboard-managed-rules.jpg)
![waf-dashboard-rating-rule.jpg](/images/waf-dashboard-rating-rule.jpg)

---

## 📊 **Observability**

### **Logs**

CloudWatch Log Groups:

```text
/aws/lambda/chewbacca-python-lambda
/aws/lambda/chewbacca-node-lambda
```

### **Recommended Metrics**

- Lambda errors
- WAF blocked requests
- Request volume
- Cost trend

### **Recommended Alerts**

- Lambda errors > threshold
- WAF anomaly spike

---

## 💰 **Cost Optimization**

- Serverless pay-per-use compute
- WAF blocks malicious requests before Lambda charges
- Log retention can be reduced
- Operational overhead minimized

---

## 🧯 **Troubleshooting**

| **Symptom**     | **Likely Cause**            | **Resolution**            |
| --------------- | --------------------------- | ------------------------- |
| `403 Forbidden` | **WAF blocked request**     | **Review WAF rules**      |
| `404 Not Found` | **Wrong route/stage**       | **Validate API path**     |
| `500 Error`     | **Lambda exception**        | **Check CloudWatch logs** |
| `Timeout`       | **IAM/network issue**       | **Validate permissions**  |
| `No Logs`       | **Missing IAM permissions** | **Fix execution role**    |

---

## 💣 **Teardown**

```bash
terraform destroy -auto-approve
```

![terraform-destroy.jpg](/images/terraform-destroy.jpg)

---

## 📘 **Lessons Learned**

- Security should start at the edge
- Terraform enables repeatable deployments
- WAF reduces cost + risk
- CloudWatch is essential for operations
- Serverless platforms can still require strong governance

---

## 👤 **Author**

| **Field**   | **Value**                                   |
| ----------- | ------------------------------------------- |
| **Author**  | `T.I.Q.S.`                                  |
| **Team**    | `Brotherhood of Evil jerMutants - Wolfpack` |
| **Lead**    | `John Sweeney`                              |
| **Date**    | `April 2026`                                |
| **Version** | `2.0`                                       |

---

## ⭐ **Portfolio Value**

This project demonstrates production-level experience in:

- Terraform Infrastructure as Code
- AWS Serverless Architecture
- API Security Controls
- Cloud Operations
- Logging & Monitoring
- CI/CD Readiness
- Production-minded Design

---

## 🏁 Final Statement

This repository reflects the mindset of a modern DevOps / Platform Engineer:

> Build secure systems, automate everything, observe everything, and make operations repeatable.
