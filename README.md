# server-settings
A quick bash script for obtaining information about the host state.
```
 _______                                   _______         __   __   __                    
|     __|.-----.----.--.--.-----.----.    |     __|.-----.|  |_|  |_|__|.-----.-----.-----.
|__     ||  -__|   _|  |  |  -__|   _|    |__     ||  -__||   _|   _|  ||     |  _  |__ --|
|_______||_____|__|  \___/|_____|__|      |_______||_____||____|____|__||__|__|___  |_____|
                                                                              |_____|      
```

## the help that can be provided
A comprehensive system status search. The script can run a full diagnostic log check in just a couple of clicks.
The tool is designed for system administrators, DevOps engineers and novice server users.


## requirements
1. Systemd  (optional, but some commands may not work)
2. APT package manager (optional, but some commands may not work) 

## Script capabilities
SYSTEM (hardware and OS)
```
[1] Hostname 
[2] Linux kernel version
[3] Linux distribution
[4] Operating time
[5] Current date
[6] Processor architecture
```
PROCESSOR AND MEMORY
```
[7] Processor model
[8] Number of cores
[9] CPU usage in percent
[10] RAM usage: total, used and free
[11] Using swap (if any)
```
DISKS AND FILESYSTEMS
```
[12] List of disk and their sizes
[13] Space usage on each partition
[14] File system type
[15] INODE - How much is left
[16] List of mounted partitions
```
NETWORK
```
[17] All server IP addresses
[18] Public IP (if you have curl)
[19] List of open ports and which processes are listening on them (if you have ss)
[20] Active network connections
[21] Network interface speed (incoming/outgoing traffic over the last minutes)
[22] Routing (default gateway)
```
USERS
```
[23] Who is currently logged into the server?
[24] Last logins
[25] List all users with shell (/bin/bash)
[26] Who has sudo rights? (if any)
```
PROCESSES AND SERVICES
```
[27] Top 5 Processes That Use CPU
[28] Top 5 processes that use up memory
[29] List of all running systemd services (if you use systemd)
[30] Which services start automatically at boot?
```
SECURITY
```
[31] Is the firewall (ufw/iptables) enabled?
[32] Recent failed login attempts (from /var/log/auth.log)
[33] Number of failed login attempts in the last hour
[34] Are there any security updates waiting to be installed?
[35] Checking if fail2ban is installed
```
LOGS
```
[36] The last 5 errors from the system log
[37] System log size
```
DOCKER (if installed)
```
[38] Number of running containers
[39] List of containers and their statuses
[40] Using a Docker disk
[41] Images that take up the most space
```
FAST ACTION
```
[42] show only SYSTEM
[43] show only PROCESSOR AND MEMORY
[44] show only DISKS AND FILESYSTEMS
[45] show only NETWORK
[46] show only PROCESSES AND SERVICES
[47] show only USERS
[48] show only SECURITY
[49] show only LOGS
[50] show only DOCKER
[51] show command list
[52] exit
```
## Installation 
1.Install server-settings.sh
~~~
git clone https://github.com/Efesint/server-settings && cd server-settings
~~~
2. Add script executable
```
chmod +x server-settings.sh
```
3. Run with root rights (required)
```
sudo ./server-settings.sh
```

## ⚠️ Disclaimer
I'm still learning Linux administration and Bash programming. 
This project is a learning exercise, not production-ready software.
But for casual use, I think it'll be quite usable.
This is my first Bash project.
Thanks for reading.
