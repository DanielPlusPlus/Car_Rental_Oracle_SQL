LOAD DATA
INFILE 'miasto.csv'   
REPLACE
INTO TABLE miasto
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	id_miasta INTEGER EXTERNAL,
	nazwa_miasta CHAR,
	id_wojewodztwa INTEGER EXTERNAL
)