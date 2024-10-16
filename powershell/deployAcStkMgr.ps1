param (
    [Parameter(Mandatory)]
    [string]$resourceGroupName
)

$templateFilePath = "..\bicep\audiocodes\main.bicep"
# $templateParametersFilePath = .\bicep\audiocodes\parameters.json

$deploymentName = "deploy-ac-stck-mgr"
$randomString = (65..90 + 97..122 | Get-Random -Count 6 | ForEach-Object {[char]$_}) -join ''
$date = Get-Date -Format "yyyyMMdd"
$uniqueDeploymentName = "$deploymentName-$randomString-$date"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath -Name $uniqueDeploymentName