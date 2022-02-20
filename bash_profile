# First run script for SlackwareWSL

blu=$(tput setaf 4)
grn=$(tput setaf 2)
red=$(tput setaf 1)
ylw=$(tput setaf 3)
txtrst=$(tput sgr0)

figlet -t -k -f /usr/share/figlet/mini.flf "Welcome to SlackwareWSL"
echo -e "\033[33;7mDo not interrupt or close the terminal window till initial setup completes!!!\n\033[0m"

diskvol=$(mount | grep -m1 ext4 | cut -f 1 -d " ")
sudo resize2fs $diskvol
disksize=$(df -k | grep $diskvol | cut -f8 -d " ")

setcap cap_net_raw+ep /bin/ping
chmod +x /usr/local/bin/slack_mirrortest
cp -f /etc/skel/.bashrc ~/.bashrc
echo "PS1='\[\033[01;31m\][\u@\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '" | tee -a ~/.bashrc >/dev/null 2>&1

if [ $disksize -le 263174212 ]; then
    echo -e ${ylw}"Your virtual hard disk has a maximum size of 256GB. If your distribution grows more than 256GB, you will see disk space errors. This can be fixed by expanding the virtual hard disk size and making WSL aware of the increase in file system size. For more information, visit this site (\033[34mhttps://docs.microsoft.com/en-us/windows/wsl/vhd-size\033[33m).\n"${txtrst} | fold -sw 120
    echo -e ${grn}"Would you like to resize your virtual hard disk?"${txtrst}
    select yn in "Yup" "Nope"; do
        case $yn in
            Yup)
                echo " "
                secs=5
                while [ $secs -gt 0 ]; do
                    printf ${ylw}"\r\033[KUse diskpart to resize your VHD and restart SlackwareWSL. System will shut down in %.d seconds. "${txtrst} $((secs--))
                    sleep 1
                done
                /mnt/c/Windows/System32/wsl.exe --shutdown $WSL_DISTRO_NAME
                ;;
            Nope)
                break
                ;;
        esac
    done
fi

echo -e "\033[32mCreate root password\033[m"
passwd
echo " "
echo -e "\033[32mDo you want to create a new user?\033[m"
select yn in "Yup" "Nope"; do
    case $yn in
        Yup)
            echo " "
            while read -p "Please enter the username you wish to create : " username; do
                if [ x$username = "x" ]; then
                    echo -e ${red}" Blank username entered. Try again!!!"${txtrst}
                    echo -en "\033[1A\033[1A\033[2K"
                    username=""
                elif grep -q "$username" /etc/passwd; then
                    echo -e ${red}"Username already exists. Try again!!!"${txtrst}
                    echo -en "\033[1A\033[1A\033[2K"
                    username=""
                else
                    groupadd sudo
                    useradd -m -g users -G sudo,wheel,floppy,audio,video,cdrom,plugdev,power,netdev,lp,scanner -s /bin/bash "$username"
                    echo "%wheel ALL=(ALL) ALL" >/etc/sudoers.d/wheel
                    echo "%sudo ALL=(ALL) ALL" >/etc/sudoers.d/sudo
                    sed -i 's/PATH="\/usr\/local\/bin:\/usr\/bin:\/bin:\/usr\/games"/PATH="\/usr\/local\/bin:\/usr\/bin:\/bin:\/usr\/games:\/sbin:\/usr\/sbin"/g' /etc/profile
                    cp -f /etc/skel/.bash_profile /home/"$username"/.bash_profile
                    cp -f /etc/skel/.bashrc /home/"$username"/.bashrc
                    echo "PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '" | tee -a /home/"$username"/.bashrc >/dev/null 2>&1
                    echo -en "\033[1B\033[1A\033[2K"
                    passwd $username
                    sed -i "/\[user\]/a default = $username" /etc/wsl.conf >/dev/null
                    echo " "
                    secs=3
                    while [ $secs -gt 0 ]; do
                        printf ${ylw}"\r\033[KSystem needs to be shutdown to set default user. Shutting down in %.d seconds..."${txtrst} $((secs--))
                        sleep 1
                    done
                    rm ~/.bash_profile
                    /mnt/c/Windows/System32/wsl.exe --terminate $WSL_DISTRO_NAME
                fi
            done
            ;;
        Nope)
            clear
            rm ~/.bash_profile
            break
            ;;
    esac
done
