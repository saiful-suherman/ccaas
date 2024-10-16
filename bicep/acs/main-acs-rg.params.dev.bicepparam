using './main-acs-rg.bicep'

var location = 'westeurope'
var environmentTag = 'dev'
var subUniqueIdTag = '0197'
var descriptionTag = 'CCaaS Voice Infrastructure - Audiocodes'
var solutionTag = 'Dynamics 365 Contact Center'

param resourceGroups = [
  {
    name: 'rg-weu-acs-sbc-dev'
    location: location
    resourceTags: {
      environment: environmentTag
      subUniqueId: subUniqueIdTag
      description: descriptionTag
      solution: solutionTag
    }
  }
]

