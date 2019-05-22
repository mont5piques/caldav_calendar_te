/**
 * CalDAV Client
 *
 * @version @package_version@
 * @author Hugo Slabbert <hugo@slabnet.com>
 * @author Daniel Meister <daniel@meisch.ch>
 *
 * based on initial version by Hugo Slabbert <hugo@slabnet.com>
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

CREATE TABLE IF NOT EXISTS caldav_calendars (
    calendar_id integer DEFAULT nextval('caldav_calendars_seq'::regclass) NOT NULL,
    user_id integer NOT NULL
        REFERENCES users (user_id) ON UPDATE CASCADE ON DELETE CASCADE,
    "name" varchar(255) NOT NULL,
    color varchar(8) NOT NULL,
    showalarms smallint NOT NULL DEFAULT 1,
    readonly smallint NOT NULL DEFAULT 1,

  caldav_url varchar(255) NOT NULL,
  caldav_tag varchar(255) DEFAULT NULL,
  caldav_user varchar(255) DEFAULT NULL,
  caldav_pass varchar(1024) DEFAULT NULL,
  caldav_last_change timestamp without time zone DEFAULT now() NOT NULL,
  caldav_oauth_provider varchar(255) DEFAULT NULL,

  PRIMARY KEY (calendar_id)
);
CREATE INDEX caldav_calendars_user_id_idx ON caldav_calendars (user_id, name);


CREATE SEQUENCE caldav_events_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE TABLE IF NOT EXISTS caldav_events (
    event_id integer DEFAULT nextval('caldav_events_seq'::regclass) NOT NULL,
    calendar_id integer NOT NULL
        REFERENCES caldav_calendars (calendar_id) ON UPDATE CASCADE ON DELETE CASCADE,
    recurrence_id integer NOT NULL DEFAULT 0,
    uid varchar(255) NOT NULL DEFAULT '',
    instance varchar(16) NOT NULL DEFAULT '',
    isexception smallint NOT NULL DEFAULT '0',
    created timestamp without time zone DEFAULT now() NOT NULL,
    changed timestamp without time zone DEFAULT now(),
    sequence integer NOT NULL DEFAULT 0,
    "start" timestamp without time zone DEFAULT now() NOT NULL,
    "end" timestamp without time zone DEFAULT now() NOT NULL,
    recurrence varchar(255) DEFAULT NULL,
    title character varying(255) NOT NULL DEFAULT '',
    description text NOT NULL DEFAULT '',
    location character varying(255) NOT NULL DEFAULT '',
    categories character varying(255) NOT NULL DEFAULT '',
    url character varying(255) NOT NULL DEFAULT '',
    all_day smallint NOT NULL DEFAULT 0,
    free_busy smallint NOT NULL DEFAULT 0,
    priority smallint NOT NULL DEFAULT 0,
    sensitivity smallint NOT NULL DEFAULT 0,
    status character varying(32) NOT NULL DEFAULT '',
    alarms text DEFAULT NULL,
    attendees text DEFAULT NULL,
    notifyat timestamp without time zone DEFAULT NULL,

  caldav_url varchar(255) NOT NULL,
  caldav_tag varchar(255) DEFAULT NULL,
  caldav_last_change timestamp without time zone DEFAULT now() NOT NULL,

  PRIMARY KEY(event_id)
);
CREATE INDEX caldav_events_calendar_id_notifyat_idx ON caldav_events (calendar_id, notifyat);
CREATE INDEX caldav_events_uid_idx ON caldav_events (uid);
CREATE INDEX caldav_events_recurrence_id_idx ON caldav_events (recurrence_id);


CREATE SEQUENCE caldav_attachments_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE TABLE IF NOT EXISTS caldav_attachments (
    attachment_id integer DEFAULT nextval('caldav_attachments_seq'::regclass) NOT NULL,
    event_id integer NOT NULL
        REFERENCES caldav_events (event_id) ON DELETE CASCADE ON UPDATE CASCADE,
    filename varchar(255) NOT NULL DEFAULT '',
    mimetype varchar(255) NOT NULL DEFAULT '',
    size integer NOT NULL DEFAULT 0,
    data text NOT NULL DEFAULT '',
    PRIMARY KEY (attachment_id)
);
CREATE INDEX caldav_attachments_user_id_idx ON caldav_attachments (event_id);


INSERT INTO system (name, value) VALUES ('calendar-caldav-version', '2015022700');


CREATE OR REPLACE FUNCTION upd_timestamp() RETURNS TRIGGER 
LANGUAGE plpgsql
AS
$$
BEGIN
    NEW.caldav_last_change = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;

CREATE TRIGGER update_timestamp_calendars
  BEFORE INSERT OR UPDATE
  ON caldav_calendars
  FOR EACH ROW
  EXECUTE PROCEDURE upd_timestamp();
CREATE TRIGGER update_timestamp_events
  BEFORE INSERT OR UPDATE
  ON caldav_events
  FOR EACH ROW
  EXECUTE PROCEDURE upd_timestamp();