param resourceGroupName string
param location string
param rgTags object

targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: rgTags
}

output rgName string = resourceGroup.name
output rgId string = resourceGroup.id
output rgLocation string = resourceGroup.location
