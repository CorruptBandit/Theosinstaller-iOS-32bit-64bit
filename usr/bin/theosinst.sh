!#/bin/bash

if [[ ! $# -ne 0 ]]; then
echo "Theos Installer"
echo "Usage: theosinst [opt] [sdks]"
echo "Opt."
echo "32 : for 32bit"
echo "64 : for 64bit"
echo "-v : Verbose Mode"
echo "Sdks."
echo "9.3  : sdk 9.3"
echo "10.3 : sdk 10.3 (64bit only)"
echo "11.2 : sdk 11.2 (64bit only)"
echo "Single Opt."
echo "sdks : Download sdk"
echo "un   : Uninstall theos and everything"
exit 1
fi

if [[ $# == 2 ]] && [[ ( $1 == sdks || $2 == sdks ) ]]; then
	while true; do
    	read -p "Please Choose Sdk : 
  S : Sdk 9.3
  D : Sdk 10.3 (for 64bit only)
  K : Sdk 11.2 (for 64bit only)
  N : Abort
:" sdk
      case $sdk in
        [Ss]* ) echo "Downloading Sdk 9.3 ..."
        git clone git://github.com/theos/sdks /var/sdks-master
        cd /var
        echo "Extracting Sdk..."
        mv /var/sdks-master/iPhoneOS9.3.sdk $THEOS/sdks
        cp /var/sdks-master/iPhoneOS10.3.sdk/usr/lib/system/liblaunch.tbd /usr/lib/system
        rm -r /var/sdks-master
        break;;
        [Dd]* ) echo "Downloading Sdk 10.3 ..."
        git clone git://github.com/theos/sdks /var/sdks-master
        cd /var
        echo "Extracting Sdk..."
        mv /var/sdks-master/iPhoneOS10.3.sdk $THEOS/sdks
        rm -r /var/sdks-master
        break;;
        [Kk]* ) echo "Downloading Sdk 11.2 ..."
        git clone git://github.com/theos/sdks /var/sdks-master
        cd /var
        echo "Extracting Sdk..."
        mv /var/sdks-master/iPhoneOS11.2.sdk $THEOS/sdks
        rm -r /var/sdks-master
        break;;
        [Nn]* ) exit 1;;
        * ) echo "Please answer yes or no.";;
    	esac
	done
	update-theos
	echo "Done!"
	exit 0

elif [[ $1 == sdks ]]; then
	while true; do
    	read -p "Please Choose Sdk : 
  S : Sdk 9.3
  D : Sdk 10.3 (for 64bit only)
  K : Sdk 11.2 (for 64bit only)
  N : Abort
:" sdk
      case $sdk in
        [Ss]* ) echo "Downloading Sdk 9.3 ..."
        git clone -q git://github.com/theos/sdks /var/sdks-master
        cd /var
        echo "Extracting Sdk..."
        mv /var/sdks-master/iPhoneOS9.3.sdk $THEOS/sdks
        cp /var/sdks-master/iPhoneOS10.3.sdk/usr/lib/system/liblaunch.tbd /usr/lib/system
        rm -r /var/sdks-master
        break;;
        [Dd]* ) echo "Downloading Sdk 10.3 ..."
        git clone -q git://github.com/theos/sdks /var/sdks-master
        cd /var
        echo "Extracting Sdk..."
        mv /var/sdks-master/iPhoneOS10.3.sdk $THEOS/sdks
        rm -r /var/sdks-master
        break;;
        [Kk]* ) echo "Downloading Sdk 11.2 ..."
        git clone -q git://github.com/theos/sdks /var/sdks-master
        cd /var
        echo "Extracting Sdk..."
        mv /var/sdks-master/iPhoneOS11.2.sdk $THEOS/sdks
        rm -r /var/sdks-master
        break;;
        [Nn]* ) exit 1;;
        * ) echo "Please answer yes or no.";;
    	esac
	done
update-theos
echo "Done!"
exit 0

fi

if [[ $# == 2 ]] && [[ ( $1 == un || $2 == un ) ]]; then
	while true; do
    		read -p "Please Choose Your Device Arch : 
  32 : 32bit
  64 : 64bit
  N  : Abort
:" un
      	case $un in
      	[32]* ) echo "Uninstalling Theos and everything..."
      	apt-get -y remove com.moose.theosinst org.coolstar.perl org.coolstar.llvm-clang32 git org.coolstar.cctools
      	apt-get autoremove
      	rm -r /var/theos
      	break;;
      	[64]* )
      	echo "Uninstalling Theos and everything..."
      	apt-get -y remove com.moose.theosinst perl git odcctools clang clang-10
      	apt-get autoremove
      	rm -r /var/theos
      	break;;
      	 [Nn]* ) exit 1;;
        * ) echo "Please answer yes or no.";;
    	esac
	done
echo "Done!, Thanks mate!"
echo "your phone will respring..."
uicache
killall -9 backboardd

elif [[ $1 == un ]]; then
	while true; do
    		read -p "Please Choose Your Device Arch : 
  32 : 32bit
  64 : 64bit
  N  : Abort
:" un
      case $un in
      	[32]* ) echo "Uninstalling Theos and everything..."
      	apt-get -y remove com.moose.theosinst org.coolstar.perl org.coolstar.llvm-clang32 git org.coolstar.cctools > /dev/null 2>&1
      	apt-get autoremove
      	rm -r /var/theos
      	break;;
      	[64]* )
      	echo "Uninstalling Theos and everything..."
      	apt-get -y remove com.moose.theosinst perl git odcctools clang clang-10 > /dev/null 2>&1
      	apt-get autoremove
      	rm -r /var/theos
      	break;;
      	 [Nn]* ) exit 1;;
        * ) echo "Please answer yes or no.";;
    	esac
	done
echo "Done!, Thanks mate!"
echo "your phone will respring..."
uicache
killall -9 backboardd

fi

echo -n -e "..."
   sleep 1
   echo -n -e "
..."
   sleep 1;
   echo -n -e "
..."
   echo -n -e "
"
   sleep 1;
   
arch32="32"
arch64="64"
if [[ ( $1 == $arch32 || $2 == $arch32 ) ]] && [[ $# == 3 ]]; then
	echo "Download & Install Dependencies..."
	cp /var/mobile/Library/Caches/com.saurik.Cydia/sources.list /var/sources.list
	awk '{gsub("deb https://apt.bingner.com/ ./", "");print}' /var/mobile/Library/Caches/com.saurik.Cydia/sources.list > sources.list && mv sources.list /var/mobile/Library/Caches/com.saurik.Cydia
	apt-get -y install org.coolstar.cctools
	apt-get -y install git
	mv /var/sources.list /var/mobile/Library/Caches/com.saurik.Cydia
	echo "..."
	apt-get update  > /dev/null 2>&1
	curl -o /var/clang.deb http://apt.thebigboss.org/repofiles/cydia/debs2.0/llvm-clang32_3.7.1-2.deb
	dpkg -i /var/clang.deb
	rm /var/clang.deb
	echo 'deb https://coolstar.org/publicrepo/ ./'>/etc/apt/sources.list.d/coolstar.list
	apt-get update > /dev/null 2>&1
	apt-get install -y --force-yes org.coolstar.perl
	rm /etc/apt/sources.list.d/coolstar.list
	apt-get update > /dev/null 2>&1
elif [[ ( $1 == $arch64 || $2 == $arch64 ) ]] && [[ $# == 3 ]]; then
	echo "Download & Install Dependencies..."
	apt-get -y install git
	apt-get -y install ldid
	apt-get -y install odcctools
	apt-get -y install clang
	apt-get -y install clang-10
	apt-get -y install perl
	apt-get -y -f install
	
else
	if [[ $1 == $arch32 ]] && [[ $# == 2 ]]; then
		echo "Download & Install Dependencies..."
		cp /var/mobile/Library/Caches/com.saurik.Cydia/sources.list /var/sources.list
		awk '{gsub("deb https://apt.bingner.com/ ./", "");print}' /var/mobile/Library/Caches/com.saurik.Cydia/sources.list > sources.list && mv sources.list /var/mobile/Library/Caches/com.saurik.Cydia
		apt-get -y install org.coolstar.cctools > /dev/null 2>&1
		apt-get -y install git > /dev/null 2>&1
		mv /var/sources.list /var/mobile/Library/Caches/com.saurik.Cydia
		apt-get update > /dev/null 2>&1
		curl -o /var/clang.deb http://apt.thebigboss.org/repofiles/cydia/debs2.0/llvm-clang32_3.7.1-2.deb > /dev/null 2>&1
		dpkg -i /var/clang.deb > /dev/null 2>&1
		rm /var/clang.deb
		echo 'deb https://coolstar.org/publicrepo/ ./'>/etc/apt/sources.list.d/coolstar.list
		apt-get update > /dev/null 2>&1
		apt-get -y --force-yes install org.coolstar.perl > /dev/null 2>&1
		rm /etc/apt/sources.list.d/coolstar.list
		apt-get update > /dev/null 2>&1
		
	elif [[ $1 == $arch64 ]] && [[ $# == 2 ]]; then
		echo "Download & Install Dependencies..."
		apt-get -y install git > /dev/null 2>&1
		apt-get -y install ldid > /dev/null 2>&1
		apt-get -y install odcctools > /dev/null 2>&1
		apt-get -y install clang > /dev/null 2>&1
		apt-get -y install clang-10 > /dev/null 2>&1
		apt-get -y install perl > /dev/null 2>&1
		apt-get -y -f install > /dev/null 2>&1
		
	fi
fi
echo "Done!"
	
if [ ! -f /usr/bin/perl ]; then
	ln -sf /usr/local/bin/perl /usr/bin/perl
fi

if [[ $# == 2 ]]; then
	echo "Installing theos..."
	rm -r /var/theos > /dev/null 2>&1
	git clone -q git://github.com/theos/theos /var/theos
else
	echo "Installing theos..."
	rm -r /var/theos > /dev/null 2>&1
	git clone git://github.com/theos/theos /var/theos
	
fi

cd $THEOS

if [[ $# == 2 ]]; then
	echo "Updating Theos..."
	git submodule init
	echo "Cloning into theos/dm.pl"
	git clone -q git://github.com/theos/dm.pl.git $THEOS/dm.pl
	echo "Cloning into theos/vendor/dm.pl"
	git clone -q git://github.com/theos/dm.pl.git $THEOS/vendor/dm.pl
	echo "Cloning into theos/vendor/headers"
	git clone -q git://github.com/theos/headers.git $THEOS/vendor/headers
	echo "Cloning into theos/vendor/include"
	git clone -q git://github.com/theos/headers.git $THEOS/vendor/include
	echo "Cloning into theos/vendor/lib"
	git clone -q git://github.com/theos/lib.git $THEOS/vendor/lib
	echo "Cloning into theos/vendor/logos"
	git clone -q git://github.com/theos/logos.git $THEOS/vendor/logos
	echo "Cloning into theos/vendor/nic"
	git clone -q git://github.com/theos/nic.git $THEOS/vendor/nic
	echo "Cloning into theos/vendor/templates"
	git clone -q git://github.com/theos/templates.git $THEOS/vendor/templates
	rm -rf $THEOS/lib
	rm -rf $THEOS/include
	ln -sf $THEOS/vendor/lib $THEOS/lib
	ln -sf $THEOS/vendor/include $THEOS/include
else
	echo "Updating Theos..."
	git submodule init
	git clone git://github.com/theos/dm.pl.git $THEOS/dm.pl
	git clone git://github.com/theos/dm.pl.git $THEOS/vendor/dm.pl
	git clone git://github.com/theos/headers.git $THEOS/vendor/headers
	git clone git://github.com/theos/headers.git $THEOS/vendor/include
	git clone git://github.com/theos/lib.git $THEOS/vendor/lib
	git clone git://github.com/theos/logos.git $THEOS/vendor/logos
	git clone git://github.com/theos/nic.git $THEOS/vendor/nic
	git clone git://github.com/theos/templates.git $THEOS/vendor/templates
	rm -rf $THEOS/lib
	rm -rf $THEOS/include
	ln -sf $THEOS/vendor/lib $THEOS/lib
	ln -sf $THEOS/vendor/include $THEOS/include
	
fi
echo "Done!"

s="9.3"
d="10.3"
k="11.2"
while true; do
    read -p "Do you wish to download Sdk? [y/nah, i’ll do later]: " yn
    case $yn in
        [Yy]* ) if [[ $# == 2 ]] && [[ $2 == $s ]]; then
        echo "Downloading Sdk..."
        git clone -q git://github.com/theos/sdks /var/sdks-master
        cd /var
        echo "Extracting Sdk..."
        mv /var/sdks-master/iPhoneOS9.3.sdk $THEOS/sdks
        cp /var/sdks-master/iPhoneOS10.3.sdk/usr/lib/system/liblaunch.tbd /usr/lib/system
        rm -r /var/sdks-master
        
        elif [[ $# == 2 ]] && [[ $2 == $d ]]; then
        echo "Downloading Sdk..."
        git clone -q git://github.com/theos/sdks /var/sdks-master
        cd /var
        echo "Extracting Sdk..."
        mv /var/sdks-master/iPhoneOS10.3.sdk $THEOS/sdks
        rm -r /var/sdks-master
        
        elif [[ $# == 2 ]] && [[ $2 == $k ]]; then
        echo "Downloading Sdk..."
        git clone -q git://github.com/theos/sdks /var/sdks-master
        cd /var
        echo "Extracting Sdk..."
        mv /var/sdks-master/iPhoneOS11.2.sdk $THEOS/sdks
        rm -r /var/sdks-master
        
        else
        	if [[ $# == 3 ]] && [[ $3 == $s ]]; then
        		echo "Downloading Sdk..."
        		git clone git://github.com/theos/sdks /var/sdks-master
        		cd /var
      	  		echo "Extracting Sdk..."
        		mv /var/sdks-master/iPhoneOS9.3.sdk $THEOS/sdks
        		cp /var/sdks-master/iPhoneOS10.3.sdk/usr/lib/system/liblaunch.tbd /usr/lib/system
        		rm -r /var/sdks-master
        			
        	elif [[ $# == 3 ]] && [[ $3 == $d ]]; then
        		echo "Downloading Sdk..."
        		git clone git://github.com/theos/sdks /var/sdks-master
        		cd /var
        		echo "Extracting Sdk..."
        		mv /var/sdks-master/iPhoneOS10.3.sdk $THEOS/sdks
        		rm -r /var/sdks-master
        				
        	elif [[ $# == 3 ]] && [[ $3 == $k ]]; then
        		echo "Downloading Sdk..."
        		git clone git://github.com/theos/sdks /var/sdks-master
        		cd /var
        		echo "Extracting Sdk..."
        		mv /var/sdks-master/iPhoneOS11.2.sdk $THEOS/sdks
        		rm -r /var/sdks-master
		fi
fi
     break;;
        [Nn]* ) echo "Done!"
echo "Note : “you can download sdk with 'sdks' opt.”"
$THEOS/bin/update-theos
echo -n "..."
sleep 1;
echo -n -e "
..."
sleep 1;
echo -n -e "
..."
sleep 1;
echo "
Successful!"
exit 0 ;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo "Done!"
$THEOS/bin/update-theos
echo -n "..."
sleep 1;
echo -n -e "
..."
sleep 1;
echo -n -e "
..."
sleep 1;
echo "
Successful!"
