--CUBE
--1. Zapytanie typu CUBE zwracajace srednia ilosc godzin na jaka wypozyczono samochod w danym wojewodztwie i miescie. Posortowane rosnaco po wojewodztwie i miescie.
SELECT NVL(Wojewodztwo.nazwa_wojewodztwa,'Razem') nazwa_wojewodztwa, NVL(Miasto.nazwa_miasta,'Razem') nazwa_miasta, srednia_ilosc_godzin
FROM(
    SELECT Wojewodztwo.id_wojewodztwa, Miasto.id_miasta, ROUND(AVG(Wypozyczenie.ilosc_godzin),2) AS srednia_ilosc_godzin
    FROM Wypozyczenie, Ulica, Miasto, Wojewodztwo
    WHERE Wypozyczenie.id_ulicy=Ulica.id_ulicy
    AND Ulica.id_miasta=Miasto.id_miasta
    AND Miasto.id_wojewodztwa=Wojewodztwo.id_wojewodztwa
    GROUP BY CUBE(Wojewodztwo.id_wojewodztwa, Miasto.id_miasta)
) P, Wojewodztwo, Miasto
WHERE P.id_wojewodztwa=Wojewodztwo.id_wojewodztwa(+)
AND P.id_miasta=Miasto.id_miasta(+)
ORDER BY Wojewodztwo.nazwa_wojewodztwa ASC, Miasto.nazwa_miasta ASC;


--2. Zapytanie typu CUBE liczace ile razy zostal wypozycznony samochod danego koloru przez mezczyzn i kobiety po peselu. Posortowane malejaco po nazwie koloru.
SELECT NVL(Kolor.nazwa_koloru,'Razem') nazwa_koloru, ilosc_kobiet, ilosc_mezczyzn
FROM(
    SELECT Kolor.id_koloru,
    SUM(CASE WHEN SUBSTR(Klient.pesel, 10, 1) IN ('0', '2', '4', '6', '8') THEN 1 ELSE 0 END) AS ilosc_mezczyzn,
    SUM(CASE WHEN SUBSTR(Klient.pesel, 10, 1) IN ('1', '3', '5', '7', '9') THEN 1 ELSE 0 END) AS ilosc_kobiet
    FROM Wypozyczenie, Samochod, Kolor, Klient
    WHERE Wypozyczenie.id_klienta=Klient.id_klienta
    AND Wypozyczenie.id_samochodu=Samochod.id_samochodu
    AND Samochod.id_koloru=Kolor.id_koloru
    GROUP BY CUBE(Kolor.id_koloru)
) P, Kolor
WHERE P.id_koloru=Kolor.id_koloru(+)
ORDER BY Kolor.id_koloru DESC;

--3. Zapytanie typu CUBE liczace ile razy zostal wypozyczony samochod z danym rodzajem skrzyni biegow, w danym regionie, w okreslonym czasie.
SELECT rok, NVL(wojewodztwo.nazwa_wojewodztwa,'Razem') nazwa_wojewodztwa, NVL(rodzaj_skrzyni_biegow.nazwa_rodzaju,'Razem') nazwa_rodzaju, ile
FROM 
(SELECT EXTRACT(year FROM wypozyczenie.data_oddania) rok, wojewodztwo.id_wojewodztwa, rodzaj_skrzyni_biegow.id_rodzaju, count(wypozyczenie.id_wypozyczenie) ile
FROM  wypozyczenie, samochod, rodzaj_skrzyni_biegow, skrzynia_biegow, wojewodztwo, miasto, ulica
WHERE wypozyczenie.id_samochodu = samochod.id_samochodu AND
rodzaj_skrzyni_biegow.id_rodzaju = skrzynia_biegow.id_rodzaju AND
wypozyczenie.id_ulicy = ulica.id_ulicy AND
ulica.id_miasta = miasto.id_miasta AND
wojewodztwo.id_wojewodztwa = miasto.id_wojewodztwa AND
samochod.id_skrzyni_biegow = skrzynia_biegow.id_skrzyni_biegow
GROUP BY EXTRACT(year FROM wypozyczenie.data_oddania), CUBE(wojewodztwo.id_wojewodztwa, rodzaj_skrzyni_biegow.id_rodzaju)
) P, wojewodztwo, rodzaj_skrzyni_biegow
WHERE P.id_wojewodztwa = wojewodztwo.id_wojewodztwa(+) AND
P.id_rodzaju = rodzaj_skrzyni_biegow.id_rodzaju(+)
ORDER BY rok ASC, wojewodztwo.id_wojewodztwa DESC,rodzaj_skrzyni_biegow.nazwa_rodzaju DESC;