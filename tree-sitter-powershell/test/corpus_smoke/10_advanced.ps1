[CmdletBinding()]
param(
    [ValidateSet("dev", "prod")]
    [string]$Environment = "dev"
)

filter Double { $_ * 2 }
1..3 | Double

$scriptBlock = { param($msg) Write-Host $msg }
& $scriptBlock "invoked"
. $scriptBlock "dot-sourced"

$null = $PSBoundParameters
$Environment -match '^d' | Out-Null
