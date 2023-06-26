--OKNA
--1. Zapytanie typu OKNO ktore ukazuje zestawienie miesiaczne dla danego roku i dla danego miasta ile wynosil koszt i srednie koszty wypozyczen
SELECT wojewodztwo.nazwa_wojewodztwa, miasto.nazwa_miasta,
EXTRACT(month FROM wypozyczenie.data_oddania) miesiac, TO_NUMBER(wypozyczenie.koszt, '9999.99') koszt, AVG(TO_NUMBER(wypozyczenie.koszt,'9999.99')) over
(PARTITION BY miasto.id_miasta ORDER BY EXTRACT(month FROM wypozyczenie.data_oddania) RANGE BETWEEN unbounded preceding AND
CURRENT ROW) srednie_koszty FROM
wojewodztwo, miasto, ulica, wypozyczenie
WHERE ulica.id_ulicy = wypozyczenie.id_ulicy AND
ulica.id_miasta = miasto.id_miasta AND
miasto.id_wojewodztwa = wojewodztwo.id_wojewodztwa
ORDER BY wojewodztwo.nazwa_wojewodztwa DESC, miasto.nazwa_miasta DESC, miesiac DESC, koszt DESC;

--2. Zapytanie typu OKNO zwracajace sumaryczny zarobek na wypozyczeniach samochod z danym rodzajem zasilania z podzialem na dekady. Posortowane po nazwie rodzaju i dekadzie.
SELECT DISTINCT Rodzaj_zasilania.nazwa_rodzaju, TRUNC(EXTRACT(YEAR FROM Wypozyczenie.data_wypozyczenia), -1) AS dekada,
SUM(TO_NUMBER(wypozyczenie.koszt, '9999.99')) OVER (
    PARTITION BY TRUNC(EXTRACT(YEAR FROM Wypozyczenie.data_wypozyczenia), -1)
    ORDER BY Rodzaj_zasilania.nazwa_rodzaju
    RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS sumaryczny_zarobek
FROM Wypozyczenie, Samochod, Silnik, Rodzaj_zasilania
WHERE Wypozyczenie.id_samochodu=Samochod.id_samochodu
AND Samochod.id_silnika=Silnik.id_silnika
AND Silnik.id_zasilania=Rodzaj_zasilania.id_zasilania
ORDER BY Rodzaj_zasilania.nazwa_rodzaju ASC, dekada ASC;

--3. Zapytanie typu OKNO zwracjace ilosc wypozyczonych samochodow z danym silnikiem dla danego miasta i wojewodztwa w przeciagu tygodnia w danym miesiacu, roku
SELECT EXTRACT(year FROM wypozyczenie.data_wypozyczenia) rok, EXTRACT(month FROM wypozyczenie.data_wypozyczenia) miesiac,
EXTRACT(day FROM wypozyczenie.data_wypozyczenia) dzien, wojewodztwo.nazwa_wojewodztwa, miasto.nazwa_miasta, rodzaj_silnika.nazwa_rodzaju, count(wypozyczenie.id_samochodu) 
over (partition by wypozyczenie.id_samochodu order by wypozyczenie.data_wypozyczenia RANGE BETWEEN INTERVAL '7' DAY PRECEDING AND CURRENT ROW) ile_wypozyczen
FROM wypozyczenie, samochod, ulica, miasto, rodzaj_silnika, silnik, wojewodztwo
WHERE wypozyczenie.id_ulicy = ulica.id_ulicy AND
ulica.id_miasta = miasto.id_miasta AND
rodzaj_silnika.id_rodzaju = silnik.id_rodzaju AND
samochod.id_silnika = silnik.id_silnika AND
wypozyczenie.id_samochodu = samochod.id_samochodu AND
wojewodztwo.id_wojewodztwa = miasto.id_wojewodztwa
ORDER BY rok DESC, miesiac ASC, dzien ASC,wojewodztwo.nazwa_wojewodztwa ASC,miasto.nazwa_miasta ASC, 
rodzaj_silnika.nazwa_rodzaju ASC, ile_wypozyczen ASC;