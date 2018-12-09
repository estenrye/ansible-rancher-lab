$hosts = @('router', 'dc', 'acs', 'utility', 'docker-manager' , 'docker-worker')

$hosts | ForEach-Object { $_; ssh vagrant@$_ -i $PSScriptRoot\id_rsa 'gzip -V' }