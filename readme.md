# Ansible Lab

## Setup

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
  - Option A: `gpedit.msc`
    - Navigate to: `Computer Configuration`
    - Navigate to: `Windows Settings`
    - Navigate to: `Security Settings`
    - Navigate to: `Local Policies`
    - Navigate to: `User Rights Assignment`
    - Add your account to the list named `Create symbolic links.`
    - Log out.
    - Log in.
  - Option B: `secpol.msc`
    - Navigate to: `Local Policies`
    - Navigate to: `User Rights Assignment`
    - Add your account to th elist named `Create symbolic links.`
    - Log out.
    - Log in.