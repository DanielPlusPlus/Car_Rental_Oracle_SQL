LOAD DATA
INFILE 'Silnik.csv'   
REPLACE
INTO TABLE Silnik
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_silnika INTEGER EXTERNAL,
	ilosc_KM CHAR,
	moc CHAR,
	pojemnosc CHAR,
	id_zasilania INTEGER EXTERNAL,
	id_rodzaju INTEGER EXTERNAL
)