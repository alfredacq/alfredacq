<#
.SYNOPSIS
    This PowerShell script ensures the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Alfred Acquah
    LinkedIn        : linkedin.com/in/alfredacquah
    GitHub          : github.com/alfredacq
    Date Created    : 2026-11-22
    Last Modified   : 2026-11-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000500
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AU-000500/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-AU-000500).ps1 
#>

# THE CODE USED
# Configure Application Event Log Maximum Size

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$ValueName = "MaxSize"
$ValueData = 32768  # 0x8000 (32,768 KB)

# Create the registry key if it does not exist
if (-not (Test-Path -Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Create or update the registry value
New-ItemProperty -Path $RegistryPath `
    -Name $ValueName `
    -Value $ValueData `
    -PropertyType DWord `
    -Force | Out-Null

# Verify the configuration
$Result = Get-ItemProperty -Path $RegistryPath -Name $ValueName

Write-Host "Application Event Log configuration updated successfully." -ForegroundColor Green
Write-Host "Registry Path: $RegistryPath"
Write-Host "Value Name: $ValueName"
Write-Host "Value Type: DWORD"
Write-Host "Value Data: $($Result.MaxSize) KB"
