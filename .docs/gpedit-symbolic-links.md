# Ansible Lab

## Enabling Creation of Symbolic Links with `gpedit.msc`

### Open `gpedit.msc`

![Run gpedit.msc](../.imgs/setup/run-gpedit.PNG)

### Navigate to the Create symbolic links policy

![gpedit.msc screenshot of Create symbolic links policy location](../.imgs/setup/gpedit.PNG)

1. Navigate to: `Computer Configuration`
2. Navigate to: `Windows Settings`
3. Navigate to: `Security Settings`
4. Navigate to: `Local Policies`
5. Navigate to: `User Rights Assignment`
6. Navigate to: `Create symbolic links`
7. Double-click: `Create symbolic links`

### Add your user to the policy

![Screenshot of the Create symbolic links dialog](../.imgs/setup/create-symbolic-links-dialog.PNG)

![Select Users Dialog](../.imgs/setup/select-users-dialog.PNG)

1. Click: `Add User or Group`
2. Type your username in the Select Users Dialog.
3. Click `OK` on the Select Users dialog.
4. Click `OK` on the Create symbolic links Dialog.
5. Close `gpedit.msc`

### Log out and log back in to apply the policy changes.

[Back to readme.md](../readme.md)