# First run script for SlackwareWSL

width=$(echo $COLUMNS)
height=$(echo $LINES)
if [ $width -lt 140 ]; then
  /mnt/c/Windows/System32/cmd.exe /C mode con:cols=140 lines=36
fi
figlet -w 140 Welcome to SlackwareWSL
echo -e "\033[33;7mDo not interrupt or close the terminal window till initial setup completes!!!\033[0m"

setcap cap_net_raw+ep /bin/ping
chmod +x /usr/local/bin/slack_mirrortest
cp -f /etc/skel/.bashrc ~/.bashrc
echo "PS1='\[\033[01;31m\][\u@\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '" | tee -a ~/.bashrc >/dev/null 2>&1
echo " "
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
          echo -e "\033[31m Blank username entered. Try again\033[m"
          echo -en "\033[1A\033[1A\033[2K"
          username=""
        elif grep -q "$username" /etc/passwd; then
          echo -e "\033[31mUsername already exists. Try again\033[m"
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
          secs=5
          while [ $secs -gt 0 ]; do
            printf "\r\e[1;33mSystem needs to be restarted. Shutting down in %.d seconds.\e[0m" $((secs--))
            sleep 1
          done
          rm ~/.bash_profile
          /mnt/c/Windows/System32/cmd.exe /C mode con:cols=$width lines=$height
          /mnt/c/Windows/System32/wsl.exe --terminate $WSL_DISTRO_NAME
        fi
      done
      ;;
    Nope)
      clear
      /mnt/c/Windows/System32/cmd.exe /C mode con:cols=$width lines=$height
      rm ~/.bash_profile
      break
      ;;
  esac
done
