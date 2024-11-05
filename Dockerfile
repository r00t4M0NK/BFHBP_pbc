##########################################################################
## NOTICE AND LICENCE
##########################################################################

# This file is provided "as is".
# No support is provided: you try, you learn, you test but only under your own responsability.
# More information, Read the full Licence:
# https://github.com/r00t4M0NK/BFHBP_pbc/blob/main/EULA_Comet.txt


##########################################################################
## DOWNLOAD DIRECTLY
##########################################################################
#cd <your_dir_in_wsl>
#curl https://raw.githubusercontent.com/r00t4M0NK/BFHBP_pbc/refs/heads/main/Dockerfile > Dockerfile
#dos2unix Dockerfile
#you can check step by step with a Docker command (COPY/PASTE):
#BUILD
#grep "docker build" Dockerfile
#Or a podman command:
#grep "docker build" Dockerfile | sed -e 's/docker/podman/g'
#CLEAN
#Docker:
#grep "docker rmi" Dockerfile
#Podman:
#grep "docker rmi" Dockerfile | sed -e 's/docker/podman/g'
#RUN
#Docker:
#grep "docker run" Dockerfile
#Podman:
#grep "docker run" Dockerfile | sed -e 's/docker/podman/g'
#
#RUN: last line for Podman (add --replace), line with --privileged for Docker
#Line only for Podman, with --replace:
#grep "podmanr run" Dockerfile
#VALIDATED line ("--privileged" could crash pod if you use openvpn inside but it's needed for nmap!):
#podmanr run --security-opt seccomp=unconfined --privileged --name halley --replace -h=halley -it -d -p 3390:3390/tcp -p 5901:5901/tcp -p 6901:6901/tcp --cap-add=NET_ADMIN comet bash
#/!\ It will replace any pod named "halley"
#
#Note: It's not really a crash but it will be network problem access if you use remote access as RDP and start an openvpn session.
#      You can repair with WSL podman access: attach the pod, go inside with a root-user and kill openvpn process.
#
#You don't need nmap:
#podmanr run --replace --name halley -h=halley -it -d -p 3390:3390/tcp -p 5901:5901/tcp -p 6901:6901/tcp --cap-add=NET_ADMIN comet bash
#
#If you see any <<podman run --privileged>>, don't use it if you need to use VPN. If you don't use "privileged", it's more secure: BUT! But you need this option for nmap.
#
#My personnal shotcurts
#grep "docker build" Dockerfile | sed -e 's/docker/podmanr/g'
#grep "docker rmi" Dockerfile | sed -e 's/docker/podmanr/g'
#grep "docker run" Dockerfile | sed -e 's/docker/podmanr/g'
#
#Why these differences? Because Docker & Podman haven't same architecture. So VPN can't be use in a same way.
#/!\ If you run a pod (ex: with podman), install (as CSL) and you run the same image but another instance (replacing it), you will loose all updates you have done in your first instance.
#Gentle Reminder: IMAGE (comet) => INSTANCE (halley)
#You run the INSTANCE from the IMAGE.
#The IMAGE is built from the Dockerfile.
#A Pod is always created with the mind of "one-shot". That's important to keep in mind to explain any behaviour.



##########################################################################
## DOCKER PART: HEAD
##########################################################################

FROM debian:12

LABEL org.opencontainers.image.authors="r00t4M0NK"

## Connection ports for controlling the UI:
# VNC port:$VNC_PORT
# Change vncvnc by our own password
# /!\ Be Carreful /!\ VNC Password required needs at least a lenght with minimum 6 chars
# /!\ Be Carreful /!\ VNC password is shared uncrypted and in clear (protocol HTTP)
# noVNC webport, connect via http://localhost:6901/vnc.html?password=vncpassw0rd
# noVNC webport, connect via http://<IP>:<NO_VNC_PORT>/?password=<VNC_PW>
ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    RDP_PORT=3390
EXPOSE $VNC_PORT $NO_VNC_PORT $RDP_PORT

#3390 is choosen for RDP because 3389 has conflict with WSL
#src=https://answers.microsoft.com/en-us/windows/forum/all/cannot-connect-to-xrdp-running-in-wsl-via-remote/bce76f7f-37da-44be-8117-9465290b54c8?page=2

#Check in Firewall (Windows) to allow this port
#Check from Windows > Remote > Settings > Port
#Don't have RDP active in the host machine

#This line could test but we keep in mind it's not same scope inside the container than here in the build file
#echo DISPLAY: $DISPLAY VNC: $VNC_PORT NONC: $NO_VNC_PORT RDP: $RDP_PORT

##########################################################################
## VAR PART: SETTINGS
##########################################################################

# Don't forget to find-replace any value you customise
# For examples, I use same path to group scripts and others
#$HOME =>[impacts]=> $INST_SCRIPTS + $INST_FF + $NO_VNC_HOME + 2 lines at the end of this file (Part: DOCKER BUILD - RUN)
#$VNC_PORT =>[impacts]=> Part "Check" (command ss with 3 first chars) + line concerning the Run  (Part: DOCKER BUILD - RUN)
#$NO_VNC_PORT =>[impacts]=> URL on the top + line concerning the Run  (Part: DOCKER BUILD - RUN)

ENV HOME=/universe \
    TERM=xterm \
    MYLANG=en_US \
    STARTUPDIR=/startup \
    INST_SCRIPTS=/universe/install \
    INST_FF=/universe/firefox \
    FF_URL=https://ftp.mozilla.org/pub/firefox/releases/102.3.0esr/linux-x86_64/en-US/firefox-102.3.0esr.tar.bz2 \
    NO_VNC_HOME=/universe/noVNC \
    DEBIAN_FRONTEND=noninteractive \
    BG_WLLP=https://raw.githubusercontent.com/r00t4M0NK/BFHBP_pbc/refs/heads/main/wallpapers/wllpp_comet_milkyway_1280_720.jpg\
    RDP_WLLP=https://raw.githubusercontent.com/r00t4M0NK/BFHBP_pbc/refs/heads/main/wallpapers/stars-dark-1654074_1280.bmp\
    RDP_LOGO=https://raw.githubusercontent.com/r00t4M0NK/BFHBP_pbc/main/tools/img/CometLogoWin_64.bmp\
    RDP_LOCAL_WLLP=/startup/wallpapers/rdpwllpp.bmp\
    RDP_TITLE="WELCOME IN UNIVERSE OF COMET"\
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x720\
    ROOT_PW=MilkyWay2024\
    USER_PW=apophis\
    USERVNC=comet\
    VNC_PW=vncpassw0rd\
    VNC_VIEW_ONLY=false
WORKDIR $HOME

#This line could test but we keep in mind it's not same scope inside the container than here in the build file
#echo HOME: $HOME STARTUPDIR: $STARTUPDIR NO_VNC_HOME: $NO_VNC_HOME VNC_RESOLUTION: $VNC_RESOLUTION USERVNC: $USERVNC USER_PW: $USER_PW ROOT_PW: $ROOT_PW

##########################################################################
## PART PREREQUISITE: INSTALL
##########################################################################

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install vim sudo procps
RUN apt-get -y install wget net-tools iproute2 curl dos2unix
RUN apt-get -y install bzip2 apt-utils coreutils
RUN apt-get -y install supervisor
RUN apt-get -y install xfce4 xfce4-terminal
RUN apt-get -y install xterm dbus-x11 libdbus-glib-1-2 libgtk2.0-dev
RUN apt-get -y install xfce4-goodies
RUN apt-get -y install tigervnc-standalone-server
RUN apt-get -y install novnc xrdp openvpn filezilla
RUN apt-get -y install python3-numpy python3-websockify
RUN apt-get -y install libnss-wrapper gettext
RUN apt-get clean -y

# INFOS PACKAGINGS INSTALL
# vim for editor when to use in terminal
# sudo for using this in terminal
# procps for accessing informations about processors (legacy from Dockerfile from ConSol)
# wget for downloading from terminal
# net-tools for tools to management network (as ping)
# iproute2 for completing net-tools
# curl for reach URL
# dos2unix for tool to convert files into unix format
# bzip2 for a tool about compressing files and unzipping
# apt-utils for management packaging in order to install/remove
# coreutils for sha256sum (already installed => openssl sha256 OR sha256sum)
# supervisor for alternative to a  scheduler (doesn't work for now but it has been keeping + legacy from Dockerfile from ConSol)
# xfce4 + xfce4-terminal + xterm + dbus-x11 + libdbus-glib-1-2 + xfce4-goodies => GUI
# libgtk2.0-dev for GIO
# tigervnc-standalone-server for server VNC
# novnc for the wrapper between browser and VNC
# xrdp for the remote windows access
# openvpn for the vpn tool
# filezilla for the GUI ftp tool
#
# python3-numpy for websockify (VNC)
# python3-websockify for Websockify, for VNC
# libnss-wrapper for daemon management user (legacy from Dockerfile from ConSol)
# gettext for text and IO (legacy from Dockerfile from ConSol)

#LANGAGE SETUP
RUN apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
        && localedef -i $MYLANG -c -f UTF-8 -A /usr/share/locale/locale.alias $MYLANG.UTF-8 \
&& apt-get clean -y
ENV LANG="$MYLANG.utf8"


##########################################################################
## PART 1: DOWNLOADS HERE
##########################################################################

################################
# A. WALLPAPERS + STARTUPDIR
################################
RUN mkdir $STARTUPDIR && mkdir $STARTUPDIR/wallpapers && chmod -R 755 $STARTUPDIR && chmod -R 755 $STARTUPDIR/wallpapers
#Uncomment only one line: here under Firewall:
#RUN wget --timeout=5 --tries=2 --no-check-certificate -O $STARTUPDIR/wallpapers/bg_custom_wallpaper.png -c $BG_WLLP
#Uncomment only one line: here without Firewall (more secure to avoid "man in the middle"):
RUN wget --timeout=5 --tries=2 -O $STARTUPDIR/wallpapers/bg_custom_wallpaper.png -c $BG_WLLP
#RUN chmod 755 $STARTUPDIR/wallpapers/bg_custom_wallpaper.png && mv /usr/share/images/desktop-base/default /usr/share/images/desktop-base/.default && ln -s $STARTUPDIR/wallpapers/bg_custom_wallpaper.png /usr/share/images/desktop-base/default

################################
# B. BROWSER: FIREFOX
################################
RUN mkdir -p $INST_FF && chmod 755 $INST_FF
#Uncomment only one line: here under Firewall:
#RUN wget --timeout=5 --tries=2 --no-check-certificate -qO- $FF_URL | tar xvj --strip 1 -C $INST_FF/
#Uncomment only one line: here without Firewall (more secure to avoid "man in the middle"):
RUN wget --timeout=5 --tries=2 -qO- $FF_URL | tar xvj --strip 1 -C $INST_FF/
RUN mkdir -p $HOME/firefox/extensions; chmod 755 $HOME/firefox/extensions;  curl https://addons.mozilla.org/firefox/downloads/file/4343983/ghostery-10.4.3.xpi > $HOME/firefox/extensions/ghostery-10.4.3.xpi; curl https://addons.mozilla.org/firefox/downloads/file/4351045/adblock_plus-4.7.xpi > $HOME/firefox/extensions/adblock_plus-4.7.xpi

#Correct issue "certificate not trust":
# In client side (as WSL), install: apt-get install ca-certificates
# ln -sT /usr/ssl /etc/ss
# wget --timeout=5 --tries=2 --ca-directory=/usr/ssl/certs -O /home/<user>/<path>/bg_custom_wallpaper.png -c https://hereitsanurltoreach.com/download/bgwallpaper.jpg
# If not working, the bad workaround:
# wget --timeout=5 --tries=2 --no-check-certificate -O /home/<user>/<path>/bg_custom_wallpaper.png -c https://hereitsanurltoreach.com/download/bgwallpaper.jpg
# [See part "Issue WGET" for explanations]

################################
# C. RDP: PICS
################################
#Logo file needs to be a bmp picture
#If you have any issue, as an image created/modified with GIMP, be sure about your file and check:
# WSL-root> file /usr/share/xrdp/login-user.bmp
# The success format file I found is here: PC bitmap, Windows 98/2000 and newer format, 64 x 64 x 24, cbSize 12426, bits offset 138
# From GIMP, my checkbox "do not write" is not checked.
# I use 24 bits for the export.
#src=https://github.com/neutrinolabs/xrdp/issues/2343
#Uncomment only one line: here under Firewall:
#RUN wget --timeout=5 --tries=2 --no-check-certificate -O /home/$USERVNC/login-user.bmp -c $RDP_LOGO && sleep 5 && chmod 755 /usr/share/xrdp/login-user.bmp && wget --timeout=5 --tries=2 --no-check-certificate -O $RDP_LOCAL_WLLP -c $RDP_WLLP && sleep 5 && chmod 755 $RDP_LOCAL_WLLP
#Uncomment only one line: here without Firewall (more secure to avoid "man in the middle"):
RUN wget --timeout=5 --tries=2 -O /usr/share/xrdp/login-user.bmp -c $RDP_LOGO && sleep 5 && chmod 755 /usr/share/xrdp/login-user.bmp && wget --timeout=5 --tries=2 --no-check-certificate -O $RDP_LOCAL_WLLP -c $RDP_WLLP && sleep 5 && chmod 755 $RDP_LOCAL_WLLP


##########################################################################
## PART 2: DIRS HERE
##########################################################################

#CREATE USER COMMANDS - START_STOP_STATUS - FEATURE FOR MYSELF
#It's tools to use manually in case of
RUN mkdir -p /home/$USERVNC && chmod 755 /home/$USERVNC
RUN touch $HOME/.profile && chmod 755 $HOME/.profile
RUN touch /home/$USERVNC/.profile && chmod 755 /home/$USERVNC/.profile
RUN echo alias ll=\"ls -artl\" >> /home/$USERVNC/.profile && echo . $STARTUPDIR/mypsswdservice.sh >> /home/$USERVNC/.profile
RUN echo alias ll=\"ls -artl\" >> $HOME/.profile && echo . $STARTUPDIR/mypsswdservice.sh >> $HOME/.profile
RUN echo alias ll=\"ls -artl\" >> /root/.profile && export DISPLAY=:1.0
RUN useradd -m -s /bin/bash $USERVNC && chown $USERVNC:$USERVNC /home/$USERVNC/.profile
RUN mkdir -p /home/$USERVNC/.vnc/
RUN chown $USERVNC:$USERVNC /home/$USERVNC/
RUN echo vncserver :1 -rfbport $VNC_PORT -localhost no > /home/$USERVNC/.start
RUN echo vncserver -kill :1 > /home/$USERVNC/.stop
RUN echo ps -aux \| grep vnc > /home/$USERVNC/.status
RUN echo netstat -a \| grep : >> /home/$USERVNC/.status
RUN echo \#!\/bin\/sh > /home/$USERVNC/.vncserverstart
RUN echo rm -Rf /tmp/.X1-lock >> /home/$USERVNC/.vncserverstart && echo rm -Rf /tmp/.X11-unix/X1 >> /home/$USERVNC/.vncserverstart
RUN echo vncserver :1 -rfbport $VNC_PORT -localhost no >> /home/$USERVNC/.vncserverstart
RUN chmod 755 /home/$USERVNC/.start /home/$USERVNC/.stop /home/$USERVNC/.status /home/$USERVNC/.vncserverstart
RUN chown $USERVNC:$USERVNC /home/$USERVNC/.vnc/

#This tool will be used, mainly this dir
RUN echo \#!\/bin\/sh > $STARTUPDIR/rebootvncserver.sh
RUN echo rm -Rf /tmp/.X1-lock >> $STARTUPDIR/rebootvncserver.sh && echo rm -Rf /tmp/.X11-unix/X1 >> $STARTUPDIR/rebootvncserver.sh
RUN echo vncserver \-kill \:1 >> $STARTUPDIR/rebootvncserver.sh && echo vncserver \:1 \-rfbport $VNC_PORT \-localhost no >> $STARTUPDIR/rebootvncserver.sh
RUN chown $USERVNC:$USERVNC $STARTUPDIR/rebootvncserver.sh && chmod 755 $STARTUPDIR/rebootvncserver.sh

#STARTUP INFORMATIONS FROM MY OWN SEARCHES FROM THE WEB
#init.d, daemon upstart, systemd => not working
#if systemd isn't PID=1, can't work in WSL
#systemd doesn't work with docker => use ENTRYPOINT
#To understand ENTRYPOINT, read this page internet below
#code.visualstudio.com/remote/advancedcontainers/start-processes
#My starter image I was used to understand fully is this member from GitHub: ConSol/docker-headless-vnc-container (my target was the debian part)

#SOURCES
#src1=unix.stackexchange.com/questions/353604/debian-startup-script-doesnt-start
#src2=hackernoon.com/how-to-run-scripts-on-boot-in-linux-using-systemd


##########################################################################
## PART 3: DIR STARTUP HERE
##########################################################################

#As REBOOT COMMANDS: it's tools to use manually in case of
RUN echo \#!\/bin\/sh > /usr/local/sbin/vncserver.sh
RUN echo rm -Rf /tmp/.X1-lock >> /usr/local/sbin/vncserver.sh && echo rm -Rf /tmp/.X11-unix/X1 >> /usr/local/sbin/vncserver.sh
RUN echo vncserver \:1 \-rfbport $VNC_PORT \-localhost no >> /usr/local/sbin/vncserver.sh && chmod +x /usr/local/sbin/vncserver.sh


##########################################################################
## PART 4: SERVICES HERE
##########################################################################

#PERSONNAL SERVICE FILE
RUN touch $STARTUPDIR/r00t4m0nk.sh

#TO RELOAD WALLPAPER BACKGROUND
RUN touch $STARTUPDIR/mybackgroundwllpservice.sh && echo rm \-f \/usr\/share\/images\/desktop\-base\/default >> $STARTUPDIR/mybackgroundwllpservice.sh  && echo ln \-s \/startup\/wallpapers\/bg_custom_wallpaper\.png \/usr\/share\/images\/desktop\-base\/default >> $STARTUPDIR/mybackgroundwllpservice.sh && chmod 755 $STARTUPDIR/mybackgroundwllpservice.sh && $STARTUPDIR/mybackgroundwllpservice.sh

#FIREFOX PANEL
RUN touch $STARTUPDIR/myfirefoxservice.sh && echo sleep 0 >> $STARTUPDIR/myfirefoxservice.sh && echo if \! \[ \-f "$HOME/.firefox" \]\; then >> $STARTUPDIR/myfirefoxservice.sh
RUN echo if \[ \-f "$HOME/Desktop/firefox.desktop" \]\; then >> $STARTUPDIR/myfirefoxservice.sh
RUN echo ls $HOME\/\.config\/xfce4\/panel\/launcher\-19\/ \> $HOME\/tmp\.txt >> $STARTUPDIR/myfirefoxservice.sh
RUN echo cp $HOME\/Desktop\/firefox\.desktop $HOME\/\.config\/xfce4\/panel\/launcher\-19\/ >> $STARTUPDIR/myfirefoxservice.sh
RUN echo \# rm \-f $HOME\/\.config\/xfce4\/panel\/launcher\-19\/\`cat $HOME\/tmp\.txt\` >> $STARTUPDIR/myfirefoxservice.sh
RUN echo mv $HOME\/\.config\/xfce4\/panel\/launcher\-19\/firefox\.desktop $HOME\/\.config\/xfce4\/panel\/launcher\-19\/\`cat $HOME\/tmp\.txt\` >> $STARTUPDIR/myfirefoxservice.sh
RUN echo fi >> $STARTUPDIR/myfirefoxservice.sh
RUN echo cp $STARTUPDIR/mymimeapps.list $HOME/.config/mimeapps.list >> $STARTUPDIR/myfirefoxservice.sh && echo chown $USERVNC:$USERVNC $HOME/.config/mimeapps.list >> $STARTUPDIR/myfirefoxservice.sh && echo chmod 755 $HOME/.config/mimeapps.list >> $STARTUPDIR/myfirefoxservice.sh
# Set Firefox shortcut in Panel XFCE4 for RDP remote access
RUN echo ls /home/$USERVNC\/\.config\/xfce4\/panel\/launcher\-19\/ 1\> $HOME\/tmp2\.txt 2\>\/dev\/null >> $STARTUPDIR/myfirefoxservice.sh && echo cp -f $HOME\/\.config\/xfce4\/panel\/launcher\-19\/\`cat $HOME\/tmp\.txt\` /home/$USERVNC\/\.config\/xfce4\/panel\/launcher\-19\/ 2\>\/dev\/null >> $STARTUPDIR/myfirefoxservice.sh && echo \# rm /home/$USERVNC\/\.config\/xfce4\/panel\/launcher\-19\/\`cat $HOME\/tmp2\.txt\` 2\>\/dev\/null >> $STARTUPDIR/myfirefoxservice.sh && echo mv /home/$USERVNC\/\.config\/xfce4\/panel\/launcher\-19\/\`cat $HOME\/tmp\.txt\` /home/$USERVNC\/\.config\/xfce4\/panel\/launcher\-19\/\`cat $HOME\/tmp2\.txt\` 2\>\/dev\/null >> $STARTUPDIR/myfirefoxservice.sh
RUN echo rm \-f $HOME\/tmp\.txt 2\>\/dev\/null >> $STARTUPDIR/myfirefoxservice.sh && echo rm \-f $HOME\/tmp2\.txt 2\>\/dev\/null >> $STARTUPDIR/myfirefoxservice.sh && echo update\-desktop\-database \-q >> $STARTUPDIR/myfirefoxservice.sh
RUN echo "pkill \-f xfce4-panel 2>/dev/null" >>  $STARTUPDIR/myfirefoxservice.sh && echo "xfce4-panel &" >>  $STARTUPDIR/myfirefoxservice.sh && echo "$STARTUPDIR/myfirefoxsvc.sh \$1 &" >> $STARTUPDIR/myfirefoxservice.sh && echo "touch $HOME/.firefox" >> $STARTUPDIR/myfirefoxservice.sh && echo "fi" >> $STARTUPDIR/myfirefoxservice.sh && echo if \! \[ \-f "$HOME/.firefoxtmp" \]\; then >> $STARTUPDIR/myfirefoxservice.sh && echo "rm $HOME/.firefox" >> $STARTUPDIR/myfirefoxservice.sh && echo "touch $HOME/.firefoxtmp" >> $STARTUPDIR/myfirefoxservice.sh && echo "fi" >> $STARTUPDIR/myfirefoxservice.sh && chmod 755 $STARTUPDIR/myfirefoxservice.sh && $STARTUPDIR/myfirefoxservice.sh
RUN echo $STARTUPDIR\/myfirefoxservice\.sh containered >> /home/$USERVNC/.bashrc && echo \#We start 2nd time but only this >> /home/$USERVNC/.bashrc && echo $STARTUPDIR\/myfirefoxsvc\.sh containered >> /home/$USERVNC/.bashrc && echo $STARTUPDIR\/myscreenstretched\.sh >> /home/$USERVNC/.bashrc && echo $STARTUPDIR\/myfirefoxservice\.sh >> /root/.bashrc && echo 'export USERCOMET='$USERVNC >> /home/$USERVNC/.bashrc && echo 'export USERCOMET='$USERVNC >> /root/.bashrc && echo 'export STARTUPDIR='$STARTUPDIR >> /home/$USERVNC/.bashrc && echo 'export STARTUPDIR='$STARTUPDIR >> /root/.bashrc && echo "alias ll='ls -artl'" >> /home/$USERVNC/.bashrc && echo "alias ll='ls -artl'" >> /root/.bashrc && cp /home/$USERVNC/.bashrc /home/$USERVNC/.bashrc_comet && cp /root/.bashrc /root/.bashrc_comet
RUN echo ACTION\=\$1 > $STARTUPDIR/myfirefoxsvc.sh && echo if \! \[ \-f "$HOME/.firefoxtmp" \]\; then >> $STARTUPDIR/myfirefoxsvc.sh && echo exit >> $STARTUPDIR/myfirefoxsvc.sh && echo fi >> $STARTUPDIR/myfirefoxsvc.sh && echo if \[ \"\$ACTION\" \= \"containered\" \]\; then >> $STARTUPDIR/myfirefoxsvc.sh && echo "cp \"$HOME/Desktop/firefox.desktop\" \"\$(grep -H Exec=exo /home/$USERVNC/.config/xfce4/panel/launcher-19/\`ls /home/$USERVNC/.config/xfce4/panel/launcher-19/\` | tail -1 | cut -d: -f1)\" 2>/dev/null" >> $STARTUPDIR/myfirefoxsvc.sh && echo fi >> $STARTUPDIR/myfirefoxsvc.sh && chmod 755 $STARTUPDIR/myfirefoxsvc.sh

#FIREFOX ASSOCIATION
RUN echo \[Added Associations\] > $STARTUPDIR/mymimeapps.list && chmod 755 $STARTUPDIR/mymimeapps.list && echo application\/xhtml\_xml\=firefox\.desktop\; >> $STARTUPDIR/mymimeapps.list && echo text\/html\=firefox\.desktop\; >> $STARTUPDIR/mymimeapps.list && echo text\/xml\=firefox\.desktop\; >> $STARTUPDIR/mymimeapps.list
RUN echo x\-scheme\-handler\/ftp\=firefox\.desktop\; >> $STARTUPDIR/mymimeapps.list && echo x\-scheme\-handler\/http\=firefox\.desktop\; >> $STARTUPDIR/mymimeapps.list && echo x\-scheme\-handler\/https\=firefox\.desktop\; >> $STARTUPDIR/mymimeapps.list && echo "" >> $STARTUPDIR/mymimeapps.list
RUN echo \[Default Applications\] >> $STARTUPDIR/mymimeapps.list && echo application\/xhtml\_xml\=firefox\.desktop\; >> $STARTUPDIR/mymimeapps.list && echo text\/html\=firefox\.desktop\; >> $STARTUPDIR/mymimeapps.list && echo text\/xml\=firefox\.desktop\; >> $STARTUPDIR/mymimeapps.list
RUN echo x\-scheme\-handler\/ftp\=firefox\.desktop\; >> $STARTUPDIR/mymimeapps.list && echo x\-scheme\-handler\/http\=firefox\.desktop\; && echo x\-scheme\-handler\/https\=firefox\.desktop\; >> $STARTUPDIR/mymimeapps.list
RUN echo cd $HOME\/Desktop\/ >> $STARTUPDIR/mymimeapps.list && echo dbus\-launch gio set firefox\.desktop \"metadata\:\:trusted\" yes >> $STARTUPDIR/mymimeapps.list

#PASSWD
RUN touch $STARTUPDIR/mypsswdservice.sh && echo export ROOT_PW= >>  $STARTUPDIR/mypsswdservice.sh && echo export USER_PW= >>  $STARTUPDIR/mypsswdservice.sh

#RDP: SET SUDO RIGHTS FOR USER VNCUSER
RUN echo touch $STARTUPDIR/myrdpservice.sh && echo sudo \/usr\/bin\/pkill xrdp >> $STARTUPDIR/myrdpservice.sh && echo sudo \/usr\/sbin\/service xrdp restart >> $STARTUPDIR/myrdpservice.sh && chmod 755 $STARTUPDIR/myrdpservice.sh
RUN echo touch $STARTUPDIR/myrdpstartservice.sh && echo sudo \/usr\/sbin\/service xrdp start \&\& tail \-f \/dev\/null >> $STARTUPDIR/myrdpstartservice.sh && chmod 755 $STARTUPDIR/myrdpstartservice.sh
RUN echo \%$USERVNC ALL\= NOPASSWD\: \/usr\/sbin\/service xrdp start >> /etc/sudoers && echo \%$USERVNC ALL\= NOPASSWD\: \/usr\/bin\/pkill xrdp >> /etc/sudoers && echo \%$USERVNC ALL\= NOPASSWD\: \/usr\/sbin\/service xrdp stop >> /etc/sudoers && echo \%$USERVNC ALL\= NOPASSWD\: \/usr\/sbin\/service xrdp restart >> /etc/sudoers && echo \%root ALL\= \(ALL\) PASSWD\: ALL >> /etc/sudoers
#MYVNCSERVICE
RUN echo rm -Rf /tmp/.X1-lock > $STARTUPDIR/myvncservice.sh
RUN echo rm -Rf /tmp/.X11-unix/X1 >> $STARTUPDIR/myvncservice.sh
RUN echo if \[ \`whoami\` \=\= \'root\' \]\; then >> $STARTUPDIR/myvncservice.sh
RUN echo     su \- $USERVNC \-c \'vncserver \:1 \-rfbport $VNC_PORT \-localhost no \-rfbauth $HOME linux\/\.vnc\/passwd\' >>  $STARTUPDIR/myvncservice.sh
RUN echo fi >> $STARTUPDIR/myvncservice.sh
RUN echo if \[ \`whoami\` \=\= \'$USERVNC\' \]\; then >> $STARTUPDIR/myvncservice.sh
RUN echo     vncserver \:1 \-rfbport $VNC_PORT \-localhost no >>  $STARTUPDIR/myvncservice.sh
RUN echo fi >> $STARTUPDIR/myvncservice.sh
RUN echo     " " >>  $STARTUPDIR/myvncservice.sh
#MYNOVNCSERVICE
RUN echo     \/usr\/share\/novnc\/utils\/novnc_proxy \-\-vnc localhost\:$VNC_PORT \-\-listen $NO_VNC_PORT \& >  $STARTUPDIR/mynovncservice.sh
#Screen Stretched
RUN echo sed -i \'s\+\"image\-style\" type\=\"int\" value\=\"5\"\+\"image\-style\" type\=\"int\" value\=\"3\"\+g\' \/home\/$USERVNC\/\.config\/xfce4\/xfconf\/xfce\-perchannel\-xml\/xfce4\-desktop\.xml 2\>\/dev\/null > $STARTUPDIR/myscreenstretched.sh && echo sed -i \'s\+\"image\-style\" type\=\"int\" value\=\"5\"\+\"image\-style\" type\=\"int\" value\=\"3\"\+g\' \/universe\/\.config\/xfce4\/xfconf\/xfce\-perchannel\-xml\/xfce4\-desktop\.xml 2\>\/dev\/null >> $STARTUPDIR/myscreenstretched.sh 
#MYENTRYPOINTSERVICE - THE START WHEN CONTAINER STARTS (with user rights not root)
RUN echo     \#\!\/usr\/bin\/env bash >  $STARTUPDIR/myentrypoint.sh
#An issue is on a Refresh during a RDP session, so it's need to relaunch twice:
RUN echo $STARTUPDIR\/myvncservice\.sh >> $STARTUPDIR/myentrypoint.sh && echo $STARTUPDIR\/mynovncservice\.sh >> $STARTUPDIR/myentrypoint.sh && echo $STARTUPDIR\/myfirefoxservice\.sh >> $STARTUPDIR/myentrypoint.sh && echo $STARTUPDIR\/mypsswdservice\.sh >> $STARTUPDIR/myentrypoint.sh && echo $STARTUPDIR\/myscreenstretched\.sh >> $STARTUPDIR/myentrypoint.sh && echo $STARTUPDIR\/myrdpservice\.sh >> $STARTUPDIR/myentrypoint.sh
RUN echo $STARTUPDIR\/r00t4m0nk\.sh >> $STARTUPDIR/myentrypoint.sh
RUN echo $STARTUPDIR\/myfirefoxservice\.sh > $STARTUPDIR/mydesk.sh && echo $STARTUPDIR\/myrdpservice\.sh >> $STARTUPDIR/mydesk.sh && chmod 755 $STARTUPDIR/mydesk.sh
RUN echo     exec \"\$\@\" >>  $STARTUPDIR/myentrypoint.sh
RUN chmod 755 $STARTUPDIR/myvncservice.sh && chmod 755 $STARTUPDIR/mynovncservice.sh && chmod 755 $STARTUPDIR/myfirefoxservice.sh && chmod 755 $STARTUPDIR/mypsswdservice.sh && chmod 755 $STARTUPDIR/myrdpservice.sh && chmod 755 $STARTUPDIR/r00t4m0nk.sh && chmod 755 $STARTUPDIR/myscreenstretched.sh && chmod 755 $STARTUPDIR/myentrypoint.sh && chown $USERVNC:$USERVNC $STARTUPDIR/myscreenstretched.sh && echo "mkdir /dev/net; mknod /dev/net/tun c 10 200; chmod 666 /dev/net/tun; echo 'nameserver 8.8.8.8' >> /etc/resolv.conf; echo 'nameserver 1.1.1.1' >> /etc/resolv.conf" >> $STARTUPDIR/myopenvpnnetwork.sh && chmod 755 $STARTUPDIR/myopenvpnnetwork.sh

#UPDATE ROOT USER: SET THE PASSWORD
#Alias ll is on part 2
RUN echo 'root:'$ROOT_PW | chpasswd
RUN echo $USERVNC:$USER_PW | chpasswd

#HOME DIR FOR .VNC
RUN mkdir $HOME/.vnc && chown -R $USERVNC:$USERVNC $HOME && chmod -R 755 $HOME

#CLEAN
RUN rm -Rf /tmp/.X1-lock && rm -Rf /tmp/.X11-unix/X1


##########################################################################
## PART 5: FIREFOX SETTINGS HERE
##########################################################################

#Disable AutoUpdate FF
RUN mkdir -p $INST_FF/browser/defaults/profile && touch $INST_FF/browser/defaults/profile/user.js
RUN echo user_pref\(\"app\.update\.auto\"\, false\)\; >> $INST_FF/browser/defaults/profile/user.js
RUN echo user_pref\(\"app\.update\.enabled\"\, false\)\; >> $INST_FF/browser/defaults/profile/user.js
RUN echo user_pref\(\"app\.update\.lastUpdateTime\.addon\-background\-update\-timer\"\, 1182011519\)\; >> $INST_FF/browser/defaults/profile/user.js
RUN echo user_pref\(\"app\.update\.lastUpdateTime\.background\-update\-timer\"\, 1182011519\)\; >> $INST_FF/browser/defaults/profile/user.js
RUN echo user_pref\(\"app\.update\.lastUpdateTime\.blocklist\-background\-update\-timer\"\, 1182010203\)\; >> $INST_FF/browser/defaults/profile/user.js
RUN echo user_pref\(\"app\.update\.lastUpdateTime\.microsummary\-generator\-update\-timer\"\, 1222586145\)\; >> $INST_FF/browser/defaults/profile/user.js
RUN echo user_pref\(\"app\.update\.lastUpdateTime\.search-engine\-update\-timer\"\, 1182010203\)\; >> $INST_FF/browser/defaults/profile/user.js

#Firefox Desktop: BETTER TO COPY EXISTING TO AVOID "MAX DEPTH EXCEEDED"
RUN mkdir -p $HOME/Desktop
RUN cp /usr/share/applications/xfce4-web-browser.desktop $HOME/.xfce4-web-browser-cpy && cp /usr/share/applications/xfce4-web-browser.desktop $HOME/Desktop/firefox.desktop && cp /usr/share/applications/xfce4-web-browser.desktop /usr/share/applications/firefox.desktop
#TRUST
RUN cd $HOME/Desktop/ && chown $USERVNC:$USERVNC firefox.desktop && chmod +x firefox.desktop && dbus-launch gio set firefox.desktop "metadata::trusted" yes && cd -
RUN cd /usr/share/applications/ && chown $USERVNC:$USERVNC firefox.desktop && chmod +x firefox.desktop && dbus-launch gio set firefox.desktop "metadata::trusted" yes && cd -
RUN cp /usr/share/applications/xfce4-web-browser.desktop /usr/share/applications/firefox.desktop
RUN chown $USERVNC:$USERVNC /usr/share/applications/xfce4-web-browser.desktop && chmod 755 /usr/share/applications/xfce4-web-browser.desktop
RUN chmod 755 $HOME/Desktop/firefox.desktop && chmod 755 /usr/share/applications/firefox.desktop
RUN sed -i 's/exo-open --launch WebBrowser/firefox/g' $HOME/Desktop/firefox.desktop
RUN sed -i 's/exo-open --launch WebBrowser/firefox/g' /usr/share/applications/firefox.desktop
RUN sed -i 's/org.xfce.webbrowser/\/usr\/lib\/firefox\/browser\/chrome\/icons\/default\/default128.png/g' $HOME/Desktop/firefox.desktop
RUN sed -i 's/org.xfce.webbrowser/\/usr\/lib\/firefox\/browser\/chrome\/icons\/default\/default128.png/g' /usr/share/applications/firefox.desktop
#ONLY PRIVATE FOR ME
RUN sed -i 's/Navigateur Web/Firefox/g' $HOME/Desktop/firefox.desktop && chmod -R 755 $HOME/Desktop

#SET FIREFOX AS TRUST, DESKTOP & ALLOW START
RUN cp -R $HOME/firefox /usr/lib/firefox && chmod -R 755 /usr/lib/firefox && ln -s /usr/lib/firefox/firefox /usr/bin/firefox

#TEST PAGE HTML (to use for checking association files or use as skeleton to download fast a target) +OPENVPN
RUN echo '<html><head></head><body><table><tr><td><a href="https://testmypage.com">My URL</a></td></tr>' > $HOME/mytestpage.html && echo '<tr><td><a href="https://www.freeopenvpn.org">Free Open VPN Server</a> user=freeopenvpn</td></tr>' >> $HOME/mytestpage.html && echo '<tr><td><a href="https://www.showmyip.com">Test on the IP address</a></td></tr>' >> $HOME/mytestpage.html && echo '<tr><td>&nbsp;</td></tr>' >> $HOME/mytestpage.html && echo '</body></html>' >> $HOME/mytestpage.html && chown $USERVNC:$USERVNC $HOME/mytestpage.html && echo "export VPN_PASSWORD=\$2; export CONFIG_FILE=\$1; export VPN_USER=freeopenvpn; bash -c \"openvpn --config '\"\$CONFIG_FILE\"' --auth-user-pass <(echo -e \"\$VPN_USER\"'\n''\"\$VPN_PASSWORD\"')\"" >> $STARTUPDIR/mystartopenvpn.sh && chmod 755 $STARTUPDIR/mystartopenvpn.sh
#[code] export VPN_PASSWORD=$2; export CONFIG_FILE=$1; export VPN_USER=freeopenvpn; bash -c "openvpn --config '"$CONFIG_FILE"' --auth-user-pass <(echo -e "$VPN_USER"'\n''"$VPN_PASSWORD"')"


##########################################################################
## PART 6: RDP
##########################################################################
#To know version: xrdp -v | grep "xrdp " | head -n 1 | cut -d' ' -f2
#
#Don't forget to set port forwarding in the host machine, with PowerShell:
#netsh interface portproxy add v4tov4 listenport=3389 listenaddress=<IP_MACHINE_HOST> connectport=3390 connectaddress=<IP_CONTAINER>
#
#<IP_MACHINE_HOST> => or you know because you connect through a VNC service, or type in the machine within a DOS shell: CMD > ipconfig (most of time: ethernet, "IPV4")
#<IP_CONTAINER> => in the WSL, within the host and outside from container: WSL ifconfig (most of time: eth0, inet @ddress)
#
#Set Port and Graphic RDP
#Leave <<port = 3 3 8 9>> without blanks, here because it's the standard port to change into the new port /!\
RUN echo "sed -i 's+port=3389+port= tcp: //:'$RDP_PORT'+g' /etc/xrdp/xrdp.ini && sed -i 's+#ls_title=My Login Title+ls_title=$RDP_TITLE+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_height=430+ls_height=240+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_bg_color=dedede+ls_bg_color=e8e8e8+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_logo_filename=$+ls_logo_filename=/usr/share/xrdp/login-user.bmp+g' /etc/xrdp/xrdp.ini && sed -i 's+#ls_logo_transform=none+ls_logo_transform=scale+g' /etc/xrdp/xrdp.ini && sed -i 's+#ls_logo_width=240+ls_logo_width=64+g' /etc/xrdp/xrdp.ini && sed -i 's+#ls_logo_height=140+ls_logo_height=64+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_logo_x_pos=55+ls_logo_x_pos=150+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_logo_y_pos=50+ls_logo_y_pos=25+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_label_x_pos=30+ls_label_x_pos=20+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_input_x_pos=110+ls_input_x_pos=150+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_input_width=210+ls_input_width=170+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_input_y_pos=220+ls_input_y_pos=100+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_btn_ok_x_pos=142+ls_btn_ok_x_pos=80+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_btn_ok_y_pos=370+ls_btn_ok_y_pos=200+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_btn_cancel_x_pos=237+ls_btn_cancel_x_pos=180+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_btn_cancel_y_pos=370+ls_btn_cancel_y_pos=200+g' /etc/xrdp/xrdp.ini && sed -i 's+ls_top_window_bg_color=009cb5+ls_top_window_bg_color=000000+g' /etc/xrdp/xrdp.ini && sed -i 's+blue=009cb5+#blue=009cb5+g' /etc/xrdp/xrdp.ini && sed -i 's+#ls_background_image=+ls_background_image='$RDP_LOCAL_WLLP'+g' /etc/xrdp/xrdp.ini && sed -i 's+#ls_background_transform=none+ls_background_transform=scale+g' /etc/xrdp/xrdp.ini" > $STARTUPDIR/mycometdesignRDP.sh && echo touch /root/.hushlogin  >> $STARTUPDIR/mycometdesignRDP.sh && echo "if [ -f /etc/xrdp/xrdp.ini.original ]; then" >> $STARTUPDIR/mycometdesignRDP.sh && echo "cp -f /etc/xrdp/xrdp.ini.original /etc/xrdp/xrdp.ini" >> $STARTUPDIR/mycometdesignRDP.sh && echo fi >> $STARTUPDIR/mycometdesignRDP.sh && chmod 755 $STARTUPDIR/mycometdesignRDP.sh && $STARTUPDIR/mycometdesignRDP.sh
RUN echo \[Unit\] > /etc/systemd/system/xrdp.service && echo Description\=RDP >> /etc/systemd/system/xrdp.service && echo "" >> /etc/systemd/system/xrdp.service && echo \[Service\] >> /etc/systemd/system/xrdp.service && echo User\=root >> /etc/systemd/system/xrdp.service && echo WorkingDirectory\=\/root >> /etc/systemd/system/xrdp.service && echo ExecStart=service xrdp restart >> /etc/systemd/system/xrdp.service && echo "" >>  /etc/systemd/system/xrdp.service && echo \[Install\] >> /etc/systemd/system/xrdp.service && echo WantedBy\=multi\-user\.target >> /etc/systemd/system/xrdp.service && chmod 755 /etc/systemd/system/xrdp.service
RUN echo \[program\:restart\-xrdp\] > /etc/supervisor/conf.d/xrdp.conf && echo command\=$STARTUPDIR\/myrdpservice\.sh >> /etc/supervisor/conf.d/xrdp.conf && chmod 755 /etc/supervisor/conf.d/xrdp.conf && touch /var/run/supervisor.sock && chmod 777 /var/run/supervisor.sock && service supervisor restart && echo service --user enable httpd.service > /etc/systemd/user/xrdp.service /etc/systemd/user && echo >> /etc/systemd/user/xrdp.service

##########################################################################
## PART 7: SPECIAL DEBIAN - DEACTIVATE POWER MANAGEMENT
##########################################################################
RUN mv /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libxfce4powermanager.so /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libxfce4powermanager.so.off && pkill -f xfce4-power-manager


##########################################################################
## PART 8: LAST ACTIONS ROOT
##########################################################################
RUN chown -R $USERVNC:$USERVNC $HOME/.local/ && chmod -R 755 $HOME
RUN chown -R $USERVNC:$USERVNC $HOME/Desktop/firefox.desktop && chown -R $USERVNC:$USERVNC /usr/bin/firefox && chown -R $USERVNC:$USERVNC /usr/lib/firefox/ && chmod -R 755 /usr/lib/firefox/ && chmod +x $HOME/Desktop/firefox.desktop
RUN cd $HOME/Desktop/ && dbus-launch gio set firefox.desktop "metadata::trusted" yes
RUN sed -i 's+OnlyShowIn=XFCE;+OnlyShowIn=+g' $HOME/Desktop/firefox.desktop
RUN echo sudo \-u $USERVNC $STARTUPDIR\/myrdpstartservice\.sh > /root/userstartxrdp.sh && chmod 755 /root/userstartxrdp.sh && . /root/userstartxrdp.sh &

RUN touch $STARTUPDIR/mycometdesignTerminal.sh && touch $STARTUPDIR/mycometdesignUserTerminal.sh && echo "cp /home/$user/.bashrc /home/$user/.bashrc_\`echo \$(date '+%Y%m%d_%H_%M_%S)\`" >> $STARTUPDIR/mycometdesignUserTerminal.sh && echo "cp /home/$user/bashrc_comet /home/$user/.bashrc" >> $STARTUPDIR/mycometdesignUserTerminal.sh && echo "cp /root/.bashrc /root/.bashrc_\`echo \$(date '+%Y%m%d_%H_%M_%S')\`" >> $STARTUPDIR/mycometdesignTerminal.sh && echo "cp /root/.bashrc_comet /root/.bashrc" >> $STARTUPDIR/mycometdesignTerminal.sh && echo "cp /root/.bashrc.original /root/.bashrc 2>/dev/null" >> $STARTUPDIR/mycometdesignTerminal.sh && touch ~/.hushlogin >> $STARTUPDIR/mycometdesignTerminal.sh && chmod 755 $STARTUPDIR/mycometdesignTerminal.sh && chmod 755 $STARTUPDIR/mycometdesignUserTerminal.sh && chmod 755 /home/$USERVNC/.bashrc && chmod 755 /home/$USERVNC/.bashrc_comet && chmod 755 /root/.bashrc && chmod 755 /root/.bashrc_comet && chown $USERVNC:$USERVNC /home/$USERVNC/.bashrc && chown $USERVNC:$USERVNC /home/$USERVNC/.bashrc_comet && touch ~/.hushlogin

##########################################################################
## PART 9: SWITCH USER
##########################################################################
#SWITCH TO USER VNC & SET THE VNC PASSWORD
USER 1000
RUN printf "$VNC_PW\n$VNC_PW\n\n" | vncpasswd
# To avoid a bug with xfce4, you will need to run twice this shell to add Firefox inside the panel: $STARTUPDIR/myfirefoxsvc.sh
RUN $STARTUPDIR/myrdpservice.sh


##########################################################################
## PART 10: START SERVICES & KEEP CONTAINER UP
##########################################################################
ENTRYPOINT ["/startup/myentrypoint.sh"]
CMD ["sleep", "infinity"]


##########################################################################
## PART 11: INFORMATIONS
##########################################################################

#INFO for DIPSLAY
#pgrep --list-full xfdesktop
#src=forum.xfce.org/viewtopic.php?id=15887

#CMD CONTROL VNC IN ORDER TO REBOOT (examples with port chosen: 5901 => change before any copy)
#vncserver -kill :1
#vncserver :1 -rfbport 5901 -localhost no

#RDP
#pkill xrdp && service xrdp restart

# CHANGE WALLPAPER
# A. Terminal, su - root => wget direct /startup/wallpapers and then step III below.
# B. I.   Download with Firefox and URL into "Download" dir
#    II.  Terminal under root: cd /startup/wallpapers; mv bg_custom_wallpaper.png bg_custom_wallpaper2.png; mv /[HOME]/Download/xxx-fle-xxx.png ./bg_custom_wallpaper.png
#    III. Activate Background Refresh: cd /startup/; . ./mybackgroundwllpservice.sh

#CHECK
#pgrep Xtigervnc
#packet iproute2:
#ss -tulpn | grep -E -i 'vnc|590'
#src= cyberciti.biz/faq/install-and-configure-tigervnc-server-on-ubuntu-18-04

#ISSUES: GIO, WGET, WSL
#If GIO doesn't work, use lib libgtk2.0-dev (for Debian)
#src=stackoverflow.com/questions/4699910/gtk-gio-no-such-file-or-directory
#GIO is mandatory for authorizations management
# gio set "${LAUNCHER}" metadata::trusted true
# gio set "firefox.desktop" metadata::trusted true
# gio info /path_to_file/file.desktop
# sudo -u "${SUDO_USER}" bash -c 'echo "${LAUNCHER}"; gio set "${LAUNCHER}" metadata::trusted true' &> /dev/null
#src=askubuntu.com/questions/1202488/how-to-mark-a-desktop-file-as-trusted-from-command-line-on-ubuntu-18-04
#
#Metadata file
# gio info <file>
# /[HOME]/.local/share/gvfs-metadata/home
#src=forum.xfce.org/viewtopic.php?id=16883
#
#XFCE:Styles
#src=https://superuser.com/questions/1506179/where-does-xfce-store-the-setting-for-the-selected-desktop-wallpaper-file
#~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
#src=https://forum.xfce.org/viewtopic.php?id=8198
#src=https://forum.xfce.org/viewtopic.php?id=9046
#xfconf-query -c xfce4-desktop -p /backdrop -lv
#xfconf-query -c xfce4-desktop -p /backdrop/<SCREEN>/<MONITOR>/WORKSPACE>/image-style -s <IMAGE_STYLE_VALUE>
#image-style (Auto=0, Centered=1, Tiled=2, Stretched=3, Scaled=4, Zoomed=5)
#xfconf-query -c xfce4-desktop -p /backdrop/<SCREEN>/<MONITOR>/WORKSPACE>/image-style -s <IMAGE_STYLE_VALUE>
#xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVGA-0/workspace0/image-style -s 5
#xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-style -s 3
#xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor1/image-style -s 3
#xfconf-query -c xfce4-desktop -v --create -p /backdrop/screen0/monitor0/image-style -t int -s 3
#xfconf-query -c xfce4-desktop -v --create -p /backdrop/screen0/monitor1/image-style -t int -s 3
#
#dbus-launch
#export DISPLAY=:0.0
#export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID/bus
#pkill xfdesktop; dbus-launch; export DISPLAY=:0.0; export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID/bus; xfdesktop &
#
#For any visual test: xeyes
#src=https://linuxconfig.org/fixing-the-cannot-open-display-error-on-linux
#
#Issue+Refresh+RDP
#src=https://askubuntu.com/questions/1523503/x2go-remote-desktop-with-xfce-doesnt-refresh-the-screen
#export DISPLAY=:0.0; touch /etc/X11/Xsession.d/98xfwm4-no_compositing; /usr/bin/xfconf-query -c xfwm4 -p /general/use_compositing -s false

#
#TRUST FILES: XFCE4, THUNAR
#cmd1=GIOFILE=/[HOME]/Desktop/firefox.desktop; sha256sum $GIOFILE  | cut -d' ' -f 1
#cmd2=for f in ~/Desktop/*.desktop; do chmod +x "$f"; gio set -t string "$f" metadata::xfce-exe-checksum "$(sha256sum "$f" | cut -d' ' -f 1)"; done
#src=forum.manjaro.org/t/desktop-files-showing-as-untrusted/133871/5
#
#cmd3=gio set string metadata::xfce-exe-checksum:FILE_SHA256_CHECKSUM
#
#All the issue same as here:
#src=askubuntu.com/questions/1506486/set-desktop-file-as-allow-launching-on-ubuntu-22-04-terminal
#src2=forum.porteus.org/viewtopic.php?t=10923
#
#Idea to have Script + Desktop
#src=unix.stackexchange.com/questions/309133/how-to-make-a-icon-in-desktop-for-a-script
#
# WGET: CACERT, FIREWALL
#To use wget without checking:
#$ wget --no-check-certificate https://download/url
#It's not recommended because of the possibility of a man-in-the-middle attack. (stackexchange, 334905)
#
#In WSL, if copy/paste is locked: superuser.com/questions/1410026/how-to-enable-ctrl-shift-v-in-windows-subsystem-for-linux-wsl-command-pr
#IF you work behind a Firewall, it can changes authorities! And make crash your request. So, turn FRWL on (FRWL=true) in order to have a workaround.

#DOCKER SETTINGS
#Don't forget to use a .wslconfig to limit DockerDesktop if you use it (memory leak)
#src=mrakelinggar.medium.com/set-up-configs-like-memory-limits-in-docker-for-windows-and-wsl2-80689997309c
#
#Below, the point is important on the line with "build"
#Keep in mind to change ports according your choice on the start (line with "run")
#"bash" is mandatory on the end of the line for running the container (in order to connect inside the container from Docker WSL)
#option "-d" is mandatory to have the return from the terminal and write commands (try without and you won't have a free terminal)


######################################################
#DOCKER BUILD - RUN
######################################################
#cd $HOME/Build_Dockerfile_Image (in WSL if you use this, where you put this Dockerfile)
#
#Be sure the file is clean, if you copy/paste into it:
#dos2unix Dockerfile
#
#To keep an idea about the time to generate: 5 minutes
#docker build --rm -t comet .
#/!\ Clean images: docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
#This line could test but we keep in mind it's not same scope inside the container than here in the build file: Here it's mainly to set manually what port are needed (labels in comment should help).
#docker run --name halley -h=halley -it -d -p $RDP_PORT:$RDP_PORT/tcp -p $VNC_PORT:$VNC_PORT/tcp -p $NO_VNC_PORT:$NO_VNC_PORT/tcp comet bash
#docker run --name halley -h=halley -it -d -p 3390:3390/tcp -p 5901:5901/tcp -p 6901:6901/tcp comet bash
#Wait at least 20 seconds and connect. Main functions will be all in an available state.
#
#Have you deleted the container just created because some work done isn't as you want? And you want another container from the same image wihtout building because it's not need? And you see same ID? Ok.
#But --replace doesn't work. Try this last option validated:
#sudo docker run --security-opt seccomp=unconfined --privileged --name halley -h=halley -it -d -p 3389:3389/tcp -p 3901:3901/tcp -p 4901:4901/tcp comet bash
#
#For Podman, use openvpn in the computer environment, because inside the pod, it cuts each connection; Use pod same as docker.
#If you don't use  --privileged, nmap can't work:
#src=https://stackoverflow.com/questions/41178553/docker-how-to-avoid-operation-not-permitted-in-docker-container
#And option "--security-opt" as described on source:
#src=#https://stackoverflow.com/questions/41178553/docker-how-to-avoid-operation-not-permitted-in-docker-container
#
#CHECK AFTER THE START
#docker ps -a
#docker attach xxx
#
#Failed to try this setting in order to work with openvpn directly inside container.
#As workaround, use directly openvpn with your host (WSL2, here Debian in Comet Documentation): it will propagate on your entire network.
#WSL-root> export VPN_PASSWORD=****; export CONFIG_FILE=filesetting_xxx.ovpn; export VPN_USER=freeopenvpn; bash -c "openvpn --config '"$CONFIG_FILE"' --auth-user-pass <(echo -e "$VPN_USER"'\n''"$VPN_PASSWORD"')"
#Or try:
#docker run --privileged --name halley --replace -h=halley -it -d -p 3390:3390/tcp -p 5901:5901/tcp -p 6901:6901/tcp -p 943:943 -p 443:443 -p 1194:1194/udp --cap-add=NET_ADMIN comet bash
#
#REMIND
#DOCKER => VPN inside container is ok: command-line above
#PODMAN => VPN outside of the container, inside the host (WSL host): command-line above
#
#In case of starting VPN inside a Podman container: connection will be lost. In the Host, search the openvpn process and kill with a root user. At this point you can connect with RDP.
#
#In order to add Firefox in the panel on bottom of screen, you need to open one Terminal with the user.
#In case of issue, you can try "$STARTUPDIR/myfirefoxsvc.sh containered" (user 'normal', from a "Terminal") => normally, only a new Terminal will do the job itself (silently correction, sentence above)
#In case of big issue, use "$STARTUPDIR/mydesk.sh" => it will disconnect you from RDP session /!\ Wait a little then you can connect again
#
######################################################
#DOCKER/PODMAN: OPENVPN
######################################################
#In order to use OpenVPN:
#Run the script: WSL-root> $STARTUPDIR/myopenvpnnetwork.sh
#If pod is running with --privileged and the script above is working fine (nod + network config by resolv), you will be able to be granted to run well openvpn
#WSL-root> openvpn <file>.ovpn
#If it's any Free Server, enter login/password (and respect law as it is required)
#
#Or use any tips below.
#
#COMET-BASH-root> mkdir /dev/net; mknod /dev/net/tun c 10 200; chmod 666 /dev/net/tun
#src=https://forum.proxmox.com/threads/turnkey-linux-openvpn-template-issues.31668/#post-157372
#
#In order to use OpenVPN, thanks to previously run this mode (update each for your own settings):
#docker run --name halley -h=halley -it -d -p 3390:3390/tcp -p 5901:5901/tcp -p 6901:6901/tcp --cap-add=NET_ADMIN comet bash
#podmanr run --name halley -h=halley -it -d -p 3390:3390/tcp -p 5901:5901/tcp -p 6901:6901/tcp --cap-add=net_admin,mknod -v /dataexchg:/dataexchg -v /dev/net/tun:/dev/net/tun comet bash
#podmanr run --replace --name halley -h=halley -it -d -p 3390:3390/tcp -p 5901:5901/tcp -p 6901:6901/tcp --cap-add=NET_ADMIN comet bash
#Thinkin in addition about nmap:
#podmanr run --replace --security-opt seccomp=unconfined --privileged --name halley --replace -h=halley -it -d -p 3390:3390/tcp -p 5901:5901/tcp -p 6901:6901/tcp comet bash
#src=https://github.com/kylemanna/docker-openvpn/issues/498
#
#Volume: creation
#
#podmanr volume create --opt type=none --opt o=bind --opt device=/dataexchg dataexchg
#
#Volume
#This will delete every data inside machine /!\
#PS> podman machine ls
#PS> podman machine stop podman-sun
#PS> podman machine rm podman-sun
#PS> podman machine init podman-sun --disk-size 200 --memory=16384 -v /dataexchg:/dataexchg -v /dev/net/tun:/dev/net/tun
#PS> podman machine start podman-sun
# Machine is set with 200GB for disk size and more than 16GB for Memory
# It will be needed to recreate connections /!\ See podman-sun-root + ssh
#src=https://stackoverflow.com/questions/69298356/how-to-mount-a-volume-from-a-local-machine-on-podman
#
#Full topic?
#src=https://stackoverflow.com/questions/57115336/connect-to-vpn-with-podman
#
#PS> podman machine set --rootful=xxx (where xx is false or true)
#PS> podman machine inspect podman-sun | Select-String -Pattern "Rootful"
#rootless to rootful:
#PS> podman machine set --rootful podman-sun
#rootful to rootless:
#PS> podman machine set --rootful=false podman-sun
#src=https://docs.podman.io/en/v4.4/markdown/podman-machine-set.1.html
#
#Location for machines (cf Tips):
#/mnt/c/Users/<user>/.local/share/containers/podman/machine/wsl/wsldist/
#
#And the easiest way:
#sudo openvpn clientfilecfg.ovpn
#src=https://serverfault.com/questions/647231/getting-cannot-ioctl-tunsetiff-tun-operation-not-permitted-when-trying-to-con
#
#Error TUN when launching OpenVPN:
#WSL-root> modprobe tun
#FATAL: Module tun not found in directory /lib/modules/5.15.153.1-microsoft-standard-WSL2
#WSL-root> apt-get update
#WSL-root> apt install linux-image-amd64 linux-headers-amd64
#
#[CONCLUSION] No solution has been found & works. Better way is to use anotehr pod: an openvpn container dedicated which completes this pod:
#podmanr image pull openvpn/openvpn-as
#podmanr run -it -d --name=openvpn-as --cap-add=NET_ADMIN -p 943:943 -p 443:443 -p 1194:1194/udp openvpn/openvpn-as
#
######################################################
#PODMAN: INSTALL
######################################################
#1. Install WSL Debian on your machine => watch "UKK: USB Key Kit" (if you prefer another than Debian, try yourself and change actions when it needs)
#2. Install Podman on Windows ("Podman Installer", only - not need Podman CLI)
#3. Set up a machine: tick "Install WSL if not present", option checked, machine with root rights, not mode networking, not start now
#4. When error "extracted Error: unexpected EOF", uninstall/install, download again, & force again & again creation.
#   Another way (not tested) is to try this with PS> podman machine reset
#   src=https://github.com/containers/podman/issues/22927
#5. Set up a machine: podman-sun
#6. Install Podman in WSL> sudo apt-get install -y podman
#   Keep in mind: do before update & upgrade for a new unix system
#6'.Any Issue during install? As a WSL corrupted? First, don't keep files in WSL! Keep them away, and do only copies! Second, install again WSL then:
#   Uninstall WSL, check list+version+default, install distribution, set as default, set version 2, check, go in WSL (default), and update system before removing/installing podman again:
#   PS> wsl --unregister Debian
#   PS> wsl -l -v
#   PS> wsl --install -d Debian
#   PS> wsl --set-default Debian
#   PS> wsl --set-default-version 2
#   PS> wsl -l -v
#   PS> wsl
#   WSL-user> sudo su - root
#   WSL-root> sudo apt-get update
#   WSL-root> sudo apt-get clean
#   WSL-root> sudo apt-get autoremove
#   WSL-root> sudo apt --fix-broken install
#   WSL-root> apt-get install podman
#
#Yes, sudo is not so need. Up to you.
#
#src=https://learn.microsoft.com/fr-fr/windows/wsl/install
#src=https://superuser.com/questions/1619233/completely-reinstall-wsl
#
#7 Set vars (WSL):
#  Inside each Clients, [root] set aliases in .bashrc (/root/) as echo "alias ll='ls -artl'" >> ~/.bashrc
#  Inside each Clients, [root] set aliases in .bashrc (/root/) as echo "alias docker=podman" >> ~/.bashrc (PS> Set-Alias -Name docker -Value podman )
#  [root] echo "sudo mount --make-rshared /" >> ~/.bashrc
#  [USER] touch /home/$USER/.ssh/known_hosts
######################################################
#   CONNECT WSL TO PODMAN DESKTOP
######################################################
#8. Set connections in WSL as for PowerShell
#   Notice what is the port "<Port_Machine>":  PS> podman machine inspect podman-sun | Select-String -Pattern "Port"
#   podman system connection ls
#   podman system connection add podman-sun ssh://user@127.0.0.1:<Port_Machine>/run/user/1000/podman/podman.sock --identity "/mnt/c/users/<user_wsl>/.local/share/containers/podman/machine/machine"
#   podman system connection add --default podman-sun-root  ssh://root@127.0.0.1:<Port_Machine>/run/podman/podman.sock --identity "/mnt/c/users/<user_wsl>/.local/share/containers/podman/machine/machine"
#   Activate "Load remote system connections (ssh)" In Podman Desktop
#   Get a remote client:
#   src=https://podman-desktop.io/docs/podman/accessing-podman-from-another-wsl-instance
#   In WSL [root]: apt-get install -y wget
#   In WSL [root]: cd /root
#   In WSL [root]: wget https://github.com/containers/podman/releases/download/v4.9.1/podman-remote-static-linux_amd64.tar.gz
#   In WSL [root]: tar -C /usr/local -xzf podman-remote-static-linux_amd64.tar.gz
#   Check (expected: empty list): podman --remote image ls
#   In Desktop App, a) run machine then b) go to pull image "quay.io/podman/hello:latest".
#   Check (expected a list): podman --remote image ls
#   Add SSH:
#   WSL-User-Deb> mkdir -p /home/$USER/.ssh
#   WSL-User-Deb> sudo apt-get install -y openssh-client
#   WSL-User-Deb> cd /home/$USER/.ssh
#   WSL-User-Deb> echo /home/$USER/.ssh/podman_rsa | ssh-keygen
#   WSL-User-Deb> podman system connection add $USER --identity /home/$USER/.ssh/podman_rsa ssh://$USER@127.0.0.1:<Port_Machine>/run/user/1000/podman/podman.sock
#   WSL-User-Deb> podman system connection default podman-sun-root
#   Check (expected a list): podman --remote image ls
#
#   [user] mkdir -p /home/$USER/comet/
#   [user] cd /home/$USER/comet/; touch Dockerfile
#   [Copy this file into and build it and run it!]


#If need an help, check the Sheet "MyVNCDockerfileTips"

#HERE FIND FEW CHARS TO COPY WHEN NEED (some terminals doesn't allow the direct input from keyboard)
# | \

# Version and Increment
#v1.0.1
#ic 11

#Thanks for authors from differents sources quoted in this document.
#by r00t4M0NK

#Comet © 2024 by R00t4m0nk is licensed under CC BY-SA 4.0 (+ EULA)
