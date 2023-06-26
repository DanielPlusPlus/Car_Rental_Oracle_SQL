LOAD DATA
INFILE 'klient.csv'
REPLACE
INTO TABLE klient
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_klienta INTEGER EXTERNAL,
	imie CHAR,
	nazwisko CHAR,
	pesel CHAR,
	nr_domu CHAR,
	nr_telefonu CHAR,
	id_ulicy INTEGER EXTERNAL
)