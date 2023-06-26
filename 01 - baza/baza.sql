CREATE TABLE Rodzaj_silnika( 
	id_rodzaju NUMBER(2) CONSTRAINT rodzaj_silnika_pk PRIMARY KEY,
	nazwa_rodzaju VARCHAR2(20)
);

CREATE TABLE Rodzaj_zasilania(
	id_zasilania NUMBER(1) CONSTRAINT rodzaj_zasilania_pk PRIMARY KEY,
	nazwa_rodzaju VARCHAR2(20)
);

CREATE TABLE Silnik(
	id_silnika NUMBER(5) CONSTRAINT silnik_pk PRIMARY KEY,
	ilosc_KM VARCHAR2(4),
	moc VARCHAR2(6),
	pojemnosc VARCHAR2(4),
	id_zasilania NUMBER(1) CONSTRAINT rodzaj_zasilania_pk_fk REFERENCES Rodzaj_zasilania(id_zasilania),
	id_rodzaju NUMBER(2) CONSTRAINT rodzaj_silnika_fk REFERENCES Rodzaj_silnika(id_rodzaju)
);

CREATE TABLE Kategoria(
	id_kategorii NUMBER(2) CONSTRAINT kategoria_pk PRIMARY KEY,
	nazwa_kategorii VARCHAR2(20)
);

CREATE TABLE Uklad_hamulcowy(
	id_ukladu_hamulcowego NUMBER(2) CONSTRAINT uklad_hamulcowy_pk PRIMARY KEY,
	rodzaj_ukladu_hamulcowego VARCHAR2(20)
);

CREATE TABLE Rodzaj_skrzyni_biegow( 
	id_rodzaju NUMBER(1) CONSTRAINT rodzaj_skrzyni_biegow_pk PRIMARY KEY,
	nazwa_rodzaju VARCHAR2(20)
);

CREATE TABLE Skrzynia_biegow(
	id_skrzyni_biegow NUMBER(2) CONSTRAINT skrzynia_biegow_pk PRIMARY KEY,
	ilosc_biegow VARCHAR2(2),
	id_rodzaju NUMBER(2) CONSTRAINT rodzaj_skrzyni_biegow_fk REFERENCES Rodzaj_skrzyni_biegow(id_rodzaju)
);

CREATE TABLE Kolor(
	id_koloru NUMBER(2) CONSTRAINT kolor_pk PRIMARY KEY,
	nazwa_koloru VARCHAR2(20)
);

CREATE TABLE Typ_nadwozia( 
	id_typu_nadwozia NUMBER(2) CONSTRAINT typ_nadwozia_pk PRIMARY KEY,
	nazwa_typu VARCHAR2(20)
);

CREATE TABLE Nadwozie(
	id_nadwozia NUMBER(5) CONSTRAINT nadwozie_pk PRIMARY KEY,
	pojemnosc VARCHAR2(4),
	ilosc_siedzen VARCHAR2(2),
	ilosc_drzwi VARCHAR2(1),
	dlugosc VARCHAR2(4),
	szerokosc VARCHAR2(4),
	wysokosc VARCHAR2(4),
	id_typu_nadwozia NUMBER(2) CONSTRAINT id_typu_nadwozia_fk REFERENCES Typ_nadwozia(id_typu_nadwozia)
);

CREATE TABLE Marka(
	id_marki NUMBER(3) CONSTRAINT marka_pk PRIMARY KEY,
	nazwa_marki VARCHAR2(30)
);

CREATE TABLE Model(
	id_modelu NUMBER(5) CONSTRAINT model_pk PRIMARY KEY,
	nazwa_modelu VARCHAR2(30)
);

CREATE TABLE Samochod(
	id_samochodu NUMBER(5) CONSTRAINT samochod_pk PRIMARY KEY,
	nr_rejestracyjny VARCHAR2(7),
	numer_VIN VARCHAR2(17),
	wartosc VARCHAR2(8),
	cena_za_godzine VARCHAR2(6),
	id_marki NUMBER(3) CONSTRAINT id_marki_fk REFERENCES Marka(id_marki),
	id_koloru NUMBER(2) CONSTRAINT id_koloru_fk REFERENCES Kolor(id_koloru),
	id_nadwozia NUMBER(5) CONSTRAINT id_nadwozia_fk REFERENCES Nadwozie(id_nadwozia),
	id_skrzyni_biegow NUMBER(2) CONSTRAINT id_skrzyni_biegow_fk REFERENCES Skrzynia_biegow(id_skrzyni_biegow),
	id_ukladu_hamulcowego NUMBER(2) CONSTRAINT id_ukladu_hamulcowego_fk REFERENCES Uklad_hamulcowy(id_ukladu_hamulcowego),
	id_silnika NUMBER(5) CONSTRAINT id_silnika_fk REFERENCES Silnik(id_silnika),
	id_modelu NUMBER(5) CONSTRAINT id_modelu_fk REFERENCES Model(id_modelu),
	id_kategorii NUMBER(2) CONSTRAINT id_kategorii_fk REFERENCES Kategoria(id_kategorii)
);

CREATE TABLE Platnosc(
	id_platnosci NUMBER(2) CONSTRAINT platnosc_pk PRIMARY KEY,
	rodzaj_platnosci VARCHAR2(20)
);

CREATE TABLE Pracownik(
	id_pracownika NUMBER(4) CONSTRAINT pracownik_pk PRIMARY KEY,
	imie VARCHAR2(50),
	nazwisko VARCHAR2(50),
	data_zatrudnienia DATE,
	pensja VARCHAR2(8)
);

CREATE TABLE Wojewodztwo( 
	id_wojewodztwa NUMBER(2) CONSTRAINT wojewodztwo_pk PRIMARY KEY,
	nazwa_wojewodztwa VARCHAR2(50)
);

CREATE TABLE Miasto(
	id_miasta NUMBER(3) CONSTRAINT miasto_pk PRIMARY KEY,
	nazwa_miasta VARCHAR2(50),
	id_wojewodztwa NUMBER(2) CONSTRAINT id_wojewodztwa_fk REFERENCES Wojewodztwo(id_wojewodztwa)
);

CREATE TABLE Ulica(
	id_ulicy NUMBER(6) CONSTRAINT ulica_pk PRIMARY KEY,
	nazwa_ulicy VARCHAR2(40),
	numer_ulicy VARCHAR2(3),
	id_miasta NUMBER(3) CONSTRAINT id_miasta_fk REFERENCES Miasto(id_miasta)
);

CREATE TABLE Klient(
	id_klienta NUMBER(5) CONSTRAINT klient_pk PRIMARY KEY,
    imie VARCHAR2(50),
	nazwisko VARCHAR2(50),
	pesel VARCHAR2(11),
	nr_domu VARCHAR2(3),
	nr_telefonu VARCHAR2(9),
	id_ulicy NUMBER(6) CONSTRAINT id_ulicy_fk REFERENCES Ulica(id_ulicy)
);

CREATE TABLE Wypozyczenie(
	id_wypozyczenie NUMBER(7) CONSTRAINT wypozyczenie_pk PRIMARY KEY,
	data_wypozyczenia DATE,
	data_oddania DATE,
	ilosc_godzin VARCHAR2(3),
    koszt VARCHAR2(7),
	id_platnosci NUMBER(2) CONSTRAINT id_platnosci_fk REFERENCES Platnosc(id_platnosci),
	id_samochodu NUMBER(5) CONSTRAINT id_samochodu_fk REFERENCES Samochod(id_samochodu),
	id_klienta NUMBER(5) CONSTRAINT id_klienta_fk REFERENCES Klient(id_klienta),
	id_pracownika_p NUMBER(4) CONSTRAINT id_pracownika_p_fk REFERENCES Pracownik(id_pracownika),
	id_pracownika_o NUMBER(4) CONSTRAINT id_pracownika_o_fk REFERENCES Pracownik(id_pracownika),
	id_ulicy NUMBER(6) CONSTRAINT id_ulicy_wypozyczenie_fk REFERENCES Ulica(id_ulicy)
);
