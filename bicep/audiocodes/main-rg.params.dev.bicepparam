using './main-rg.bicep'

var location = 'westeurope'
var environmentTag = 'dev'
var subUniqueIdTag = '0197'
var descriptionTag = 'CCaaS Voice Infrastructure - Audiocodes'
var solutionTag = 'Dynamics 365 Contact Center'

param resourceGroups = [
  {
    resourceGroupName: 'rg-weu-ccaas-vnet-dev'
    location: location
    resourceTags: {
      environment: environmentTag
      subUniqueId: subUniqueIdTag
      description: descriptionTag
      solution: solutionTag
    }
  }
  {
    resourceGroupName: 'rg-weu-ccaas-stackmgr-dev'
    location: location
    resourceTags: {
      environment: environmentTag
      subUniqueId: subUniqueIdTag
      description: descriptionTag
      solution: solutionTag
    }
  }
  {
    resourceGroupName: 'rg-weu-ccaas-sbc-dev'
    location: location
    resourceTags: {
      environment: environmentTag
      subUniqueId: subUniqueIdTag
      description: descriptionTag
      solution: solutionTag
    }
  }
]

