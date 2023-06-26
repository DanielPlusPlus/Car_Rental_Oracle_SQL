--FUNKCJE RANKINGOWE
--1. Zapytanie typu FUNKCJA RANKINGUJACA zwracajaca miasta wypozyczajace najdrozsze samochody.
SELECT Miasto_hd.nazwa_miasta, RANK() OVER (ORDER BY MAX(Samochod_hd.wartosc) DESC) AS miejsce
FROM Wypozyczenie_hd, Miasto_hd, Samochod_hd
WHERE Wypozyczenie_hd.id_miasta=Miasto_hd.id_miasta
AND Wypozyczenie_hd.id_samochodu=Samochod_hd.id_samochodu
GROUP BY Miasto_hd.nazwa_miasta
ORDER BY miejsce ASC;

--2. Zapytanie typu FUNKCJA RANKINGUJACA zwracajaca ranking pracownikow z danego regionu ktorzy wypozyczyli najwiecej samochodow danej kategorii
SELECT wojewodztwo_hd.nazwa_wojewodztwa, miasto_hd.nazwa_miasta, pracownik_hd.id_pracownika, pracownik_hd.imie, pracownik_hd.nazwisko,
count(wypozyczenie_hd.id_wypozyczenie) ile, 
RANK() over (ORDER BY count(wypozyczenie_hd.id_wypozyczenie) DESC ) ranking
FROM miasto_hd, pracownik_hd, wypozyczenie_hd, wojewodztwo_hd
WHERE
wypozyczenie_hd.id_miasta = miasto_hd.id_miasta AND
wypozyczenie_hd.id_wojewodztwo = wojewodztwo_hd.id_wojewodztwo AND
wypozyczenie_hd.id_pracownika_p = pracownik_hd.id_pracownika
GROUP BY wojewodztwo_hd.nazwa_wojewodztwa,miasto_hd.nazwa_miasta, pracownik_hd.id_pracownika,pracownik_hd.imie, pracownik_hd.nazwisko
ORDER BY wojewodztwo_hd.nazwa_wojewodztwa ASC, miasto_hd.nazwa_miasta ASC, pracownik_hd.id_pracownika ASC,ranking DESC;

--3. Zapytanie typu FUNKCJA RANKINGUJACA zwracajaca ktore metody platnosci byly najczesciej wybierane przy wypozyczeniu samochodu danego modelu w danym regionie.
SELECT wojewodztwo_hd.nazwa_wojewodztwa, platnosc_hd.rodzaj_platnosci, model_hd.nazwa_modelu, count(wypozyczenie_hd.id_platnosci) ile,
DENSE_RANK() over (ORDER BY count(wypozyczenie_hd.id_platnosci) DESC) ranking
FROM wypozyczenie_hd, model_hd, platnosc_hd,wojewodztwo_hd
WHERE
wypozyczenie_hd.id_wojewodztwo = wojewodztwo_hd.id_wojewodztwo AND
wypozyczenie_hd.id_platnosci = platnosc_hd.id_platnosci AND
wypozyczenie_hd.id_modelu = model_hd.id_modelu
GROUP BY wojewodztwo_hd.nazwa_wojewodztwa, platnosc_hd.rodzaj_platnosci, model_hd.nazwa_modelu
ORDER BY wojewodztwo_hd.nazwa_wojewodztwa ASC, platnosc_hd.rodzaj_platnosci ASC, model_hd.nazwa_modelu ASC,ranking DESC;