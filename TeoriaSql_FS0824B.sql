-- Commenti a riga singola

/*
	Commenti multi riga
*/

-- DDL | DQL | DML

-- DDL -> Creazione | Cancellare | Modificare 

-- CREATE DATABASE db_name
-- DROP DATABSE db_name
/* CREATE TABLE db_table (
	column_name datatype constraints,
	column_name datatype constraints,
	column_name datatype constraints,
	...
    [constraint_name] table_constraints
)
*/
-- DROP TABLE db_table
-- ALTER TABLE table_name ADD COLUMN column_name datatype column_constraints;
-- ALTER TABLE table_name DROP COLUMN column_name;
-- ALTER TABLE table_name MODIFY column_name datatype;
-- ALTER TABLE table_name RENAME COLUMN column_name TO new_column_name;
-- ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint_type(column_name) REFERENCES table_name(column_name);
-- ALTER TABLE table_name DROP CONSTRAINT constraint_name;

DROP TABLE public.user;
CREATE TABLE public.user ( 
	id SERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(25) NOT NULL,
	lastname VARCHAR(50) NOT NULL,
	age INT NULL DEFAULT 18,
	city VARCHAR(50) NULL,
	email VARCHAR(25) NOT NULL UNIQUE
);

ALTER TABLE public.user ADD COLUMN fiscal_code CHAR(16) NOT NULL UNIQUE;
ALTER TABLE public.user DROP COLUMN email;
ALTER TABLE public.user RENAME COLUMN name TO firstname;

DROP TABLE public.signin;
CREATE TABLE public.signin ( 
	signin_id SERIAL NOT NULL,
	email VARCHAR(25) NOT NULL,
	password VARCHAR(25) NOT NULL,
	user_id INT NOT NULL UNIQUE,
	
	CONSTRAINT signin_pkey PRIMARY KEY(signin_id),
	CONSTRAINT email_un UNIQUE(email),
	CONSTRAINT signin_user_fk FOREIGN KEY(user_id) REFERENCES public.user(id)
);



-- DML
-- INSERT | UPDATE | DELETE

-- INSERT INTO table_name (column_name1, column_name2, column_name3, ..., column_nameN)
-- VALUES(value1, value2, value3, ..., valueN)

-- UPDATE table_name SET column_name1=value1, column_name2=value2, ..., column_nameN=valueN
-- WHERE column_name = value

-- DELETE FROM table_name WHERE column_name = value;

INSERT INTO public.user (firstname, lastname, age, city, fiscal_code)
			VALUES  ('Mario', 'Rossi', 23, 'Roma', 'AB123CD45E678PQO'),
					('Giuseppe', 'Verdi', 49, 'Milano', 'AB123CD45E678WER'),
					('Francesca', 'Neri', 33, 'Palermo', 'AB456CD45E678PQO');
					
INSERT INTO public.signin (email, password, user_id) 
			VALUES  ('m.rossi@example.com', 'qwerty', 1),
					('g.verdi@example.com', 'Pa$$w0rd!', 2),
					('f.neri@example.com', '12345', 3);

UPDATE public.user SET age = 99 WHERE id = 2;

DELETE FROM public.user WHERE id = 2;

-- DQL

SELECT * FROM public.user;
SELECT * FROM public.signin;