# IaC for CCaaS

### Most recent updates
#### **Update 17.10.2024**
> Repo is currently undergoing development and is being reorganized into modules and seprate component main-templates. Below README may not reflect current state.
#### **Update 16.10.2024**
> Repo created and fed with base templates

## README
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

### Azure Communication Services (acs)
The `main.bicep` template found under the `acs` folder deploys  following resources:

| Resource Type | Description | Purpose | 
| --- | --- | --- |
| Azure Communication Services | --- |  ---|
| Log Analytics Workspace | --- |  ---|
| Event Grid System Topics | --- |  ---|
| Application Insights | --- |  ---|

### ACS Event Subscriptions (event-subscriptions)
**_Work in progress_...**

## PowerShell
PowerShell scripts are used to deploy the respective Bicep Templates.

```
/powershell    
    ├── deployAudiocodesStackManager.ps1 # Work in progress
    └── deployAcsInfra.ps1
```

The PowerShell script(s) assume that you have already connected to the designated Azure tenant/subscription using:
```ps
Connect-AzAccount -AccountId your.name@domain.com -Tenant tenantId -Subscription subscriptionId
```

You are required to set the powershell folder as working directory
```
ccaas 
└── /powershell    
   ├── deployAcsInfra.ps1
   └── ...
```

| Script | Description | 
| --- | --- |
| deployCcaasRgs.ps1 | _Work in progress_<br>Deploys the resources groups declared in `main-rgs.bicep` template in the `audiocodes` folder |
| deployAudiocodesStackManager.ps1 | _Work in progress_<br>Deploys the resources declared in `main.bicep` template in the `audiocodes` folder |
| deployAcsInfra.ps1 | Deploys the resources declared in `main.bicep` template in the `acs` folder. <br> It is mandatory to specify the target `$resourceGroupName`, when running the script: <br>`.\deployAcsInfra.ps1 -resourceGroupName "rg-ccaas-dev"`|


