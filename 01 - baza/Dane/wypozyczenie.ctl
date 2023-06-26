LOAD DATA
INFILE 'wypozyczenie.csv'
REPLACE
INTO TABLE wypozyczenie
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_wypozyczenie INTEGER EXTERNAL,
	data_wypozyczenia "Rtrim(to_date(:data_wypozyczenia,'MM/DD/YYYY'))",
	data_oddania "Rtrim(to_date(:data_oddania,'MM/DD/YYYY'))",
	ilosc_godzin CHAR,
	koszt CHAR,
	id_platnosci INTEGER EXTERNAL,
	id_samochodu INTEGER EXTERNAL,
	id_klienta INTEGER EXTERNAL,
	id_pracownika_p INTEGER EXTERNAL,
	id_pracownika_o INTEGER EXTERNAL,
	id_ulicy INTEGER EXTERNAL
)