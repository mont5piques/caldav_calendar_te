I made this as a working, out of the box, calendar for use with Nextcloud (Version 16 is the latest known working).

I will update this when needed by deprecated purposes or when Nextcloud changes their sabre version.

This is a fork of Kolab and FasterIT calendars combining the best of both and using the sabre from Nextcloud to work with it's version of sabre. It will sync already existing calendars. If you want more than the default, you must add calendar within Nextcloud
and then go back to Roundcube and it should be there. From Roundcube, you can add, edit and delete events and will be in sync
with Nextcloud.

This is also compatible with RCMCARDDAV 3.0.3 as I use it to sync my contacts with Nextcloud to Roundcube as well.

This was tested using Roundcube 1.4-RC1 and PHP 7.2.11.

_________________________________________________________________________________________

Installation is pretty straight forward.

Copy calendar and libcalendaring folders to Roundcube Plugin folder, copy config.inc.php.dist to config.inc.php, located in root of calendar directory, and change domain.ltd to your URL. 'These URL's are already configured for the default calendar url for Nextcloud.'

Import sql schemas located in /driver/ folders to your database.

Add "calendar" to $config['plugins'] in your Roundcube main config file and you are set.

***IMPORTANT***

Your username and password must be the same for Nextcloud and Roundcube to work properly.

Known Issues:
-------
* Incompatible libcalendaring with Tasklist (WIP to make compatible)
* Will not create new calendar.
* ~~Itip does not send reply to event organizer using RC1.3. Works in RC1.2.4.~~ Fixed!!!!
* ~~Recurring events marked as "All Day Events" will be a day early the following years.~~ Fixed!!!!
* ~~Database driver does not work. Birthdays are the issue due to being all day.~~ Fixed!!!

User Discovered Issues:
-------
* ~~Check Calendar shows Error 500.~~ Fixed!!!!

If anyone would like to help out to make oauth work and other features, I would appreciate it.

TODO:
-------
* Ability to add new calendar to Nextcloud from Roundcube Calendar GUI.
* Oauth support. (TBD. My skills aren't the best. :-(  ....  I need some help)
* Assign random colors to autodiscover calendars.
* ~~Remove mcrypt and replace with openssl.~~ Fixed!!!!

Random Color Quickie:
-------
* Multiple Calendars saved with same color. (Import into database `UPDATE caldav_calendars SET color = substring(MD5(RAND()), -6);` to assign radmon colors after initial sync of calendars)

Issue submitting:
-------
I will only accept geuine issues using Roundcube and Nextcloud running on a dedicated server (No VM's, cross domains or Dockers ... Sorry  :-(  ) ....
This was forked for use with Nextcloud only. I wished I had the time to make it work for all but real life says otherwise.
