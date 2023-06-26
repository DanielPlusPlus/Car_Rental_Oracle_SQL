LOAD DATA
INFILE 'Samochod.csv'   
REPLACE
INTO TABLE Samochod
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_samochodu INTEGER EXTERNAL,
	nr_rejestracyjny CHAR,
	numer_VIN CHAR,
	wartosc CHAR,
	cena_za_godzine CHAR,
	id_marki INTEGER EXTERNAL,
	id_koloru INTEGER EXTERNAL,
	id_nadwozia INTEGER EXTERNAL,
	id_skrzyni_biegow INTEGER EXTERNAL,
	id_ukladu_hamulcowego INTEGER EXTERNAL,
	id_silnika INTEGER EXTERNAL,
	id_modelu INTEGER EXTERNAL,
	id_kategorii INTEGER EXTERNAL
)