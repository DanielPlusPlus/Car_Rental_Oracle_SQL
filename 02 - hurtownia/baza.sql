CREATE TABLE Wojewodztwo_HD(
	id_wojewodztwo NUMBER(2) CONSTRAINT wojewodztwo_hd_pk PRIMARY KEY,
	nazwa_wojewodztwa VARCHAR2(30)
);

CREATE TABLE Typ_nadwozia_HD( 
	id_typu_nadwozia NUMBER(2) CONSTRAINT typ_nadwozia_hd_pk PRIMARY KEY,
	nazwa_typu VARCHAR2(20)
);

CREATE TABLE Rodzaj_skrzyni_biegow_HD( 
	id_rodzaju_skrzyni_biegow NUMBER(1) CONSTRAINT rodzaj_skrzyni_biegow_hd_pk PRIMARY KEY,
	nazwa_rodzaju VARCHAR2(20)
);

CREATE TABLE Marka_HD( 
	id_marki NUMBER(3) CONSTRAINT marka_hd_pk PRIMARY KEY,
	nazwa_marki VARCHAR2(30)
);

CREATE TABLE Rok_HD(
	id_roku NUMBER(4) CONSTRAINT rok_hd_pk PRIMARY KEY,
	nr_roku VARCHAR2(4)
);

CREATE TABLE Pracownik_HD(
	id_pracownika NUMBER(4) CONSTRAINT pracownik_hd_pk PRIMARY KEY,
	imie VARCHAR2(50),
	nazwisko VARCHAR2(50)
);

CREATE TABLE Rodzaj_silnika_HD( 
	id_silnika NUMBER(2) CONSTRAINT rodzaj_silnika_hd_pk PRIMARY KEY,
	nazwa_rodzaju VARCHAR2(20)
);

CREATE TABLE Miesiac_HD(
	id_miesiaca NUMBER(2) CONSTRAINT miesiac_hd_pk PRIMARY KEY,
	nr_miesiaca VARCHAR2(2)
);

CREATE TABLE Dzien_HD(
	id_dnia NUMBER(2) CONSTRAINT dzien_hd_pk PRIMARY KEY,
	nr_dnia VARCHAR2(2)
);

CREATE TABLE Klient_HD(
	id_klienta NUMBER(5) CONSTRAINT klient_hd_pk PRIMARY KEY,
    imie VARCHAR2(50),
	nazwisko VARCHAR2(50),
	pesel VARCHAR2(11)
);

CREATE TABLE Rodzaj_zasilania_HD(
	id_rodzaju_zasilania NUMBER(1) CONSTRAINT rodzaj_zasilania_hd_pk PRIMARY KEY,
	nazwa_rodzaju VARCHAR2(20)
);

CREATE TABLE Platnosc_HD(
	id_platnosci NUMBER(2) CONSTRAINT platnosc_hd_pk PRIMARY KEY,
	rodzaj_platnosci VARCHAR2(20)
);

CREATE TABLE Model_HD(
	id_modelu NUMBER(5) CONSTRAINT model_hd_pk PRIMARY KEY,
	nazwa_modelu VARCHAR2(30)
);

CREATE TABLE Miasto_HD(
	id_miasta NUMBER(3) CONSTRAINT miasto_hd_pk PRIMARY KEY,
	nazwa_miasta VARCHAR2(30)
);

CREATE TABLE Samochod_HD(
	id_samochodu NUMBER(5) CONSTRAINT samochod_hd_pk PRIMARY KEY,
	wartosc VARCHAR2(8),
	nr_rejestracyjny VARCHAR2(7),
	cena_za_godzine VARCHAR2(6)
);

CREATE TABLE Kolor_HD(
	id_koloru NUMBER(2) CONSTRAINT kolor_hd_pk PRIMARY KEY,
	nazwa_koloru VARCHAR2(20)
);

CREATE TABLE Kategoria_HD(
	id_kategorii NUMBER(2) CONSTRAINT kategoria_hd_pk PRIMARY KEY,
	nazwa_kategorii VARCHAR2(20)
);

CREATE TABLE Wypozyczenie_HD(
	id_wypozyczenie NUMBER(7) CONSTRAINT wypozyczenie_hd_pk PRIMARY KEY,
    koszt VARCHAR2(7),
	ilosc_godzin NUMBER(3),
	id_wojewodztwo NUMBER(2) CONSTRAINT id_wojewodztwo_hd_fk REFERENCES Wojewodztwo_HD(id_wojewodztwo),
	id_typu_nadwozia NUMBER(2) CONSTRAINT id_typu_nadwozia_hd_fk REFERENCES Typ_nadwozia_HD(id_typu_nadwozia),
	id_rodzaju_skrzyni_biegow NUMBER(1) CONSTRAINT id_rodzaju_skrzyni_biegow_hd_fk REFERENCES Rodzaj_skrzyni_biegow_HD(id_rodzaju_skrzyni_biegow),
	id_marki NUMBER(3) CONSTRAINT id_marki_hd_fk REFERENCES Marka_HD(id_marki),
	id_roku_w NUMBER(4) CONSTRAINT id_roku_hd_fk REFERENCES Rok_HD(id_roku),
	id_pracownika_o NUMBER(4) CONSTRAINT id_pracownika_o_hd_fk REFERENCES Pracownik_HD(id_pracownika),
	id_pracownika_p NUMBER(4) CONSTRAINT id_pracownika_p_hd_fk REFERENCES Pracownik_HD(id_pracownika),
	id_silnika NUMBER(2) CONSTRAINT id_silnika_hd_fk REFERENCES Rodzaj_silnika_HD(id_silnika),
	id_miesiaca_w NUMBER(2) CONSTRAINT id_miesiaca__hd_fk REFERENCES Miesiac_HD(id_miesiaca),
	id_dnia_w NUMBER(2) CONSTRAINT id_dnia_hd_fk REFERENCES Dzien_HD(id_dnia),
	id_klienta NUMBER(5) CONSTRAINT id_klienta_hd_fk REFERENCES Klient_HD(id_klienta),
	id_rodzaju_zasilania NUMBER(1) CONSTRAINT id_rodzaju_zasilania_hd_fk REFERENCES Rodzaj_zasilania_HD(id_rodzaju_zasilania),
	id_platnosci NUMBER(2) CONSTRAINT id_platnosci_hd_fk REFERENCES Platnosc_HD(id_platnosci),
	id_modelu NUMBER(5) CONSTRAINT id_modelu_hd_fk REFERENCES Model_HD(id_modelu),
	id_miasta NUMBER(3) CONSTRAINT id_miasta_hd_fk REFERENCES Miasto_HD(id_miasta),
	id_samochodu NUMBER(5) CONSTRAINT id_samochodu_hd_fk REFERENCES Samochod_HD(id_samochodu),
	id_koloru NUMBER(2) CONSTRAINT id_koloru_hd_fk REFERENCES Kolor_HD(id_koloru),
	id_kategorii NUMBER(2) CONSTRAINT id_kategorii_hd_fk REFERENCES Kategoria_HD(id_kategorii),
    id_roku_o NUMBER(4) CONSTRAINT id_roku_o_hd_fk REFERENCES Rok_HD(id_roku),
    id_miesiaca_o NUMBER(2) CONSTRAINT id_miesiaca_o_hd_fk REFERENCES Miesiac_HD(id_miesiaca),
    id_dnia_o NUMBER(2) CONSTRAINT id_dnia_hd_o_fk REFERENCES Dzien_HD(id_dnia)
);
