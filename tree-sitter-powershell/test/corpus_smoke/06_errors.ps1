try {
    Get-Item -Path "C:\does\not\exist" -ErrorAction Stop
} catch [System.Management.Automation.ItemNotFoundException] {
    Write-Warning "not found: $($_.Exception.Message)"
} catch {
    Write-Error "unexpected: $_"
} finally {
    Write-Verbose "cleanup"
}

throw "fatal condition"
