LOAD DATA
INFILE 'Kategoria.csv'
REPLACE
INTO TABLE Kategoria
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_kategorii INTEGER EXTERNAL,
	nazwa_kategorii CHAR
)