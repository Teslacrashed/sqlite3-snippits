-- vim: set filetype=sql:
-- Order of table-column declarations
-- Followed by the recommended suffix to add to constraint names
-- NOTE: While it's often recommended to prefix the constraint names, I prefer suffixing them for technical reasons
-- PRIMARY KEY _pk
-- NOT NULL    _nn
-- UNIQUE      _uk
-- CHECK       _ck
-- DEFAULT     _df
-- COLLATE
-- FOREIGN KEY _fk

-- datetime
-- The following sqlite build-in function is the closets to ISO-8601 standardized time.
-- Creates a 29 character long entry, down to milliseconds.
-- NOTE: datetimes should always be in UTC timezone, not local time, for meta data like:
-- created_at_datetime
-- updatedat_datetime
-- strftime('%Y-%m-%dT%H:%M:%f+00:00', 'now')

-- CHECK constraints
-- email check constraint formulas
-- Check for 3 characters before `@` & 3 characters after
-- CONSTRAINT [user_email_ck] CHECK ([email] LIKE '%___@___%')

-- Found on the net, seems to to a "better" validation for checking for valid characters and a domain
-- CONSTRAINT [user_email_ck] CHECK ([email] LIKE '^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$')

DROP TABLE IF EXISTS [user];

CREATE TABLE [user] (
	[id] INTEGER
		CONSTRAINT [user_pk] PRIMARY KEY AUTOINCREMENT
		NOT NULL,
	[email] VARCHAR(128)
		NOT NULL
		CONSTRAINT [user_email_uk] UNIQUE
		CONSTRAINT [user_email_valid_ck] CHECK ([email] REGEXP "^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$")
		COLLATE NOCASE,
	[password] VARCHAR(128)
		NOT NULL,
	[active] BOOLEAN
		NOT NULL
		CONSTRAINT [user_active_bool_ck] CHECK ([active] IN (0, 1))
		CONSTRAINT [user_active_df] DEFAULT ((1)),
	[authenticated] BOOLEAN
		NOT NULL
		CONSTRAINT [user_authenticated_bool_ck] CHECK ([authenticated] IN (0, 1))
		CONSTRAINT [user_authenticated_df] DEFAULT ((1)),
	[login_count] INTEGER
		NOT NULL
		CONSTRAINT [user_login_count_df] DEFAULT ((0)),
	[created_at_datetime] DATETIME
		NOT NULL
		CONSTRAINT [user_created_at_datetime_df] DEFAULT (strftime('%Y-%m-%dT%H:%M:%f+00:00', 'now')),
	[updated_at_datetime] DATETIME
		NOT NULL
		CONSTRAINT [user_updated_at_datetime_df] DEFAULT (strftime('%Y-%m-%dT%H:%M:%f+00:00', 'now'))
);

INSERT INTO [user] ([id], [email], [password])
VALUES
	(1,'admin@localhost.com','admin'),
	(2,'first@gmail.com','first');
