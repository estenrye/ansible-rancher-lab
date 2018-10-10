function Launch-VM
{
    param(
        [string]$AnsibleVMName,
        [string]$VMName
    )

    if (-not (Get-VM $VMName -ErrorAction SilentlyContinue))
    {
        vagrant up $AnsibleVMName
    }

    $vm = Get-VM $VMName

    return @{
        name = $AnsibleVMName
        ip = $vm.NetworkAdapters[0].IPAddresses[0]
    }
}

function Add-SecondNetworkAdapter
{
    param(
        [string]$AnsibleVMName,
        [string]$VMName,
        [string]$SwitchName,
        [string]$NetworkAdapterName
    )

    if ((Get-VM $VMName).NetworkAdapters.Count -eq 1)
    {
        vagrant halt $AnsibleVMName
        Add-VMNetworkAdapter -VMName $VMName -SwitchName $SwitchName -Name $NetworkAdapterName
        Start-VM -Name $VMName
    }
    elseif ((Get-VM $VMName).NetworkAdapters[1].SwitchName -ne $SwitchName) {
        $switch = Get-VMSwitch -Name $SwitchName
        Connect-VMNetworkAdapter -VMSwitch $switch -VMName $VMName -Name $NetworkAdapterName
    }

}

if (-not (Get-VMSwitch -Name Private))
{
    New-VMSwitch -Name Private -SwitchType Private
}

$machines = @{
    ansible_control_servers = @(
        Launch-VM -AnsibleVMName acs -VMName ansible-control-server
    )
    routers = @(
        Launch-VM -AnsibleVMName router -VMName router
    )
}

Add-SecondNetworkAdapter -AnsibleVMName router -VMName router -SwitchName Private -NetworkAdapterName LAN
Add-SecondNetworkAdapter -AnsibleVMName acs -VMName ansible-control-server -SwitchName Private -NetworkAdapterName LAN

$machines.Keys | ForEach-Object {
    $machines[$_] | ForEach-Object {
        "$($_.name) ansible_ssh_host=$($_.ip)"
    }
} | Out-File -FilePath $PSScriptRoot\inventory -Force -Encoding utf8

$machines.Keys | ForEach-Object {
    "[$_]"
    $machines[$_] | ForEach-Object {
        $_.name
    }
} | Out-File -FilePath $PSScriptRoot\inventory -Append -Encoding utf8

$machines['ansible_control_servers'] | ForEach-Object {
    scp -i "$PSScriptRoot\.vagrant\machines\acs\hyperv\private_key" "$PSScriptRoot\inventory" vagrant@$($_.ip):~/ansible-rancher-lab
}
