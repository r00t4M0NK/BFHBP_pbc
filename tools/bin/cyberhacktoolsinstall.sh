#!/bin/sh
##########################################################################
## NOTICE AND LICENCE
##########################################################################
#
# This file is provided "as is".
# No support is provided: you try, you learn, you test but only under your own responsability.
# More information, Read the full Licence:
# https://github.com/r00t4M0NK/BFHBP_pbc/blob/main/EULA_Comet.txt
#
#
##########################################################################
## NOTICE2
##########################################################################
# Apps are mainly from KALI:
# The scope of warnings from Kali's Team is to apply here too.
# The goal is really or learning or labs or anything under legal.
# Any controled professionnal goals are also inside this scope.
#
################################################################
# Check sources
################################################################
#Logs ($USER and root)
export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log
export TIMETAG=[TIME]
mkdir -p /home/$USERCOMET/internetdl/
touch /home/$USERCOMET/internetdl/timetags.log
echo "[START] SCRIPT" >>  /home/$USERCOMET/internetdl/timetags.log
echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >> /home/$USERCOMET/internetdl/timetags.log
#
################################################################
# Check sources
################################################################
#
#This is information: If you want save time, go directly on process described below and follow each step
#
# cat /etc/apt/sources.list
# cat /etc/apt/sources.list.d/debian.sources
#
#If missing and you don't see any kali repo:
#echo "deb http://deb.debian.org/debian bookworm main" > /etc/apt/sources.list
#echo "deb http://deb.debian.org/debian bookworm-updates main" >> /etc/apt/sources.list
#echo "deb http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list
#echo "deb http://ftp.debian.org/debian bookworm-backports main" >> /etc/apt/sources.list
#
#echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" >> /etc/apt/sources.list.d/debian.sources
#echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" >> /etc/apt/sources.list
#
#Check repo in the official website
#If any issue during update:
#<<Yes, there appears to be issues with Kali Linux WSL (not downloaded from Microsoft Store)>>
#src=https://superuser.com/questions/1644520/apt-get-update-issue-in-kali
#We will use this information from step 5 to step 9 below.
#
#
################################################################
# For Downloading parts: choice to store in a dedicated dir
################################################################
# You need to run these commands in order to download this script in the target machine for adding these tools
# (1.) COMET-BASH-user> export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log; mkdir -p /home/$USERCOMET/internetdl; touch /home/$USERCOMET/internetdl/htools.log; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >> $HTOOLLOGS; cd /home/$USERCOMET/internetdl; echo END [1]
# If need Firefox extensions plugins:
#export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log; mkdir -p /home/$USERCOMET/internetdl; touch /home/$USERCOMET/internetdl/htools.log; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >> $HTOOLLOGS; cd /home/$USERCOMET/internetdl; curl https://addons.mozilla.org/firefox/downloads/file/4343983/ghostery-10.4.3.xpi > /home/$USERCOMET/internetdl/ghostery-10.4.3.xpi; curl https://addons.mozilla.org/firefox/downloads/file/4351045/adblock_plus-4.7.xpi > /home/$USERCOMET/internetdl/adblock_plus-4.7.xpi; echo END [1b]
# [1] 2 extensions to block have been download in the folder: if you need, install them manually. Be carefull, it will be 2 Firefox in this version! (FF from Comet and FF from Kali)
# Then, switch into root (or open a new terminal): su - root
# (2.) COMET-BASH-root> export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log; apt-get install -y curl dos2unix; apt-get upgrade; apt-get update; export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log; export INSTALL_SH_MYTOOLS=https://raw.githubusercontent.com/r00t4M0NK/BFHBP_pbc/refs/heads/main/tools/bin/cyberhacktoolsinstall.sh; cd /home/$USERCOMET/internetdl; curl $INSTALL_SH_MYTOOLS > cyberhacktoolsinstall.sh; dos2unix cyberhacktoolsinstall.sh; chown $USERCOMET:$USERCOMET cyberhacktoolsinstall.sh; chmod 755 cyberhacktoolsinstall.sh; sleep 10; echo END [2]
#Only the script CSL to download and update when needed:
#export INSTALL_SH_MYTOOLS=https://raw.githubusercontent.com/r00t4M0NK/BFHBP_pbc/refs/heads/main/tools/bin/cyberhacktoolsinstall.sh; cd /home/$USERCOMET/internetdl; curl $INSTALL_SH_MYTOOLS > cyberhacktoolsinstall.sh; dos2unix cyberhacktoolsinstall.sh; chown $USERCOMET:$USERCOMET cyberhacktoolsinstall.sh; chmod 755 cyberhacktoolsinstall.sh
#If need only update the local script with a new download (check "Increment" version to be sure no cache phenomenon, here curl bypassing cache):
#export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log; export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log; export INSTALL_SH_MYTOOLS=https://raw.githubusercontent.com/r00t4M0NK/BFHBP_pbc/refs/heads/main/tools/bin/cyberhacktoolsinstall.sh; cd /home/$USERCOMET/internetdl; curl -H 'Cache-Control: no-cache' $INSTALL_SH_MYTOOLS > cyberhacktoolsinstall.sh; dos2unix cyberhacktoolsinstall.sh; chown $USERCOMET:$USERCOMET cyberhacktoolsinstall.sh; chmod 755 cyberhacktoolsinstall.sh; sleep 10; echo END [2b]
#src=https://stackoverflow.com/questions/31653271/how-to-call-curl-without-using-server-side-cache
#But download without cache seems not so working great... (case: when you switch from curl into curl -H => requires time !!! Please wait)
# (3.) COMET-BASH-root> echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >/home/$USERCOMET/internetdl/installation.log ; sh cyberhacktoolsinstall.sh $USERCOMET 2>>/home/$USERCOMET/internetdl/errlist.log 1>>/home/$USERCOMET/internetdl/installation.log ; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >>/home/$USERCOMET/internetdl/installation.log; echo END [3]
# [3] It's a fast run, less than 5 minutes (sometimes up to 12 min). Check & Analyze Error File Logs: cat /home/$USERCOMET/internetdl/errlist.log
# [3] You can follow the run:
# [3] COMET-BASH-user> tail -f /home/$USERCOMET/internetdl/installation.log
#If script in Step [3] will be ended normally, this text will be displayed:
#Setting up wireshark (4.0.11-1~deb12u1) ...
#Setting up qtwayland5:amd64 (5.15.8-2) ...
#Processing triggers for man-db (2.11.2-2) ...
#Processing triggers for shared-mime-info (2.2-1) ...
#Processing triggers for mailcap (3.70+nmu1) ...
#Processing triggers for desktop-file-utils (0.26-1) ...
#Processing triggers for hicolor-icon-theme (0.17-2) ...
#Processing triggers for libc-bin (2.36-9+deb12u8) ...
# [3] Check if all apt commands are well (not locked): COMET-BASH-root> ps -aux | grep apt
# (4.) Check errors in error-list: COMET-BASH-root> grep Unable /home/$USERCOMET/internetdl/errlist.log; echo END [4]
# (4.) If you need to count, number expected is 28: COMET-BASH-root> grep Unable /home/$USERCOMET/internetdl/errlist.log | wc -l
# [4] At this step, sources from default image should be not enough. That's this error list seems long. It's mandatory to correct this point.
# [5] Download part
# (5.) COMET-BASH-root> wget http://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2024.1_all.deb
# [6] Install this repo for archives
# (6.) COMET-BASH-root> dpkg -i kali-archive-keyring_2024.1_all.deb
# Remove downloaded file
# (7.) COMET-BASH-root> rm kali-archive-keyring_2024.1_all.deb
# [8] Update
# (8.) COMET-BASH-root> apt-get update
# [5-6-7-8] In one line: wget http://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2024.1_all.deb; dpkg -i kali-archive-keyring_2024.1_all.deb; rm kali-archive-keyring_2024.1_all.deb; apt-get update
# (9.) COMET-BASH-root> echo "[9] START" >>/home/$USERCOMET/internetdl/installation2.log; echo "[9][START]" $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >>/home/$USERCOMET/internetdl/timetags.log ; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >>/home/$USERCOMET/internetdl/installation2.log ; echo deb http://http.kali.org/kali kali-rolling main contrib non-free >> /etc/apt/sources.list && apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y && $STARTUPDIR/mybackgroundwllpservice.sh && $STARTUPDIR/mycometdesignRDP.sh && $STARTUPDIR/mycometdesignTerminal.sh; echo "[9] END" >>/home/$USERCOMET/internetdl/installation2.log; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >>/home/$USERCOMET/internetdl/installation2.log ; echo "[9][END]" $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >>/home/$USERCOMET/internetdl/timetags.log ; echo END [9]
# [9] This step should change the wallpaper: to come back to Comet, it's to use <STARTUPDIR>/mybackgroundwllpservice.sh
# [9] This step should change the Terminal for the root user: to come back to Comet, it's to use <STARTUPDIR>/mycometdesignTerminal.sh (already done above) => after a bug, it is done again at end of this script
# [9] This step is during about 20~45 minutes on a medium machine & slow internet connection (this measure is not higly defined and is only to be shared to keep in mind)
# [9] To have a measure in a file "mytracking.log": echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') > mytracking.log; [here_script_to_mesure]; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >> mytracking.log
# If the step to check validates and need again:
# (10.) It's need to check processes (lock by apt-get, with a command "sh") and with only the id list:
# (10.) COMET-BASH-root> ps -aC apt-get
# (10.) COMET-BASH-root> ps -aC apt-get -o pid=
# (10.) COMET-BASH-root> echo "[10][START]" $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >>/home/$USERCOMET/internetdl/timetags.log ; echo "[10] START" >>/home/$USERCOMET/internetdl/installation2.log; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >>/home/$USERCOMET/internetdl/installation2.log ; sh /home/$USERCOMET/internetdl/cyberhacktoolsinstall.sh $USERCOMET 2>>/home/$USERCOMET/internetdl/errlist2.log 1>>/home/$USERCOMET/internetdl/installation2.log ; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >/home/$USERCOMET/internetdl/installation2.log ; echo "[10] END" >>/home/$USERCOMET/internetdl/installation2.log; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >>/home/$USERCOMET/internetdl/installation2.log ; echo "[10][END]" $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >>/home/$USERCOMET/internetdl/timetags.log ; echo END [10]
# This step is about 45 minutes. Check not more, and stop the script if needed.
#If script is locked, this end will be displayed:
#wireshark is already the newest version (4.4.0-1).
#The following packages were automatically installed and are no longer required:
# COMET-BASH-user> tail -20 /home/$USERCOMET/internetdl/installation2.log
#Result expected:
#[
#  fdisk gdisk gpg-wks-server libabsl20220623 libargon2-1 libassuan0
# (...)
#Use 'apt autoremove' to remove them.
#0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
#]
#
#It might be broken if you have this result:
#[
# xfce4-timer-plugin : Depends: libglib2.0-0t64 (>= 2.26.0) but it is not going to be installed
# xfce4-verve-plugin : Depends: libglib2.0-0t64 (>= 2.32.0) but it is not going to be installed
# xfce4-wavelan-plugin : Depends: libglib2.0-0t64 (>= 2.18.0) but it is not going to be installed
# xfce4-weather-plugin : Depends: libglib2.0-0t64 (>= 2.68.0) but it is not going to be installed
# xfce4-whiskermenu-plugin : Depends: libglib2.0-0t64 (>= 2.38.0) but it is not going to be installed
# xfce4-xkb-plugin : Depends: libglib2.0-0t64 (>= 2.38.0) but it is not going to be installed
# xfdesktop4 : Depends: libglib2.0-0t64 (>= 2.75.3) but it is not going to be installed
# xfwm4 : Depends: libglib2.0-0t64 (>= 2.75.3) but it is not going to be installed
#]
#  Do "/home/$USERCOMET/internetdl/genmatchlist.sh" as described in this file and check with "Final Check" /home/$USERCOMET/internetdl/finalcheck.sh.
# (In case of any error) COMET-BASH-root> grep broken /home/$USERCOMET/internetdl/installation2.log
# (In case of any error) COMET-BASH-root> apt-get install -y --fix-broken
# (In case of final check is not at the result expected) COMET-BASH-root> /home/$USERCOMET/internetdl/cyberhacktoolsinstall.sh
#
#[END]
# # # # # For the FINAL CHECK, see below. # # # # # 
#Here the shortcut for the command to check:
#grep ' | ' /root/.match_list | tr -d '|' | cut -d' ' -f 3 | wc -l
#Result expected: 65. See details in the concerning part below.
#
#macchanger is requesting to change automatically MAC @ y/n
#For this, you need manually :(
#apt-get install -y macchanger
#
#Check this second list: you expect to have no error or at least only 1 error in this list: msfrpcd
# grep Unable /home/$USERCOMET/internetdl/errlist2.log
#Check again the command: msfrpcd -h (program is inside the package metasploit-framework)
#
#About netcat, the question could be what kind of package to use? This is a corrected version. More to know? Check the source.
# src=https://askubuntu.com/questions/346869/what-are-the-differences-between-netcat-traditional-and-netcat-openbsd
#
#If script in Step [9] will be ended normally, this text will be displayed:
#Setting up policykit-1 (124-2+kali1) ...
#Processing triggers for initramfs-tools (0.145) ...
#Processing triggers for libgdk-pixbuf-2.0-0:amd64 (2.42.12+dfsg-1) ...
#
#To follow the running:
#[10] COMET-BASH-user> tail -f /home/$USER/internetdl/installation2.log
# (11.) When it's finished and validated: COMET-BASH-root> rm /home/$USERCOMET/internetdl/*.log
#
#
################################################################
# VALIDATION
################################################################
#When every point is operational and validated by you, the suggestion is to save the container:
# PS> wsl --shutdown
# PS> wsl --export podman-<machine> podman.tar
#For more details, refer to document "MyVNCDockerfileTips" (part "Storage Full" from file with "Tips")
#If you have 2 drives, check to go on the right location. If my C:\ is near full, do the change dir:
# PS> D:
# PS>(export cmd, see above)
#An information to keep in mind, my package is near 17 GB, from my side.
#In any case an issue would appear, you will be able to install it again easily.
#
#To check if file already existing:
#cd /mnt/c/Users/<user>/.local/share/containers/podman/machine/wsl/wsldist/; ls -artl
#cd /mnt/d/podman/machine/; ls -artl
#WINDOWS
#cd C:\Users\<user>\.local\share\containers\podman\machine\wsl\wsldist\; dir
#D:; cd D:\podman\machine\; dir
#
#ADVICE: Run the command, save into a tar-file, then rename this file ("podman.tar") and move it into a Save-Directory.
#Example: I choose directory "Install_Import_Save_Sun" in the host.
#
################################################################
# Analyse each script from KALI
################################################################
#src=https://www.kali.org/tools/
#
#
################################################################
# Part before everything: save scripts
# Change the directory with the valkue choosen in Dockerfile
################################################################
tar -cvf /$STARTUPDIR.tar $STARTUPDIR/
#
################################################################
# Part for install -y: packages
################################################################
#HERE: 66 programs to install
apt-get update -y
apt-get install -y mypaint
apt-get install -y nmap netdiscover ettercap-common amass rkhunter cisco-torch lynis above masscan firewalk fierce
apt-get install -y netmask hping3 netcat-openbsd ffuf tcpdump nbtscan
apt-get install -y hashcat mimikatz john ophcrack fcrackzip
apt-get install -y hydra gobuster
apt-get install -y bloodhound crackmapexec evil-winrm enum4linux shellter smbmap
apt-get install -y wpscan dirbuster cewl dnsrecon dnsenum whatweb parsero lbd dirsearch subfinder httrack dmitry wfuzz sublist3r skipfish nikto
apt-get install -y crunch theharvester powershell responder snort impacket-scripts chntpw wordlists eyewitness trufflehog chisel ncat openssh-client
apt-get install -y yersinia havoc
apt-get install -y veil metasploit-framework
apt-get install -y ldap-utils
apt-get install -y burpsuite
#Wine32 for shellter (shellter + crunch makes root-bash changing)
dpkg --add-architecture i386 && apt update && apt -y install wine32
#Set the backup
echo "[BACK] [START]" >> /home/$USERCOMET/internetdl/installation2.log
#Please do it manually: in case of error, clean another environment
#rm -Rf $STARTUPDIR/*
tar -xvf /$STARTUPDIR.tar -C /
#In case of a bug, set again the wallpaper, the RDP login box and the terminal as it has been defined for the Comet Software
$STARTUPDIR/mybackgroundwllpservice.sh && $STARTUPDIR/mycometdesignRDP.sh && $STARTUPDIR/mycometdesignTerminal.sh
echo "[BACK] [END]" >> /home/$USERCOMET/internetdl/installation2.log
#case of some issues on these 2 packages
apt-get install -y hashcat --fix-missing
apt-get install -y hydra --fix-missing
#wireshark is requesting to capture y/n for non-superuser
echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections; apt-get install -y wireshark &
#
################################################################
# Part for Explanations: packages
################################################################
# [Analyse] mypaint> for tiny drawing, think of the paths
# [Enum] nmap> enable OS detection, version detection, script scanning, traceroute (network scan)
# [Enum] wireshark> network packets capture (network scan)
# [Enum] netdiscover> active/passive address reconnaissance tool (network scan)
# [Enum] ettercap> many feature for network and host analysis
# [Enum] amass> tool to help information security professionals perform network mapping of attack surfaces, active reconnaissance techniques (package: metasploit-framework)
# [Enum] rkhunter> scans systems for known and unknown rootkits, backdoors, sniffers and exploits
# [Enum] cisco-torch> scan against IP
# [Enum] lynis> smooth quiet scan
# [Enum] above> Invisible network protocol sniffer
# [Enum] masscan> scan network
# [Enum] firewalk> active reconnaissance network security tool
# [Enum] fierce> a semi-lightweight scanner against a domain
# [Network] netmask> network tool
# [Network] hping3> traceroute
# [Network] netcat> A simple netowrk Unix utility
# [Network] ffuf> discovery:  typical dir, v-host
# [Network] tcpdump> dump the traffic on a network
# [Network] nbtscan> scan networks for NetBIOS name information
# [Smash] hashcat> passwords cracking
# [Smash] mimikatz> extract Windows passwords, kerberos tickets from memory
# [Smash] john> passwords cracking
# [Smash] ophcrack> passwords cracking
# [Smash] fcrackzip> passwords cracking for zip files
# [Attack] hydra> bruteforce password attack on services
# [Attack] gobuster> bruteforce Web as URIs (directories and files), DNS subdomains, Virtual Host, buckets (Amazon, Google), TFTP servers
# [AD] bloodhound> Tool against Active Dirs
# [AD] crackmapexec> Tools against Active Dirs
# [AD] evil-winrm> Tools to snap fingers in Microsoft Windows Servers
# [AD] enum4linux> Enum Samba and Windows systems
# [AD] shellter> injection in 32-bits Windows
# [AD] smbmap> enumerate samba share drives
# [Web] wpscan> WordPress Scan
# [Web] dirbuster> BruteForce Dirs
# [Web] cewl> Spider
# [Web] dnsrecon> scan a domain
# [Web] dnsenum> enum a domain
# [Web] whatweb> detect information from a website
# [Web] parsero> check the forbidds from robot.txt
# [Web] lbd> test if site uses a load balancer
# [Web] dirsearch> bruteforce a webserver
# [Web] subfinder> discovers valid subdomains for websites in silence mode
# [Web] httrack> download a website to local, with subdirs
# [Web] dmitry> whois
# [Web] wfuzz> bruteforce web apps
# [Web] sublist3r> enum subdomain from a website domain
# [Web] skipfish> active web application security reconnaissance tool
# [Web] nikto> webserver for fast checks informations (some says it's slow, not useful but I found this tool in many REX)
# [Tool] crunch> tool for dictionnary gen
# [Tool] theharvester> Search from email addresses from a domain
# [Tool] powershell> What Else?
# [Tool] responder> rogue proxy, netork tool
# [Tool] snort> libpcap-based packet sniffer/logger in real-time
# [Tool] macchanger> maniputation of MAC addresses
# [Tool] impacket-scripts> scripts as tools
# [Tool] chntpw> tool against Windows NT/2000
# [Tool] wordlists> famous dictionnary for all crack tools
# [Tool] eyewitness> take a screenshot from websites
# [Tool] trufflehog> search secrets on git
# [Tool] chisel> tunnel SSH
# [Tool] ncat> feature-packed networking utility which reads and writes data across networks
# [Tool] openssh-client> for the command "ssh"
# [Framework] yersinia> framework for attack
# [Framework] havoc> framework for controlling
# [PayLoads] veil> framework for attack
# [PayLoads] msfvenom> to replace metasploit (but inside package "metasploit-framework")
# [LDAP] ldapsearch> classical for LDAP, in addition of all other scripts listed here
# [Special] burpsuite> framework to use only for 1 scan / 1 action and NOT automatic
# [Special] msfrpcd> framework Metasploit (only in 1 machine)
# [Special] winpeas> windows priv escal => not install -yed as other, it's from git
# [Special] linpeas> linux priv escal => not install -yed as other, it's from git
#src=101labs.net/comptia-security/lab-86-how-to-enumerate-for-privilege-escalation-on-a-linux-target-with-linpeas/
#
#
################################################################
# TOOLS FORGOTTEN
################################################################
#sqlmap> forbidden for OSCP Test
#burpsuite> forbidden for OSCP Test
#spiderfoot> OSINT Tool
#maltego> Forensic Tool
#steghide> Forensic Tool
#autopsy> Forensic Tool
#aircrack-ng> WiFi Tool
#beef-xss> Pen Web-Browser
#armitage> not found in cheatsheet from rex from candidates
#airgeddon> wireless networks
#wifiphisher > wifi phishing
#Recon-ng> it's a full-featured Web Reconnaissance framework
#scapy> should replace other apps, so not need for OSCP
#reaver> attack on wifi access point
#dsniff> network sniffer, not found in cheatsheet from rex from candidates
#arpwatch> defense, alert on network
#sherlock> use for searching an username on social media
#legion> automatic tool, forbidden for OSCP Test
#kismet> it is a wireless network and device detector
#ghidra> NSA tool
#foremost> Forensic Tool
#cryptsetup> Crypto dirs
#bettercap> smooth enum wifi/wireless networks
#yara> tool for malwares
#sparrow-wifi> wifi
#set> social engineering
#gophish> phishing
#goldeneye> http ddos detection
#xsser> automatic xss vuln, forbidden for OSCP Test
#wifipumpkin3> wifi rogue access point attack
#wafw00f> automatic versus wen app firewall, forbidden for OSCP Test
#socat> bidirectionnal byte streams data
#
#
################################################################
# ALLOW TOOLS
################################################################
#Which tools are allowed for the OSCP exam?
#
#All tools that do not perform any restricted actions are allowed during the exam. The following tools are allowed, but the list is not limited to these:
#
#    BloodHound (Legacy and Community Edition only)
#    SharpHound
#    PowerShell Empire
#    Covenant 
#    Powerview
#    Rubeus
#    evil-winrm
#    Responder (Poisoning and Spoofing is not allowed in the challenges or on the exam)
#    Crackmapexec
#    Mimikatz
#    Impacket
#    PrintSpoofer
#
#List to check, src=https://www.quantmleak.com/posts/list-of-offensive-tools/
#
#
################################################################
#Tools to use carefully
################################################################
#Burpsuite> https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Command%20Injection
#src=https://liodeus.github.io/2020/09/18/OSCP-personal-cheatsheet.html
#
#
################################################################
# Launchpad, package deb
################################################################
# DL Launchpad (as an example/sample)
#wget --no-check-certificate https://launchpad.net/dibuja/trunk/0.24.0/+download/dibuja_0.24.0-1_amd64.deb
# install -y deb
#sudo dpkg -i dibuja_0.24.0-1_amd64.deb
#
#
################################################################
# CHECK ALL PACKAGES
################################################################
#export $USERCOMET=
export $USERCOMET=$1; export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log; export USRBINLOGS=/home/$USERCOMET/internetdl/usrbin.log;
ls -artl /usr/bin > $USRBINLOGS
echo "mypaint nmap wireshark netdiscover ettercap-common amass rkhunter cisco-torch lynis above masscan firewalk fierce netmask hping3 netcat ffuf tcpdump nbtscan hashcat john ophcrack fcrackzip hydra gobuster bloodhound crackmapexec evil-winrm enum4linux shellter smbmap wpscan dirbuster cewl dnsrecon dnsenum whatweb parsero lbd dirsearch subfinder httrack dmitry wfuzz sublist3r skipfish nikto crunch theharvester powershell responder snort macchanger impacket-scripts chntpw wordlists eyewitness trufflehog chisel ncat openssh-client yersinia havoc veil msfvenom ldap-utils burpsuite msfrpcd" > /home/$USERCOMET/internetdl/pgms.lst
sed -i 's+ +\r\n+g' /home/$USERCOMET/internetdl/pgms.lst
while read p; do
  grep $p $USRBINLOGS >> $HTOOLLOGS
done </home/$USERCOMET/internetdl/pgms.lst
export cpt=1; echo " [ $cpt ] " > $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo mypaint --version >> $HTOOLLOGS; mypaint --version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo nmap -v >> $HTOOLLOGS; nmap -v >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo wireshark -v | grep Wireshark >> $HTOOLLOGS; wireshark -v | grep Wireshark >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo netdiscover -h | head -1 >> $HTOOLLOGS; netdiscover -h | head -1 >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ettercap -v| grep ettercap >> $HTOOLLOGS; ettercap -v| grep ettercap >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo amass -version >> $HTOOLLOGS; amass -version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo rkhunter -V | grep Root >> $HTOOLLOGS; rkhunter -V | grep Root >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo cisco-torch -V >> $HTOOLLOGS; cisco-torch -V >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo lynis -V >> $HTOOLLOGS; lynis -V >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo above | grep Version >> $HTOOLLOGS; above | grep Version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo masscan | grep usage >> $HTOOLLOGS; masscan | grep usage >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo firewalk -v | grep version >> $HTOOLLOGS; firewalk -v | grep version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo fierce -h | grep usage >> $HTOOLLOGS; fierce -h | grep usage >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo netmask -v >> $HTOOLLOGS; netmask -v >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo hping3 -v >> $HTOOLLOGS; hping3 -v >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo netcat -v >> $HTOOLLOGS; netcat -v >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ffuf -V >> $HTOOLLOGS; ffuf -V >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo tcpdump --version >> $HTOOLLOGS; tcpdump --version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo nbtscan -h | grep Human >> $HTOOLLOGS; nbtscan -h | grep Human >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo hashcat -V >> $HTOOLLOGS; hashcat -V >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /usr/bin/mimikatz >> $HTOOLLOGS; ls -artl /usr/bin/mimikatz >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo john -h | grep John >> $HTOOLLOGS; john -h | grep John >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ophcrack -h | grep securite >> $HTOOLLOGS; ophcrack -h | grep securite >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo fcrackzip -h | grep "fcrackzip v" >> $HTOOLLOGS; fcrackzip -h | grep "fcrackzip v" >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo hydra -h | grep "Hydra v" >> $HTOOLLOGS; hydra -h | grep "Hydra v" >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo gobuster version >> $HTOOLLOGS; gobuster version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo bloodhound | grep futex >> $HTOOLLOGS; bloodhound | grep futex >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo crackmapexec | grep Version >> $HTOOLLOGS; crackmapexec | grep Version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo evil-winrm -v >> $HTOOLLOGS; evil-winrm -v >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo enum4linux -h | grep enum4linux >> $HTOOLLOGS; enum4linux -h | grep enum4linux >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo shellter -v_pb >> $HTOOLLOGS; shellter -v_pb >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo smbmap | grep Samba >> $HTOOLLOGS; smbmap | grep Samba >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo wpscan --version | grep Current >> $HTOOLLOGS; wpscan --version | grep Current >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /usr/bin/dirbuster >> $HTOOLLOGS; ls -artl /usr/bin/dirbuster >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo cewl -v | grep CeWL >> $HTOOLLOGS; cewl -v | grep CeWL >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo dnsrecon -V >> $HTOOLLOGS; dnsrecon -V >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo dnsenum | grep VERSION >> $HTOOLLOGS; dnsenum | grep VERSION >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo whatweb | grep version >> $HTOOLLOGS; whatweb | grep version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo parsero | grep usage >> $HTOOLLOGS; parsero | grep usage >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /usr/bin/lbd >> $HTOOLLOGS; ls -artl /usr/bin/lbd >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /usr/bin/dirsearch >> $HTOOLLOGS; ls -artl /usr/bin/dirsearch >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo subfinder -version >> $HTOOLLOGS; subfinder -version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo httrack -h | grep HTTrack | head -1 >> $HTOOLLOGS; httrack -h | grep HTTrack | head -1 >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo dmitry -v | grep Version >> $HTOOLLOGS; dmitry -v | grep Version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo wfuzz --version >> $HTOOLLOGS; wfuzz --version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /usr/bin/sublist3r >> $HTOOLLOGS; ls -artl /usr/bin/sublist3r >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo skipfish -h | grep version >> $HTOOLLOGS; skipfish -h | grep version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo nikto -Version >> $HTOOLLOGS; nikto -Version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo crunch -v >> $HTOOLLOGS; crunch -v >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /usr/bin/theharvester >> $HTOOLLOGS; ls -artl /usr/bin/theharvester >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /etc/skel/.config/powershell/Microsoft.PowerShell_profile.ps1 >> $HTOOLLOGS; ls -artl /etc/skel/.config/powershell/Microsoft.PowerShell_profile.ps1 >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo responder --version | tail -1 >> $HTOOLLOGS; responder --version | tail -1 >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo snort -V | grep Version >> $HTOOLLOGS; snort -V | grep Version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo macchanger -v >> $HTOOLLOGS; macchanger -v >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo impacket-scripts -v_pb >> $HTOOLLOGS; impacket-scripts -v_pb >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo chntpw | grep "chntpw version" >> $HTOOLLOGS; chntpw | grep "chntpw version" >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /usr/share/wordlists >> $HTOOLLOGS; ls -artl /usr/share/wordlists >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo eyewitness | grep usage >> $HTOOLLOGS; eyewitness | grep usage >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /usr/bin/trufflehog >> $HTOOLLOGS; ls -artl /usr/bin/trufflehog >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo chisel -v >> $HTOOLLOGS; chisel -v >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ncat -v >> $HTOOLLOGS; ncat -v >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo /usr/share/lintian/overrides/openssh-client >> $HTOOLLOGS; /usr/share/lintian/overrides/openssh-client >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo yersinia -V | grep yersinia >> $HTOOLLOGS; yersinia -V | grep yersinia >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo havoc | grep Version >> $HTOOLLOGS; havoc | grep Version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo havoc | grep Version >> $HTOOLLOGS; havoc | grep Version >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /usr/bin/msfvenom >> $HTOOLLOGS; ls -artl /usr/bin/msfvenom >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /usr/bin/ldapsearch >> $HTOOLLOGS; ls -artl /usr/bin/ldapsearch >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo ls -artl /usr/bin/burpsuite >> $HTOOLLOGS; ls -artl /usr/bin/burpsuite >> $HTOOLLOGS; echo " [ $cpt ] " >> $HTOOLLOGS; export cpt=`expr $cpt + 1`;  echo msfrpcd -h | grep Usage >> $HTOOLLOGS; msfrpcd -h | grep Usage >> $HTOOLLOGS; echo " [ END ] " >> $HTOOLLOGS;
#
#Cleaning:
apt-get clean
#
#[GENERATE .MATCH_LIST] To check if each package are well install, open a new terminal under root:
#[
if ! [ -f "/home/$USERCOMET/internetdl/finalcheck.sh" ]; then
echo "grep ' | ' /root/.match_list | tr -d '|' | cut -d' ' -f 3 | wc -l" > /home/$USERCOMET/internetdl/finalcheck.sh
chmod 755 /home/$USERCOMET/internetdl/finalcheck.sh
fi
if ! [ -f "/home/$USERCOMET/internetdl/genmatchlist.sh" ]; then
echo '#!/bin/bash' > /home/$USERCOMET/internetdl/genmatchlist.sh
echo "dpkg --get-selections > /root/.package_list" >> /home/$USERCOMET/internetdl/genmatchlist.sh
echo "rm /root/.match_list" >> /home/$USERCOMET/internetdl/genmatchlist.sh
echo "export caret='\r\n'" >> /home/$USERCOMET/internetdl/genmatchlist.sh
echo "cat "/home/$USERCOMET/internetdl/pgms.lst" | while read line " >> /home/$USERCOMET/internetdl/genmatchlist.sh
echo "do" >> /home/$USERCOMET/internetdl/genmatchlist.sh
echo "    export p=\`echo \${line//[$'\t\r\n ']}| tr -d \$caret\`" >> /home/$USERCOMET/internetdl/genmatchlist.sh
echo "    echo \$p '|' \`grep \$p /root/.package_list\` >> /root/.match_list" >> /home/$USERCOMET/internetdl/genmatchlist.sh
echo "    export p=\`echo \${line//[\$'\t\r\n ']}\`" >> /home/$USERCOMET/internetdl/genmatchlist.sh
echo "done" >> /home/$USERCOMET/internetdl/genmatchlist.sh
chmod 755 /home/$USERCOMET/internetdl/genmatchlist.sh
fi
/home/$USERCOMET/internetdl/genmatchlist.sh
#
#Here the code in case it's need to copy/paste (here idea for file "unmatch" is kept but not neeed now):
#
#dpkg --get-selections > /root/.package_list
#rm /root/.match_list
#rm /root/.unmatch_list
#export caret='\r\n'
#cat "/home/$USERCOMET/internetdl/pgms.lst" | while read line 
#do
#    export p=`echo ${line//[$'\t\r\n ']}| tr -d $caret`
#    echo $p '|' `grep $p /root/.package_list` >> /root/.match_list
#	export p=`echo ${line//[$'\t\r\n ']}`
#	echo $p '|' `grep $p /root/.package_list` >> /root/.unmatch_list
#done
#chmod 755 /home/$USERCOMET/internetdl/genmatchlist.sh
#]
#
echo ""
echo If you don\'t already did it, thank you to install manually this last package: [[[ apt-get install -y macchanger ]]]
echo Remove these files after been checked if you don\'t need more: /home/$USERCOMET/internetdl/pgms.lst /home/$USERCOMET/internetdl/usrbin.log $HTOOLLOGS /root/.package_list /root/.match_list
echo COPY/PASTE "rm /home/$USERCOMET/internetdl/pgms.lst\; rm /home/$USERCOMET/internetdl/usrbin.log\; rm $HTOOLLOGS /root/.package_list\; rm /root/.match_list; rm /home/$USERCOMET/internetdl/errlist.log; rm /home/$USERCOMET/internetdl/errlist2.log; rm /home/$USERCOMET/internetdl/installation.log; rm /home/$USERCOMET/internetdl/installation2.log"
#[FINAL CHECK]
echo Here programs from this script which are not listed and require a manual control \(check comments in \"cyberhacktoolsinstall.sh\"\)\:
grep '|$' /root/.match_list | tr -d '|'
grep '|$' /root/.match_list | tr -d '|' | wc -l
#result should be 3: macchanger, msfvenom , msfrpcd  => [ msfvenom + msfrpcd ] are in metasploit-framework
#CHECK MANUALLY (result expected: shells are here):
#grep msfvenom $HTOOLLOGS -B 1 -A 10
#grep msfrpcd $HTOOLLOGS -B 1 -A 10
grep ' | ' /root/.match_list | tr -d '|' | cut -d' ' -f 3
grep ' | ' /root/.match_list | tr -d '|' | cut -d' ' -f 3 | wc -l
#65 + macchanger = 66 from list (list is 68 because 2 are listed even if included inside another, the metasploit framework)
#apt-get install -y macchanger
#generate again files and check as described above.
#result should be 65 (in case of any difference => WSL-root> apt-get update; apt-get install -y --fix-broken; ./cyberhacktoolsinstall.sh)
#if macchanger installed (+ regenerate .match_list as above): 66
#The number gives an idea to check from full lists: if you want or need details, check the full list in files (as do the action with /root/.match_list)
#
apt-get -y autoremove
echo "[END] SCRIPT" >>  /home/$USERCOMET/internetdl/timetags.log
echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >> /home/$USERCOMET/internetdl/timetags.log
echo [END SCRIPT]
#
# ISSUES:
# 1. RDP Access has been modified as a Kali Linux Access. Run this to set again:
#$STARTUPDIR/mycometdesignTerminal.sh (watch the right value in Dockerfile)
# 2. The terminal for root as changed. Run this to correct:
# [under investigation]
# List reduced at: john ophcrack fcrackzip hydra gobuster bloodhound
# The target is bloodhound. (+ shellter +crucnh)
#
#Increment 1.4
#Comet (c) 2024 by R00t4m0nk is licensed under CC BY-SA 4.0 (+ EULA)
