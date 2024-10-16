/*
SUMMARY: Service being deployed {Resource Group}
DESCRIPTION:
  Template provides 3 resource grups for the deployment of the AudioCodes SBCs environment.

AUTHOR/S: Saiful Suherman
VERSION 0.0.1
*/

/* ------------------------------------------------ */
// TARGET SCOPE
targetScope = 'subscription'

/* ------------------------------------------------ */

/* START PARAMETERS */
// -- General parameters

// -- Resource Parameters
@description('Array of resource group configurations')
param resourceGroups array

param dateTime string = utcNow('yyyy-MM-dd')
/* END PARAMETERS*/
/* ------------------------------------------------ */

/* BEGIN RESOURCES */

// --- Resource Group
// Loop through the resourceGroups array and deploy the resource group module
module resourceGroup '../modules/resourceGroups/resource-group.module.bicep' = [for rg in resourceGroups: {
  name: 'deploy-${rg.resourceGroupName}-${dateTime}'
  params: {
    resourceGroupName: rg.resourceGroupName
    location: rg.location
    rgTags: rg.resourceTags
    }
  }
]

/* END RESOURCES */
/* ------------------------------------------------ */

/* BEGIN OUTPUTS */
output rgInfo array = [for (rg, i) in resourceGroups: {
  rgName: resourceGroup[i].outputs.rgName
  rgId: resourceGroup[i].outputs.rgId
  location: resourceGroup[i].outputs.rgLocation
}]
/* END OUTPUTS */
