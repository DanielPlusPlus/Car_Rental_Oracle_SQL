CREATE OR REPLACE PROCEDURE insertIntoWojewodztwo
AS
BEGIN 
    INSERT INTO Wojewodztwo_HD
    SELECT * FROM Wojewodztwo;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoTypNadwozia
AS
BEGIN 
    INSERT INTO Typ_nadwozia_HD
    SELECT * FROM Typ_nadwozia;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoRodzajSkrzyniBiegow
AS
BEGIN 
    INSERT INTO Rodzaj_skrzyni_biegow_HD
    SELECT * FROM Rodzaj_skrzyni_biegow;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoMarka
AS
BEGIN 
    INSERT INTO Marka_HD
    SELECT * FROM Marka;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoRok
AS
BEGIN 
    INSERT INTO Rok_HD
    SELECT EXTRACT(year FROM Wypozyczenie.data_wypozyczenia), EXTRACT(year FROM Wypozyczenie.data_wypozyczenia)
    FROM Wypozyczenie
    UNION
    SELECT EXTRACT(year FROM Wypozyczenie.data_oddania), EXTRACT(year FROM Wypozyczenie.data_oddania)
    FROM Wypozyczenie;
    
END;
/
CREATE OR REPLACE PROCEDURE insertIntoPracownik
AS
BEGIN 
    INSERT INTO Pracownik_HD
    SELECT id_pracownika,imie,nazwisko FROM Pracownik;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoRodzajSilnika
AS
BEGIN 
    INSERT INTO Rodzaj_silnika_HD
    SELECT * FROM Rodzaj_silnika;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoMiesiac
AS
BEGIN 
    INSERT INTO Miesiac_HD
    SELECT EXTRACT(month FROM Wypozyczenie.data_wypozyczenia), EXTRACT(month FROM Wypozyczenie.data_wypozyczenia)
    FROM Wypozyczenie
    UNION
    SELECT EXTRACT(month FROM Wypozyczenie.data_oddania), EXTRACT(month FROM Wypozyczenie.data_oddania)
    FROM Wypozyczenie;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoDzien
AS
BEGIN 
    INSERT INTO Dzien_HD
    SELECT EXTRACT(day FROM Wypozyczenie.data_wypozyczenia), EXTRACT(day FROM Wypozyczenie.data_wypozyczenia)
    FROM Wypozyczenie
    UNION
    SELECT EXTRACT(day FROM Wypozyczenie.data_oddania), EXTRACT(day FROM Wypozyczenie.data_oddania)
    FROM Wypozyczenie;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoKlient
AS
BEGIN 
    INSERT INTO Klient_HD 
    SELECT id_klienta,imie,nazwisko,pesel FROM Klient;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoRodzajZasilania
AS
BEGIN 
    INSERT INTO Rodzaj_zasilania_HD
    SELECT * FROM Rodzaj_zasilania;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoPlatnosc
AS
BEGIN 
    INSERT INTO Platnosc_HD
    SELECT * FROM Platnosc;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoModel
AS
BEGIN 
    INSERT INTO Model_HD
    SELECT * FROM Model;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoMiasto
AS
BEGIN 
    INSERT INTO Miasto_HD
    SELECT id_miasta,nazwa_miasta FROM Miasto;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoSamochod
AS
BEGIN 
    INSERT INTO Samochod_HD
    SELECT id_samochodu, wartosc, nr_rejestracyjny, cena_za_godzine
    FROM Samochod;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoKolor
AS
BEGIN 
    INSERT INTO Kolor_HD
    SELECT * FROM Kolor;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoKategoria
AS
BEGIN 
    INSERT INTO Kategoria_HD
    SELECT * FROM Kategoria;
END;
/
CREATE OR REPLACE PROCEDURE insertIntoWypozyczenie
AS
BEGIN
    INSERT INTO Wypozyczenie_HD(id_wypozyczenie, koszt, ilosc_godzin,id_wojewodztwo,id_typu_nadwozia,id_rodzaju_skrzyni_biegow,
    id_marki,id_roku_w,id_pracownika_o,id_pracownika_p,id_silnika, id_miesiaca_w, id_dnia_w,id_klienta,id_rodzaju_zasilania, id_platnosci, id_modelu, 
    id_miasta, id_samochodu, id_koloru, id_kategorii,id_roku_o, id_miesiaca_o, id_dnia_o)
    SELECT Wypozyczenie.id_wypozyczenie, Wypozyczenie.koszt, Wypozyczenie.ilosc_godzin,Wojewodztwo.id_wojewodztwa,Typ_nadwozia.id_typu_nadwozia, 
    Rodzaj_skrzyni_biegow.id_rodzaju, Marka.id_marki, EXTRACT(year FROM Wypozyczenie.data_wypozyczenia),Wypozyczenie.id_pracownika_o,Wypozyczenie.id_pracownika_p,
    Rodzaj_silnika.id_rodzaju,EXTRACT(month FROM Wypozyczenie.data_wypozyczenia),EXTRACT(day FROM Wypozyczenie.data_wypozyczenia), Klient.id_klienta, Rodzaj_zasilania.id_zasilania,
    Platnosc.id_platnosci, Model.id_modelu, Miasto.id_miasta, Samochod.id_samochodu, Kolor.id_koloru, Kategoria.id_kategorii,
    EXTRACT(year FROM Wypozyczenie.data_oddania),EXTRACT(month FROM Wypozyczenie.data_oddania),EXTRACT(day FROM Wypozyczenie.data_oddania)
    FROM Wypozyczenie, Ulica, Miasto, WOjewodztwo, Samochod, Kolor, Kategoria, Model, Platnosc, Klient, Silnik, Rodzaj_silnika, Marka, Typ_nadwozia, Nadwozie,
    Skrzynia_biegow, Rodzaj_skrzyni_biegow, Rodzaj_zasilania
    WHERE Wypozyczenie.id_ulicy = Ulica.id_ulicy AND
    Ulica.id_miasta = Miasto.id_miasta AND
    Miasto.id_wojewodztwa = Wojewodztwo.id_wojewodztwa AND
    Wypozyczenie.id_samochodu = Samochod.id_samochodu AND
    Samochod.id_koloru = Kolor.id_koloru AND
    Samochod.id_kategorii = Kategoria.id_kategorii AND
    Samochod.id_modelu = Model.id_modelu AND
    Wypozyczenie.id_platnosci = Platnosc.id_platnosci AND
    Wypozyczenie.id_klienta = Klient.id_klienta AND
    Samochod.id_silnika = Silnik.id_silnika AND
    Silnik.id_rodzaju = Rodzaj_silnika.id_rodzaju AND
    Samochod.id_marki = Marka.id_marki AND
    Samochod.id_nadwozia = Nadwozie.id_nadwozia AND
    Nadwozie.id_typu_nadwozia = Typ_nadwozia.id_typu_nadwozia AND
    Samochod.id_skrzyni_biegow = Skrzynia_biegow.id_skrzyni_biegow AND
    Skrzynia_biegow.id_rodzaju = Rodzaj_Skrzyni_biegow.id_rodzaju AND
    Silnik.id_zasilania = Rodzaj_zasilania.id_zasilania;
    
    EXECUTE IMMEDIATE 'ALTER TABLE Wypozyczenie_HD DISABLE CONSTRAINT id_roku_hd_fk';
    EXECUTE IMMEDIATE 'ALTER TABLE Wypozyczenie_HD DISABLE CONSTRAINT id_roku_o_hd_fk';
    EXECUTE IMMEDIATE 'ALTER TABLE Rok_HD DISABLE CONSTRAINT rok_hd_pk';
    DECLARE
        counter NUMBER := 1;
    BEGIN
        FOR rec IN (SELECT id_roku, nr_roku FROM Rok_HD ORDER BY nr_roku) LOOP
            UPDATE Rok_HD SET id_roku = counter WHERE id_roku = rec.id_roku;
            counter := counter + 1;
        END LOOP;
    END;
    BEGIN
        FOR rec IN (SELECT id_wypozyczenie, id_roku_w FROM Wypozyczenie_HD) LOOP
            UPDATE Wypozyczenie_HD SET id_roku_w = (SELECT id_roku FROM Rok_HD WHERE nr_roku = rec.id_roku_w) WHERE id_wypozyczenie = rec.id_wypozyczenie;
        END LOOP;
    END;
    BEGIN
        FOR rec IN (SELECT id_wypozyczenie, id_roku_o FROM Wypozyczenie_HD) LOOP
            UPDATE Wypozyczenie_HD SET id_roku_o = (SELECT id_roku FROM Rok_HD WHERE nr_roku = rec.id_roku_o) WHERE id_wypozyczenie = rec.id_wypozyczenie;
        END LOOP;
    END;
    EXECUTE IMMEDIATE 'ALTER TABLE Rok_HD ENABLE CONSTRAINT rok_hd_pk';
    EXECUTE IMMEDIATE 'ALTER TABLE Wypozyczenie_HD ENABLE CONSTRAINT id_roku_o_hd_fk';
    EXECUTE IMMEDIATE 'ALTER TABLE Wypozyczenie_HD ENABLE CONSTRAINT id_roku_hd_fk';
END;
/
EXECUTE insertIntoWojewodztwo;
EXECUTE insertIntoTypNadwozia;
EXECUTE insertIntoRodzajSkrzyniBiegow;
EXECUTE insertIntoMarka;
EXECUTE insertIntoRok;
EXECUTE insertIntoPracownik;
EXECUTE insertIntoRodzajSilnika;
EXECUTE insertIntoMiesiac;
EXECUTE insertIntoDzien;
EXECUTE insertIntoKlient;
EXECUTE insertIntoRodzajZasilania;
EXECUTE insertIntoPlatnosc;
EXECUTE insertIntoModel;
EXECUTE insertIntoMiasto;
EXECUTE insertIntoSamochod;
EXECUTE insertIntoKolor;
EXECUTE insertIntoKategoria;
EXECUTE insertIntoWypozyczenie;
