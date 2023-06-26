LOAD DATA
INFILE 'Rodzaj_zasilania.csv'   
REPLACE
INTO TABLE Rodzaj_zasilania
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_zasilania INTEGER EXTERNAL,
	nazwa_rodzaju CHAR
)