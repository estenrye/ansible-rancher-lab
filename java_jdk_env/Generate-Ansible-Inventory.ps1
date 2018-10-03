$acsIP = (Get-VM ansible-control-server).NetworkAdapters[0].IPAddresses[0]
$jdkIP = (Get-VM jdk).NetworkAdapters[0].IPAddresses[0]

$inventoryFile = "acs ansible_ssh_host=$acsIP
jdk ansible_ssh_host=$jdkIP

[ansible_control_servers]
acs

[jdk_workstations]
jdk"

$inventoryFile | Out-File -FilePath $PSScriptRoot\inventory -Force -Encoding utf8