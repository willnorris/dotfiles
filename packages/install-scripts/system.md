Notes as I setup my new computer.  I'm sure I'll end up having to do this again
some day, so having some notes may be good.
 
I've been having a lot of stability issues with my current machine, so I'm not
going to setup the new machine using Time Machine.  I'll copy a lot of files
over manually I'm sure, but I'm going to try and do as much manual setup as
possible to make sure I don't bring over any baggage. 
 
 
## System Level Stuff ##

 1. Do clean install of OS X, since I don't need the printer drivers, language packs, and such.  (this saves a good 4+ GB or so) (about 30 minutes)
 1. Go through normal Mac setup.  Add MobileMe account, but choose not to migrate any data
 1. TimeMachine backup of machine as-is, since it might be cool to have backups all the way back to the beginning. (about 15-20 minutes)
 1. All Software Updates (there will certainly be more once I install all the iLife stuff)
 1. TimeMachine backup again
 1. Run Boot Camp Assistant, and designate 32 GB for Windows.  Install Windows, drivers, and updates (roughly 2 hours)
 1. TimeMachine backup again
 

## Basic Environment Setup ## 

 1. Install Secrets Preference Pane and get environment customized so I can work
 1. Install bluetooth mouse b/c the trackpad clicking is driving me a little crazy
 1. Configure Safari preferences (tabs, homepage, etc)
 1. Setup secure volume and copy over contents (should blog about this some time).  Add volume as login item
 1. Install 1Password and setup with existing keychain (both for passwords and software license keys).
 1. Setup Mail.app 
 	* to copy over local messages not on the IMAP server, I stopped Mail, restored the messages through Time Machine, deleted the Envelope Index, then started Mail again and let it rebuild the cache
 

## Setup Terminal ##

 1. Install Hex Color Picker
 1. Install SIMBL + TerminalColors
 1. svn cat http://willnorris.com/svn/homedir/setup | sh
 

## SSH ##

 1. Generate new SSH keys
 1. ssh localhost to add passphrase to keychain
 
Something about symlinking all the files on /Volumes/secure
 
Install Hazel and turn off Quarantine for Downloads folder
 
Install GD for PHP (http://www.kenior.com/macintosh/adding-gd-library-for-mac-os-x-leopard) 
 
Install Rootdir
 

## MySQL ##

 1. Download and install MySQL + PreferencePane
 1. load launchdaemon: sudo launchctl load /Library/LaunchDaemons/com.mysql.mysqld.plist
 1. change root password using:   mysqladmin -u root -p'oldpassword' password newpass
 1. import data
 
 
## MacPorts ##

Install MacPorts from source with: ./configure --prefix /opt/mp
Add /opt/mp/bin to the end of /etc/paths
see macports install script
 
 
## Install Applications ##

 - iLife
 - Password Assistant
 - growl
 - colloquy
 - slim battery monitor
 - unplugged preference pane 
 

<!-- vim: ft=markdown
-->
