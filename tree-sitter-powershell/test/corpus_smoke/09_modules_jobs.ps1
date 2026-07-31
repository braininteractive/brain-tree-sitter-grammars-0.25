Import-Module PSReadLine -ErrorAction SilentlyContinue

$job = Start-Job -ScriptBlock {
    param($x)
    Start-Sleep -Milliseconds 100
    $x * 2
} -ArgumentList 21

Wait-Job $job | Out-Null
Receive-Job $job

Get-Command -Module PSReadLine | Select-Object -First 1
