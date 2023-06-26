--PARTYCJA OBLICZENIOWA
--1. Zapytanie typu PARTYCJA OBLICZENIOWA ukazujace koszt dla wypozyczenia danego samochodu, sume kosztow wypozyczen tego samochodu i procentowy udzial wypozyczenia
--tego samochodu z danym miesiacu dla danego roku w danym wojewodztwie
SELECT wojewodztwo_hd.nazwa_wojewodztwa, miesiac_hd.nr_miesiaca, samochod_hd.nr_rejestracyjny, TO_NUMBER(wypozyczenie_hd.koszt,'9999.99') koszt,
SUM(TO_NUMBER(wypozyczenie_hd.koszt,'9999.99')) OVER
(PARTITION BY samochod_hd.id_samochodu) suma, round(100*TO_NUMBER(wypozyczenie_hd.koszt,'9999.99')/(sum(TO_NUMBER(wypozyczenie_hd.koszt,'9999.99'))
over (PARTITION BY samochod_hd.id_samochodu))) "udzial %"
FROM wojewodztwo_hd, wypozyczenie_hd, samochod_hd, miesiac_hd
WHERE wypozyczenie_hd.id_samochodu = samochod_hd.id_samochodu AND
wypozyczenie_hd.id_wojewodztwo = wojewodztwo_hd.id_wojewodztwo AND
wypozyczenie_hd.id_miesiaca_w = miesiac_hd.id_miesiaca
ORDER BY wojewodztwo_hd.nazwa_wojewodztwa ASC, miesiac_hd.nr_miesiaca ASC;

--2. Zapytanie typu PARTYCJA OBLICZENIOWA zwracajace ilosc wypozyczen danego samochodu, z danym typem silnika w danym roku i w danym regionie
SELECT DISTINCT rok_hd.nr_roku, wojewodztwo_hd.nazwa_wojewodztwa, rodzaj_silnika_hd.nazwa_rodzaju,count(wypozyczenie_hd.id_wypozyczenie) over
(partition by wojewodztwo_hd.nazwa_wojewodztwa,rodzaj_silnika_hd.nazwa_rodzaju) ile
FROM wypozyczenie_hd, rok_hd, rodzaj_silnika_hd, wojewodztwo_hd
WHERE wypozyczenie_hd.id_roku_o = rok_hd.id_roku AND
wypozyczenie_hd.id_silnika = rodzaj_silnika_hd.id_silnika AND
wypozyczenie_hd.id_wojewodztwo = wojewodztwo_hd.id_wojewodztwo
ORDER BY rok_hd.nr_roku DESC, wojewodztwo_hd.nazwa_wojewodztwa DESC, rodzaj_silnika_hd.nazwa_rodzaju ASC;

--3. Zapytanie typu PARTYCJA OBLICZENIOWA zwracajace maksymalna i minimalna wartosc (cene za godzine) wypozyczonego samochodu, danej marki dla danego dnia, miesiaca.
SELECT DISTINCT Marka_hd.nazwa_marki AS marka, Dzien_hd.nr_dnia AS dzien, Miesiac_hd.nr_miesiaca AS miesiac, Rok_hd.id_roku AS rok,
MAX(Samochod_hd.cena_za_godzine) OVER (PARTITION BY Dzien_hd.nr_dnia, Miesiac_hd.nr_miesiaca, Rok_hd.id_roku) AS max_koszt,
MIN(Samochod_hd.cena_za_godzine) OVER (PARTITION BY Dzien_hd.nr_dnia, Miesiac_hd.nr_miesiaca, Rok_hd.id_roku) AS min_koszt
FROM Samochod_hd, Wypozyczenie_hd, Dzien_hd, Miesiac_hd, Rok_hd, Marka_hd
WHERE Wypozyczenie_hd.id_samochodu=Samochod_hd.id_samochodu
AND Wypozyczenie_hd.id_dnia_w=Dzien_hd.id_dnia
AND Wypozyczenie_hd.id_miesiaca_w=Miesiac_hd.id_miesiaca
AND Wypozyczenie_hd.id_roku_w=Rok_hd.id_roku
AND Wypozyczenie_hd.id_marki=Marka_hd.id_marki
ORDER BY marka, rok, miesiac, dzien;