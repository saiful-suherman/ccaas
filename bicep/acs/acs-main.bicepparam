using './acs-main.bicep'

// Environment params
param Environment = 'dev'
param subUniqueId = '0197'
param solution = 'Dynamics 365 Contact Center'
param description = 'CCaaS Voice Infrastructure - ACS'

// Not declared in bicep main-file, therefore using var
var shortDescription = 'ccaas'

param rscNameSuffix = '-${subUniqueId}-${shortDescription}-${Environment}'

// Tag params
param tags = {
  environment: Environment
  subUniqueId: subUniqueId
  description: description
  solution: solution
}

// Resource params
param acsResourceLocation = 'global'
param dataLocation = 'europe'
param enableAcsCallLogs = true
param enableAcsSmsLogs = false
param enableAcsChatLogs = false
param enableAcsEmailLogs = false
// param egstSku = 'Basic'

