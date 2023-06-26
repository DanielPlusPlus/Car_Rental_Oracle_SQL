LOAD DATA
INFILE 'Nadwozie.csv'   
REPLACE
INTO TABLE Nadwozie
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_nadwozia INTEGER EXTERNAL,
	pojemnosc CHAR,
	ilosc_siedzen CHAR,
	ilosc_drzwi CHAR,
	dlugosc CHAR,
	szerokosc CHAR,
	wysokosc CHAR,
	id_typu_nadwozia INTEGER EXTERNAL
)
