LOAD DATA
INFILE 'ulica.csv'
REPLACE
INTO TABLE ulica
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_ulicy INTEGER EXTERNAL,
	nazwa_ulicy CHAR,
	numer_ulicy CHAR,
	id_miasta INTEGER EXTERNAL
)