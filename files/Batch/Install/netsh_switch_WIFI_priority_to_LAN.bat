@echo off


netsh interface ipv4 show interfaces
netsh interface ipv4 set interface "WiFi" metric=5
netsh interface ipv4 set interface "Ethernet" metric=10



REM Idx     Met         MTU          State                Name
REM ---  ----------  ----------  ------------  ---------------------------
  REM 1          75  4294967295  connected     Loopback Pseudo-Interface 1
 REM 12           5        1500  disconnected  Ethernet
 REM 11          25        1500  disconnected  Local Area Connection
 REM 18          45        1500  connected     WiFi
 REM 16          25        1500  disconnected  OpenVPN Data Channel Offload for NordVPN
 REM 10          25        1500  disconnected  Local Area Connection* 1
 REM 20           5        1420  connected     NordLynx
  REM 6          25        1500  disconnected  Local Area Connection* 2
  
  
  
REM Explanation -------------------------------------------------------------------------------
  
REM Idx     Met         MTU          State                Name
REM ---  ----------  ----------  ------------  ---------------------------
REM 1        25        1500      connected     Ethernet
REM 12        10        1500      connected     Wi-Fi
REM Column Breakdown:
REM Idx: The interface index number (used for other netsh commands).

REM Met: The interface metric — this is what you're asking about.

REM MTU: Maximum Transmission Unit.

REM State: connected, disconnected, etc.

REM Name: The name of the network interface.

REM What is "Metric"?
REM The interface metric determines the priority of the interface. Lower values mean higher priority for routing (i.e., the system will prefer a lower-metric interface when multiple routes are available).
