# SlackwareWSL
Slackware on WSL2 (Windows 10 FCU or later) based on [wsldl](https://github.com/yuk7/wsldl).

<a href='http://postimg.cc/3dPv323Z' target='_blank'><img src='https://i.postimg.cc/3dPv323Z/Screenshot-2022-02-21-161127.png' border='0' alt='Screenshot-2022-02-21-161127'/></a>   <a href='http://postimg.cc/mPCFkhDW' target='_blank'><img src='https://i.postimg.cc/mPCFkhDW/Screenshot-2022-02-21-161206.png' border='0' alt='Screenshot-2022-02-21-161206'/></a>   <a href='http://postimg.cc/G8hBXQjb' target='_blank'><img src='https://i.postimg.cc/G8hBXQjb/Screenshot-2022-02-21-161249.png' border='0' alt='Screenshot-2022-02-21-161249'/></a>   <a href='http://postimg.cc/7G663Lx6' target='_blank'><img src='https://i.postimg.cc/7G663Lx6/Screenshot-2022-02-21-161314.png' border='0' alt='Screenshot-2022-02-21-161314'/></a>   <a href='http://postimg.cc/BLVvMG6C' target='_blank'><img src='https://i.postimg.cc/BLVvMG6C/Screenshot-2022-02-21-161414.png' border='0' alt='Screenshot-2022-02-21-161414'/></a>    <a href='http://postimg.cc/9rpvHpPv' target='_blank'><img src='https://i.postimg.cc/9rpvHpPv/Screenshot-2022-02-17-132617.png' border='0' alt='Screenshot-2022-02-17-132617'/></a>    <a href='http://postimg.cc/xX1Bfztq' target='_blank'><img src='https://i.postimg.cc/xX1Bfztq/Screenshot-2022-02-17-132742.png' border='0' alt='Screenshot-2022-02-17-132742'/></a>    <a href='http://postimg.cc/G4gVHm5K' target='_blank'><img src='https://i.postimg.cc/G4gVHm5K/Screenshot-2022-02-17-132916.png' border='0' alt='Screenshot-2022-02-17-132916'/></a>
[![Github All Releases](https://img.shields.io/github/downloads/sileshn/SlackwareWSL/total.svg?style=flat-square)](https://github.com/sileshn/SlackwareWSL/releases)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![License](https://img.shields.io/github/license/sileshn/SlackwareWSL.svg?style=flat-square)](https://raw.githubusercontent.com/sileshn/SlackwareWSL/main/LICENSE)

## Features and important information
This is a very minimal build of Slackware. The list of packages included may change from release to release. You can view the actual list of packages included in any release by downloading the [package_list.txt](https://github.com/sileshn/SlackwareWSL/releases) file. This file is also created while building the distro.

SlackwareWSL has the following features during the installation stage.
* Increase virtual disk size from the default 256GB
* Create a new user and set the user as default

SlackwareWSL includes a wsl.conf file which only has section headers. Users can use this to configure the distro to their liking. You can read more about wsl.conf and its configuration settings [here](https://docs.microsoft.com/en-us/windows/wsl/wsl-config).

## Requirements
* For x64 systems: Version 1903 or higher, with Build 18362 or higher.
* For ARM64 systems: Version 2004 or higher, with Build 19041 or higher.
* Builds lower than 18362 do not support WSL 2.
* If you are running Windows 10 version 2004 or higher, you can install all components required to run wsl2 with a single command. This will install ubuntu by default. More details are available [here](https://devblogs.microsoft.com/commandline/install-wsl-with-a-single-command-now-available-in-windows-10-version-2004-and-higher/).
	```cmd
	wsl.exe --install
	```
* If you are running Windows 10 lower then version 2004, follow the steps below. For more details, check [this](https://docs.microsoft.com/en-us/windows/wsl/install-manual) microsoft document.
	* Enable Windows Subsystem for Linux feature.
	```cmd
	dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
	```
	* Enable Virtual Machine feature
	```cmd
	dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
	```
	* Download and install the latest Linux kernel update package from [here](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi).

## Install
* [Download](https://github.com/sileshn/SlackwareWSL/releases/latest) installer zip
* Extract all files in zip file to same directory
* Set version 2 as default. Note that this step is required only for manual installation.
  ```dos
  wsl --set-default-version 2
  ```
* Run Slackware.exe to extract rootfs and register to WSL

**Note:**
Exe filename is using the instance name to register. If you rename it you can register with a diffrent name and have multiple installs.

## How-to-Use(for Installed Instance)
#### exe Usage
```
Usage :
    <no args>
      - Open a new shell with your default settings.

    run <command line>
      - Run the given command line in that instance. Inherit current directory.

    runp <command line (includes windows path)>
      - Run the given command line in that instance after converting its path.

    config [setting [value]]
      - `--default-user <user>`: Set the default user of this instance to <user>.
      - `--default-uid <uid>`: Set the default user uid of this instance to <uid>.
      - `--append-path <true|false>`: Switch of Append Windows PATH to $PATH
      - `--mount-drive <true|false>`: Switch of Mount drives
      - `--default-term <default|wt|flute>`: Set default type of terminal window.

    get [setting]
      - `--default-uid`: Get the default user uid in this instance.
      - `--append-path`: Get true/false status of Append Windows PATH to $PATH.
      - `--mount-drive`: Get true/false status of Mount drives.
      - `--wsl-version`: Get the version os the WSL (1/2) of this instance.
      - `--default-term`: Get Default Terminal type of this instance launcher.
      - `--lxguid`: Get WSL GUID key for this instance.

    backup [contents]
      - `--tar`: Output backup.tar to the current directory.
      - `--reg`: Output settings registry file to the current directory.
	  - `--tgz`: Output backup.tar.gz to the current directory.
      - `--vhdx`: Output backup.ext4.vhdx to the current directory.
      - `--vhdxgz`: Output backup.ext4.vhdx.gz to the current directory.

    clean
      - Uninstall that instance.

    help
      - Print this usage message.
```

#### Just Run exe
```cmd
>{InstanceName}.exe
[root@PC-NAME user]#
```

#### Run with command line
```cmd
>{InstanceName}.exe run uname -r
4.4.0-43-Microsoft
```

#### Run with command line with path translation
```cmd
>{InstanceName}.exe runp echo C:\Windows\System32\cmd.exe
/mnt/c/Windows/System32/cmd.exe
```

#### Change Default User(id command required)
```cmd
>{InstanceName}.exe config --default-user user

>{InstanceName}.exe
[user@PC-NAME dir]$
```

#### Set "Windows Terminal" as default terminal
```cmd
>{InstanceName}.exe config --default-term wt
```

## How to setup

SlackwareWSL will ask you to create a new user during its first run. If you chose to create a new user during initial setup, the steps below are not required unless you want to create additional users.
```dos
passwd
groupadd sudo
useradd -m -g users -G sudo,wheel,floppy,audio,video,cdrom,plugdev,power,netdev,lp,scanner -s /bin/bash <username>
echo "%wheel ALL=(ALL) ALL" >/etc/sudoers.d/wheel
echo "%sudo ALL=(ALL) ALL" >/etc/sudoers.d/sudo
sed -i 's/PATH="\/usr\/local\/bin:\/usr\/bin:\/bin:\/usr\/games"/PATH="\/usr\/local\/bin:\/usr\/bin:\/bin:\/usr\/games:\/sbin:\/usr\/sbin"/g' /etc/profile
passwd <username>
```

You can set the user you created as default user using 2 methods.

Open Slackware.exe, run the following command (replace username with the actual username you created).
```dos
sed -i '/\[user\]/a default = username' /etc/wsl.conf
```

Shutdown and restart the distro (this step is important).

(or)

Execute the command below in a windows cmd terminal from the directory where Slackware.exe is installed.
```dos
>Slackware.exe config --default-user <username>
```

The next step involves changing the default mirror to your liking. This is achieved by editing the `/etc/slackpkg/mirrors` file. SlackwareWSL uses the default mirror provided by Slackware `(http:\\slackware.osuosl.org\slackware64-15.0\)`. You can find a list of Slackware mirrors [here](https://mirrors.slackware.com/mirrorlist/). SlackwareWSL also provides a script to list the top 10 fastest slackware mirrors. You can run the script with the following command.
```dos
slack_mirrortest
```

After updating the `/etc/slackpkg/mirrors` file with a mirror of your choice, run the command's below to update your system. Use sudo if running the command as user.
```dos
slackpkg update gpg
slackpkg update
slackpkg upgrade-all
```

## How to uninstall instance
```dos
>Slackware.exe clean

```

## How to backup instance
export to backup.tar.gz
```cmd
>Slackware.exe backup --tgz
```
export to backup.ext4.vhdx.gz
```cmd
>Slackware.exe backup --vhdxgz
```

## How to restore instance

There are 2 ways to do it. 

Rename the backup to rootfs.tar.gz and run Slackware.exe

(or)

.tar(.gz)
```cmd
>Slackware.exe install backup.tar.gz
```
.ext4.vhdx(.gz)
```cmd
>Slackware.exe install backup.ext4.vhdx.gz
```

You may need to run the command below in some circumstances.
```cmd
>Slackware.exe --default-uid 1000
```

## How to build

#### Prerequisites

Docker, tar, zip, unzip, bsdtar need to be installed.

```dos
git clone git@gitlab.com:sileshn/SlackwareWSL.git
cd SlackwareWSL
make

```
Copy the SlackwareWSL.zip file to a safe location and run the command below to clean.
```dos
make clean

```
