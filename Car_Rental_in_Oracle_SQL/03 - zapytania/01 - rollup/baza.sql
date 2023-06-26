--ROLLUP
--1. Zapytanie typu ROLLUP zwracajace wypozyczona liczbe samochodow danej marki i danego typu samochodu. Posortowane rosnaco wzgledem marki i kategorii.
SELECT NVL(Marka.nazwa_marki,'Razem') nazwa_marki,NVL(Kategoria.nazwa_kategorii,'Razem') nazwa_kategorii, ilosc_wypozyczen
FROM(
    SELECT Marka.id_marki, Kategoria.id_kategorii, COUNT(Wypozyczenie.id_wypozyczenie) AS ilosc_wypozyczen
    FROM Samochod, Marka, Kategoria, Wypozyczenie
    WHERE Samochod.id_kategorii=Kategoria.id_kategorii
    AND Samochod.id_marki=Marka.id_marki
    AND Samochod.id_samochodu=Wypozyczenie.id_samochodu
    GROUP BY ROLLUP(Marka.id_marki, Kategoria.id_kategorii)
) P, Marka, Kategoria
WHERE P.id_kategorii=Kategoria.id_kategorii(+)
AND P.id_marki=Marka.id_marki(+)
ORDER BY Marka.nazwa_marki ASC, Kategoria.nazwa_kategorii ASC;

--2. Zapytanie typu ROLLUP zwracajace ilosc wypozyczonych samochodow danej marki przez klientow z danego miasta. Posortowane malejaco wzgledem marki i miasta.
SELECT NVL(Miasto.nazwa_miasta,'Razem') nazwa_miasta, NVL(Marka.nazwa_marki,'Razem') nazwa_marki, ilosc_wypozyczen
FROM(
    SELECT Miasto.id_miasta, Marka.id_marki, COUNT(Wypozyczenie.id_wypozyczenie) AS ilosc_wypozyczen
    FROM Wypozyczenie, Samochod, Marka, Ulica, Miasto
    WHERE Wypozyczenie.id_samochodu=Samochod.id_samochodu
    AND Samochod.id_marki=Marka.id_marki
    AND Wypozyczenie.id_ulicy=Ulica.id_ulicy
    AND Ulica.id_miasta=Miasto.id_miasta
    GROUP BY ROLLUP(Miasto.id_miasta, Marka.id_marki)
) P, Marka, Miasto
WHERE P.id_marki=Marka.id_marki(+)
AND P.id_miasta=Miasto.id_miasta(+)
ORDER BY Miasto.nazwa_miasta ASC, Marka.nazwa_marki DESC;

--3. Zapytanie typu ROLLUP zwracajace ilosc wypozyczonych samochodow, z danym typem nadwozia przez mezczyzn i kobiety dla danego regionu.
SELECT NVL(wojewodztwo.nazwa_wojewodztwa,'Razem') nazwa_wojewodztwa, NVL(typ_nadwozia.nazwa_typu,'Razem') nazwa_typu, mezczyzni, kobiety
FROM (
    SELECT wojewodztwo.id_wojewodztwa, typ_nadwozia.id_typu_nadwozia,
    SUM(CASE WHEN SUBSTR(klient.pesel, 10, 1) IN ('0', '2', '4', '6', '8') THEN 1 ELSE 0 END) AS mezczyzni,
    SUM(CASE WHEN SUBSTR(klient.pesel, 10, 1) IN ('1', '3', '5', '7', '9') THEN 1 ELSE 0 END) AS kobiety
    FROM wojewodztwo, ulica, miasto, wypozyczenie, samochod, nadwozie, typ_nadwozia, klient
    WHERE wojewodztwo.id_wojewodztwa = miasto.id_wojewodztwa AND
    miasto.id_miasta = ulica.id_miasta AND
    wypozyczenie.id_ulicy = ulica.id_ulicy AND
    wypozyczenie.id_samochodu = samochod.id_samochodu AND
    samochod.id_nadwozia = nadwozie.id_nadwozia AND
    typ_nadwozia.id_typu_nadwozia = nadwozie.id_typu_nadwozia AND
    Wypozyczenie.id_klienta=Klient.id_klienta
    GROUP BY ROLLUP(wojewodztwo.id_wojewodztwa, typ_nadwozia.id_typu_nadwozia)
) P, wojewodztwo, typ_nadwozia
WHERE P.id_wojewodztwa = wojewodztwo.id_wojewodztwa(+) AND
P.id_typu_nadwozia = typ_nadwozia.id_typu_nadwozia(+)
ORDER BY wojewodztwo.nazwa_wojewodztwa ASC,typ_nadwozia.nazwa_typu ASC;
