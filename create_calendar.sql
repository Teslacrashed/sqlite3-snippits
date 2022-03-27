-- vim: set filetype=sql:
CREATE TABLE IF NOT EXISTS [day_of_week] (
	[id] INTEGER
		CONSTRAINT [day_of_week_pk] PRIMARY KEY AUTOINCREMENT
		CONSTRAINT [day_of_week_nn] NOT NULL,
	[alpha_1] NCHAR(1)
		CONSTRAINT [day_of_week_alpha_1_nn] NOT NULL
		CONSTRAINT [day_of_week_alpha_1_uk] UNIQUE,
	[alpha_2] NCHAR(2)
		CONSTRAINT [day_of_week_alpha_2_nn] NOT NULL
		CONSTRAINT [day_of_week_alpha_2_uk] UNIQUE,
	[alpha_3] NCHAR(3)
		CONSTRAINT [day_of_week_alpha_3_nn] NOT NULL
		CONSTRAINT [day_of_week_alpha_3_uk] UNIQUE,
	[name_full] [NVARCHAR](9)
		CONSTRAINT [day_of_week_name_full_nn] NOT NULL
		CONSTRAINT [day_of_week_name_full_uk] UNIQUE
);

INSERT INTO [day_of_week] ([id],[alpha_1],[alpha_2],[alpha_3],[name_full])
VALUES
	(1,'M','Mo','Mon','Monday'),
	(2,'T','Tu','Tue','Tuesday'),
	(3,'W','We','Wed','Wednesday'),
	(4,'R','Tr','Thr','Thursday'),
	(5,'F','Fr','Fri','Friday'),
	(6,'S','Sa','Sat','Saturday'),
	(7,'U','Su','Sun','Sunday');

CREATE TABLE IF NOT EXISTS [month_of_year] (
	[id] INTEGER
		CONSTRAINT [month_of_year_pk] PRIMARY KEY AUTOINCREMENT
		CONSTRAINT [month_of_year_nn] NOT NULL,
	[alpha_3] NCHAR(3)
		CONSTRAINT [month_of_year_alpha_3_nn] NOT NULL
		CONSTRAINT [month_of_year_alpha_3_uk] UNIQUE,
	[name_full] NVARCHAR(9)
		CONSTRAINT [month_of_year_name_full_nn] NOT NULL
		CONSTRAINT [month_of_year_name_full_uk] UNIQUE
);

INSERT INTO [month_of_year] ([id],[alpha_3],[name_full])
VALUES
	(1,'JAN','January'),
	(2,'FEB','February'),
	(3,'MAR','March'),
	(4,'APR','April'),
	(5,'MAY','May'),
	(6,'JUN','June'),
	(7,'JUL','July'),
	(8,'AUG','August'),
	(9,'SEP','September'),
	(10,'OCT','October'),
	(11,'NOV','November'),
	(12,'DEC','December');
