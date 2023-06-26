--OKNA
--1. Zapytanie typu OKNO ktore ukazuje zestawienie miesiaczne dla danego roku i dla danego miasta ile wynosil koszt i srednie koszty wypozyczen
SELECT wojewodztwo_hd.nazwa_wojewodztwa, miasto_hd.nazwa_miasta,
miesiac_hd.nr_miesiaca, TO_NUMBER(wypozyczenie_hd.koszt, '9999.99') koszt, AVG(TO_NUMBER(wypozyczenie_hd.koszt,'9999.99')) over
(PARTITION BY miasto_hd.id_miasta ORDER BY miesiac_hd.id_miesiaca RANGE BETWEEN unbounded preceding AND
CURRENT ROW) srednie_koszty
FROM wojewodztwo_hd, miasto_hd, wypozyczenie_hd, miesiac_hd
WHERE wypozyczenie_hd.id_wojewodztwo = wojewodztwo_hd.id_wojewodztwo AND
wypozyczenie_hd.id_miasta = miasto_hd.id_miasta AND
wypozyczenie_hd.id_miesiaca_o = miesiac_hd.id_miesiaca
ORDER BY wojewodztwo_hd.nazwa_wojewodztwa DESC, miasto_hd.nazwa_miasta DESC, miesiac_hd.nr_miesiaca DESC, koszt DESC;

--2. Zapytanie typu OKNO zwracajace sumaryczny zarobek na wypozyczeniach samochod z danym rodzajem zasilania z podzialem na dekady. Posortowane po nazwie rodzaju i dekadzie.
SELECT DISTINCT Rodzaj_zasilania_hd.nazwa_rodzaju, TRUNC(Rok_hd.nr_roku, -1) AS dekada,
SUM(TO_NUMBER(Wypozyczenie_hd.koszt, '9999.99')) OVER (
    PARTITION BY TRUNC(Rok_hd.nr_roku, -1)
    ORDER BY Rodzaj_zasilania_hd.nazwa_rodzaju
    RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS sumaryczny_zarobek
FROM Wypozyczenie_hd, Rodzaj_zasilania_hd, Rok_hd
WHERE Wypozyczenie_hd.id_roku_w=Rok_hd.id_roku
AND Wypozyczenie_hd.id_rodzaju_zasilania=Rodzaj_zasilania_hd.id_rodzaju_zasilania
ORDER BY Rodzaj_zasilania_hd.nazwa_rodzaju ASC, dekada ASC;

--3. Zapytanie typu OKNO zwracjace ilosc wypozyczonych samochodow z danym silnikiem dla danego miasta i wojewodztwa w przeciagu tygodnia w danym miesiacu, roku
SELECT rok_hd.nr_roku, miesiac_hd.nr_miesiaca, dzien_hd.nr_dnia, wojewodztwo_hd.nazwa_wojewodztwa, miasto_hd.nazwa_miasta, rodzaj_silnika_hd.nazwa_rodzaju,
count(wypozyczenie_hd.id_samochodu) over (partition by wypozyczenie_hd.id_samochodu order by TO_DATE(TO_CHAR(rok_hd.id_roku)|| '-' || TO_CHAR(miesiac_hd.id_miesiaca) || '-' ||
TO_CHAR(dzien_hd.id_dnia),'YYYY-MM-DD') RANGE BETWEEN INTERVAL '7' DAY PRECEDING AND CURRENT ROW) ile_wypozyczen
FROM wypozyczenie_hd, samochod_hd, miasto_hd, rodzaj_silnika_hd, rok_hd, miesiac_hd, dzien_hd, wojewodztwo_hd
WHERE wypozyczenie_hd.id_samochodu = samochod_hd.id_samochodu AND
wypozyczenie_hd.id_miasta = miasto_hd.id_miasta AND
wypozyczenie_hd.id_silnika = rodzaj_silnika_hd.id_silnika AND
wypozyczenie_hd.id_roku_w = rok_hd.id_roku AND
wypozyczenie_hd.id_miesiaca_w = miesiac_hd.id_miesiaca AND
wypozyczenie_hd.id_dnia_w = dzien_hd.id_dnia AND
wypozyczenie_hd.id_wojewodztwo = wojewodztwo_hd.id_wojewodztwo
ORDER BY rok_hd.nr_roku DESC, miesiac_hd.nr_miesiaca ASC, dzien_hd.nr_dnia ASC,wojewodztwo_hd.nazwa_wojewodztwa ASC,miasto_hd.nazwa_miasta ASC, 
rodzaj_silnika_hd.nazwa_rodzaju ASC, ile_wypozyczen ASC;
