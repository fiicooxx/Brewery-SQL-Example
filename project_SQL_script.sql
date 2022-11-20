
CREATE DATABASE BrowarKraftowy
GO
USE BrowarKraftowy
GO

CREATE TABLE [dbo].[Piwo](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (50) UNIQUE NOT NULL,
	[Rodzaj] [nvarchar] (50) NOT NULL,
	[Skład] [nvarchar] (1000) NOT NULL,
	[Alkohol] [char] (10) NOT NULL,
	[WProdukcji] [char] (3) NOT NULL,
	[PuszkaButelka] [char] (7) NOT NULL)

CREATE TABLE [dbo].[Produkcja](
	[ID] [int] PRIMARY KEY IDENTITY,
	[PiwoID] [int] NOT NULL FOREIGN KEY REFERENCES Piwo(ID),
	[DataProdukcji] [datetime] NOT NULL,
	[DataPrzydatności] [datetime] NOT NULL,
	[Ilość_szt] [int] NOT NULL,
	[ZatwierdzenieRozlew] [bit] NOT NULL,
	[ZatwierdzenieMagazyn] [bit] NOT NULL)

CREATE TABLE [dbo].[Sekcja](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (50) UNIQUE NOT NULL)

CREATE TABLE [dbo].[Pracownicy](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Imie] [nvarchar] (50) NOT NULL,
	[Nazwisko] [nvarchar] (100) NOT NULL,
	[Email] [nvarchar] (100),
	[Telefon] [char] (9) NOT NULL,
	[PESEL] [char] (11) UNIQUE NOT NULL,
	[KodPocztowy] [char] (6) NOT NULL,
	[SekcjaID] [int] NOT NULL FOREIGN KEY REFERENCES Sekcja(ID),
	CONSTRAINT PracPeselCheck CHECK
	(PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CONSTRAINT PracTelefonCheck CHECK
	(Telefon LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CONSTRAINT PracKodCheck CHECK
	(KodPocztowy LIKE '[0-9][0-9][-][0-9][0-9][0-9]'))

CREATE TABLE [dbo].[Samochody](
	[ID] [int] PRIMARY KEY IDENTITY,
	[PracownikID] [int] FOREIGN KEY REFERENCES Pracownicy(ID),
	[Marka] [nvarchar] (50) NOT NULL,
	[Model] [nvarchar] (50) NOT NULL,
	[RokProdukcji] [char] (4) NOT NULL,
	[Rejestracja] [nvarchar] (10) UNIQUE NOT NULL,
	[Przeznaczenie] [nvarchar] (50) NOT NULL,
	CONSTRAINT RokProdCheck CHECK
	(RokProdukcji LIKE '[1-2][0-9][0-9][0-9]'))

CREATE TABLE [dbo].[Firmy](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (100) NOT NULL,
	[NIP] [nvarchar] (50) NOT NULL,
	[KodPocztowy] [char] (6) NOT NULL,
	[Miasto] [nvarchar] (50) NOT NULL,
	[Adres] [nvarchar] (100) NOT NULL,
	CONSTRAINT FirmaKodCheck CHECK
	(KodPocztowy LIKE '[0-9][0-9][-][0-9][0-9][0-9]'))

CREATE TABLE [dbo].[Klienci](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Imie] [nvarchar] (50) NOT NULL,
 	[Nazwisko] [nvarchar] (100) NOT NULL,
	[PESEL] [char] (11) UNIQUE NOT NULL,
	[Email] [nvarchar] (100) NOT NULL,
	[Telefon] [char] (9) NOT NULL,
	[FirmaID] [int] NULL,
	[Informacje] [nvarchar] (100),
	CONSTRAINT KlientPeselCheck CHECK
	(PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CONSTRAINT KlientTelefonCheck CHECK
	(Telefon LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))

CREATE TABLE [dbo].[Status](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (20) UNIQUE NOT NULL)

CREATE TABLE [dbo].[Zamówienia](
	[ID] [int] PRIMARY KEY IDENTITY,
	[StatusID] [int] NOT NULL FOREIGN KEY REFERENCES Status(ID),
	[DataZamówienia] [datetime] NOT NULL,
	[DataRealizacji] [datetime] NULL,
	[KlientID] [int] NOT NULL FOREIGN KEY REFERENCES Klienci(ID),
	[Kwota] [decimal] (8,3) NOT NULL,
	[Komentarze] [nvarchar] (100))
 
INSERT INTO Piwo (Nazwa, Rodzaj, Skład, Alkohol, WProdukcji, PuszkaButelka)
VALUES 
('Atak Chmielu', 'American IPA','woda, słody jęczmienne: pale ale, melanoidynowy, Carared®, Carapils®, chmiele (USA): Citra®, Simcoe®, Cascade, Amarillo®; drożdże SafAle™ US-05', '9.1%', 'Tak', 'Butelka'),
('Pierwsza Pomoc', 'Polski PILS', 'woda; słody jęczmienne pilzneński, monachijski typ II, Caramunich® Typ II, Carapils®, chmiele (PL): Marynka, Lubelski; drożdże dolnej fermentacji SaflAger™ W 34/70', '4.1%', 'Tak', 'Butelka'),
('Modern Drinking', 'West Coast IPA', 'woda; słody jęczmienne pale ale, Caraplils®; chmiel Mosaic® (USA): drożdże SafAle™ US-05.', '6.5%', 'Tak', 'Butelka'),
('A Ja Pale Ale', 'APA', 'woda; słody jęczmienne: pale ale, Caraamber®; chmiele (USA): Columbus, Centennial, Cascade, Simcoe®, Citra®; drożdże SafAle™ US-05.', '5.0%', 'Tak', 'Butelka'),
('Hazy Morning', 'American Pale IPA', 'woda; słód jęczmienny: pilzneński, Carapils®, słód pszeniczny jasny; płatki owsiane błyskawiczne; chmiele: na whirlpool: Citra®, Columbus®; na zimno do tanku: Citra®, Mosaic®, Engima®; drożdże Safale™ US-05.', '4.4%', 'Tak', 'Butelka'),
('Bawarka', 'Hefeweizen', 'woda, słód jęczmienny – pilzneński; słód pszeniczny jasny; chmiele (PL): Lubelski, Marynka; drożdże SafBrew™ WB-06.', '5.7%', 'Tak', 'Butelka'),
('Kwas XY', 'Catharina Sour', 'woda; słód jęczmienny pilzneński; słód pszeniczny; chmiel: do kotła- Flex, Lubelski (PL); przecier z marakui; drożdże Fermentis SafAle™ US-05;bakteria kwasu mlekowego SafSour LB 1™.', '4.7%', 'Tak', 'Butelka'),
('Kwas GAMMA', 'Raspberyy Sour', 'słód jeczmienny: pilznenski; sok z malin; chmiel (PL): lubelski; drożdże SafAle US-05; bakteria SafSour LB 01.', '5.0%', 'Tak', 'Butelka'),
('IIPPAA', 'West Coast Double IPA', 'woda, słod jęczmienny – pilzneński, cukier; chmiele: do kotła: Flex; na whirlpool: Citra®, Columbus®; na zimno do tanku: Citra®, Mosaic®, Simcoe®; drożdże Safale™ US-05.', '8.1%', 'Tak', 'Butelka'),
('Mini Maxi IPA', 'Non-alcoholic Session IPA', 'woda, słód jęczmienny: pilzneński, Carapils®, chmiele (USA) Citra® i Mosaic®, drożdże SafAle™ LA-01.', '0.0%', 'Tak', 'Butelka'),
('Dyniamit', 'Pumpkin ALE', 'woda, słody jęczmienne pale ale, Carapils®, Carared®; Biscuit; chmiele: (USA); Ahtanum™, Palisade, Wilamette; dynia pieczona, goździki, cynamon, imbir, mech irlandzki, drożdże SafBrew™ T-58. Surowce dla PINTY dostarcza Browamator®.', '6.0%', 'Nie', 'Butelka'),
('Ala Grodziskie', 'Grodziskie', 'woda, słod jęczmienny – pilzneński, cukier; chmiele: do kotła: Flex; na whirlpool: Citra®, Columbus®; na zimno do tanku: Citra®, Mosaic®, Simcoe®; drożdże Safale™ US-05.', '2.6%', 'Nie', 'Butelka'),
('Imperator Bałtycki', 'Imperial Baltic Porter', 'woda, słody jęczmienne: pilzneński, monachijski, wiedeński, Carabohemian®, Carafa® Special II; cukier; chmiele: do kotła: Flex, na whirlpool: Mosaic®, Centennial, Citra®, na zimno: Centennial, Citra®, El Dorado; drożdże: SafLager™ W34/70 / Contains the allergen: malted barley', '10.5%', 'Tak', 'Butelka'),
('Król Lata', 'Hoppy Oat Witbier', 'woda; słód jęczmienny pilzneński; słód pszeniczny jasny; płatki owsiane błyskawiczne; chmiel: Flex, Citra®, Lubelski; kolendra ziarnista; skórka gorzkiej pomarańczy; drożdże Safale ™ S-33.', '4.0%', 'Tak', 'Puszka'),
('Hazy Stavanger', 'TDH TIPA', 'woda, słody jęczmienny pilzneński, pszeniczny, owsiany; płatki owsiane, ryżowe; maltodekstryna; cukier; chmiele: do kotła: Flex, na whirlpool: Sabro®, Mosaic® Incognito; na zimno: Nelson Sauvin™, Sabro®, Mosaic® BBC; drożdże: London Ale III / Contains the allergens: barley malt, oat malt, wheat malt, flaked oats.', '10.2%', 'Tak', 'Puszka'),
('Wet Hop IPA', 'IPA', 'woda; słód jęczmienny pilzneński; płatki ryżowe błyskawiczne; chmiele (USA): do kotła – Flex®, Frozen Fresh Hops Simcoe®, Frozen Fresh Hops Cascade, Frozen Fresh Hops Azacca®; na zimno – Azacca®, Cryo Hops® Mosaic®, Simcoe®; drożdże SafAle™ US-05 / Contains the allergen: malted barley', '6.8%', 'Tak', 'Puszka'),
('Beskidy Pszeniczne', 'Pszeniczne', 'woda; słód jęczmienny, pilzneński, słód pszeniczny; chmiele (PL): Lubelski, Saaz (CZ); drożdże Safale™ WB-06.', '6.0%', 'Tak', 'Butelka')

INSERT INTO Produkcja (PiwoID, DataProdukcji, DataPrzydatności, Ilość_szt, ZatwierdzenieRozlew, ZatwierdzenieMagazyn)
VALUES
(1, '2021-08-02', '2022-05-02', 40000, '1', '1'),
(8, '2021-08-03', '2022-05-03', 25000, '1', '1'),
(7, '2021-08-04', '2022-05-04', 25000, '1', '1'),
(3, '2021-08-05', '2022-05-05', 37500, '1', '1'),
(1, '2021-08-06', '2022-05-06', 40000, '1', '1'),
(3, '2021-08-09', '2022-05-09', 39000, '1', '1'),
(6, '2021-08-10', '2022-05-10', 20000, '1', '1'),
(5, '2021-08-11', '2022-05-11', 10000, '1', '1'),
(11, '2021-08-12', '2022-05-12', 5000, '1', '1'),
(4, '2021-08-13', '2022-05-13', 40000, '1', '1'),
(10, '2021-08-16', '2022-05-16', 20000, '1', '1'),
(2, '2021-08-17', '2022-05-17', 25000, '1', '1'),
(14, '2021-08-18', '2022-05-18', 10000, '1', '1'),
(15, '2021-08-19', '2022-05-19', 10000, '1', '1'),
(12, '2021-08-20', '2022-05-20', 15000, '1', '1'),
(16, '2021-08-23', '2022-05-23', 27000, '1', '1'),
(13, '2021-08-24', '2022-05-24', 4000, '1', '1'),
(1, '2021-08-25', '2022-05-25', 39000, '1', '1'),
(2, '2021-08-26', '2022-05-26', 30000, '1', '1'),
(10, '2021-08-27', '2022-05-27', 25000, '1', '1'),
(8, '2021-08-30', '2022-05-30', 25000, '1', '1'),
(1, '2021-08-31', '2022-05-31', 38500, '1', '1'),
(9, '2021-09-01', '2022-06-01', 15000, '1', '1'),
(17, '2021-09-02', '2022-06-02', 10000, '1', '1'),
(1, '2021-09-03', '2022-06-03', 30000, '1', '1')

INSERT INTO Sekcja (Nazwa)
VALUES
('Założyciel'),
('Dyrektor'),
('Marketing'),
('Sprzedaż'),
('Sklep'),
('Produkcja'),
('Fermentownia'),
('Magazyn'),
('Rozlew'),
('Kierowca')

INSERT INTO Pracownicy (Imie, Nazwisko, Email, Telefon, PESEL, Kodpocztowy, SekcjaID)
VALUES
('Dawid', 'Szklarek', 'dawid.szklarek@browarkraft.pl', '265822420', '98070273637', '34-300', 1),
('Filip', 'Copija', 'filip.copija@browarkraft.pl', '692845006', '25041772558', '34-300', 2),
('Bartłomiej', 'Łabuz', 'bartlomiej.labuz@browarkraft.pl', '084603684', '74051752834', '34-300', 2),
('Oliwia', 'Goryl', 'oliwia.goryl@browarkraft.pl', '069651804', '90060556867', '34-300', 3),
('Jakub', 'Lach', 'jakub.lach@browarkraft.pl', '718093594', '77101077712', '34-300', 3),
('Jakub', 'Strzykawa', 'jakub.strzykawa@browarkraft.pl', '240710079', '83073011933', '34-300', 3),
('Jarosław', 'Copija', 'jaroslaw.copija@browarkraft.pl', '092957148', '29020424476', '34-300', 4),
('Marcin', 'Koralewski', 'marcin.koralewski@browarkraft.pl', '466366726', '56111265571', '34-300', 4),
('Jakub', 'Mikusek', 'jakub.mikusek@browarkraft.pl', '496467575', '51040459336', '34-300', 4),
('Damian', 'Grzegorczyk', 'damian.grzegorczyk@browarkraft.pl', '353559374', '58100735571', '34-300', 4),
('Dominik', 'Hendzel', 'dominik.hendzel@browarkraft.pl', '196062380', '70061573397', '34-300', 4),
('Artur', 'Kuczyński', 'artur.kuczynski@browarkraft.pl', '983427521', '77031891831', '34-300', 5),
('Adrian', 'Michalski', 'adrian.michalski@browarkraft.pl', '505871450', '64060837413', '34-300', 6),
('Dominik', 'Stokłosa', 'dominik.stoklosa@browarkraft.pl', '133830078', '98122753557', '34-300', 6),
('Marcin', 'Najman', 'marcin.najman@browarkraft.pl', '879222084', '61120957971', '34-300', 7),
('Grzegorz', 'Ferment', NULL, '172782539', '58052334435', '34-300', 7),
('Łukasz', 'Zuziak', NULL, '710194102', '98021148319', '34-300', 7),
('Barłomiej', 'Piątek', 'bartlomiej.piatek@browarkraft.pl', '515511275', '60071485717', '34-300', 8),
('Filip', 'Serwatka', NULL, '693862126', '80050328453', '34-300', 8),
('Roksana', 'Sypta', NULL, '032041561', '90060491942', '34-300', 8),
('Kamil', 'Groszek', NULL, '549014309', '59012876314', '34-300', 8),
('Aleksandra', 'Michta', NULL, '522304286', '80091875569', '34-300', 8),
('Arkardiusz', 'Pal', 'arek.pal@browarkraft.pl', '537251399', '51122419951', '34-300', 9),
('Błażej', 'Raczek', NULL, '052063494', '42021438853', '34-300', 9),
('Amelia', 'Raczek', NULL, '696837356', '51120137949', '34-300', 9),
('Oskar', 'Kliś', NULL, '313149378', '48050668531', '34-300', 9),
('Alicja', 'Matlas', NULL, '598895244', '93041893827', '34-300', 10),
('Adam', 'Chorąży', NULL, '816599225', '89082645895', '34-300', 10)

INSERT INTO Firmy (Nazwa, NIP, KodPocztowy, Miasto, Adres)
VALUES
('Kaufland', '9931742334', '30-215', 'Rabka Zdrój', 'ul. Na wzgórzu 42'),
('Tesco', '7233422312', '32-712', 'Nowy Sącz', 'ul. Krakowska 12'),
('Żabka', '9256345423', '02-250', 'Warszawa', 'ul. Krótka 32'),
('Lidl', '6722341245', '30-230', 'Kraków', 'ul. Informatyków 1'),
('Biedronka', '6792933459', '30-118', 'Kraków', 'ul. Rakowicka 27'),
('POLO', '9933451283', '30-702', 'Kraków', 'ul. Lipowa 3'),
('Hurtownika "Widzyk"', '9913451273', '00-212', 'Oświęcim', 'ul. Chemików 12'),
('BroHurt', '7452342345', '45-215', 'Warszawa', 'ul. Poznańska 18'),
('Ryś Market', '6452349827', '33-101', 'Tarnów', 'ul. I. Mościckiego 106'),
('Beskid-Hurt', '9571950285', '34-300', 'Żywiec', 'ul. Przemysłowa 20')

INSERT INTO Klienci (Imie, Nazwisko, PESEL, Email, Telefon, FirmaID, Informacje)
VALUES
('Artur', 'Szczepanek', '77101016997', 'artur.szczepanek@kauflandmarketing.com', '346553996', 1, '5 sklepów, dostawa w godzinach 7-12'),
('Magda', 'Kowaleczko', '92020832127', 'magdakowaleczko@tesco.com', '381262321', 2, '3 sklepy, dostawa w godziach 8-12'),
('Joanna', 'Worek', '77112033952', 'joanna.w@zabka.pl', '660121317', 3, 'Wyłącznie palety CHEP, pakowanie po 20 do kartonu'),
('Michał', 'Wawrzyniec', '94111291639', 'michwaw@gmail.com', '018774074', 4, 'Kartony x20, 2 rodzaje piwa w kartonie x10 sz.'),
('Roksana', 'Stańco', '95080351339', 'rokstan@gmail.com', '375592834', 5, 'Nowy klient, palety CHEP, 2 sklepy'),
('Wojtek', 'Banaś', '01272121521', 'wojtek.ban@gmail.com', '107129351', 6, 'Dostawy do Hurtowni w Nowej Hucie'),
('Krzysztof', 'Widzyk', '61051472884', 'krzyszwidz@gmail.com', '922700217', 7, 'Zamówienia wysyłać zawsze terminowo'),
('Michalina', 'Wysocka', '62081188448', 'michta@gmail.com', '813473666', 8, 'Klient odsyła źle ostreczowane palety'),
('Robert', 'Kolanko', '49091513213', 'kolankorober@gmail.com', '671394320', 9, ''),
('Filip', 'Beskidzki', '99060315726', 'filbeskid@gmail.com', '496776797', 10, 'Beskdzkie terytorium, tylko piwa serii "BESKIDY"'),
('Oskar', 'Wojciechowski', '72112324147', 'oskwok@gmail.com', '667904361', NULL, ''),
('Renata', 'Wandzel', '52022978766', 'wadzelrenata@gmail.com', '777917340', NULL, ''),
('Andrzej', 'Fijak', '57070677865', 'andrzejak@gmail.com', '944611291', NULL, 'dostawa na rynek w piątki o 12'),
('Konrad', 'Rosicki', '02301699796', 'konros@gmail.com', '477177604', NULL, 'restauracja sprzedaje tylko nasze piwo, przywozić podstawki'),
('Mateusz', 'Wajcha', '87060477164', 'matwah@gmail.com', '025826651', NULL, ''),
('Michał', 'Jakubiec', '57051983268', 'jakubmi@gmail.com', '011472502', NULL, ''),
('Zbigniew', 'Chrupek', '69010619729', 'zbigniew.chrupek@gmail.com', '512516925', NULL, 'nieuprzejmy klient'),
('Paweł', 'Policzek', '56042792984', 'paweł.policzek@onet.pl', '885519855', NULL, 'dobry sklep piwny, warto dawać gratisy'),
('Adam', 'Dertucha', '69031033339', 'adam.dertucha@gmail.com', '512418624', NULL, '')

INSERT INTO Status (Nazwa)
VALUES
('Zrealizowane'),
('W toku'),
('Anulowane')

INSERT INTO Zamówienia (StatusID, DataZamówienia, DataRealizacji, KlientID, Kwota, Komentarze)
VALUES
(1, '2021-07-01', '2021-07-05', 1 , 35.700, 'Kaufland Olsztyn'),
(1, '2021-07-02', '2021-07-06', 2, 25.300, ''),
(1, '2021-07-02', '2021-07-06', 3, 21.700, 'Sprawdzić przydatność'),
(1, '2021-07-02', '2021-07-06', 4, 20.000, 'Zwracać uwagę na PALETY'),
(1, '2021-07-04', '2021-07-11', 5, 10.000, 'Nowy klient, dopytać o miejsca dostaw'),
(1, '2021-07-04', '2021-07-19', 6 , 26.400, 'Hurtowna w Nowej Hucie Kraków'),
(1, '2021-07-06', '2021-07-09', 7, 19.800, 'Szybka dostawa'),
(1, '2021-07-06', '2021-07-12', 8, 15.000, 'Jakość pakunku'),
(1, '2021-07-10', '2021-07-12', 9, 7.450, ''),
(1, '2021-07-11', '2021-07-11', 10, 16.300, ''),
(1, '2021-07-16', '2021-07-17', 11, 0.500, 'Gastronomia'),
(3, '2021-07-17', NULL, 17, 0.300, 'Nie zapłacono!'),
(1, '2021-07-19', '2021-07-20', 15, 0.400, 'Gastronomia'),
(1, '2021-07-20', '2021-07-23', 13, 0.800, 'Gastronomia, Rynek Kraków'),
(1, '2021-07-20', '2021-07-23', 12, 0.200, 'Sklep'),
(1, '2021-07-20', '2021-07-23', 19, 0.450, 'Sklep'),
(1, '2021-07-23', '2021-07-24', 4, 15.000, 'Zwracać uwagę na PLETY'),
(2, '2021-07-23', '2021-07-24', 18, 0.700, 'Zamówienie wysłać 2021-08-01'),
(1, '2021-07-24', '2021-07-25', 19, 0.220, 'Sklep'),
(1, '2021-07-24', '2021-07-30', 14, 1.000, 'Gastronomia'),
(2, '2021-07-27', NULL, 16, 0.370, 'Oczekiwanie na płatność...'),
(1, '2021-07-30', '2021-08-02', 17, 0.450, 'Sklep'),
(2, '2021-07-31', '2021-08-13', 11, 0.650, 'Przekroczno czas oczekiwania')

INSERT INTO Samochody (PracownikID, Marka, Model, RokProdukcji, Rejestracja, Przeznaczenie)
VALUES
(2, 'Lexus', 'NX 350h', '2021', 'SZY 16473 ', 'Służbowe'),
(3, 'Lexus', 'NX 350h', '2021', 'SZY 2545W', 'Służbowe'),
(10, 'Kia', 'Ceed III', '2020', 'SZY 123KW', 'Praca'),
(11, 'Kia', 'Ceed III', '2020', 'SZY 98KI1', 'Praca'),
(9, 'Kia', 'Ceed III', '2020', 'SZY 0923C', 'Praca'),
(NULL, 'Renault', 'Traffic', '2018', 'WE 723UP', 'Dostawcze'),
(NULL, 'Renault', 'Traffic', '2018', 'WE 712DW', 'Dostawcze'),
(27, 'IVECO', 'EUROCARGO', '2017', 'WE 98238', 'Dostawcze'),
(28, 'IVECO', 'S-WAY', '2020', 'WE 8787H', 'Dostawcze')

 
/* Przygotowuje zapytanie, które zwraca nazwę oraz zawartość procentową piw, które mają powyżej 7% alkoholu */

CREATE VIEW [dbo].[v_WysokoProcentowe] AS
SELECT Nazwa + ' ' + Alkohol AS 'Wysoko procentowe Alkohole'
FROM Piwo
WHERE Alkohol LIKE '[7-9]%' OR Alkohol LIKE '__.__'

SELECT * FROM v_WysokoProcentowe

/* Zwraca imię oraz nazwisko klienta i zliczone wszystkie jego zamówienia, które zostały zrealizowane */

CREATE VIEW [dbo].[v_IloscZamowien] AS
SELECT Imie + ' ' + Nazwisko AS 'Klient',
COUNT(KlientID) AS Zamowienia
FROM Zamówienia Z
JOIN Klienci K ON K.ID = Z.KlientID
JOIN Status S ON S.ID = Z.StatusID
WHERE StatusID = 1
GROUP BY Imie + ' ' + Nazwisko

SELECT * FROM v_IloscZamowien

/* Informuje ile pracowników wykonuję daną funkcję w firmie */

CREATE VIEW [dbo].[v_IlePracownikow] AS
SELECT Nazwa AS Funkcja,
COUNT(SekcjaID) AS 'Ilość pracowników w sekcji'
FROM Sekcja S
JOIN Pracownicy P ON P.SekcjaID = S.ID
GROUP BY Nazwa

SELECT * FROM v_IlePracownikow

/* Widok zwraca informacje o kliencie, który najdłużej czekał na swoje zamówienie */

CREATE VIEW [dbo].[v_NajdluzejCzekajacy]
AS

SELECT TOP 1 Imie + ' ' + Nazwisko AS 'Imię i nazwisko',
	   Email, Telefon, DATEDIFF(DD, DataZamówienia, DataRealizacji) AS 'CZAS'
FROM Klienci K
	LEFT JOIN Zamówienia Z ON Z.KlientID = K.ID
ORDER BY DATEDIFF(DD, DataZamówienia, DataRealizacji) DESC

SELECT * FROM v_NajdluzejCzekajacy

/* Funkcja skalarna, która na podstawie największej ilości zamówień zwraca firmę klienta (tylko klienci, którzy posiadają firmę). */

CREATE FUNCTION FirmaNajwiecejZamowien()
RETURNS nvarchar(100)
AS
BEGIN
	DECLARE @W nvarchar(100)
	SET @W  = (SELECT TOP 1 F.Nazwa FROM Zamówienia AS Z
	LEFT JOIN Klienci K ON K.ID = Z.KlientID
	LEFT JOIN Firmy F ON F.ID = K.FirmaID
	WHERE F.Nazwa IS NOT NULL
	GROUP BY F.Nazwa
	ORDER BY COUNT(KlientID) DESC) 
	RETURN @W 
END 


SELECT [dbo].[FirmaNajwiecejZamowien]() AS 'Lider wsród zamówień'

/* Na podstawie PESELU z tabeli Pracownicy funkcja skalarna określa płeć pracownika oraz oddaje wartość NULL w przypadku, gdy PESEL nie należy do żadnego z pracowników */
CREATE FUNCTION SprawdzPlecPracownika
	(@PESEL char (11))
	RETURNS char (10)
	AS
	BEGIN
	DECLARE @Kobieta char(10), @Mezczyzna char(10), @Plec char(10)
	SET @Kobieta = (SELECT 'Kobieta' AS 'Płeć' FROM Pracownicy WHERE @PESEL = Pracownicy.PESEL)
	SET @Mezczyzna = (SELECT 'Mężczyzna' AS 'Płeć' FROM Pracownicy WHERE @PESEL = Pracownicy.PESEL)
	SET @Plec = (@Kobieta)
IF (@PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
	AND (SUBSTRING(@PESEL, 10, 1) % 2=0)) SET @Plec = (@Kobieta)
IF (@PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
	AND (SUBSTRING(@PESEL, 10, 1) % 2=1)) SET @Plec = (@Mezczyzna)
	RETURN @Plec
END

SELECT [dbo].[SprawdzPlecPracownika] (93041893827) AS 'Płeć'

/* Funkcja tabelaryczna, która na podstawie ID pracownika pokazuje jego stanowisko oraz samochód, który przypisała mu firma. W przypadku, gdy pracownik nie posiada przypisanego samochodu funkcja nie zwróci wartości */

CREATE FUNCTION PracownikInfo
	(@ID INT)
	RETURNS TABLE
	AS
	RETURN
		SELECT  Imie + ' ' + Nazwisko AS 'Imię i nazwisko',
				Marka AS 'Samochód',
				Nazwa AS 'Stanowisko'
		FROM Pracownicy P
		JOIN Samochody Sa ON P.ID = Sa.PracownikID
		JOIN Sekcja S ON Sa.PracownikID = S.ID		
		WHERE P.ID = @ID 

SELECT * FROM PracownikInfo(2)

/* Za pomocą ID zamówienia funkcja skalarna umożliwia nam odczytanie czasu jego realizacji */

CREATE FUNCTION CzasZamowienia
	(@ID INT)
RETURNS INT
AS
BEGIN
DECLARE @Data AS INT
SET @Data = (SELECT(DATEDIFF(DD, DataZamówienia, DataRealizacji)) 
			FROM Zamówienia
			WHERE StatusID = 1 AND @ID = ID)
RETURN @Data
END

SELECT [dbo].[CzasZamowienia] (18) AS 'Czas Realizacji'

/* Umożliwia dodanie firmy oraz uzupełnienie niezbędnych dla niej danych w tabeli */

CREATE PROCEDURE DodajFirme
	@Nazwa nvarchar (100),
	@NIP nvarchar (50),
	@KodPocztowy char (6),
	@Miasto nvarchar (50),
	@Adres nvarchar (100)
AS
BEGIN
	INSERT Firmy
	VALUES (@Nazwa, @NIP, @KodPocztowy, @Miasto, @Adres)
END

EXECUTE DodajFirme 'Dystrybucja Piw', '7233422888', '43-304', 'Bielsko-Biała', 'ul. Jazowa 70'

/* Tworzy procedurę, która aktualizuje status zamówienia na "zrealizowane" oraz uzupełnia datę realizacji i umożliwia zmianę/dodatnie komentarza. Procedurę można modyfikować w zależności od potrzeby */

CREATE PROCEDURE ZrealizujZamowienie
	@ZamowienieID INT,
	@DataRealizacji datetime,
	@Komentarz nvarchar(100)
AS
BEGIN
UPDATE Zamówienia
SET StatusID = 1
WHERE ID = @ZamowienieID
UPDATE Zamówienia
SET DataRealizacji = @DataRealizacji
WHERE ID = @ZamowienieID
UPDATE Zamówienia
SET Komentarze = @Komentarz
WHERE ID = @ZamowienieID
END

EXECUTE ZrealizujZamowienie 12, '2021-08-02', 'Uregulowano płatność'
-- przykład modyfikacji procedury, aby zmienić tylko komentarz dla danego zamówienia
ALTER PROCEDURE ZrealizujZamowienie
	@ZamowienieID INT,
	@Komentarz nvarchar(100)
AS
BEGIN
UPDATE Zamówienia
SET Komentarze = @Komentarz
WHERE ID = @ZamowienieID
END

EXECUTE ZrealizujZamowienie 1, 'Zabrakło kilku pozycji, uzupełnić przy następnym zamówieniu'

/* Procedura sprawdza skład oraz/lub rodzaj piwa za pomocą podanych przez nas parametrów tekstowych */

CREATE PROCEDURE SprawdzSklad
@Sklad nvarchar (1000),
@Rodzaj nvarchar (100),
@LICZ int OUTPUT
AS
BEGIN
	SET NOCOUNT ON 
	SET @LICZ = (SELECT COUNT(*)
				FROM Piwo
				WHERE Skład LIKE @Sklad AND Rodzaj LIKE @Rodzaj)
	SELECT Nazwa, Rodzaj, Skład, WProdukcji
	FROM Piwo
	WHERE Skład LIKE @Sklad AND Rodzaj LIKE @Rodzaj
END

DECLARE @LICZ INT
EXEC SprawdzSklad '%', 'IPA', @LICZ OUTPUT

/* Wyświetla zamówienia, które nie zostały zrealizowane, dane klienta oraz odpowiednie informacje o nim i komentarz do zamówienia - przydatne w celu zweryfikowania, dlaczego zamówienia nie zrealizowano */ 

SELECT StatusID, Imie + ' ' + Nazwisko AS 'Imię i nazwisko', Komentarze, Informacje
	FROM Klienci K
	JOIN Zamówienia Z ON Z.KlientID = K.ID
	WHERE StatusID != 1
SELECT * FROM Klienci

/* Zwraca butelkowane piwa, które aktualnie nie znajdują się w produkcji */

SELECT * FROM Piwo WHERE PuszkaButelka LIKE 'Butelka' AND WProdukcji LIKE 'NIE'

/* Informuje o zamówieniach powyżej 1000 zł w okresie od 4 lipca do 23 lipca */

SELECT StatusID, KlientID, Kwota 
FROM Zamówienia 
WHERE DataZamówienia BETWEEN '2021-07-04' AND '2021-07-23' AND Kwota > 1.000

/* Wykaz największej i najmniejszej produkcji do tej pory */

SELECT DISTINCT 
MAX(Ilość_szt) AS 'Największa produkcja',  
MIN(Ilość_szt) AS 'Najmniejsza produckja' 
FROM Produkcja 

/* Wyświetla imiona z całej bazy danych tak, aby się nie powtarzały w kolejności [A-Z] */

SELECT DISTINCT Imie FROM Pracownicy
UNION 
SELECT DISTINCT Imie FROM Klienci
ORDER BY Imie ASC

/* Wyświetla imiona z całej bazy danych razem z powtórzeniami w kolejności [Z-A] */

SELECT Imie FROM Pracownicy
UNION ALL
SELECT Imie FROM Klienci
ORDER BY Imie DESC

/* Wyświetla Średnią kwotę zamówień (w tys.), ich sumę oraz łączną ilosć */

SELECT ROUND(AVG(Kwota),2) AS Średnia, SUM(Kwota) AS Suma, COUNT(Kwota) AS 'Ilość transakcji'
FROM Zamówienia

/* Wykaz danych klientów oraz ich firm (klient bez firmy w przypadku jej braku) w malejacej kolejności łącznych kwot zamówień oraz ilość transakcji */

SELECT ISNULL(Nazwa, 'Klient bez firmy') AS 'Nazwa firmy',
		Imie + ' ' + Nazwisko AS 'Klient',
		SUM(Kwota) AS 'Łączna kwota zamówień',
		COUNT(Kwota) AS 'Ilość transakcji'
FROM Zamówienia Z
LEFT JOIN Klienci K ON Z.KlientID = K.ID
LEFT JOIN Firmy F ON F.ID = K.FirmaID
GROUP BY ISNULL(Nazwa, 'Klient bez firmy'), Imie + ' ' + Nazwisko 
ORDER BY SUM(Kwota) DESC

/* Pokazuje tabelę z ID Piwa oraz miesiącami, w którym zostało wyprodukowane. Również określa czy miesiąc to sierpień lub inny */

SELECT PiwoID, MONTH(DataProdukcji) AS 'Miesiac', 
		CASE WHEN(MONTH(DataProdukcji)) = 8 THEN 'Sierpień'
		ELSE 'Inny miesiąc' END AS Wynik
FROM Produkcja

/* Wyświetla ilość samochodów oraz ich przeznaczenie w firmie */

SELECT COUNT(Przeznaczenie) AS 'Słuzbowe/Dostawcze/Praca' FROM Samochody
WHERE Przeznaczenie = 'Służbowe' 
UNION ALL
SELECT COUNT(Przeznaczenie) FROM Samochody
WHERE Przeznaczenie = 'Dostawcze'
UNION ALL
SELECT COUNT(Przeznaczenie) FROM Samochody
WHERE Przeznaczenie = 'Praca'

/* Wyświetla najdłuższy i najkrótszy opis składu piwa */

SELECT MAX(LEN(Skład)) as 'Najdłuższy opis', MIN(LEN(Skład)) as 'Najkrótszy opis' FROM Piwo
