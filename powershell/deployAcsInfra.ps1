$resourceGroupName = "rg-ccaas-dev"

$templateFilePath = .\bicep\acs\main.bicep
# $templateParametersFilePath = .\bicep\acs\parameters.json

$deploymentName = "deploy-acs-infra"
$randomString = (65..90 + 97..122 | Get-Random -Count 6 | ForEach-Object {[char]$_}) -join ''
$uniqueDeploymentName = "$deploymentName-$randomString"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath -Name $uniqueDeploymentName