[Home](../README.md) | [Sprint 1](README.md)

---

<p align="right">
    <img src="../.assets/logo-02.png" width="140x" />
</p>

# Knixat Cloud DevOps - Sprint 8
### Hators Corp Cloud Infrastructure Design Documentation
---
The Infrastructure is designed to create a robust Cloud solution to host various application workloads considering various factors like High Availability, Autoscaling, Security

1.  Web Application - "MediConnect"
      - Azure FrontDoor: Azure Front Door and CDN profiles is security led, modern cloud CDN that provides static and dynamic content acceleration, global load balancing and enhanced security for your apps, APIs and websites with intelligent threat protection. these provide security, availability and scalability simultenously 
  
      - App service: it helps to  Create, build, deploy, and manage powerful web, mobile, and API apps using a single back-end. the solution suggest a PaaS. it has two web app to provide high availabilty which are deployed in different regions, with one being the primary and the other; standby. The Azure frontdoor helps to perform failover when the primary fails.
  
  
      - App service plan: App Service plans represent the collection of physical resources used to host your web apps, like location, scale, size and SKU
  
      - Azure Monitor: Azure Monitor is a comprehensive monitoring solution for collecting, analyzing, and responding to monitoring data from your cloud and on-premises environments. You can use Azure Monitor to maximize the availability and performance of your applications and services. It helps you understand how your applications are performing and allows you to manually and programmatically respond to system events.
  
      - Application Insights: it helps to monitor live web apps

2.  Storage Solution for Unstructured Data - "HealthVault"
       - Storage account:An Azure storage account contains all of your Azure Storage data objects: blobs, files, queues, and tables. The storage account provides a unique namespace for your Azure Storage data that's accessible from anywhere in the world over HTTP or HTTPS. Data in your storage account is durable and highly available, secure, and massively scalable. it provides soluton to store unstructued data using blobs.
       - Backup Center
  
       - Microsoft Managed Keys
    
  
3.  Virtual Desktops (Bastion) for Developers - "CodeHealth Workspace"
    - Azure Bastion
    - Virtual Machines
    - Network security groups
    - Virtual Networks and private subnet
  
4. Cost-Saving Deployment Model for API - "HealthAPI"
    - Function app 
   
   


---

<p align="left">
    <img src="../.assets/logo-03.png" width="50x" />
</p>

**Contact Us:**  
Email: [admissions@knixat.com](mailto:admissions@email.com)  
Website: [www.knixat.com](https://www.knixat.com)

&copy; 2023 Knixat. All Rights Reserved.

---

[Home](../README.md) | [Sprint 1](README.md)
