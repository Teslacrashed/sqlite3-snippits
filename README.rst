=====================
SQLite3 Documentation
=====================

There's a constant struggle between keeping brevity and clarity.
Brevity is desirable to keep typing down, and keep long queries easy to read.
Clarity is desirable so if you're looking over something you haven't in a while, or someone new is looking at your data.

Be as methodical as possible when naming things.

There will always be times where it's okay or preferred to break conventions.
Just try to keep the most consistent methods of doing so.
You may want to always use lower case in table/column names, but maybe you are working with 401K information, so you use capital K

I prefer to use [] to surround identifier names (table names, column names, constraint names, etc)
I find it makes it easier to use find/replace without accidents / unintended consequences.

Naming Tables
-------------

Use singular-noun form.
Ex: user, not users.
Saves typing/space.

Two popular conventions exist for naming SQL objects (tables, columns, functions, triggers, etc)

snake_case
Use underscores between words.
Helps identifiers stand out clearly from keywords (i.e.: SELECT id, name_first FROM customers)
Pro: Easiest to read.
Con: Uses more space.
Examples:
  - customer
  - user
  - customer_address
  - user_role

PascalCase
Pro: Uses less space.
Con: Can be harder to read.
Examples:
  - CustomerAddress
  - UserRole

All-capitals looks horrendous.
All-capitals with underscores looks less horrendous but uses up even more screen space.

Refrain from usage of acronyms, as many things can share the same acronym.
Refrain from usage of abbreviations, as people do not always have the same idea for how to abbreviate words.

Naming Views
------------

Prefix view names with "vw_"
For views you may want to use plural-form nouns.
Commonly, you may want a simple view for your user table that only shows active users, so "vw_users" is a sensible name.
Just try to be consistent in why/how you use plurals, or any convention.
Examples:
  - vw_customers
  - vw_users

Naming Triggers
Prefix triggers with "tr_"
  - tr_user_update_login

Naming Table Column Constraints
-------------------------------

Many prefix table constraints in the identifier
For logical reasons involving searching a database, I prefer to suffix table constraints to the identifier

PRIMARY KEY [table_name_pk]
  - For the PRIMARY KEY column on table [user]
  - Ex: customer_pk
  - NOTE: Make sure to use the full word INTEGER, not INT, for SQLite3 to implement the built-in [sqlite_sequence] table/index
  - Ex: [id] INTEGER PRIMARY KEY AUTOINCREMENT
NOT NULL
  - SQLite3 does not recognize naming NOT NULL constraints.
  - You can add a CHECK that functionally performs the same task if you want.
  - Use suffix "_nn", table_name_column_name_nn
  - ex: CONSTRAINT [user_email_nn] ([email] IS NOT NULL)
UNIQUE [table_name_column_name_uk]
  - For an [email] column on table [user]
  - Ex: user_email_uk
CHECK        table_name_column_name_ck
  - for a valid email string check on [email] column on table [user]
  - Ex: user_email_valid_ck
DEFAULT [table_name_column_name_df]
  - For a default value on an [active] column on table [user]
  - Ex: user_active_bool_df
FOREIGN KEY [table_name_foreign_table_name_fk]
  - For FOREIGN KEY from table [customer] to table [address]
  - Ex: customer_address_fk

Common Field Values
-------------------

Not necessary so much for SQLite3, but good to have for reference and making scripts cross-db compatible.

+----------------------------+-----+------+
| Field                      | Min | Max  |
+============+===============+=====+======+
| Hostname                   | 1   | 255  |
+----------------------------+-----+------+
| Domainname                 | 4   | 253  |
+----------------------------+-----+------+
| IP Address (incl ipv6)     | 7   | 45   |
+----------------------------+-----+------+
| email max length           | 4   | 255  |
+----------------------------+-----+------+
| URL                        | 6   | 2083 |
+----------------------------+-----+------+
| HTTP(S) URL w/ Domainname  | 11  | 2083 |
+----------------------------+-----+------+
| Telephone Number           | 10  | 15   |
+----------------------------+-----+------+
| Telephone Number (intl)    | 3   | 26   |
+----------------------------+-----+------+
| Email Address              | 7   | 254  |
+----------------------------+-----+------+
| Email Address [1]          | 3   | 254  |
+----------------------------+-----+------+
| City                       | 1   | 60   |
+----------------------------+-----+------+
| State                      | 1   | 100  |
+----------------------------+-----+------+
| Country                    | 1   | 55   |
+----------------------------+-----+------+
| Postal Code [4]            | 2   | 11   |
+----------------------------+-----+------+
| Street address             | 1   | 100  |
+----------------------------+-----+------+
| YouTube max channel length | 1   | 20   |
+----------------------------+-----+------+
| Facebook max name length   | 1   | 50   |
+----------------------------+-----+------+
| Twitter max handle length  | 1   | 15   |
+----------------------------+-----+------+

+-----------+---------------+
| Field     | Type          |
+===========+===============+
| Longitude | NUMERIC(9,6)  |
+-----------+---------------+
| Latitude  | NUMERIC(8,6)  |
+-----------+---------------+
| Money[5]  | NUMERIC(19,4) |
+-----------+---------------+

  - NUMERIC is preferred in money to prevent rounding errors that occur in DECIMAL

Naming Table Columns
--------------------

Fields involving BOOLEAN values
Use adjectives.
Do not prefix with "is_", save space, those three extra characters will make large queries uglier and longer.
Examples:
  - active
  - visible
  - frozen
  - allowed

Use VERB_at for "timestamps"
Fields involving DATETIME or TIME, typically.
Examples:
  - created_at
  - updated_at
  - logged_in_at

Use VERB_on for dates
Fields involving DATE, typically.
Examples:
  - reported_on
  - discovered_on

Use NOUN_in_MEASUREMENT_NAME for fields recording measured units
Provide clarity in what is being measured by including the measurement in the name
Do not just use "height" or "weight"
Examples:
  - weight_in_pounds
  - height_in_meters
  - circumference_in_inches

Naming Indexes
--------------

Tables can only have one clustered index.
Clustered indexes determine the structure of a table and how it is displayed.
Tables without clustered indexes are called heaps.
KEYS and INDEXES are synonyms, meaning all declared keys (PRIMARY KEY and UNIQUE) create indexes automatically.
PRIMARY KEY automatically creates a clustered, unique index.
UNIQUE automatically creates a non-clustered, unique index.

UNIQUE KEYS and UNIQUE INDEXES are a logical distinction, but otherwise similar.
UNIQUE INDEX should be used when FOREIGN KEY columns are included in the index column list

Non-unique Indexes
------------------
table_name_column_name_idx for non-clustered, non-unique indexes

``CREATE INDEX [customer_idx] ON [customer] ([name_last], [name_first]);``

Unique Indexes
--------------
table_name_column_name_udx for non-clustered, unique indexes
For an index on table employee that has a FOREIGN KEY to [department] table

``CREATE UNIQUE INDEX [employee_department_id_id_udx] ON [customer] ([department_id], [id]);``

Other
-----

Comparator - Not Equals
``<>`` is ANSI compliant, preferred over ``!=``

.sqliterc
---------

Place file in root of your home directory to improve/change your SQLite3 CLI experience

``mv .sqliterc ${HOME}``
