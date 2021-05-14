### YTFetch                                                                                                     
 
#### A simple script to automatically download YouTube channels and playlists.
 
NOTE: This is a work in progress, and may not work as intended.
This means that YTFetch is not ready for production use.
 
Features
--------

* Download channels and playlists
* Categorize them into their own directories
* Can be run by cron
 
Dependencies
------------
 
YTFetch has been tested to run on the following:
 
* OpenBSD
* GNU/Linux
 
YTFetch requires the following to be installed on the system:
 
* curl (May add wget compatibility in the future)
* youtube-dl
 
Installation
------------
 
YTFetch currently has no official method of installation.
For now, you may run it wherever you choose.
 
One way you can install YTFetch globally is to issue the following command:
 
    # cp ytfetch.sh /usr/local/bin
 
You can instead use /usr/bin if you prefer.
 
 
Usage
-----
 
To add channels and/or playlists for downloading, edit the URL file at Default directory:
        
    ~/.config/ytfetch/urls
 
Then run
    
    $ ./ytfetch.sh
 
OR run (If you have installed ytfetch to a directory within your $PATH):
    
    $ ytfetch.sh
 
Changelog
---------
0.0.1a - Initial Release

