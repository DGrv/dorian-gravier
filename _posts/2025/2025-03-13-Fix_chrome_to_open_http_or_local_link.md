--- 
title: "Fix chrome to open http or local link, file in a new tab when you use scoop" 
date: "2025-03-13 09:16" 
--- 


- Open chrome 
- Use process explorer with the target to find which exe it is and check the path 
		- Should be something like this :
		- "C:\Users\user\scoop\apps\googlechrome\current\chrome.exe" --user-data-dir="C:\Users\user\scoop\apps\googlechrome\current\User Data"
- Modify in the registry : Computer\HKEY_CLASSES_ROOT\ChromeHTML.NT43LP3HFQOY4TWE5TD7B6C6SY\shell\open\command
	- to "C:\Users\doria\scoop\apps\googlechrome\current\chrome.exe" --user-data-dir="C:\Users\doria\scoop\apps\googlechrome\current\User Data" %1
