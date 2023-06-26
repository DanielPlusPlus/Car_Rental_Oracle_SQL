LOAD DATA
INFILE 'platnosc.csv'   
REPLACE
INTO TABLE platnosc
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_platnosci INTEGER EXTERNAL,
	rodzaj_platnosci CHAR
)