Write-Host "Starting Windows Privilege Escalation Checks..."

Write-Host "`n[+] Checking for unquoted service paths..."
Get-WmiObject win32_service | Where-Object { $_.PathName -and ($_.PathName -notmatch '^".*"$') -and ($_.PathName -match '\s') } | Select-Object Name, PathName

Write-Host "`n[+] Checking services with weak permissions..."
Get-WmiObject win32_service | ForEach-Object {
    $sd = (Get-Acl -Path "HKLM:\SYSTEM\CurrentControlSet\Services\$($_.Name)")
    if ($sd.Access | Where-Object { $_.FileSystemRights -match 'FullControl' -and $_.IdentityReference -match 'Everyone|Users' }) {
        Write-Output "$($_.Name) - Weak Permissions"
    }
}

Write-Host "`n[+] Checking for AutoLogon..."
$autoLogon = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoAdminLogon -ErrorAction SilentlyContinue
if ($autoLogon.AutoAdminLogon -eq "1") {
    Write-Host "AutoLogon is enabled"
} else {
    Write-Host "AutoLogon is not enabled"
}

Write-Host "`nPrivilege Escalation check complete."
