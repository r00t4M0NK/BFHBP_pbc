#!/bin/sh

##########################################################################
## NOTICE AND LICENCE
##########################################################################

# This file is provided "as is".
# No support is provided: you try, you learn, you test but only under your own responsability.
# More information, Read the full Licence:
# https://github.com/r00t4M0NK/BFHBP_pbc/blob/main/EULA_Comet.txt

################################################################
# For Downloading parts: choice to store in a dedicated dir
################################################################
mkdir -p $HOME/internetdl
cd $HOME/internetdl

################################################################
# Analyse each script from KALI
################################################################
#src=https://www.kali.org/tools/

################################################################
# Part for Install: packages
################################################################
apt-get update -y
apt-get install -y mypaint
apt-get install -y nmap wireshark netdiscover ettercap-common amass rkhunter cisco-torch lynis above masscan firewalk fierce
apt-get install -y netmask hping3 netcat ffuf tcpdump nbtscan
apt-get install -y hashcat mimikatz john ophcrack fcrackzip
apt-get install -y hydra gobuster
apt-get install -y bloodhound crackmapexec evil-winrm enum4linux shellter smbmap
apt-get install -y wpscan dirbuster cewl dnsrecon dnsenum whatweb parsero lbd dirsearch subfinder httrack dmitry wfuzz sublist3r skipfish nikto
apt-get install -y crunch theharvester powershell responder snort macchanger impacket-scripts chntpw wordlists eyewitness trufflehog chisel ncat openssh-client
apt-get install -y yersinia havoc
apt-get install -y veil msfvenom
apt-get install -y ldap-utils
apt-get install -y burpsuite msfrpcd
#case of some issues on these 2 packages
apt-get install -y hashcat --fix-missing
apt-get install -y hydra --fix-missing


################################################################
# Part for Explanations: packages
################################################################
# [Analyse] mypaint> for tiny drawing, think of the paths
# [Enum] nmap> enable OS detection, version detection, script scanning, traceroute (network scan)
# [Enum] wireshark> network packets capture (network scan)
# [Enum] netdiscover> active/passive address reconnaissance tool (network scan)
# [Enum] ettercap> many feature for network and host analysis
# [Enum] amass> tool to help information security professionals perform network mapping of attack surfaces, active reconnaissance techniques
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
# [PayLoads] msfvenom> to replace metasploit
# [LDAP] ldapsearch> classical for LDAP, in addition of all other scripts listed here
# [Special] burpsuite> framework to use only for 1 scan / 1 action and NOT automatic
# [Special] msfrpcd> framework Metasploit (only in 1 machine)
# [Special] winpeas> windows priv escal => not installed as other, it's from git
# [Special] linpeas> linux priv escal => not installed as other, it's from git
#src=101labs.net/comptia-security/lab-86-how-to-enumerate-for-privilege-escalation-on-a-linux-target-with-linpeas/

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

################################################################
#Tools to use carefully
################################################################
#Burpsuite> https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Command%20Injection
#src=https://liodeus.github.io/2020/09/18/OSCP-personal-cheatsheet.html


################################################################
# Launchpad, package deb
################################################################
# DL Launchpad
wget --no-check-certificate https://launchpad.net/dibuja/trunk/0.24.0/+download/dibuja_0.24.0-1_amd64.deb
# Install deb
sudo dpkg -i dibuja_0.24.0-1_amd64.deb

#Comet © 2024 by R00t4m0nk is licensed under CC BY-SA 4.0 (+ EULA)