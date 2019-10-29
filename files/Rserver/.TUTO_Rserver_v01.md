# How to install packages Rstudio server

## Shared libraries

- Open Putty or Kitty
	- SSH port 22 , host magrathea
	- login : gravier
	- pass : normalpassword HDC
- run "sudo R --vanilla"
	- You are now in R
	- install.packages("name",lib=.libPaths()[4])
		- .libPaths()[4] is "/usr/lib/R/library", accessible by all users.
		
		
## Installed 20140819
		
		IP <- as.data.frame(installed.packages())
		dput(rownames(IP))
		- copy the result
		
		
		install.packages(c("abind", "affy", "affyio", "annotate", "AnnotationDbi", "assertthat", "BH", "Biobase", "BiocGenerics", "BiocInstaller", "bitops", "boot", "car", "Category", "caTools", "cellHTS2", "colorspace", "DBI", "DEoptimR", "dichromat", "digest", "dplyr", "drc", "evaluate", "fields", "formatR", "gdata", "genefilter", "ggmap", "ggplot2", "GO.db", "googleVis", "graph", "gridExtra", "GSEABase", "gtable", "gtools", "hflights", "highr", "htmltools", "httpuv", "hwriter", "ic50", "IRanges", "knitr", "labeling", "Lahman", "limma", "locfit", "magic", "magrittr", "manipulate", "mapproj", "maps", "markdown", "mime", "miscTools", "munsell", "mvtnorm", "numDeriv", "optimx", "pcaPP", "plotrix", "plyr", "png", "prada", "preprocessCore", "proto", "R.methodsS3", "R.oo", "R.utils", "R2HTML", "RBGL", "Rcmdr", "RColorBrewer", "Rcpp", "reshape2", "rgl", "RgoogleMaps", "rJava", "rjson", "RJSONIO", "rmarkdown", "robustbase", "rrcov", "RSQLite", "rstudio", "scales", "scatterplot3d", "shiny", "spam", "splots", "stringr", "tcltk2", "vsn", "xlsx", "xlsxjars", "XML", "xtable", "yacca", "yaml", "yhat", "zlibbioc", "base", "boot", "class", "cluster", "codetools", "compiler", "datasets", "foreign", "graphics", "grDevices", "grid", "KernSmooth", "lattice", "MASS", "Matrix", "methods", "mgcv", "nlme", "nnet", "parallel", "rpart", "spatial", "splines", "stats", "stats4", "survival", "tcltk", "tools", "utils"), .libPaths()[4])
		
## if errors does not available :
	pk <- "https://cran.r-project.org/src/contrib/pbkrtest_0.4-6.tar.gz"
	pk <- "https://cran.r-project.org/src/contrib/ETLUtils_1.4.1.tar.gz"
	install.packages(pk, repos=NULL, type="source",lib=.libPaths()[4])

# Rsession hangs freeze

if session hanging, delete folder /home/username/.rstudio
	
# Add user

Kitty 
	SSH : magrathea
	port: 22

	l: gravier
	p: (normal password)

create a new user
	sudo adduser nameuser

connect on user name
	su nameuser

check rights
	cd /home/nameuser
	ls -la

HTS should be not in root but in the user name

add HTS shortcut or mount
	sudo ln -s /mnt/hts_share/ HTS
	sudo ln -s /mnt/opera/ opera
	sudo ln -s /mnt/Ablage/ Ablage

Well, ln -s creates a symbolic link, whereas mount --bind creates a mount.

check 
	ls -la

# Install packages 

## Github devtools

Go in R
	library(withr)
	library(devtools)
	with_libpaths(new = .libPaths()[4], code = install_github('hadley/ggplot2'))

	
# Mount unmount modify drive

## modify the ip

Change fstab
	sudo nano /etc/fstab
	or
	sudo vim /etc/fstab
	
	to run it (but load at start):
		mount -a

change what you need 

Actual one : 24/10/2016

		```# /etc/fstab: static file system information.
		#
		# Use 'blkid' to print the universally unique identifier for a
		# device; this may be used with UUID= as a more robust way to name devices
		# that works even if disks are added and removed. See fstab(5).
		#
		# <file system> <mount point>   <type>  <options>       <dump>  <pass>
		/dev/mapper/magrathea--vg-root /               ext4    errors=remount-ro 0       1
		# /boot was on /dev/sda1 during installation
		#UUID=9c20105f-85f5-47aa-b3f9-5770f7a7c07d /boot           ext2    defaults        0       2
		/dev/mapper/magrathea--vg-swap_1 none            swap    sw              0       0
		/dev/fd0        /media/floppy0  auto    rw,user,noauto,exec,utf8 0       0
		//10.13.20.9/hts  /mnt/hts_share  cifs  username=robolab,password=labarobo,_netdev,iocharset=utf8,file_mode=0777,dir_mode=0777,uid=1002,sec=ntlm  0  0
		//10.13.20.9/OperaImages  /mnt/operaimages  cifs  username=robolab,password=labarobo,_netdev,iocharset=utf8,file_mode=0777,dir_mode=0777,uid=1002,sec=ntlm  0  0
		# Ablage need version 2.0
		//10.13.20.10/Ablage /mnt/Ablage  cifs  username=hdc,password=uspfhdc,_netdev,iocharset=utf8,file_mode=0777,dir_mode=0777,uid=1002,sec=ntlm,vers=2.0  0  0
		UUID=803411ae-2a6d-41ab-9259-7f4997c692d0 none swap sw 0 0
		~
		```

Single cmd 
mount
	sudo mount //10.13.20.9/hts  /mnt/hts_share -t cifs -o username=robolab,password=labarobo,vers=2.0
	sudo mount //10.13.20.10/Ablage /mnt/Ablage -t cifs -o username=hdc,password=uspfhdc,vers=2.0
unmount
	sudo umount /mnt/hts_share
	sudo umount /mnt/Ablage
	

	
# Install R on Linux

check the bit version of Linux
	uname -a
		gravier@magrathea:~$ uname -a
			Linux magrathea 3.13.0-101-generic #148-Ubuntu SMP Thu Oct 20 22:08:32 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
		wormulon-2
			Linux wormulon-2 4.2.0-35-generic #40-Ubuntu SMP Tue Mar 15 22:15:45 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
Which linux
	lsb_release -a
		gravier@magrathea:~$ lsb_release -a
			No LSB modules are available.
			Distributor ID: Ubuntu
			Description:    Ubuntu 14.04.3 LTS
			Release:        14.04
			Codename:       trusty
		wormulon-2
			No LSB modules are available.
			Distributor ID: Ubuntu
			Description:    Ubuntu 15.10
			Release:        15.10
			Codename:       wily

Info how : https://cran.rstudio.com/bin/linux/ubuntu/
	To obtain the latest R packages, add an entry like (trusty, wily and so on depending on lsb_release)
		deb https://<my.favorite.cran.mirror>/bin/linux/ubuntu trusty/
	in your /etc/apt/sources.list file, replacing by the actual URL of your favorite CRAN mirror. See https://cran.r-project.org/mirrors.html for the list of CRAN mirrors.
		deb https://http://ftp5.gwdg.de/pub/misc/cran/bin/linux/ubuntu wily/
			for this use the editor vim
				sudo vim /etc/apt/sources.list
				go to the line you want, click a to enter in edit mode (append, exist i, I, A, ...).
				to quit without saving ':q' or ':q!' (no warning), to save add a w before the q
	To install the complete R system, use
		sudo apt-get install r-base
	Users who need to compile R packages from source [e.g. package maintainers, or anyone installing packages with install.packages()] should also install the r-base-dev package:
		sudo apt-get install r-base-dev

	
# Update Rserver
	
> seems to work ? is it complex to do it ? I do not want to do it just understand what you did and what the meaning of the text in the website was.
The installation on magrathea?

In principle not. But… since the installation was done long ago and ‘on the fly’ I had to cleanup. i.e. re-partition the boot sector, deleting old packages and reconfiguring the cran archive in the sources list.

R: should be updated with the normal update process of the system. Apt-get install update / apt-get install upgrade -> cran mirror in the sources list

			sudo vim /etc/apt/sources.list
				add : deb http://ftp.gwdg.de/pub/misc/cran/bin/linux/ubuntu trusty/
					for VIM use "i" for getting in insert mode and esc for esc it (quit ":q!" without saving, ":wq" for saving)
			sudo apt-get update
			sudo apt-get install r-base
			sudo apt-get install r-base-dev

Rserver: download of debian package and installation with a debian package handler

With Ubuntu 64 bits (x86_64):
			sudo apt-get install gdebi-core
			sudo wget https://download2.rstudio.org/rstudio-server-1.0.143-amd64.deb
			sudo gdebi rstudio-server-1.0.143-amd64.deb

Reboot also works, rserver is then started automatically


# error transmission initialization Rstudio

This appears after removing all packages from all lib.
I had to first desinstall r-base-core and r-base-dev and rstudio-server and then reinstall them

To get a list of pgm installed : 
	dpkg --list
To remove pgm : 
	sudo apt-get --purge remove pkg
			sudo apt-get --purge remove r-base-core (The package r-base is a so-called virtual package which exists to just pulls other packages in. Removing it does not remove any parts of the R system --- for which you need to remove r-base-core. )
			sudo apt-get --purge remove r-base-dev
			sudo apt-get --purge remove rstudio-server
			sudo apt-get autoremove (for cleaning)
	
I then reinstall all packages needed with :
	sudo R --vanilla
		install.packages(list of packages needed, repos="http://ftp.gwdg.de/pub/misc/cran/", lib=.libPaths()[4])
			 lib=.libPaths()[4] is for library accessible by all users
			 the repos is to avoid R to search for repos
For github packages
	install.packages("devtools", repos="http://ftp.gwdg.de/pub/misc/cran/", lib=.libPaths()[4])
	library(devtools)
	withr::with_libpaths(new = .libPaths()[4], install_github("kassambara/r2excel"))
Update packages
	sudo R --vanilla
	update.packages(.libPaths()[4])
	
	
# Clean linux


Remove partial packages

This is yet another built-in feature, but this time it is not used in Synaptic Package Manager. It is used in the Terminal. Now, in the Terminal, key in the following command

		sudo apt-get autoclean

Then enact the package clean command. What this commnad does is to clean remove .deb packages that apt caches when you install/update programs. To use the clean command type the following in a terminal window:

		sudo apt-get clean

You can then use the autoremove command. What the autoremove command does is to remove packages installed as dependencies after the original package is removed from the system. To use autoremove tye the following in a terminal window:

		sudo apt-get autoremove
		
		
Remove temp files
	sudo rm -rf /tmp/*
	
	*

# Modify Rprofile

	cd /usr/lib/R/library/base/R
	nano Rprofile
	or 
	vim Rprofile
	sudo nano Rprofile

type i to go in insert mode
escape for going in command mode
	:w to save write
	:q to quit
	:wq to save and quit
	:q! to quit without saving

	
# Packages

## libtiff

# Install libtiff

http://www.linuxfromscratch.org/blfs/view/svn/general/libtiff.html

go to the tar.gz

tar xzvf program.tar.gz

go in the new folder

sudo ./configure
sudo make
sudo make install

# Mysql

To install MySQL, run the following command from a terminal prompt:

	sudo apt-get install mysql-server

During the installation process you will be prompted to enter a password for the MySQL root user.
Once the installation is complete, the MySQL server should be started automatically. You can run the following command from a terminal prompt to check whether the MySQL server is running:

	sudo netstat -tap | grep mysql

When you run this command, you should see the following line or something similar:

tcp        0      0 localhost:mysql         *:*                LISTEN      2556/mysqld

If the server is not running correctly, you can type the following command to start it:

	sudo service mysql restart


	sudo apt-get install libmysqlclient-dev
	sudo apt-get install libiodbc2-dev
	sudo apt-get install libiodbc2
	sudo apt-get install iodbc
	sudo apt-get install libmyodbc

	start iodbc
	iodbcadm-gtk


In R
	install.packages("RMySQL")

	
## Download packages dependencies

getPackages <- function(packs){
  packages <- unlist(
    tools::package_dependencies(packs, available.packages(),
                         which=c("Depends", "Imports"), recursive=TRUE)
  )
  packages <- union(packs, packages)
  packages
}

packages <- getPackages(c("ggplot2"))


download.packages(packages, destdir="H:/Data/Thermo/Echo/Analysis", 
                  type="win.binary")
				  
				  
install.packages(path_to_file, repos = NULL, type="source")



install.packages("H:/Data/Thermo/Echo/Analysis/colorspace_1.2-6.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/labeling_0.3.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/munsell_0.4.2.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/dichromat_2.0-0.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/RColorBrewer_1.1-2.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/stringr_1.0.0.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/Rcpp_0.12.1.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/proto_0.3-10.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/scales_0.3.0.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/reshape2_1.4.1.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/gtable_0.1.2.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/digest_0.6.8.zip", repos = NULL, type="source")
install.packages("H:/Data/Thermo/Echo/Analysis/ggplot2_1.0.1.zip", repos = NULL, type="source")
	

## Tcltk

Then unzip them
	gunzip -c tcl8.6.2-src.tar.gz	#to ungz a file
	tar -xvf tcl8.6.2-src.tar	#to untar
	or
	tar -zxvf tk8.6.2-src.tar.gz	#to un tar.gz a file
go in the tcl folder and in unix folder
run
	sudo ./configure
	sudo make
	sudo make test
	sudo make install

# Run auto script from cmd
 
```batch
echo n | H:\TEMP\Dorian\Batch_Files\Rserver\plink.exe -v -ssh gravier@magrathea -pw uspfhdc "Rscript /mnt/hts_share/Data/R/Scripts/Gxx68/Gxxx8_PrS_AUTO_v01.R"
```

	

	

	

	

	