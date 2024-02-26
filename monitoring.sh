#!/bin/bash

SIZE=$(lsblk | grep 'lvm' | wc -l )

wall "\
#Architecture:$(uname -a | sed 's/PREEMPT_DYNAMIC//')
#CPU physical : $(lscpu | grep 'Socket(s)' | awk '{print $2}')
#vCPU : $(lscpu | grep 'Thread(s) per core' | awk '{print $4}')
#Memory Usage: $(free --mega | awk 'NR==2{printf"%d/%dMB (%.2f%%)", $3, $2, $3*100/$2}')
#Disk Usage: $(df -h --total | grep 'total' | awk '{printf"%d/%dGB (%s)",$3,$2,$5}')
#CPU load: $(top -bn1 | grep '^%Cpu' | awk '{printf"%.1f%%", $2+$4}')
#Last boot: $(who -b | awk '{printf"%s %s", $3,$4}')
#LVM use: $(if [ $SIZE > 0 ]; then echo "yes"; else echo "no"; fi)
#Connections TCP : $(ss --tcp | grep 'ESTAB' | wc -l | awk '{printf "%d ESTABLISHED", $0}')
#User log: $(who |cut -d " " -f 1 | sort -u | wc -l)
#Network: $(hostname -I | awk '{printf"IP %s", $0}')$(ip addres | grep 'ether' | awk 'NR==1 {printf"(%s)", $2}')
#Sudo : $(journalctl | grep 'sudo.*COMMAND' | wc -l | awk '{printf"%d cmd", $0}')
\
"