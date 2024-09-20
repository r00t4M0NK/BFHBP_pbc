##################################################################################################################################################################
# MANAGEMENT OF PORTS INSIDE WINDOWS FOR LINKS TO PODMAN
##################################################################################################################################################################

#This PowerShell Script grants ports to be used in Windows for applications (if you have any issue to access containers through ports)

# A/ Allow script execution:
#
#1. Get status of Restriction Policy:
#PS> get-executionpolicy
#
#2. Allow scripts execution (as ADMIN), and confirm (Yes)
#PS> set-executionpolicy unrestricted
#
# [Reverse point] You can apply point 2, then you launch the script in an admin PowerShell (B), then do the reverse which applies again restrictions:
#PS> set-executionpolicy restricted
#
# C/ Check rules in Firewall included in Windows. Analyse> Rules> WSL 2 (set in part "Firewall - Inbound Rules")
# D/ [Optional] Reboot the machine (where you used PowerShell). Not so need, but up to you.
#
#src=https://superuser.com/questions/106360/how-to-enable-execution-of-powershell-scripts

##############################
#PODMAN: NETWORK, WSL, FIREWALL
##############################
#1. Have only a connexion for "ethernet" (host) => not need more (no Hyper-V and so on)
#2. You can download a firewall tool manager (apt-get install ufw) and disable it (ufw disable): you have a clear status
#3. Podman connexion ls => only podman (you add container to it)
#4. Set correct informations in files:
#
#ADD TO ~/.bashrc (WSL\root)
#echo "echo 'sudo tee /etc/wsl.conf << EOF' > /etc/wsl.conf" >> ~/.bashrc
#echo "echo '[network]' >> /etc/wsl.conf && echo 'generateResolvConf = false' >> /etc/wsl.conf" >> ~/.bashrc
#echo "echo 'EOF' >> /etc/wsl.conf" >> ~/.bashrc
#echo "echo 'nameserver 8.8.8.8' > /etc/resolv.conf" >> ~/.bashrc
#echo "echo 'nameserver 1.1.1.1' >> /etc/resolv.conf" >> ~/.bashrc



##################################################################################################################################################################
# SCRIPT POWERSHELL
##################################################################################################################################################################

#B/ In order to open ports in Windows (link Windows-Podman), Run this with PowerShell as ADMIN /!\ (with rights given as described in part A)

#src=https://stackoverflow.com/questions/61002681/connecting-to-wsl2-server-via-local-network
# You NEED to change the Ports List here in order to update for your own settings when you change the Dockerfile.

$remoteport = bash.exe -c "ifconfig eth0 | grep 'inet '"
$found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';

if( $found ){
  $remoteport = $matches[0];
} else{
  echo "The Script Exited, the ip address of WSL 2 cannot be found";
  exit;
}

#[Ports]

#All the ports you want to forward separated by coma
$ports=@(80,443,3389,3901,4901);


#[Static ip]
#You can change the addr to your ip config to listen to a specific address
$addr='0.0.0.0';
$ports_a = $ports -join ",";


#Remove Firewall Exception Rules
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' ";

#adding Exception Rules for inbound and outbound Rules
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalPort $ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalPort $ports_a -Action Allow -Protocol TCP";

for( $i = 0; $i -lt $ports.length; $i++ ){
  $port = $ports[$i];
  iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr";
  iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$remoteport";
}
