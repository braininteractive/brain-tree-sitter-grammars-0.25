$config = @{
    Name     = "app"
    Ports    = @(80, 443)
    Nested   = @{ Deep = $true }
}

$config["Extra"] = "added"
$config.Ports += 8080

$splat = @{
    Path    = "."
    Recurse = $true
}
Get-ChildItem @splat | Select-Object -First 1
