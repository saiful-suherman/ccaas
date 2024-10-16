param (
    [Parameter(Mandatory)]
    [string]$location
)

$templateFilePath = "..\bicep\audiocodes\main-rgs.bicep"
$templateParametersFilePath = "..\bicep\audiocodes\main-rg.params.dev.bicepparam"

$deploymentName = "deploy-ccaas-rgs"
$randomString = (65..90 + 97..122 | Get-Random -Count 6 | ForEach-Object {[char]$_}) -join ''
$date = Get-Date -Format "yyyyMMdd"
$uniqueDeploymentName = "$deploymentName-$randomString-$date"

New-AzDeployment -Name $uniqueDeploymentName -Location $location -TemplateFile $templateFilePath -TemplateParameterFile $templateParametersFilePath