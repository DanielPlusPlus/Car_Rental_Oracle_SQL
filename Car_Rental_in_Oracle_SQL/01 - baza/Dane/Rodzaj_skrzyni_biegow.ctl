LOAD DATA
INFILE 'Rodzaj_skrzyni_biegow.csv'   
REPLACE
INTO TABLE Rodzaj_skrzyni_biegow
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_rodzaju INTEGER EXTERNAL,
	nazwa_rodzaju CHAR
)