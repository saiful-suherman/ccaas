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
│   └── /event-subscriptions
│      └── # Work in progress
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

## PowerShell
PowerShell scripts are used to deploy the respective Bicep Templates.

```
/powershell    
    ├── deployAudiocodesStackManager.ps1 # Work in progress
    └── deployAcsInfra.ps1
```
| Script | Description | 
| --- | --- |
| deployAudiocodesStackManager.ps1 | _Work in progress_<br>Deploys the resources declared in `main.bicep` template in the `audiocodes` folder |
| deployAcsInfra.ps1 | Deploys the resources declared in `main.bicep` template in the `acs` folder  |


The PowerShell script(s) assume that you have already connected to the designated Azure tenant/subscription using
```ps
Connect-AzAccount -AccountId your.name@domain.com -Tenant tenantId -Subscription subscriptionId
```