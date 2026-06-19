#!/bin/bash

if [ "$EUID" -ne 0 ]; then
   echo "Restart with root rights (sudo)"
   exit 1
fi

is_work=false

banner(){
cat << "EOF"
 _______                                   _______         __   __   __                    
|     __|.-----.----.--.--.-----.----.    |     __|.-----.|  |_|  |_|__|.-----.-----.-----.
|__     ||  -__|   _|  |  |  -__|   _|    |__     ||  -__||   _|   _|  ||     |  _  |__ --|
|_______||_____|__|  \___/|_____|__|      |_______||_____||____|____|__||__|__|___  |_____|
                                                                              |_____|    
EOF
  
  echo ""
  echo "made by Efesint 2026"
  echo "started at: $(date)"
  echo ""
}

banner



echo "Welcome to Server-Settings 1.0"
echo ""

desc() {

echo "SYSTEM (hardware and OS)"
echo "[1] Hostname " 
echo "[2] Linux kernel version"
echo "[3] Linux distribution"
echo "[4] Operating time"
echo "[5] Current date"
echo "[6] Processor architecture" #arch
echo ""

echo "PROCESSOR AND MEMORY"
echo "[7] Processor model"
echo "[8] Number of cores"
echo "[9] CPU usage in percent"
echo "[10] RAM usage: total, used and free"
echo "[11] Using swap (if any)"
echo ""

echo "DISKS AND FILESYSTEMS"
echo "[12] List of disk and their sizes"
echo "[13] Space usage on each partition"
echo "[14] File system type"
echo "[15] INODE - How much is left"
echo "[16] List of mounted partitions"
echo ""

echo "NETWORK"
echo "[17] All server IP addresses"
echo "[18] Public IP (if you have curl)"
echo "[19] List of open ports and which processes are listening on them (if you have ss)" #ss -tulpn
echo "[20] Active network connections"
echo "[21] Network interface speed (incoming/outgoing traffic over the last minutes)"
echo "[22] Routing (default gateway)"
echo ""

echo "USERS"
echo "[23] Who is currently logged into the server?"
echo "[24] Last logins" #last
echo "[25] List all users with shell (/bin/bash)"
echo "[26] Who has sudo rights? (if any)"
echo ""

echo "PROCESSES AND SERVICES"
echo "[27] Top 5 Processes That Use CPU"
echo "[28] Top 5 processes that use up memory"
echo "[29] List of all running systemd services (if you use systemd)"
echo "[30] Which services start automatically at boot?"
echo ""

echo "SECURITY"
echo "[31] Is the firewall (ufw/iptables) enabled?"
echo "[32] Recent failed login attempts (from /var/log/auth.log)"
echo "[33] Number of failed login attempts in the last hour"
echo "[34] Are there any security updates waiting to be installed?"
echo "[35] Checking if fail2ban is installed"
echo ""

echo "LOGS"
echo "[36] The last 5 errors from the system log"
echo "[37] System log size"
echo ""

echo "DOCKER (if installed)"
echo "[38] Number of running containers"
echo "[39] List of containers and their statuses"
echo "[40] Using a Docker disk"
echo "[41] Images that take up the most space"
echo ""

echo "FAST ACTION"
echo "[42] show only SYSTEM"
echo "[43] show only PROCESSOR AND MEMORY"
echo "[44] show only DISKS AND FILESYSTEMS"
echo "[45] show only NETWORK"
echo "[46] show only PROCESSES AND SERVICES"
echo "[47] show only USERS"
echo "[48] show only SECURITY"
echo "[49] show only LOGS"
echo "[50] show only DOCKER"
echo "[51] show command list"
echo "[52] exit"

}

desc

while [ "$is_work" = false ]; do

echo ""
echo "Select what to show. Selection table - 51"
read answer

if [ "$answer" = 1 ]; then
hostname 

elif [ "$answer" = 2 ]; then
uname -r 

elif [ "$answer" = 3 ]; then
cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f2

elif [ "$answer" = 4 ]; then
uptime -p

elif [ "$answer" = 5 ]; then
date

elif [ "$answer" = 6 ]; then
uname -m

elif [ "$answer" = 7 ]; then
cat /proc/cpuinfo | grep "model name" | head -1 | cut -d ':' -f2 | xargs

elif [ "$answer" = 8 ]; then
nproc

elif [ "$answer" = 9 ]; then
top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d '%' -f1

elif [ "$answer" = 10 ]; then
free -h

elif [ "$answer" = 11 ]; then
swapon --show

elif [ "$answer" = 12 ]; then
lsblk

elif [ "$answer" = 13 ]; then
df -h

elif [ "$answer" = 14 ]; then
df -T

elif [ "$answer" = 15 ]; then
df -i

elif [ "$answer" = 16 ]; then
mount | column -t

elif [ "$answer" = 17 ]; then
ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127.0.0.1

elif [ "$answer" = 18 ]; then
curl -s --connect-timeout 5 --max-time 10 ifconfig.me || echo "Public IP not available"

elif [ "$answer" = 19 ]; then
ss -tulpn

elif [ "$answer" = 20 ]; then
ss -tun

elif [ "$answer" = 21 ]; then
ip -s link

elif [ "$answer" = 22 ]; then
ip route | grep default

elif [ "$answer" = 23 ]; then
who

elif [ "$answer" = 24 ]; then
last -n 10

elif [ "$answer" = 25 ]; then
cat /etc/passwd | grep "/bin/bash" | cut -d ':' -f1

elif [ "$answer" = 26 ]; then
if grep -q "^sudo:" /etc/group; then
  grep -Po '^sudo.+:\K.*$' /etc/group
elif grep -q "^wheel:" /etc/group; then
  grep -Po '^wheel.+:\K.*$' /etc/group
else
  echo "No sudo or wheel group found"
fi

elif [ "$answer" = 27 ]; then
ps aux --sort=-%cpu | head -6

elif [ "$answer" = 28 ]; then
ps aux --sort=-%mem | head -6

elif [ "$answer" = 29 ]; then
systemctl list-units --type=service --state=running

elif [ "$answer" = 30 ]; then
systemctl list-unit-files --type=service --state=enabled

elif [ "$answer" = 31 ]; then
iptables -L -n | head -5

elif [ "$answer" = 32 ]; then
journalctl -q -n 20 | grep -i "failed password" || echo "No failed login attempts found"

elif [ "$answer" = 33 ]; then
journalctl -q --since "1 hour ago" | grep -i "failed password" | wc -l

elif [ "$answer" = 34 ]; then
echo "For debiab/ubuntu"
apt list --upgradable | grep -i security


elif [ "$answer" = 35 ]; then
which fail2ban-client


elif [ "$answer" = 36 ]; then
journalctl -p 3 -b | tail -5


elif [ "$answer" = 37 ]; then
du -sh /var/log/

elif [ "$answer" = 38 ]; then
docker ps -q | wc -l

elif [ "$answer" = 39 ]; then
docker ps -a


elif [ "$answer" = 40 ]; then
docker system df


elif [ "$answer" = 41 ]; then
docker images --sort=size | head -5


elif [ "$answer" = 42 ]; then
hostname
uname -r 
cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f2 
uptime -p
date
uname -m


elif [ "$answer" = 43 ]; then
cat /proc/cpuinfo | grep "model name" | head -1 | cut -d ':' -f2 | xargs
nproc
top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d '%' -f1
free -h
swapon --show

elif [ "$answer" = 44 ]; then
lsblk
df -h
df -T
df -i
mount | column -t

elif [ "$answer" = 45 ]; then
ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127.0.0.1
curl -s --connect-timeout 5 --max-time 10 ifconfig.me || echo "Public IP not available"
ss -tulpn | head -20
ss -tun | head -20
ip -s link
ip route | grep default


elif [ "$answer" = 46 ]; then
ps aux --sort=-%cpu | head -6
ps aux --sort=-%mem | head -6
systemctl list-units --type=service --state=running | head -20
systemctl list-unit-files --type=service --state=enabled | head -20

elif [ "$answer" = 47 ]; then
who
last -n 10
cat /etc/passwd | grep "/bin/bash" | cut -d ':' -f1
if grep -q "^sudo:" /etc/group; then
  grep -Po '^sudo.+:\K.*$' /etc/group
elif grep -q "^wheel:" /etc/group; then
  grep -Po '^wheel.+:\K.*$' /etc/group
else
  echo "No sudo or wheel group found"
fi

elif [ "$answer" = 48 ]; then
iptables -L -n | head -5
grep "Failed password" /var/log/auth.log | tail -5
echo "Failed logins last hour: $(grep "Failed password" /var/log/auth.log | grep "$(date +'%b %d %H')" | wc -l)"
echo "For debian/ubuntu security updates:"
apt list --upgradable | grep -i security 2>/dev/null || echo "No security updates or not Debian/Ubuntu"
which fail2ban-client 2>/dev/null || echo "fail2ban not installed"

elif [ "$answer" = 49 ]; then
journalctl -p 3 -b | tail -5
du -sh /var/log/

elif [ "$answer" = 50 ]; then
echo "Running containers: $(docker ps -q | wc -l)"
docker ps -a
docker system df
docker images --sort=size | head -5

elif [ "$answer" = 51 ]; then
desc

elif [ "$answer" = 52 ]; then
is_work=true
echo "Bye!"

else
echo "Invalid option: $answer. please choose a number between 1 and 52"

fi
done
