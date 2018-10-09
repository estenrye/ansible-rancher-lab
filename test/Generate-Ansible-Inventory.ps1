$acsIP = (Get-VM ansible-control-server).NetworkAdapters[0].IPAddresses[0]
$jdkIP = (Get-VM router).NetworkAdapters[0].IPAddresses[0]

$inventoryFile = "acs ansible_ssh_host=$acsIP
router ansible_ssh_host=$jdkIP

[ansible_control_servers]
acs

[routers]
router"

$inventoryFile | Out-File -FilePath $PSScriptRoot\inventory -Force -Encoding utf8
Push-Location $PSScriptRoot
vagrant scp inventory acs:~/ansible-rancher-lab
Pop-Location