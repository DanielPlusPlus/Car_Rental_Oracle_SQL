LOAD DATA
INFILE 'Skrzynia_biegow.csv'   
REPLACE
INTO TABLE Skrzynia_biegow
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_skrzyni_biegow INTEGER EXTERNAL,
	ilosc_biegow CHAR,
	id_rodzaju INTEGER EXTERNAL
)