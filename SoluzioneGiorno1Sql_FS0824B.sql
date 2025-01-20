
/* CREATE TABLE db_table (
	column_name datatype constraints,
	column_name datatype constraints,
	column_name datatype constraints,
	...
    [constraint_name] table_constraints
)
*/
-- Clienti (NumeroCliente, Nome, Cognome, AnnoDiNascita, RegioneResidenza)
CREATE TABLE clienti (
	numero_cliente SERIAL NOT NULL PRIMARY KEY,
	nome VARCHAR(25) NOT NULL,
	cognome VARCHAR(25) NOT NULL,
	anno_di_nascita INT NOT NULL,
	regione_residenza VARCHAR(25) NULL
)
-- Prodotti (IdProdotto, Descrizione, InProduzione, InCommercio, DataAttivazione, DataDisattivazione)
CREATE TABLE prodotti (
	id_prodotto SERIAL NOT NULL PRIMARY KEY,
	descrizione VARCHAR(255) NOT NULL,
	in_produzione BOOLEAN NULL DEFAULT false,
	in_commercio BOOLEAN NULL DEFAULT false,
	data_attivazione DATE NOT NULL,
	data_disattivazione DATE NULL
)
-- Fornitori (NumeroFornitore, Denominazione, RegioneDiResidenza)
CREATE TABLE fornitori (
	numero_fornitore SERIAL NOT NULL PRIMARY KEY,
	denominazione VARCHAR(255) NOT NULL,
	regione_residenza VARCHAR(100) NOT NULL
)
-- Fatture (NumeroFattura, Tipologia, Importo, Iva, IdCliente, DataFattura, NumeroFornitore)
CREATE TABLE fatture (
	numero_fattura SERIAL NOT NULL PRIMARY KEY,
	tipologia VARCHAR(10) NOT NULL,
	importo NUMERIC NULL DEFAULT 0,
	iva INT NULL DEFAULT 20,
	id_cliente INT NOT NULL, 
	data_fattura DATE NOT NULL,
	numero_fornitore INT NOT NULL, 
	
	CONSTRAINT fatture_cliente_FK 
				FOREIGN KEY(id_cliente) 
				REFERENCES clienti(numero_cliente)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
	CONSTRAINT fatture_fornitore_FK
				FOREIGN KEY(numero_fornitore)
				REFERENCES fornitori(numero_fornitore)

)

INSERT INTO clienti (nome, cognome, anno_di_nascita, regione_residenza) 
			VALUES  ('Mario', 'Rossi', 1982, 'Lazio' ),
					('Giuseppe', 'Verdi', 1999, 'Lombardia'),
					('Francesca', 'Neri', 2005, 'Sicilia'),
					('Antonio', 'Bianchi', 1982, 'Puglia' ),
					('Maria', 'Gialli', 2000, 'Lazio');
SELECT * FROM clienti;

INSERT INTO prodotti (descrizione, in_produzione, data_attivazione)
			VALUES   ('Iphone bellissimo', true, '2025-01-01'),
					 ('Tv LED 60p', true, '2024-11-24')
INSERT INTO prodotti (descrizione, in_produzione,in_commercio, data_attivazione, data_disattivazione)
			VALUES   ('Figurine Panini', true, true, '2025-01-10', '2025-07-20')
SELECT * FROM prodotti;

INSERT INTO fornitori (denominazione, regione_residenza)
			VALUES   ('ABC S.r.l.', 'Umbria'),
					 ('Epicode Spa', 'Lazio'),
					 ('Panini Spa', 'Emilia Romagna')
SELECT * FROM fornitori;

-- Fatture (NumeroFattura, Tipologia, Importo, Iva, IdCliente, DataFattura, NumeroFornitore)
INSERT INTO fatture (tipologia, importo, iva, id_cliente, data_fattura, numero_fornitore)
			VALUES   ('A', 890.99, 20, 2, '2025-01-12', 1),
					 ('B', 19.90, 10, 1, '2025-01-14', 3),
					 ('A', 2500.00, 20, 4, '2025-01-18', 2)
SELECT * FROM fatture;

SELECT * FROM clienti WHERE nome = 'Mario';
SELECT nome, cognome FROM clienti WHERE anno_di_nascita = 1982;