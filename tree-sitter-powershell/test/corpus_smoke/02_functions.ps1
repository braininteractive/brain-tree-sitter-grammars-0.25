function Get-Greeting {
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        [int]$Count = 1
    )
    for ($i = 0; $i -lt $Count; $i++) {
        "hello $Name"
    }
}

function Add($a, $b) { return $a + $b }

Get-Greeting -Name "dev" -Count 2
Add 1 2
