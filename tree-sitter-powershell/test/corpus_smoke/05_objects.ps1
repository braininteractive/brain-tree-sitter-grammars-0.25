class Server {
    [string]$Name
    [int]$Port = 8080

    Server([string]$name) {
        $this.Name = $name
    }

    [string] Describe() {
        return "$($this.Name):$($this.Port)"
    }
}

$s = [Server]::new("web01")
$s.Describe()

$obj = [PSCustomObject]@{
    Environment = "prod"
    Replicas    = 3
}
$obj.Replicas
