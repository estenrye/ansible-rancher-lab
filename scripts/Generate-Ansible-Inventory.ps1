param(
    $excludeVMs = @(
        'MobyLinuxVM',
        'Remote Client',
        'VS Emulator 5-inch KitKat (4.4) XXHDPI Phone.esten'
    ),
    $groups = @{
        ansible_control_servers = @(
            'ansible-control-server'
        )
        routers = @(
            'router'
        )
        jdk_workstations = @(
            'jdk'
        )
    }
)

'' | Out-File -Force -FilePath $PSScriptRoot\inventory -Encoding utf8

$activeVMs = Get-VM | Where-Object { !$excludeVMs.Contains($_.Name) }

$activeVMs | ForEach-Object {
    "$($_.Name) ansible_ssh_host=$($_.NetworkAdapters[0].IPAddresses[0])" | Out-File -Append -FilePath $PSScriptRoot\inventory -Encoding utf8
}

"`n[datacenter]" | Out-File -Append -FilePath $PSScriptRoot\inventory -Encoding utf8
$activeVMs.Name | Out-File -Append -FilePath $PSScriptRoot\inventory -Encoding utf8

$groups.Keys | ForEach-Object {
    $machines = $groups.$_ | Where-Object { $activeVMs.Name.Contains($_) }
    if ($machines.Count -gt 0)
    {
        "`n[$_]" | Out-File -Append -FilePath $PSScriptRoot\inventory -Encoding utf8
        $machines | Out-File -Append -FilePath $PSScriptRoot\inventory -Encoding utf8
    }
}

$acsIP = (Get-VM ansible-control-server).NetworkAdapters[0].IPAddresses[0]
scp -i "$PSScriptRoot\..\.vagrant\machines\acs\hyperv\private_key" "$PSScriptRoot\inventory" vagrant@$($acsIP):~/ansible-rancher-lab/inventory