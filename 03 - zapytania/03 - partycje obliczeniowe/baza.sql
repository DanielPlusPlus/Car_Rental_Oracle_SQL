--PARTYCJA OBLICZENIOWA
--1. Zapytanie typu PARTYCJA OBLICZENIOWA ukazujace koszt dla wypozyczenia danego samochodu, sume kosztow wypozyczen tego samochodu i procentowy udzial wypozyczenia
--tego samochodu z danym miesiacu dla danego roku w danym wojewodztwie
SELECT wojewodztwo.nazwa_wojewodztwa, EXTRACT(month FROM wypozyczenie.data_wypozyczenia) miesiac, samochod.nr_rejestracyjny, TO_NUMBER(wypozyczenie.koszt,'9999.99') koszt,
sum(TO_NUMBER(wypozyczenie.koszt, '9999.99'))  over 
(PARTITION BY samochod.id_samochodu) suma, round(100*TO_NUMBER(wypozyczenie.koszt, '9999.99')/(sum(TO_NUMBER(wypozyczenie.koszt, '9999.99')) 
over (PARTITION BY samochod.id_samochodu))) "udzial %" 
FROM ulica, miasto, wojewodztwo, wypozyczenie, samochod 
WHERE
samochod.id_samochodu = wypozyczenie.id_samochodu AND
wypozyczenie.id_ulicy = ulica.id_ulicy AND
ulica.id_miasta = miasto.id_miasta AND
miasto.id_wojewodztwa = wojewodztwo.id_wojewodztwa
ORDER BY wojewodztwo.nazwa_wojewodztwa ASC, EXTRACT(month FROM wypozyczenie.data_wypozyczenia) ASC;

--2. Zapytanie typu PARTYCJA OBLICZENIOWA zwracajace ilosc wypozyczen danego samochodu, z danym typem silnika w danym roku i w danym regionie
SELECT DISTINCT EXTRACT(year FROM wypozyczenie.data_oddania) rok, wojewodztwo.nazwa_wojewodztwa, rodzaj_silnika.nazwa_rodzaju,count(wypozyczenie.id_wypozyczenie) over
(partition by wojewodztwo.nazwa_wojewodztwa,rodzaj_silnika.nazwa_rodzaju) ile
FROM wypozyczenie, wojewodztwo, miasto, ulica, samochod, silnik, rodzaj_silnika
WHERE rodzaj_silnika.id_rodzaju = silnik.id_rodzaju AND
silnik.id_silnika = samochod.id_silnika AND
samochod.id_samochodu = wypozyczenie.id_samochodu AND
wypozyczenie.id_ulicy = ulica.id_ulicy AND
ulica.id_miasta = miasto.id_miasta AND
miasto.id_wojewodztwa = wojewodztwo.id_wojewodztwa
ORDER BY rok DESC, wojewodztwo.nazwa_wojewodztwa DESC,rodzaj_silnika.nazwa_rodzaju ASC;

--3. Zapytanie typu PARTYCJA OBLICZENIOWA zwracajace maksymalna i minimalna wartosc (cene za godzine) wypozyczonego samochodu, danej marki dla danego dnia, miesiaca.
SELECT DISTINCT
Marka.nazwa_marki AS marka,
TO_CHAR(Wypozyczenie.data_wypozyczenia, 'DD') AS dzien,
TO_CHAR(Wypozyczenie.data_wypozyczenia, 'MM') AS miesiac,
TO_CHAR(Wypozyczenie.data_wypozyczenia, 'YYYY') AS rok,
MAX(Samochod.cena_za_godzine) OVER (PARTITION BY TO_CHAR(Wypozyczenie.data_wypozyczenia, 'DD'), TO_CHAR(Wypozyczenie.data_wypozyczenia, 'MM'), TO_CHAR(Wypozyczenie.data_wypozyczenia, 'YYYY')) AS max_koszt,
MIN(Samochod.cena_za_godzine) OVER (PARTITION BY TO_CHAR(Wypozyczenie.data_wypozyczenia, 'DD'), TO_CHAR(Wypozyczenie.data_wypozyczenia, 'MM'), TO_CHAR(Wypozyczenie.data_wypozyczenia, 'YYYY')) AS min_koszt
FROM Samochod, Wypozyczenie, Marka
WHERE Wypozyczenie.id_samochodu=Samochod.id_samochodu AND
Samochod.id_marki = Marka.id_marki
ORDER BY marka, rok, miesiac, dzien;