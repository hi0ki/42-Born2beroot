# Born2beroot

### About Born2beroot
Born2beroot is a system administration project at 42 School that focuses on creating and configuring a virtual machine (VM) using a Linux distribution. The primary objectives of this project include:

- Learning system administration fundamentals
- Understanding Linux server configuration
- Implementing security best practices
- Exploring virtual machine setup and management
- Practicing user and group management
- Configuring network services and firewall
- Implementing password policies
- Setting up SSH and sudo configurations

The project challenges students to manually install and configure a Linux server environment, emphasizing manual configuration over automated tools like Docker or pre-configured images. Students typically create a VM with strict security settings, configure various system services, and demonstrate their understanding of Linux system administration principles.


> ~~ **ALL YOU NEED TO CREATE YOUR VM & GL HF**~~

## Install Sudo

**Switch to root**
```bash
su -
```
**Install sudo**
```bash
apt install sudo
```
**Add ur user to sudo group**
```bash
adduser <username> sudo
```
**Open Sudo file**
```bash
visudo
```

**Add ur user to sudo config file.**

```bash
<username> ALL=(ALL:ALL) ALL
```


## Ssh config

**Install 'openssh-server'to run openssh server on your machine**
```bash
sudo apt install openssh-server
```
**Open config file to open the port**
```bash
vim /etc/ssh/sshd.config
```

**Open the port and change it to 4242** 

```bash
Port 4242
```

**Check server status**
```bash
sudo systemctl status ssh
```

**To restart ssh service**
```bash
service ssh restart
```

## Install UFW 

**Install UFW**
```bash
sudo apt install ufw
```
**Enable UFW**
```bash
sudo ufw enable
```

**Allow port 4242**

```bash
sudo ufw allow 4242
```

**In case you want to remove port 4242**

```bash
sudo ufw delete allow 4242
```
### **Creat port for virtualbox**
<img width="1277" alt="Screen Shot 2024-02-27 at 9 07 56 PM" src="https://github.com/hi0ki/Born2beroot/assets/123004073/8898de34-fcff-467e-8b62-280091b9deb0">
<img width="1277" alt="Screen Shot 2024-02-27 at 9 15 40 PM" src="https://github.com/hi0ki/Born2beroot/assets/123004073/86ab5cbd-cbf7-4080-bd97-7ccb05a65f90">
<img width="1275" alt="Screen Shot 2024-02-27 at 9 19 22 PM" src="https://github.com/hi0ki/Born2beroot/assets/123004073/8bc04d0e-c92a-4363-9ec3-3b6aa5c73146">
<img width="1275" alt="Screen Shot 2024-02-27 at 9 20 14 PM" src="https://github.com/hi0ki/Born2beroot/assets/123004073/838cf0aa-917a-4d5f-bc4c-61157ff7dc2e">

**Now u can connect with ssh**
```bash
ssh username@localhost -p 4242
```

## Password Policy 

**Install library for password quality**
```bash
sudo apt install libpam-pwquality
```

**Open the password configuration file**

```bash
vim /etc/pam.d/common-password
```

**We would go to the line that contains pam_pwquality.so and edit in this line as follows**
```bash
password        requisite        pam_pwquality.so  retry=3  minlen=10 ucredit=-1  lcredit=-1  dcredit=-1  maxrepeat=3  usercheck=1  difok=7  enforce_for_root
```

**Open the password quality file for more commands**

```bash
vim /etc/security/pwquality.config
```

## Password expiration

**Open the login file**
```bash
vim /etc/login.defs
```

**Search for lines containing password expiration**

```bash
PASS_MAX_DAYS 9999
PASS_MIN_DAYS 0
PASS_WARN_AGE 7
```


**Expire every 30days.**
```bash
PASS_MAX_DAYS 30 
```
**Minimum modification interval to 2 days.**
```bash
PASS_MIN_DAYS 2
```
**Warning message 7day before their password expires.**
```bash
PASS_WARN_AGE 7
```
**You can use this cmd to desplay password expiration information**
```bash
chage -l <username>
```
**YOU can change information with chage with flag**
```bash
example: change mindays to 2days for user
chage -m 2 <username>

flags:
-M > for maxdays
-W > for warning days
```
## Config Sudo 

**Switch to root**
```bash
su -
```
**Open Sudo file**
```bash
visudo
```

```bash
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
```
**The user has 3 attempts to enter the password.**
```bash
Defaults        passwd_tries=3
```
**Message displayed if user enters the wrong password.**
```bash
Defaults        badpass_message="wrong password"
```
**Enable logging of command input and output for sudo**
```bash
Defaults        log_input, log_output
```
**Change dir of the input and output logs of sudo command**
```bash
Defaults        iolog_dir="/var/log/sudo"
```
**Sudo command can only be used from tty, this means that sudo cannot be used from scripts or system processes that do not have a tty.**
```bash
Defaults        requiretty
```

## Add user & Add group & change hostname ... 

**Switch to root**
```bash
su -
```

### **Add user & delete user**

**Add user**
```bash
adduser <username>
```
**Delete user**
```bash
deluser <username>
```

### **Add group & Add a user to the grp**

**Create a group**
```bash
groupadd <grpname>
```
**Add a user to the group**
```bash
usermod -aG <grpname> <username>
```

# List users | List groups

**List users**
```bash
getent password
```
**List groups**
```bash
getent group
```
# Bonus Part

**Install packages**
```bash
sudo apt install lighttpd

sudo apt install mariadb-server

sudo apt install php-cgi

sudo lighttpd-enable-mod fastcgi
```

**Config lighttpd**
```bash
sudo vim /etc/lighttpd/lighttpd.conf
```

```bash
fastcgi.server += ( ".php" => (( "bin-path" => "/usr/bin/php-cgi", "socket" => "/tmp/php.socket" )))
```
```bash
sudo service lighttpd status
```
```bash
sudo service lighttpd force-reload
```
**Config database**
```bash
mariadb 
```
```bash
CREATE DATABASE wordpress;
```
```bash
CREATE USER 'your_username'@'localhost' IDENTIFIED BY 'your_password';
```
```bash
GRANT ALL PRIVILEGES ON your_database_name.* TO 'your_username'@'localhost';
```
```bash
exit
```

**Config wordpress**

```bash
su -
```
```bash
cd /var/www/html
```
```bash
wget https://wordpress.org/latest.tar.gz
```
```bash
tar -xzvf latest.tar.gz
```
```bash
mv wordpress/*  .
```
```bash
cp wp-config-sample.php wp-config.php
```
```bash
vim wp-config.php
```
```bash
and change 
            'database_name_here'
            'username_here'
            'password_here'
```
**Open Port 80 for lighttpd server**
```bash
ufw allow 80
```
```bash
sudo service lighttpd restart
```
**http://127.0.0.1/**
### END
