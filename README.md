# Born2beroot

> ~~ **ALL YOU NEED TO CREATE YOUR VM & GL HF**~~

## Install Sudo

**Go to root**
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
<img width="1277" alt="Screen Shot 2024-02-27 at 9 07 56 PM" src="https://github.com/hi0ki/Born2beroot/assets/123004073/8898de34-fcff-467e-8b62-280091b9deb0">

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

**Go to root**
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

**Go to root**
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
**Add a user to the group*
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
