/*
  AUTHOR:  Saiful Suherman, Avanade
  VERSION: 1.0
  SYNOPSIS:
    This template deploys Azure Communication Services (ACS), Log Analytics Workspace, and Application Insights.
    Additionally the template configures the ACS resource to enable diagnostics logs with Log Analytics Workspace as the destination,
    based on the selected log types (such as "enableAcsCallLogs = true").

    The template will deploy the following resources:
    - Azure Communication Services
    - Log Analytics Workspace
    - Event Grid System Topics
    - Application Insights
*/

/* --- DEFINING SCOPE --- */
targetScope = 'resourceGroup'

/* --- DEFINING PARAMETERS --- */
// Resource Location
param location string = resourceGroup().location

// Environment Parameter
@allowed([
  'dev'
  'test'
  'prod'
])
param env string = 'dev'

/* --- CLIENT SPECIFIC PARAMS FOR TAGS AND NAMING CONVENTION --- */
// Azure Subscription Unique Id
param subUniqueId string = '0197'

// Solution Description
param description string = 'ccaas'

// Resource Name Suffix
param rscNameSuffix string = '-${subUniqueId}-${description}-${env}'

/* --- RESOURCE PARAMS --- */
// Azure Communication Services Resource Location
@allowed([
  'global'
])
param acsResourceLocation string = 'global'

// Azure Communication Services Data Residence
@allowed([
  'asia'
  'europe'
  'us'
])
param dataLocation string = 'europe'

/* --- ENABLE LOG TYPE SWITCHES --- */
// @allowed([
//   true
// ])
// param enableAcsGeneralLogs bool = true
// Enable Call logs
param enableAcsCallLogs bool = true
// Enable SMS logs
param enableAcsSmsLogs bool = false
// Enable Chat logs
param enableAcsChatLogs bool = false
// Enable Email logs
param enableAcsEmailLogs bool = false

/* LOG TYPE ARRAYS */
// ACS General logs
param acsGeneralLogs array = [
  {
    category: 'AuthOperational'
    enabled: true
  }
  {
    category: 'Usage'
    enabled: true
  }
]

// ACS Call logs
param acsCallLogs array = [
  
  {
    category: 'CallSummary'
    enabled: true
  }
  {
    category: 'CallRecordingOperational'
    enabled: true
  }
  {
    category: 'CallRecordingSummary'
    enabled: true
  }
  {
    category: 'CallDiagnostics'
    enabled: true
  }
  {
    category: 'CallAutomationOperational'
    enabled: true
  }
  {
    category: 'CallAutomationMediaSummary'
    enabled: true
  }
  {
    category: 'CallSurvey'
    enabled: true
  }
  {
    category: 'CallClientOperations'
    enabled: true
  }
  {
    category: 'CallClientMediaStatsTimeSeries'
    enabled: true
  }
  {
    category: 'CallClosedCaptionsSummary'
    enabled: true
  }
]

// ACS SMS logs
param acsSmsLogs array = [
  {
    category: 'SMSOperational'
    enabled: true
  }
]

// ACS Chat logs
param acsChatLogs array = [
  {
    category: 'ChatOperational'
    enabled: true
  }
]

// ACS Email logs
param acsEmailLogs array = [
  {
    category: 'EmailSendMailOperational'
    enabled: true
  }
  {
    category: 'EmailStatusUpdateOperational'
    enabled: true
  }
  {
    category: 'EmailUserEngagementOperational'
    enabled: true
  }
]

// Variable to include ACS log types based on the enabled switches
var enabledAcsLogs = concat(acsGeneralLogs, (enableAcsCallLogs ? acsCallLogs : []), (enableAcsSmsLogs ? acsSmsLogs : []), (enableAcsChatLogs ? acsChatLogs : []), (enableAcsEmailLogs ? acsEmailLogs : []))

// Resource Tags
param tags object = {
  environment: '${env}'
  subUniqueId: '${subUniqueId}'
  description: 'ACS Voice Infrastructure'
  solution: 'Dynamics 365 Contact Center Europe'
}

// Event Grid System Topic SKU type
@allowed([
  'Basic'
  'Premium'
])
param egstSku string = 'Basic'

/* --- RESOURCE DEPLOYMENT --- */
// Azure Communication Services
resource communicationService 'Microsoft.Communication/communicationServices@2023-03-31' = {
  name: 'acs${rscNameSuffix}-${dataLocation}'
  location: acsResourceLocation
  tags: tags
  properties: {
    dataLocation: dataLocation
  }
}

// Log Analytics Workspace
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: 'log${rscNameSuffix}'
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

// Enable diagnostic settings for Azure Communication Services - OLD
// resource diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
//   name: 'acs-call-diagnostics-and-voice-insights'
//   scope: communicationService
//   properties: {
//     logs: enabledAcsLogs
//     workspaceId: logAnalyticsWorkspace.id
//   }
// }

// Enable diagnostic settings for Azure Communication Services
resource diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'acs-diagnostic-logs'
  scope: communicationService
  properties: {
    logs: enabledAcsLogs
    workspaceId: logAnalyticsWorkspace.id
  }
}

// Application Insights
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi${rscNameSuffix}'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}

// Event Grid System Topic
resource eventGridSystemTopic 'Microsoft.EventGrid/systemTopics@2022-06-15' = {
  name: 'egst${rscNameSuffix}'
  location: acsResourceLocation
  tags: tags
  sku: {
    name: egstSku
  }
  identity: {
    type: 'None'
  }
  properties:{
    source: communicationService.id
    topicType: 'Microsoft.Communication.CommunicationServices'
  }
}

// Outputs
output acsResourceName string = communicationService.name
output acsResourceId string = communicationService.id
output acsImmutableResourceId string = communicationService.properties.immutableResourceId
//output acsDataLocation string = communicationService.properties.dataLocation
