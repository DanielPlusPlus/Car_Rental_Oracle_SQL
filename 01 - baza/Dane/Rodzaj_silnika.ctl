LOAD DATA
INFILE 'Rodzaj_silnika.csv'   
REPLACE
INTO TABLE Rodzaj_silnika
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_rodzaju INTEGER EXTERNAL,
	nazwa_rodzaju CHAR
)
