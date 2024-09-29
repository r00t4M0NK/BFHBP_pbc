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
################################################################
# Check sources
################################################################
#Logs ($USER and root)
export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log
export TIMETAG=[TIME]
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
# (1.) COMET-BASH-user> export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log; mkdir -p /home/$USERCOMET/internetdl; touch /home/$USERCOMET/internetdl/htools.log; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >> $HTOOLLOGS; cd /home/$USERCOMET/internetdl;
# Then, switch into root (or open a new terminal): su - root
# (2.) COMET-BASH-root> export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log; apt-get install -y curl dos2unix; apt-get upgrade; apt-get update; export HTOOLLOGS=/home/$USERCOMET/internetdl/htools.log; export INSTALL_SH_MYTOOLS=https://raw.githubusercontent.com/r00t4M0NK/BFHBP_pbc/refs/heads/main/tools/bin/cyberhacktoolsinstall.sh; cd /home/$USERCOMET/internetdl; curl $INSTALL_SH_MYTOOLS > cyberhacktoolsinstall.sh; dos2unix cyberhacktoolsinstall.sh; chown $USERCOMET:$USERCOMET cyberhacktoolsinstall.sh; chmod 755 cyberhacktoolsinstall.sh; sleep 10
# (3.) COMET-BASH-root> echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >/home/$USERCOMET/internetdl/installation.log ; sh cyberhacktoolsinstall.sh $USERCOMET 2>>/home/$USERCOMET/internetdl/errlist.log 1>>/home/$USERCOMET/internetdl/installation.log ; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >>/home/$USERCOMET/internetdl/installation.log; echo END [3]
# [3] It's a fast run, less than 5 minutes. Check & Analyze Error File Logs: cat /home/$USERCOMET/internetdl/errlist.log
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
# (4.) Check errors in error-list: COMET-BASH-root> grep Unable /home/$USERCOMET/internetdl/errlist.log
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
# (9.) COMET-BASH-root> echo deb http://http.kali.org/kali kali-rolling main contrib non-free >> /etc/apt/sources.list && apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y && $STARTUPDIR/mybackgroundwllpservice.sh && $STARTUPDIR/mycometdesignTerminal.sh; echo END [9]
# [9] This step should change the wallpaper: to come back to Comet, it's to use <STARTUPDIR>/mybackgroundwllpservice.sh
# [9] This step should change the Terminal for the root user: to come back to Comet, it's to use <STARTUPDIR>/mycometdesignTerminal.sh (already done above)
# [9] This step is during about 20 minutes on a medium machine & slow internet connection (this measure is not higly defined and is only to be shared to keep in mind)
# [9] To have a measure in a file "mytracking.log": echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') > mytracking.log; [here_script_to_mesure]; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >> mytracking.log
# If the step to check validates and need again:
# (10.) It's need to check processes (lock by apt-get, with a command "sh") and with only the id list:
# (10.) COMET-BASH-root> ps -aC apt-get
# (10.) COMET-BASH-root> ps -aC apt-get -o pid=
# (10.) COMET-BASH-root> echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >/home/$USERCOMET/internetdl/installation2.log ; sh cyberhacktoolsinstall.sh $USERCOMET 2>>/home/$USERCOMET/internetdl/errlist2.log 1>>/home/$USERCOMET/internetdl/installation2.log ; echo $TIMETAG $(date '+%Y%m%d_%H_%M_%S') >/home/$USERCOMET/internetdl/installation2.log ; echo END [10]
# This step is about 45 minutes. Check not more, and stop the script if needed.
#If script is locked, this end will be displayed:
#wireshark is already the newest version (4.4.0-1).
#The following packages were automatically installed and are no longer required:
# COMET-BASH-user> tail -20 /home/$USERCOMET/internetdl/installation2.log
#Result expected:
#  fdisk gdisk gpg-wks-server libabsl20220623 libargon2-1 libassuan0
# (...)
#Use 'apt autoremove' to remove them.
#0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
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
#
#
################################################################
# VALIDATION
################################################################
#When every point is operational and validated by you, the suggestion is to save the container:
# PS> wsl --shutdown
# PS> wsl --export podman-<machine> podman.tar
#For more details, refer to document "MyVNCDockerfileTips" (part "Storage Full")
#If you have 2 drives, check to go on the right location. If my C:\ is near full, do the change dir:
# PS> D:
# PS>(export cmd, see above)
#An information to keep in mind, my package is near 17 GB, from my side.
#In any case an issue would appear, you will be able to install it again easily.
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
mypaint -v > $HTOOLLOGS; echo " " >> $HTOOLLOGS; nmap -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; wireshark -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; netdiscover -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; ettercap-common -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; amass -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; rkhunter -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; cisco-torch -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; lynis -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; above -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; masscan -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; firewalk -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; fierce -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; netmask -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; hping3 -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; netcat -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; ffuf -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; tcpdump -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; nbtscan -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; hashcat -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; ls -artl /usr/bin/mimikatz >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; john -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; ophcrack -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; fcrackzip -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; hydra -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; gobuster -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; bloodhound -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; crackmapexec -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; evil-winrm -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; enum4linux -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; shellter -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; smbmap -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; wpscan -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; dirbuster -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; cewl -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; dnsrecon -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; dnsenum -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; whatweb -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; parsero -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; lbd -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; dirsearch -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; subfinder -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; httrack -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; dmitry -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; wfuzz -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; sublist3r -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; skipfish -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; nikto -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; crunch -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; theharvester -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; powershell -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; responder -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; snort -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; macchanger -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; impacket-scripts -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; chntpw -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; wordlists -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; eyewitness -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; trufflehog -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; chisel -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; ncat -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; openssh-client -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; yersinia -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; havoc -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; veil -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; msfvenom -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; ldap-utils -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; burpsuite -v >> $HTOOLLOGS; echo " " >> $HTOOLLOGS; msfrpcd -h >> $HTOOLLOGS
#
#Cleaning:
apt-get clean
#
#To check if each package are well install, open a new terminal under root:
dpkg --get-selections > /root/.package_list
export caret='\r\n'
cat "/home/$USERCOMET/internetdl/pgms.lst" | while read line 
do
    export p=`echo $line| tr -d $caret`
    echo $p '|' `grep $p /root/.package_list` >> /root/.match_list
done
#
echo ""
echo If you don\'t already did it, thank you to install manually this last package: [[[ apt-get install -y macchanger ]]]
echo Remove these files after been checked if you don\'t need more: /home/$USERCOMET/internetdl/pgms.lst /home/$USERCOMET/internetdl/usrbin.log $HTOOLLOGS /root/.package_list /root/.match_list
echo COPY/PASTE "rm /home/$USERCOMET/internetdl/pgms.lst\; rm /home/$USERCOMET/internetdl/usrbin.log\; rm $HTOOLLOGS /root/.package_list\; rm /root/.match_list; rm /home/$USERCOMET/internetdl/errlist.log; rm /home/$USERCOMET/internetdl/errlist2.log; rm /home/$USERCOMET/internetdl/installation.log; rm /home/$USERCOMET/internetdl/installation2.log"
echo Here programs from this script which are not listed and require a manual control \(check comments in \"cyberhacktoolsinstall.sh\"\)\:
grep '|$' /root/.match_list | tr -d '|'
#
#Set the backup
rm -Rf $STARTUPDIR/*
tar -xvf /$STARTUPDIR.tar -C /
#
# ISSUES:
# 1. RDP Access has been modified as a Kali Linux Access. Run this to set again:
#$STARTUPDIR/mycometdesignTerminal.sh (watch the right value in Dockerfile)
# 2. The terminal for root as changed. Run this to correct:
# [under investigation]
# List reduced at: john ophcrack fcrackzip hydra gobuster bloodhound
# The target is bloodhound.
#
#Comet (c) 2024 by R00t4m0nk is licensed under CC BY-SA 4.0 (+ EULA)
