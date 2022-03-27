
-- NOTE: Fails due NOT NULL constraint failure, no password value is sent
INSERT INTO [user] ([id], [email])
VALUES
	(3, 'admin@localhost.com');

-- NOTE: Does not fail because it accepts an empty string as valid
INSERT INTO [user] ([id], [email], [password])
VALUES
	(3, 'admin@localhost', '');

-- NOTE: Fails due to invalid regexp check, no domain ex: .com
INSERT INTO [user] ([id], [email], [password])
VALUES
	(3, 'admin@localhost', 'admin');

-- NOTE: Fails due to invalid regexp check, not formatted like an email
INSERT INTO [user] ([id], [email], [password])
VALUES
	(3, '', 'three');

-- NULL constrain failure #1
INSERT INTO [user] ([id], [email], [password])
VALUES
	(3, NULL, 'three');

-- NULL constrain failure #2
INSERT INTO [user] ([id], [password])
VALUES
	(3, 'three');
