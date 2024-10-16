param (
    [Parameter(Mandatory)]
    [string]$resourceGroupName
)
param (
    [Parameter(Mandatory)]
    [ValidateSet('dev', 'test', 'prod')]
    [string]$environment
)

$templateFilePath = "..\bicep\acs\main.bicep"
# $templateParametersFilePath = .\bicep\acs\parameters.json

$deploymentName = "deploy-acs-infra"
$randomString = (65..90 + 97..122 | Get-Random -Count 6 | ForEach-Object {[char]$_}) -join ''
$date = Get-Date -Format "yyyyMMdd"
$uniqueDeploymentName = "$deploymentName-$randomString-$date"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath -Name $uniqueDeploymentName -Environment $environment