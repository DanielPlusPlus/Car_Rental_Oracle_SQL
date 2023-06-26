--CUBE
--1. Zapytanie typu CUBE zwracajace srednia ilosc godzin na jaka wypozyczono samochod w danym wojewodztwie i miescie. Posortowane rosnaco po wojewodztwie i miescie.
SELECT NVL(Wojewodztwo_hd.nazwa_wojewodztwa,'Razem') nazwa_wojewodztwa, NVL(Miasto_hd.nazwa_miasta,'Razem') nazwa_miasta, srednia_ilosc_godzin
FROM(
    SELECT Wojewodztwo_hd.id_wojewodztwo, Miasto_hd.id_miasta, ROUND(AVG(Wypozyczenie_hd.ilosc_godzin),2) AS srednia_ilosc_godzin
    FROM Wojewodztwo_hd, Miasto_hd, Wypozyczenie_hd
    WHERE Wypozyczenie_hd.id_wojewodztwo=Wojewodztwo_hd.id_wojewodztwo
    AND Wypozyczenie_hd.id_miasta=Miasto_hd.id_miasta
    GROUP BY CUBE(Wojewodztwo_hd.id_wojewodztwo, Miasto_hd.id_miasta)
) P, Wojewodztwo_hd, Miasto_hd
WHERE P.id_wojewodztwo=Wojewodztwo_hd.id_wojewodztwo(+)
AND P.id_miasta=Miasto_hd.id_miasta(+)
ORDER BY Wojewodztwo_hd.nazwa_wojewodztwa ASC, Miasto_hd.nazwa_miasta ASC;

--2. Zapytanie typu CUBE liczace ile razy zostal wypozycznony samochod danego koloru przez mezczyzn i kobiety po peselu. Posortowane malejaco po nazwie koloru.
SELECT NVL(Kolor_hd.nazwa_koloru,'Razem') nazwa_koloru, ilosc_kobiet, ilosc_mezczyzn
FROM(
    SELECT Kolor_hd.id_koloru,
    SUM(CASE WHEN SUBSTR(Klient_hd.pesel, 10, 1) IN ('0', '2', '4', '6', '8') THEN 1 ELSE 0 END) AS ilosc_mezczyzn,
    SUM(CASE WHEN SUBSTR(Klient_hd.pesel, 10, 1) IN ('1', '3', '5', '7', '9') THEN 1 ELSE 0 END) AS ilosc_kobiet
    FROM Wypozyczenie_hd, Kolor_hd, Klient_hd
    WHERE Wypozyczenie_hd.id_klienta=Klient_hd.id_klienta
    AND Wypozyczenie_hd.id_koloru=Kolor_hd.id_koloru
    GROUP BY CUBE(Kolor_hd.id_koloru)
) P, Kolor_hd
WHERE P.id_koloru=Kolor_hd.id_koloru(+)
ORDER BY Kolor_hd.id_koloru DESC;

--3. Zapytanie typu CUBE liczace ile razy zostal wypozyczony samochod z danym rodzajem skrzyni biegow, w danym regionie, w okreslonym czasie.
SELECT rok_hd.nr_roku, NVL(wojewodztwo_hd.nazwa_wojewodztwa,'Razem') nazwa_wojewodztwa, NVL(rodzaj_skrzyni_biegow_hd.nazwa_rodzaju,'Razem') nazwa_rodzaju, ile
FROM (
    SELECT rok_hd.id_roku, wojewodztwo_hd.id_wojewodztwo, rodzaj_skrzyni_biegow_hd.id_rodzaju_skrzyni_biegow, count(wypozyczenie_hd.id_wypozyczenie) ile
    FROM wypozyczenie_hd, rok_hd, wojewodztwo_hd, rodzaj_skrzyni_biegow_hd
    WHERE wypozyczenie_hd.id_roku_o = rok_hd.id_roku AND
    wypozyczenie_hd.id_wojewodztwo = wojewodztwo_hd.id_wojewodztwo AND
    wypozyczenie_hd.id_rodzaju_skrzyni_biegow = rodzaj_skrzyni_biegow_hd.id_rodzaju_skrzyni_biegow
    GROUP BY rok_hd.id_roku, CUBE(wojewodztwo_hd.id_wojewodztwo, rodzaj_skrzyni_biegow_hd.id_rodzaju_skrzyni_biegow)
) P, rok_hd,wojewodztwo_hd, rodzaj_skrzyni_biegow_hd
WHERE P.id_wojewodztwo = wojewodztwo_hd.id_wojewodztwo(+) AND
P.id_rodzaju_skrzyni_biegow = rodzaj_skrzyni_biegow_hd.id_rodzaju_skrzyni_biegow(+) AND
P.id_roku = rok_hd.id_roku
ORDER BY rok_hd.nr_roku ASC, wojewodztwo_hd.nazwa_wojewodztwa DESC,rodzaj_skrzyni_biegow_hd.nazwa_rodzaju DESC;