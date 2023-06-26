LOAD DATA
INFILE 'Typ_nadwozia.csv'   
REPLACE
INTO TABLE Typ_nadwozia
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_typu_nadwozia INTEGER EXTERNAL,
	nazwa_typu CHAR
)