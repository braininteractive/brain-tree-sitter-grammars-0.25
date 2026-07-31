Get-Process |
    Where-Object { $_.CPU -gt 10 } |
    Sort-Object CPU -Descending |
    Select-Object -First 5 -Property Name, CPU |
    ForEach-Object { "$($_.Name): $($_.CPU)" }

$items = 1..10 | Where-Object { $_ % 2 -eq 0 }
$items | Measure-Object -Sum
