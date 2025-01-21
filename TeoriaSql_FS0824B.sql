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
	user_id SERIAL NOT NULL PRIMARY KEY,
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
INSERT INTO public.user (firstname, lastname, age, city, fiscal_code)
			VALUES  ('Antonio', 'Bianchi', 40, 'Torino', 'AB789CD45E678PQO');
INSERT INTO public.user (firstname, lastname, age, city, fiscal_code)
			VALUES  ('Luigi', 'Viola', 60, 'Milano', 'AB789CD49E678PQO');
					
INSERT INTO public.signin (email, password, user_id) 
			VALUES  ('m.rossi@example.com', 'qwerty', 1),
					('g.verdi@example.com', 'Pa$$w0rd!', 2),
					('f.neri@example.com', '12345', 3);

UPDATE public.user SET age = 99, city= 'Torino' WHERE id = 2;

DELETE FROM public.user WHERE id = 2;

-- DQL
-- SELECT -> Un elenco di campi o tutto (*) che voglio restituire
-- FROM -> indica la sorgente di dati
-- WHERE -> condizione della select
-- GROUP BY -> aggrega dei dati 
-- HAVING -> filtro sui dati aggregati con il GROUP BY
-- ORDER BY -> Ordinare i dati 
-- LIMIT -> selezionare un numero definito di record

/*
SELECT [DISTINCT] column_name1,  column_name2, ...,  column_namen | * | aggregate_function(expression)
	FROM table_name
	[WHERE search_condition]
	[GROUP BY]
	[HAVING]
	[ORDER BY]
	[LIMIT n]
*/

SELECT * FROM public.user WHERE age > 30;
SELECT * FROM public.user WHERE fiscal_code = 'AB123CD45E678PQO';
SELECT * FROM public.user WHERE fiscal_code LIKE 'AB1%';
SELECT * FROM public.user WHERE fiscal_code LIKE '%QO';
SELECT * FROM public.user WHERE fiscal_code LIKE '%123%';
SELECT * FROM public.user WHERE fiscal_code LIKE 'A_123%';

SELECT * FROM public.user
SELECT * FROM public.signin;

SELECT * FROM public.user AS u ORDER BY u.age DESC;
SELECT DISTINCT city FROM public.user AS u;
SELECT avg(age) FROM public.user
SELECT sum(age) AS Somma_età FROM public.user
SELECT city, count(*) FROM public.user GROUP BY city;
SELECT city, avg(age) FROM public.user GROUP BY city;

SELECT firstname, lastname, email, s.user_id AS num
	FROM public.user AS u INNER JOIN public.signin AS s
	ON u.id = s.user_id;
	
SELECT firstname, lastname, email 
	FROM public.user LEFT JOIN public.signin 
	ON public.user.id = public.signin.user_id;