# Caldav Calendar Plugin for Roundcube - Texas Edition

**IMPORTANT** If you are updating this plugin from versions prior to and including 0.5.1 to 0.6.x, a clean install is highly recommended. Read the [Update Info](update_guide.md) page for details.

**Tested and working using the following:**
* Roundcube v 1.4.2
* Nextcloud v 18.0
* PHP v 7.2.24
* MySQL Server v 5.5.60

**Elastic Skin Support now available**

I forked this with the intent to make a working, out of the box caldav enabled calendar for exclusive use with Nextcloud.

I will maintain this repo for as long as I can.

This plugin is intended to be used with Nexcloud only at this point in time. The Calendar Plugin will sync already existing calendars from Nextcloud. If you want more than the default, you must add calendar within Nextcloud Calendar GUI and then go back to Roundcube and it will magically appear in your Roundcube Calendar GUI after a good refresh (F5). From Roundcube Calendar GUI, you can add, edit, delete, download, copy and add attachments to events. iTip invitations are succesfully sent, accepted, declined, etc upon inviting attendees ... 

This is also compatible with RCMCARDDAV 3.0.3 as I use it to sync my contacts from Nextcloud to Roundcube as well.

For Roundcube v1.3.x and older download ver [0.4](https://github.com/texxasrulez/caldav_calendar_te/releases/tag/0.4)


**Installation** More Detailed instructions for [Beginners](detailed_install_instructions.md)

Installation is pretty straight forward. I wouldn't use composer to install, just download zip file of the latest release or most current commit from github and follow the directions below:

1. Copy/FTP/Upload calendar, libcalendaring and libkolab folders to Roundcube Plugin folder. 
2. Copy config.inc.php.dist to config.inc.php, located in root of calendar directory, and edit the following according to your requirements:
	* Change domain.ltd to your FQDN. 
	* If Nextcloud was installed using a custom directory, change /nextcloud/ in the URL structure to match the directory you installed in.
	* **IMPORTANT** - Change calendar_crypt_key to any random sequence of 24 characters.
	* There are many customizable variables whcih can be changed to your suite your needs.
3. Import the corresponding initial SQL schema (MySQL, Postgres) located in calendar/drivers/*/SQL/ folder to your roundcube database.
4. Add "calendar" to $config['plugins'] in your Roundcube main config file.
5. Login to Roundcube, click on the Calendar Tab, give it 15-30 seconds to do its thang and you should be good to go.

***VERY IMPORTANT***

Your username and password must be the same for Nextcloud and Roundcube to work properly.\
The Nextcloud account must be created and user must log into Nextcloud at least once before calendar will sync in Roundcube. Nextcloud does not create calendars until the initial login, so there will be no calendar for the Roundcube Calendar to find.\
There are no plans at this time to implement the use of different login usernames. \
There shouldn't be any issues if you create your users in Nextcloud using the exact username and password required to login to Roundcube. \
There are configurable parameters to alter your email for logins within Roundcube's config that may help you out if you require something a little different.

**Known Issues**

* There are 4 persistant errors being thrown in Roundcube errors.log. More info at bottom of this file.
* Will not create new calendar from Roundcube Calendar GUI.
* Recurring events marked as "All Day" displays a day early the following instance of it.
	* Workarounds for All Day Recurring Events issue:
		- Do not check the "All Day" box and there will be no issue. 
			- If you just have to have that box checked, do so and save it. Let Calendar refresh.
			- Then edit the event and uncheck the box and save it. Let Calendar refresh.
			- Then, one more time, edit the event and check that box again and save it. Let Calendar refresh.
			- It will then appear properly the next time it is scheduled and can be edited (as long as it is not the future instance you click to edit) and still display properly.

**Help Wanted**

If anyone would like to help maintain and develop more features, I would truly appreciate it.

**Wishlist**

- [ ] Add the ability to create new calendar within Roundcube Calendar GUI.
- [ ] Oauth support for a wider range of calendar choices. (Probably will take me a month of Sundays as my skills aren't the best. :frowning_face:  ....  I need some help
- [ ] Add a preview / agenda list in main Mail Tab within the left side column at the bottom.
- [ ] Assign random colors upon initial sync of calendars.
- [ ] Add sound notifications.
- [ ] Integrate a Caldav Enabled Tasklist plugin.
- [ ] Add Emoticon Support.
- [x] ~~Remove mcrypt and replace with openssl.~~ Thank you @MAT-WEISS-2017
* User feature requests are always welcome but I cannot guarantee if I can pull it off ... :relaxed:

**Random Color Quickie**

Multiple Calendars are created with the same color. To quickly get a random coloring scheme, just import the following into database `UPDATE caldav_calendars SET color = substring(MD5(RAND()), -6);` after initial sync of calendars.

**Submitting Issues**

Issue submissions are always welcome but I do ask that you read this [file](issue_submittal_readme.md) first. \
I appreciate your understanding and I do thank you ...

**Persistant Errors**

These 4 errors are persistant, albeit not too often, and show up in Roundcube's errors.log, always together, at the exact same time down to the second. They have no rhyme or reason for when they appear. 99% of the time when these do get logged, users will be unaware as the requested task will complete successfully. As far as I can tell, the first three errors has to do with line endings `\r\n` which I am working on. Once I clear the first 3, I will tackle the 4th. So far, no joy ..

* PHP Warning:  feof() expects parameter 1 to be resource, null given in /path_to_roundcube/plugins/calendar/lib/vendor/sabre/vobject/lib/Parser/MimeDir.php on line 245
* PHP Warning:  fgets() expects parameter 1 to be resource, null given in /path_to_roundcube/plugins/calendar/lib/vendor/sabre/vobject/lib/Parser/MimeDir.php on line 247
* PHP Warning:  feof() expects parameter 1 to be resource, null given in /path_to_roundcube/plugins/calendar/lib/vendor/sabre/vobject/lib/Parser/MimeDir.php on line 249
* PHP Error: iCal data parse error: Error reading from input stream in /path_to_roundcube/plugins/libcalendaring on line 163 (POST /mail/?_task=calendar&_action=refresh)

:moneybag: **Donations** :moneybag:

If you use this plugin and would like to show your appreciation by buying me a cup of coffee, I surely would appreciate it. A regular cup of Joe is sufficient, but a Starbucks Coffee would be better ... \
Zelle (Zelle is integrated within many major banks Mobile Apps by default) - Just send to texxasrulez at yahoo dot com \
No Zelle in your banks mobile app, no problem, just click [Paypal](https://paypal.me/texxasrulez?locale.x=en_US) and I can make a Starbucks run ...

I appreciate the interest in this plugin and wish nothing but the best for all ...