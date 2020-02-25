# Detailed Manual Installation Instructions

These instructions depend on the fact that Roundcube and Nextcloud have been installed, configured and confirmed running smoothly. \
The Plugin requires that users pre-exist for Nextcloud with **IDENTICAL** usernames and passwords used for their Roundcube Login. \
The User must have logged in at least once to the Nextcloud GUI. Calendars are not created until the user logs in. \
If these requirements cannot be met, this plugin **WILL NOT WORK** for you.

* Login to your webserver. FTP is recommended method. SSH is fine if you are skilled in the SSH Arts. I would not use composer update method.
* Upload the folders named calendar, libcalendaring and libkolab to /roundcube_directory/plugins/ directory.
* Navigate to /roundcube_directory/plugins/calendar/config/ and rename config.inc.php.dist to config.inc.php.
* Edit the file config.inc.php and change domain.ltd to match your Fully Qualified Domain (FQDN). Ensure your Nextcloud install direcotry name matches the directory structure of URL's. To enhance your Calendar and make it your own, edit the many configurable variables, which is documented with explanations and examples to try and make it simple. **VERY IMPORTANT** Make sure to change "random_24_byte_string" to a random string of at least 24 characters and keep that safe.
* Login to your sql server and import SQL schemas located in /calendar/drivers/*/SQL/ folder to your roundcube database.
* Login to Roundube and click on Calendar Tab.Give it 15-30 seconds to sync, and **BOOM**. Your Calendar has been created in Roundcube and has populated itself with the events from your Nextcloud Calendar if you have events added. If not, then an empty calendar awaits it's destiny.
* If you have multiple calendars, they all import with the same color. If you want different colors for each calendar and care what color they are, you can edit calendar color accordingly within Roundcube Calendar GUI at anytime.
* If you don't care what colors your calendars are but do want them different colors, just import the following into your roundcue database: `UPDATE caldav_calendars SET color = substring(MD5(RAND()), -6);` You now have randmon colored calendars.
* BOOM!, You are done ... Enjoy!


**Expert**
* You got this ... :sunglasses:


:moneybag: **Donations** :moneybag:

If you use this plugin and would like to show your appreciation by buying me a cup of coffee, I surely would appreciate it. A regular cup of Joe is sufficient, but a Starbucks Coffee would be better ... \
Zelle (Zelle is integrated within many major banks Mobile Apps by default) - Just send to texxasrulez at yahoo dot com \
No Zelle in your banks mobile app, no problem, just click [Paypal](https://paypal.me/texxasrulez?locale.x=en_US) and I can make a Starbucks run ... \
If you got the skills to and would prefer to donate your time to this project, I welcome it and NEED it .. 

Feel free to suggest any additions, clarifications or modifications you feel are missing or inadequate.

Many Thanks and have a great day ...


