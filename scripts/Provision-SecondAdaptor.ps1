param(
    [string]$VMName,
    [string]$VMSwitchName,
    [string]$VMNetworkAdapterName
)

if (!((Get-VM $VMName).NetworkAdapters.Name).Contains($VMNetworkAdapterName))
{
    vagrant halt $VMName
    Add-VMNetworkAdapter -VMName $VMName -SwitchName $VMSwitchName -Name $VMNetworkAdapterName
    Start-VM $VMName
}
else
{
    $adapter = (Get-VM $VMName).NetworkAdapters | Where-Object {$_.Name -eq $VMNetworkAdapterName }
    if ($adapter.SwitchName -ne $VMSwitchName)
    {
        Connect-VMNetworkAdapter -VMNetworkAdapter $adapter -SwitchName $VMSwitchName
    }
}