param(
    [string]$VMName,
    [string]$VMSwitchName,
    [string]$VMNetworkAdapterName
)

vagrant halt $VMName
Add-VMNetworkAdapter -VMName $VMName -SwitchName $VMSwitchName -Name $VMNetworkAdapterName
vagrant up $VMName