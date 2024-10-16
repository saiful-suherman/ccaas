# IaC for CCaaS
This repository contains IaC templates for deploying Azure components necessary for Contact Center as a Service voice infrastructure.

```
ccaas
├── /bicep
│   ├── /audiocodes
│   │   └── # Work in progress
│   │
│   ├── /acs
│   │   └── main.bicep
│   │
│   ├── /event-subscriptions
│   └── # Work in progress
│   
├── /powershell    
│   └── deployAcsInfra.ps1
│
└── /pipelines    
    └── # Work in progress
```

## Bicep
### Audiocodes 
**_Work in progress_...**

### Azure Communication Services
The `main.bicep` template found under the `acs` folder deploys  following resources:

| Resource Type | Description | Purpose | 
| --- | --- | --- |
| Azure Communication Services | --- |  ---|
| Log Analytics Workspace | --- |  ---|
| Event Grid System Topics | --- |  ---|
| Application Insights | --- |  ---|

### Event Subscriptions
**_Work in progress_...**