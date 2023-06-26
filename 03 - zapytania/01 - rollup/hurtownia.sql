--ROLLUP
--1. Zapytanie typu ROLLUP zwracajace wypozyczona liczbe samochodow danej marki i danego typu samochodu. Posortowane rosnaco wzgledem marki i kategorii.
SELECT NVL(Marka_hd.nazwa_marki,'Razem') nazwa_marki,NVL(Kategoria_hd.nazwa_kategorii,'Razem') nazwa_kategorii, ilosc_wypozyczen
FROM(
    SELECT Marka_hd.id_marki, Kategoria_hd.id_kategorii, COUNT(Wypozyczenie_hd.id_wypozyczenie) AS ilosc_wypozyczen
    FROM Marka_hd, Kategoria_hd, Wypozyczenie_hd
    WHERE Wypozyczenie_hd.id_marki=Marka_hd.id_marki
    AND Wypozyczenie_hd.id_kategorii=Kategoria_hd.id_kategorii
    GROUP BY ROLLUP(Marka_hd.id_marki, Kategoria_hd.id_kategorii)
) P, Marka_hd, Kategoria_hd
WHERE P.id_kategorii=Kategoria_hd.id_kategorii(+)
AND P.id_marki=Marka_hd.id_marki(+)
ORDER BY Marka_hd.nazwa_marki ASC, Kategoria_hd.nazwa_kategorii ASC;

--2. Zapytanie typu ROLLUP zwracajace ilosc wypozyczonych samochodow danej marki przez klientow z danego miasta. Posortowane malejaco wzgledem marki i miasta.
SELECT NVL(Miasto_hd.nazwa_miasta,'Razem') nazwa_miasta, NVL(Marka_hd.nazwa_marki,'Razem') nazwa_marki, ilosc_wypozyczen
FROM(
    SELECT Miasto_hd.id_miasta, Marka_hd.id_marki, COUNT(Wypozyczenie_hd.id_wypozyczenie) AS ilosc_wypozyczen
    FROM Wypozyczenie_hd, Marka_hd, Miasto_hd
    WHERE Wypozyczenie_hd.id_miasta=Miasto_hd.id_miasta
    AND Wypozyczenie_hd.id_marki=Marka_hd.id_marki
    GROUP BY ROLLUP(Miasto_hd.id_miasta, Marka_hd.id_marki)
) P, Marka_hd, Miasto_hd
WHERE P.id_marki=Marka_hd.id_marki(+)
AND P.id_miasta=Miasto_hd.id_miasta(+)
ORDER BY Miasto_hd.nazwa_miasta ASC, Marka_hd.nazwa_marki DESC;

--3. Zapytanie typu ROLLUP zwracajace ilosc wypozyczonych samochodow, z danym typem nadwozia przez mezczyzn i kobiety dla danego regionu.
SELECT NVL(wojewodztwo_hd.nazwa_wojewodztwa,'Razem') nazwa_wojewodztwa, NVL(typ_nadwozia_hd.nazwa_typu,'Razem') nazwa_typu, mezczyzni, kobiety
FROM(
    SELECT wojewodztwo_hd.id_wojewodztwo, typ_nadwozia_hd.id_typu_nadwozia,
    SUM(CASE WHEN SUBSTR(klient_hd.pesel,10,1) IN ('0','2','4','6','8') THEN 1 ELSE 0 END) AS mezczyzni,
    SUM(CASE WHEN SUBSTR(klient_hd.pesel,10,1) IN ('1','3','5','7','9') THEN 1 ELSE 0 END) AS kobiety
    FROM wojewodztwo_hd,wypozyczenie_hd,typ_nadwozia_hd,klient_hd
    WHERE wypozyczenie_hd.id_wojewodztwo = wojewodztwo_hd.id_wojewodztwo AND
    wypozyczenie_hd.id_typu_nadwozia = typ_nadwozia_hd.id_typu_nadwozia AND
    wypozyczenie_hd.id_klienta = klient_hd.id_klienta
    GROUP BY ROLLUP(wojewodztwo_hd.id_wojewodztwo, typ_nadwozia_hd.id_typu_nadwozia)
) P, wojewodztwo_hd, typ_nadwozia_hd
WHERE P.id_wojewodztwo = wojewodztwo_hd.id_wojewodztwo(+) AND
P.id_typu_nadwozia = typ_nadwozia_hd.id_typu_nadwozia(+)
ORDER BY wojewodztwo_hd.nazwa_wojewodztwa ASC,typ_nadwozia_hd.nazwa_typu ASC;