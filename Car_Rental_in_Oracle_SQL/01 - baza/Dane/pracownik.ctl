LOAD DATA
INFILE 'pracownik.csv'   
REPLACE
INTO TABLE pracownik
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_pracownika INTEGER EXTERNAL,
	imie CHAR,
	nazwisko CHAR,
	data_zatrudnienia "Rtrim(to_date(:data_zatrudnienia,'MM/DD/YYYY'))",
	pensja CHAR
)