--FUNKCJE RANKINGOWE
--1. Zapytanie typu FUNKCJA RANKINGUJACA zwracajaca miasta wypozyczajace najdrozsze samochody.
SELECT Miasto.nazwa_miasta, RANK() OVER (ORDER BY MAX(Samochod.wartosc) DESC) AS miejsce
FROM Wypozyczenie, Ulica, Miasto, Samochod
WHERE Wypozyczenie.id_ulicy=Ulica.id_ulicy
AND Ulica.id_miasta=Miasto.id_miasta
AND Wypozyczenie.id_samochodu=Samochod.id_samochodu
GROUP BY Miasto.nazwa_miasta
ORDER BY miejsce ASC;

--2. Zapytanie typu FUNKCJA RANKINGUJACA zwracajaca ranking pracownikow z danego regionu ktorzy wypozyczyli najwiecej samochodow danej kategorii
SELECT wojewodztwo.nazwa_wojewodztwa,miasto.nazwa_miasta, pracownik.id_pracownika, pracownik.imie, pracownik.nazwisko,
count(wypozyczenie.id_wypozyczenie) ile, 
RANK() over (ORDER BY count(wypozyczenie.id_wypozyczenie) DESC ) ranking
FROM miasto, ulica, pracownik, wypozyczenie, wojewodztwo
WHERE
wypozyczenie.id_ulicy = ulica.id_ulicy AND
ulica.id_miasta = miasto.id_miasta AND
pracownik.id_pracownika = wypozyczenie.id_pracownika_p AND
miasto.id_wojewodztwa = wojewodztwo.id_wojewodztwa
GROUP BY wojewodztwo.nazwa_wojewodztwa,miasto.nazwa_miasta, pracownik.id_pracownika,pracownik.imie, pracownik.nazwisko
ORDER BY wojewodztwo.nazwa_wojewodztwa ASC, miasto.nazwa_miasta ASC, pracownik.id_pracownika ASC,ranking DESC;

--3. Zapytanie typu FUNKCJA RANKINGUJACA zwracajaca ktore metody platnosci byly najczesciej wybierane przy wypozyczeniu samochodu danego modelu w danym regionie.
SELECT wojewodztwo.nazwa_wojewodztwa, platnosc.rodzaj_platnosci, model.nazwa_modelu, count(wypozyczenie.id_platnosci) ile,
DENSE_RANK() over (ORDER BY count(wypozyczenie.id_platnosci) DESC) ranking
FROM wypozyczenie, samochod, model, platnosc, ulica, miasto, wojewodztwo
WHERE
wypozyczenie.id_ulicy = ulica.id_ulicy AND
ulica.id_miasta = miasto.id_miasta AND
miasto.id_wojewodztwa = wojewodztwo.id_wojewodztwa AND
wypozyczenie.id_samochodu = samochod.id_samochodu AND
samochod.id_modelu = model.id_modelu AND
wypozyczenie.id_platnosci = platnosc.id_platnosci
GROUP BY wojewodztwo.nazwa_wojewodztwa, platnosc.rodzaj_platnosci, model.nazwa_modelu
ORDER BY wojewodztwo.nazwa_wojewodztwa ASC, platnosc.rodzaj_platnosci ASC, model.nazwa_modelu ASC,ranking DESC;
