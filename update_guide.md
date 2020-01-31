#Updating from 0.5.x to 0.6.x Instructions#

** Lots of changes, so it is just best to start over, sort of. **

A clean install is required, so I recommend the following proceedures:

**Begginner**

* Login to webserver. (FTP is recommended method. SSH is fine if you are skilled in the SSH Arts. I would not use composer update method.)
* Navigate to your /roundcube_directory/plugins
* Rename folders/directories calendar, libcalendaring and libkolab (if present) to calendar2, libcalendaring2 and libkolab2 (if present)
* Downlaod the latest [commit](https://github.com/texxasrulez/Caldav_Calendar/archive/master.zip) for Caldav_Calendar.
* Unzip contents
* Upload the the folders calendar, libcalendaring and libkolab to /roundcube_directory/plugins/
* Navigate to /roundcube_directory/plugins/ and rename config.inc.php.dist to config.inc.php and edit the URL's within config to match your Domain and Nextcloud install direcotry name as well as customize the many variables to your preferrence
* Login to your sql server and backup the tables caldav_attachments, caldav_calendars and caldav_events under your roundcube database
* If you do not want to redo attachments or invitations manually, skip next step (This potentially can cause issues, the risk is low)
* TRUNCATE the tables caldav_attachments, caldav_calendars and caldav_events within your roundcube database
* Login to Roundube like normal, click on Calendar Tab and give it 15-30 seconds to resync, and then BOOM - Should be repopulated with your calendars and events
* If you care what color your calenders are, you can edit calendar color accordingly within Roundcube Calendar GUI at anytime, so skip next step
* Go back to your SQL terminal and import into database `UPDATE caldav_calendars SET color = substring(MD5(RAND()), -6);` to assign radmon colors after initial sync of calendars
* Logout of your SQL server. (Just a friendly reminder)
* You are done ... Enjoy



**Expert**
* delete calendar, libcalendaring and libkolab (if there) directories
* install it
* enjoy

Now, if anyone finds this plugin handy or helpful or just want to help out someone. Buy me a coffe .. 

You can faciliate the purchase of that cup of coffee by Zelle 'ing whatever amount you can afford and would like to contribute to texxasrulez@yahoo.com
No Zelle, no problem

<form action="https://www.paypal.com/cgi-bin/webscr" method="post"  target="_blank">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----
">
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form>

