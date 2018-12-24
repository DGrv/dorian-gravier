---
lazout: post
title: How to roll back Acronis Backup from a HDD from your own computer
---

**Goal:**

Use a virtual machine on your own computer to maintain other HDD from other computers.

- Rollback Acrnois Backup 
- Make a backup from standalone HDD

**Info:**

Some time were invested to find a working solution to this problem and a lot of method were tested usually without success.
The one that is described here was tested and working.

Software used:

- VirtualBox 5.2.8
- VirtualBox Extension Pack that fits to your VirtualBox version : Oracle_VM_VirtualBox_Extension_Pack-5.2.8
- ImgBurn


# Tutorial

- With Acronis rescue CD, you have done in the past a backup of a computer in the .tib format
- Create an iso of your .tib
- Use ImgBurn to create it (use only a folder, not direct file)
- Create a Virtual Machine (VM) with Virtual Box (VB), xp or ubuntu whatever it should work.
- In settings of the VM / storage / add a cd reader or use the one existing and tell the system you have the iso of the Acronis rescue media (L:\Doku\IT\Software\Acronis\Acronis_2009\NepheloAcronisBootMedia2009.iso)
- In settings of the VM / storage / add a cd reader with the iso file created with ImgBurn, be sure it is the secondary slave (will not boot on this one)
- In settings of the VM / usb / check usb2 and add a new empty filter (just need to be empty)
- Start the VM, it should boot on the Acronis cd
- Plug your HDD to restore on (Adpater SATA or so to USB), you should see a window in acronis that it detected a new storage media and it shortly scanning it. Extension pack should be of course installed and its versioning should fit to the one of the virtualbox software
- Choose to restore a drive
- select your .tib in your second cd reader
- select your hdd that recently pluged
- Let's go
# Test your HDD

Then you should be able to boot a virtual machine from this new restored HDD

https://www.serverwatch.com/server-tutorials/using-a-physical-hard-drive-with-a-virtualbox-vm.html

This method is called VirtualBox "raw hard disk access."

- Create VM. Choose all options like normal, but when asked about the virtual hard drive, select Do not add a virtual hard drive.
- In Windows, open Disk Management (run diskmgmt.msc). You'll see the associated drive numbers on the left and will identify them later as PhysicalDrive0, PhysicalDrive1, etc.
- Create the VirtualBox Hard Drive, open a cmd prompt with admin right
VBoxManage internalcommands createrawvmdk -filename "C:\Users\<user_name>\VirtualBox VMs\<VM_folder_name>\<file_name>.vmdk" -rawdisk \\.\PhysicalDrive#
C:\PROGRA~1\Oracle\VIRTUA~1\VBOXMA~1.EXE internalcommands createrawvmdk -filename "C:\Users\gravier\Downloads\VM\Opera\Opera.vmdk" -rawdisk \\.\PhysicalDrive1
- Attach the VMDK to your VM. To do so, open the VirtualBox GUI,select the desired VM, click Settings, click Storage, click Add Hard Disk button, select Choose existing drive, and then select the VMDK file you just created.
- Start your VM


# Other solution tested:

- create iso or img from a file using ImgBurn
- convert iso to img with virtualbox, done by cmd line
- Ex
C:\PROGRA~1\Oracle\VirtualBox\VBoxManage.exe convertfromraw Disc.img Disc.vdi
C:\PROGRA~1\Oracle\VirtualBox\VBoxManage.exe convertdd Disc.img Disc.vdi
