--- 
title: "Set up Barrier windows to windows (installed with scoop)" 
date: "2026-03-18 16:32" 
--- 

# Set up Barrier windows to windows (installed with scoop) 

I had difficulties to set it up so here the explanation:

# New

- be sure that the service is started, `services.msc` and search for Barrier
- Be sure that SSL disable in settings from barrier (F4)
- Be sure to be on Private domain wifi/LAN
- Disable SSL in Settings Barrier



# Old

- open barrier and test first, use F2 to open log to see if working
- open `wf.msc` (windows firewall)
- be sure that barrier in the Server PC is allowed on Private Domain
- add a tcp rule inbound and outbout for port TCP 24800
- ping the client, should work, ping the server from the client should work
- be sure that the service is started, `services.msc` and search for Barrier
- you might have to create it in powershell with : `New-Service -Name 'Barrier' -BinaryPathName "C:\Users\doria\scoop\apps\barrier\current\barrierd.exe" -StartupType 'Manual' -Description 'Manages the Barrier background processes.' -ErrorAction 'SilentlyContinue'`
- be sure that barrier is allowed in Control panel > System and Security > Windows Firewall > Allow Apps to communicate --- and barrier on private domain
- be sure maybe that 


Good luck.