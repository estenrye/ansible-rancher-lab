# Set default provider for vagrant to hyperv.
[System.Environment]::SetEnvironmentVariable('VAGRANT_DEFAULT_PROVIDER', 'hyperv', 'user')
$env:VAGRANT_DEFAULT_PROVIDER = 'hyperv'

# Ensure git binaries are in the path.
if (-not $env:PATH.Contains('C:/Program Files/Git/usr/bin'))
{
    $new_path = "$env:PATH;C:/Program Files/Git/usr/bin"
    $env:PATH=$new_path
    [Environment]::SetEnvironmentVariable("path", $new_path, "user")
}

# Ensure VM Switch Exists.
if (-not (Get-VMSwitch -Name Private))
{
    New-VMSwitch -Name Internal -SwitchType Private
}

# Generate Private Key for Ansible if it does not already exist.
if (-not (Test-Path $PSScriptRoot/id_rsa))
{
    ssh-keygen -f "$PSScriptRoot\id_rsa" -t rsa -b 4096
}

$activeVMs = Get-VM

if (-not $activeVMs.Name.Contains('open-vas'))
{
    vagrant up openvas
}

if (-not $activeVMs.Name.Contains('router'))
{
    vagrant up router
}

& "$PSScriptRoot\Provision-SecondAdaptor.ps1" -VMName router -VMSwitchName Private -VMNetworkAdapterName LAN
& "$PSScriptRoot\Generate-Ansible-Inventory.ps1"