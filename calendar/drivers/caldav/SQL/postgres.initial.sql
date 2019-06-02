/**
 * CalDAV Client
 *
 * @version @package_version@
 * @author Hugo Slabbert <hugo@slabnet.com>
 *
 * Copyright (C) 2014, Hugo Slabbert <hugo@slabnet.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

CREATE SEQUENCE caldav_calendars_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE TABLE caldav_calendars (
  calendar_id int DEFAULT nextval('caldav_calendars_seq'::text) NOT NULL PRIMARY KEY,
  user_id int NOT NULL
    REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  name varchar(255) NOT NULL,
  color varchar(8) NOT NULL,
  showalarms smallint NOT NULL DEFAULT '1',
  caldav_url varchar(255) NOT NULL,
  caldav_tag varchar(255) DEFAULT NULL,
  caldav_user varchar(255) DEFAULT NULL,
  caldav_pass varchar(1024) DEFAULT NULL,
  caldav_oauth_provider varchar(255) DEFAULT NULL,
  readonly smallint NOT NULL DEFAULT 0,
  caldav_last_change timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX caldav_user_name_idx ON caldav_calendars (user_id, name);

CREATE SEQUENCE caldav_events_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE TABLE caldav_events (
  event_id int DEFAULT nextval('caldav_events_seq'::text) NOT NULL PRIMARY KEY,
  calendar_id int NOT NULL
    REFERENCES caldav_calendars(calendar_id) ON DELETE CASCADE ON UPDATE CASCADE,
  recurrence_id int NOT NULL DEFAULT 0,
  uid varchar(255) NOT NULL,
  instance varchar(16) NOT NULL DEFAULT '',
  isexception smallint NOT NULL DEFAULT 0,
  created timestamp with time zone DEFAULT now() NOT NULL,
  changed timestamp with time zone DEFAULT now() NOT NULL,
  sequence int NOT NULL DEFAULT 0,
  "start" timestamp with time zone DEFAULT now() NOT NULL,
  "end" timestamp with time zone DEFAULT now() NOT NULL,
  recurrence varchar(255) DEFAULT NULL,
  title varchar(255) NOT NULL,
  description text NOT NULL,
  location varchar(255) NOT NULL DEFAULT '',
  categories varchar(255) NOT NULL DEFAULT '',
  url varchar(255) NOT NULL DEFAULT '',
  all_day smallint NOT NULL DEFAULT 0,
  free_busy smallint NOT NULL DEFAULT 0,
  priority smallint NOT NULL DEFAULT 0,
  sensitivity smallint NOT NULL DEFAULT 0,
  status varchar(32) NOT NULL DEFAULT '',
  alarms text NULL DEFAULT NULL,
  attendees text DEFAULT NULL,
  notifyat timestamp DEFAULT NULL,
  caldav_url varchar(255) NOT NULL,
  caldav_tag varchar(255) DEFAULT NULL,
  caldav_last_change timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX caldav_uid_idx ON caldav_events (uid);
CREATE INDEX caldav_recurrence_idx ON caldav_events (recurrence_id);
CREATE INDEX caldav_calendar_notify_idx ON caldav_events (calendar_id,notifyat);

CREATE SEQUENCE caldav_attachments_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE TABLE caldav_attachments (
  attachment_id int DEFAULT nextval('caldav_attachments_seq'::text) NOT NULL PRIMARY KEY,
  event_id int NOT NULL
    REFERENCES caldav_events(event_id) ON DELETE CASCADE ON UPDATE CASCADE,
  filename varchar(255) NOT NULL DEFAULT '',
  mimetype varchar(255) NOT NULL DEFAULT '',
  size int NOT NULL DEFAULT 0,
  data text NOT NULL
);

CREATE INDEX caldav_attachments_event_id_idx ON caldav_attachments (event_id);

INSERT INTO "system" (name, value) VALUES ('calendar-caldav-version', '2017010100');
