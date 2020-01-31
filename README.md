# Caldav Calendar Plugin for Roundcube

**IMPORTANT** If you are updating this plugin from < 0.5.x to 0.6.x, a clean install is required. Read the [Update Info](update_guide.md) page for details.

**Tested using:**
* Roundcube v1.4.2
* Nextcloud v18.0
* PHP v7.2.24
* MySQL Server v5.5.60

**Elastic Skin Support now available**

I forked this with the intent to make a working, out of the box, specific for Nextcloud, caldav enabled calendar to sync your Nextcloud events to a Roundcube Calendar which then can be managed from Roundcube and stay in sync with Nextcloud.

I will update this when needed by deprecated purposes or when Nextcloud changes their sabre version for as long as I can. I am currently dreaming of many other features, but would love some help on that.

This plugin is intended to be used with Nexcloud only at this point in time. The Calendar Plugin will sync already existing calendars from Nextcloud. If you want more than the default, you must add calendar within Nextcloud Calendar GUI and then go back to Roundcube and it will magically appear in your Roundcube Calendar GUI after a good refresh (F5). From Roundcube Calendar GUI, you can add, edit, delete, download, copy and add attachments to events. iTip invitations are succesfully sent, accepted, declined, etc upon inviting attendees ... 

This is also compatible with RCMCARDDAV 3.0.3 as I use it to sync my contacts with Nextcloud to Roundcube as well.

For Roundcube v1.3 and older download ver 0.4 here https://github.com/texxasrulez/Caldav_Calendar/releases/tag/0.4

_________________________________________________________________________________________

**Installation**

Installation is pretty straight forward. I wouldn't use composer to install, just download zip file from github and follow the directions below:

1. Copy/FTP/Upload calendar, libcalendaring and libkolab folders to Roundcube Plugin folder. 
2. Copy config.inc.php.dist to config.inc.php, located in root of calendar directory, and edit the following according to your requirements:
	* Change domain.ltd to your FQDN. 
	* If Nextcloud was installed using a custom directory, change /nextcloud/ in the URL structure to match the directory you installed in.
	* **IMPORTANT** - Change calendar_crypt_key to any random sequence of 24 characters.
	* There are many customizable variables whcih can be changed to your suite your needs.
3. Import the corresponding initial SQL schema(MySQL, Postgres) located in calendar/drivers/*/SQL/ folder to your roundcube database.
4. Add "calendar" to $config['plugins'] in your Roundcube main config file.
5. Login to Roundcube, click on the Calendar Tab, give it 15-30 seconds to do its thang and you should be good to go.

***VERY IMPORTANT***

Your username and password must be the same for Nextcloud and Roundcube to work properly.\
The Nextcloud account must be created and logged into at least once before calendar will sync.\
There are no plans at this time to implement different logins but will try in the future once my wishlist is whittled down a bit.\
In the meantime, create your users in Nextcloud using the exact username and password required to login to Roundcube.\
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

- [ ] Ability to add new calendar to Nextcloud from Roundcube Calendar GUI.
- [ ] Oauth support. (Probably will take me a month of Sundays as my skills aren't the best. :frowning_face:  ....  I need some help
- [ ] Assign random colors upon initial sync of calendars.
- [ ] Add sound notifications.
- [ ] Integrate a Caldav Enabled Tasklist plugin.
- [ ] Add Emoticon Support.
- [x] ~~Remove mcrypt and replace with openssl.~~ Thank you @MAT-WEISS-2017
* User feature requests are always welcome but I cannot guarantee if I can pull it off ... :relaxed:

**Random Color Quickie**

Multiple Calendars are created with the same color. To quickly get a random coloring scheme, just import the following into database `UPDATE caldav_calendars SET color = substring(MD5(RAND()), -6);` after initial sync of calendars.

**Submitting Issues**

Issue submissions are always welcome but I do ask that you provide as detailed info as you can so I can try to recreate the issue. What, how, why, where etc. No detail is too small to leave out. \
Roundcube logs, installed plugins and versions, Nextcloud logs and version, system logs, OS info, PHP Version with mods enabled and config and SQL Server Type and Version are also requested to be posted at time of issue submission. This will help me out tremendously and is highly recommended. \
Not supplying any of the previously requested info will not impact anyone personally, but it will delay any help I can offer you. Failure to supply requested information within a reasonable time frame from initial request will cause your issue to be closed with no resolution provided if I cannot recreate your issue. \
I appreciate your understanding and I do thank you ...

**Persistant Errors**

These 4 errors are persistant, albeit not too often, and show up in Roundcube's errors.log, always together, at the exact same time down to the second. They have no rhyme or reason for when they appear. 99% of the time when these do get logged, users will be unaware as the requested task will complete successfully. As far as I can tell, the first three errors has to do with line endings `\r\n` which I am working on. Once I clear the first 3, I will tackle the 4th. So far, no joy ..

* PHP Warning:  feof() expects parameter 1 to be resource, null given in /path_to_roundcube/plugins/calendar/lib/vendor/sabre/vobject/lib/Parser/MimeDir.php on line 245
* PHP Warning:  fgets() expects parameter 1 to be resource, null given in /path_to_roundcube/plugins/calendar/lib/vendor/sabre/vobject/lib/Parser/MimeDir.php on line 247
* PHP Warning:  feof() expects parameter 1 to be resource, null given in /path_to_roundcube/plugins/calendar/lib/vendor/sabre/vobject/lib/Parser/MimeDir.php on line 249
* PHP Error: iCal data parse error: Error reading from input stream in /path_to_roundcube/plugins/libcalendaring on line 163 (POST /mail/?_task=calendar&_action=refresh)

:moneybag: **Donations** :moneybag:

If you use this plugin and would like to show your appreciation by buying me a cup of coffee, I surely would appreciate it. A regular cup of Joe is sufficient, but a Starbucks Coffee would be better ... \
Zelle (Zelle is integrated within many major banks Mobile Apps by default) - Just send to texxasrulez at yahoo.com \
No Zelle in your banks mobile app, no problem, just click [Paypal](https://paypal.me/texxasrulez?locale.x=en_US) and I can make a Starbucks run ...

I appreciate the interest in this plugin and hope all the best ...