LOAD DATA
INFILE 'wojewodztwo.csv'
REPLACE
INTO TABLE wojewodztwo
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS 
(
	id_wojewodztwa INTEGER EXTERNAL,
	nazwa_wojewodztwa CHAR
)