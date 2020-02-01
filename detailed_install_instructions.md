# Detailed Manual Installation Instructions

These instructions require that Roundcube and Nextcloud have been installed and running. The Plugin requires that users must pre-exist for Nextcloud with IDENTICAL usernames and passwords used for their Roundcube Login and have logged in at least once to the Nextcloud GUI so calendars will be created for that user. If these requirements cannot be met, this plugin WILL NOT WORK for you.

* Login to your webserver. FTP is recommended method. SSH is fine if you are skilled in the SSH Arts. I would not use composer update method.
* Upload the folders named calendar, libcalendaring and libkolab to /roundcube_directory/plugins/ directory.
* Navigate to /roundcube_directory/plugins/calendar/config/ and rename config.inc.php.dist to config.inc.php.
* Edit the file config.inc.php and change the URL's within config to match your Fully Qualified Domain (FQDN) and Nextcloud install direcotry name. Edit the many configurable variables, which is documented with explanations and examples, to tailer your GUI to better suite your requirements. **VERY IMPORTANT** Make sure to change random_24_byte_string to a random string of atleast 24 characters and keep that safe.
* Login to your sql server and import SQL schemas located in the folders /calendar/drivers/*/SQL/ folder to your roundcube database.
* Login to Roundube like normal, click on Calendar Tab and give it 15-30 seconds to sync, and then BOOM - Your Calendar has been created in Roundcube and has populated itself with the events from your Nextcloud Calendar if you have events added. 
* If you care what color your calenders are, you can edit calendar color accordingly within Roundcube Calendar GUI at anytime, so skip next step
* Go back to your SQL terminal and import into database `UPDATE caldav_calendars SET color = substring(MD5(RAND()), -6);` to assign randmon colors after initial sync of calendars
* Logout of your SQL server. (Just a friendly reminder)
* If all works well, delete the directories calendar2, libcalendaring2 and libkolab2 (if present) from your /roundcube_directory/plugins/ directory. Logout of your FTP/SSH Client and ... BOOM!, You are done ... Enjoy


**Expert**
* Downlaod Latest [Release](https://github.com/texxasrulez/caldav_calendar_te/releases/latest) or Latest [Commit](https://github.com/texxasrulez/caldav_calendar_te/archive/master.zip) , Dealers Choice
* delete calendar, libcalendaring and libkolab (if there) directories 
* Do yo thang
* Enjoy


:moneybag: **Donations** :moneybag:

If you use this plugin and would like to show your appreciation by buying me a cup of coffee, I surely would appreciate it. A regular cup of Joe is sufficient, but a Starbucks Coffee would be better ... \
Zelle (Zelle is integrated within many major banks Mobile Apps by default) - Just send to texxasrulez at yahoo dot com \
No Zelle in your banks mobile app, no problem, just click [Paypal](https://paypal.me/texxasrulez?locale.x=en_US) and I can make a Starbucks run ... \
If you got the skills to and would prefer to donate your time to this project, I welcome it and NEED it .. 

Many Thanks and have a great day ...

