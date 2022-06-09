CREATE DATABASE firma CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci;

USE firma;

CREATE TABLE pracownik (
	id INT PRIMARY KEY AUTO_INCREMENT,
	imie VARCHAR(30) NOT NULL,
	nazwisko VARCHAR(30) NOT NULL,
    wynagrodzenie DOUBLE(9,2),
    data_urodzenia DATE,
    stanowisko VARCHAR(20)
);

INSERT INTO pracownik
	(imie, nazwisko, wynagrodzenie, data_urodzenia, stanowisko)
VALUES
	('Michał', 'Wójcik', 12450.00, '1982-01-01', 'kierownik zespołu'),
	('Andrzej', 'Kaczmarek', 3859.00, '1997-11-25', 'stażysta'),
	('Monika', 'Biełczyk', 5720.00, '1993-11-25', 'konstruktor'),
	('Aldona', 'Nieszporek', 10720.00, '1988-08-11', 'starszy konstruktor'),
	('Rafał', 'Witczak', 14500.00, '1980-08-11', 'główny konstruktor'),
	('Aleksandra', 'Jasnowska', 17500.00, '1983-10-10', 'członek rady konstruktorskiej'),
	('Wiktor', 'Urbański', 9880.00, '1991-12-12', 'starszy konstruktor'),
    ('Arnold', 'Zielony', 5400, '1997-11-25', 'konstruktor');
    
SELECT * FROM pracownik ORDER BY nazwisko;
    
SELECT * FROM pracownik WHERE stanowisko = 'starszy konstruktor';
    
SELECT * FROM pracownik WHERE DATEDIFF(CURDATE(), data_urodzenia) >= 30*365.2425;
    
UPDATE pracownik SET wynagrodzenie = wynagrodzenie*1.1 WHERE stanowisko = 'stażysta';
    
SELECT * FROM pracownik WHERE data_urodzenia = (SELECT MAX(data_urodzenia) FROM pracownik);
    
DROP TABLE pracownik;
    
CREATE TABLE stanowisko(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nazwa_stanowiska VARCHAR(30) NOT NULL,
	opis VARCHAR(200),
	wynagrodzenie_bazowe DOUBLE(9,2)
);

INSERT INTO stanowisko
	(nazwa_stanowiska, opis, wynagrodzenie_bazowe)
VALUES
	('kierownik zespołu', 'osoba zarządzająca zespołem (5-20 osób)', 13000),
	('stażysta', 'początkujący pracownik bez doświadczenia', 4000),
	('konstruktor', 'inżynier z działu konstrukcyjnego (na ogół 1-4 lata doświadczenia)', 6000),
	('starszy konstruktor', 'inżynier z działu konstrukcyjnego będący samodzielnym pracownikiem (na ogół od 3-5 lat doświadczenia)', 10000),
	('główny konstruktor', 'inżyniew z działu konstrukcyjnego wyróżniający się wiedzą i bogactwem doświadczenia, pełni rolę mentorską', 14000),
	('członek rady konstruktorskiej', 'prowadzi nadzór nad pracami konstrukcyjnymi, pełni rolę mentorską, wszystkie zmiany konstrukcyjne oraz nowe projekty muszą zostać zatwierdzone przez członków rady konstrukcyjnej', 17500);

SELECT * FROM stanowisko;

CREATE TABLE adres(
	id INT PRIMARY KEY AUTO_INCREMENT,
    ulica_i_nr_domu VARCHAR(70) NOT NULL,
    miasto VARCHAR(50) NOT NULL,
    kod_pocztowy VARCHAR(5) NOT NULL    
);   

INSERT INTO adres
	(ulica_i_nr_domu, miasto, kod_pocztowy)
VALUES
	('Sieradzka 1A/4', 'Jelonki', '05231'),
	('Skórka 21', 'Jelonki', '05231'),
    ('Wójtowska 21', 'Zdrój', '05225'),
    ('55', 'Zwady', '05300'),
    ('21', 'Zwady', '05300'),
    ('Ignacka 60/12', 'Ogólniki', '05232'),
    ('Pagórek 1', 'Ogólniki', '05232'),
    ('Zielona', 'Ogólniki', '05232');
    
SELECT * FROM adres;

CREATE TABLE pracownik(
	id INT PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR (30) NOT NULL,
    nazwisko VARCHAR(30) NOT NULL,
    adres_id INT,
    stanowisko_id INT NOT NULL,
    CONSTRAINT fk_adres_id FOREIGN KEY (adres_id) REFERENCES adres(id),
    CONSTRAINT fk_stanowisko_id FOREIGN KEY (stanowisko_id) REFERENCES stanowisko(id)
);

INSERT INTO pracownik
	(imie, nazwisko, adres_id, stanowisko_id)
VALUES
	('Michał', 'Wójcik', 1, 1),
	('Andrzej', 'Kaczmarek', 2, 2),
	('Monika', 'Biełczyk', 3, 3),
	('Aldona', 'Nieszporek', 4, 4),
	('Rafał', 'Witczak', 5, 5),
	('Aleksandra', 'Jasnowska', 6, 6),
	('Wiktor', 'Urbański', 7, 2),
    ('Arnold', 'Zielony', 8, 3);
    
SELECT imie, nazwisko, ulica_i_nr_domu, miasto, kod_pocztowy, nazwa_stanowiska, wynagrodzenie_bazowe FROM pracownik p
JOIN adres a ON p.adres_id = a.id
JOIN stanowisko s ON p.stanowisko_id = s.id;

SELECT SUM(wynagrodzenie_bazowe) FROM pracownik p
JOIN adres a ON p.adres_id = a.id
JOIN stanowisko s ON p.stanowisko_id = s.id;

SELECT imie, nazwisko, ulica_i_nr_domu, miasto, kod_pocztowy, nazwa_stanowiska, wynagrodzenie_bazowe FROM pracownik p
JOIN adres a ON p.adres_id = a.id
JOIN stanowisko s ON p.stanowisko_id = s.id
WHERE kod_pocztowy = '05232';

DROP SCHEMA firma;

