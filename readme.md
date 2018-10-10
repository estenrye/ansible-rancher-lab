# Ansible Lab

## Host Machine Setup

1. Enable Hyper-V
2. Install Vagrant
3. Install Git

  - Ensure the following options are selected:
    - Use OpenSSH
    - Use the native Windows Secure Channel Library
    - Checkout as-is, commit Unix-style line endings
    - Use MinTTY
    - Enable file system caching
    - Enable Git Credential Manager
    - Enable symbolic links
    - Enable experimental, built-in rebase
    - Enable experimental, built-in stash

4. Enable Developer Mode for Windows 10.
5. Set Group Policy to allow your user to create symbolic links without an elevated shell using one of the following options.

  - Option A: [Update policy using gpedit.msc](.docs/gpedit-symbolic-links.md)
  - Option B: [Update policy using secpol.msc](.docs/secpol-symbolic-links.md)

6. [Add your user to the list of Hyper-V Administrators.](.docs/hyperv-administrators-group.md)  This will allow you to use vagrant without opening an Administrative PowerShell prompt.

7. Clone repo using `git clone -c core.symlinks=true git@github.com:estenrye/ansible-rancher-lab.git`
8. Add the bin directory installed with git to your path:

```powershell
# From http://www.hurryupandwait.io/blog/need-an-ssh-client-on-windows-dont-use-putty-or-cygwinuse-git
if (-not $env:PATH.Contains('C:/Program Files/Git/usr/bin'))
{
    $new_path = "$env:PATH;C:/Program Files/Git/usr/bin"
    $env:PATH=$new_path
    [Environment]::SetEnvironmentVariable("path", $new_path, "user")
}
```