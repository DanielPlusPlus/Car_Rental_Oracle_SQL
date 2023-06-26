LOAD DATA
INFILE 'Uklad_hamulcowy.csv'   
REPLACE
INTO TABLE Uklad_hamulcowy
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_ukladu_hamulcowego INTEGER EXTERNAL,
	rodzaj_ukladu_hamulcowego CHAR
)