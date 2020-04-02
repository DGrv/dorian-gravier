---
layout: "post"
title: "Share files between Linux (CentOS) and Windows (secured share)"
date: "2019-04-26 16:58"
comments_id: 	27
---

I wanted to be able to share a folder between Linux and Windows. This was a nightmare regarding configuration and found everything possible on the net. I did not know really what to trust and did not want to read in detail the documentation since I would have to learn a lot of basic to get everything.

Whatever, I used Samba on CentOS 7 (CentOS Linux release 7.5.1804 (Core)).

Here the diffent steps I did with the source of info for the important things:

- Install Samba: `sudo yum install samba samba-client samba-common`
- Add samba to the firewall
  - `sudo firewall-cmd --permanent --zone=public --add-service=samba`
  - `sudo firewall-cmd --reload`
- On windows : Check windows workgroup (usually 'workgroup'): `net config workstation`
- Modify the config file
  - Make a backup of the samba config file `sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.orig`
  - Modify it: `sudo vi /etc/samba/smb.conf`
  It should look like this (<variable> to modify depending on you)
  This would be for a **secured share**.

```
[global]
	workgroup = WORKGROUP
	security = user
	printing = cups
	printcap name = cups
	load printers = yes
	cups options = raw
	netbios name = <nameofyourserver>

[etc]
	path = </path/ofyour/folder>
	valid users = @<etcshare>
	browsable = yes
	writable = yes
	guest ok = no
	read only = no
```

- Create user group: `sudo groupadd etcshare`
  - *For troubleshooting : List group* `cut -d: -f1 /etc/group | sort`
- Add user: `csudo usermod -a -G etcshare <youruser>`
  - *For troubleshooting : Check*	`getent group <etcshare>`
- Change permission
  - `sudo chmod -R 0770 </path/ofyour/folder>`
	- `sudo chown -R <youruser>:<etcshare> </path/ofyour/folder>`
	- `sudo chcon -t samba_share_t </path/ofyour/folder>`
	- **Highly important** to be able to go in the sub-folders ([https://medium.com/@brandboat/centos-smb-4-4-nt-status-access-denied-listing-a7e8ab72696e
](https://medium.com/@brandboat/centos-smb-4-4-nt-status-access-denied-listing-a7e8ab72696e
3))
		- `sudo setsebool -P samba_enable_home_dirs on`
- Add password samba:	`sudo smbpasswd -a screener`
  - *For troubleshooting : List info user samba*	`sudo pdbedit -L -v`
- Test parameters: `testparm`
- Enable service at boot
	- `sudo systemctl enable smb.service`
	- `sudo systemctl enable nmb.service`
	- `sudo systemctl start smb.service`
	- `sudo systemctl start nmb.service`
  - To restart the service after some modif	of the config file or other
  	- `sudo systemctl restart smb.service`
  	- `sudo systemctl restart nmb.service`


**TROUBLESHOOTING**

Try to connect first on CentOS, and navigate in sub-folders, check what is inside (`ls`).
If you have an error 'NT_STATUS_ACCESS_DENIED listing', check the 'setsebool'
	`smbclient \\\\<yourn netbios name in your config file>\\<basename of your folder>`

If you have problem check your `net use` and delete if needed (windows, just for example):
	`net use`
	`net use \<yourn netbios name in your config file>\<basename of your folder> /delete`
Or check in the **Credentials manager** (only way), sometimes windows keep info here and you do not see it with net use or net session ([https://serverfault.com/questions/326255/how-can-i-clear-the-authentication-cache-in-windows-7-to-a-password-protected
](https://serverfault.com/questions/326255/how-can-i-clear-the-authentication-cache-in-windows-7-to-a-password-protected))

**Source:**

- [https://www.tecmint.com/install-samba4-on-centos-7-for-file-sharing-on-windows/
](https://www.tecmint.com/install-samba4-on-centos-7-for-file-sharing-on-windows/)
- [https://serverfault.com/questions/326255/how-can-i-clear-the-authentication-cache-in-windows-7-to-a-password-protected
](https://serverfault.com/questions/326255/how-can-i-clear-the-authentication-cache-in-windows-7-to-a-password-protected))
- [https://medium.com/@brandboat/centos-smb-4-4-nt-status-access-denied-listing-a7e8ab72696e
](https://medium.com/@brandboat/centos-smb-4-4-nt-status-access-denied-listing-a7e8ab72696e
3)
