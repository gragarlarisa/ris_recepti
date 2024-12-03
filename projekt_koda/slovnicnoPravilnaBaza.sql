-- Ustvarjanje baze podatkov
DROP DATABASE IF EXISTS ReceptiNaDlani; 
CREATE DATABASE ReceptiNaDlani;
USE ReceptiNaDlani;



/*
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON ReceptiNaDlani.* TO 'admin'@'localhost';
CREATE USER 'root'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON receptinadlani.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
*/




-- Ustvarjanje tabel
DROP TABLE IF EXISTS Recept;
DROP TABLE IF EXISTS Vpisan_Uporabnik;
DROP TABLE IF EXISTS Regionalna_Kuhinja;
DROP TABLE IF EXISTS Prehranske_Omejitve;
DROP TABLE IF EXISTS Kategorija_Skupno;
DROP TABLE IF EXISTS Obrok;
DROP TABLE IF EXISTS Korak_Postopka;
DROP TABLE IF EXISTS Komentarji;
DROP TABLE IF EXISTS Sestavine;
DROP TABLE IF EXISTS Recept_Sestavine;


CREATE TABLE Vpisan_Uporabnik (
    ID_Vpisan_Uporabnik INT PRIMARY KEY AUTO_INCREMENT,
    Ime VARCHAR(255) NOT NULL,
    Priimek VARCHAR (255) NOT NULL,
    Elektronski_Naslov VARCHAR(255) NOT NULL,
    Geslo VARCHAR(255) NOT NULL,
    Administrator TINYINT NOT NULL,
    Avatar VARCHAR(255) NULL
);

CREATE TABLE Regionalna_Kuhinja (
    ID_Regionalna_Kuhinja INT PRIMARY KEY AUTO_INCREMENT,
    Naziv VARCHAR(255) NOT NULL
);

CREATE TABLE Obrok (
    ID_Obrok INT PRIMARY KEY AUTO_INCREMENT,
    Naziv VARCHAR(255) NOT NULL
);

CREATE TABLE Recept (
    ID_Recept INT PRIMARY KEY AUTO_INCREMENT,
    Naziv VARCHAR(255) NOT NULL,
    Opis TEXT NOT NULL,
    Slika TEXT NOT NULL,
    Priprava_Minute INT NOT NULL,
    Stevilo_Oseb INT NOT NULL,
    Tezavnost INT NOT NULL,
    Javen TINYINT NOT NULL,
    Datum_Objave DATE NULL,
    Datum_Zadnje_Spremembe DATE NULL,
    TK_Vpisan_Uporabnik INT  NULL,
    TK_Regionalna_Kuhinja INT NULL,
    TK_Obrok INT NOT NULL,
    FOREIGN KEY (TK_Vpisan_Uporabnik) REFERENCES Vpisan_Uporabnik (ID_Vpisan_Uporabnik),
    FOREIGN KEY (TK_Regionalna_Kuhinja) REFERENCES Regionalna_Kuhinja (ID_Regionalna_Kuhinja),
    FOREIGN KEY (TK_Obrok) REFERENCES Obrok (ID_Obrok)

);


CREATE TABLE Prehranske_Omejitve (
    ID_Prehranske_Omejitve INT PRIMARY KEY AUTO_INCREMENT,
    Naziv VARCHAR(255) NOT NULL
);

CREATE TABLE Kategorija_Skupno (
    ID_Kategorija_Skupno INT PRIMARY KEY AUTO_INCREMENT,
    TK_Recept INT NOT NULL,
    TK_Prehranske_Omejitve INT NOT NULL,
    FOREIGN KEY (TK_Prehranske_Omejitve) REFERENCES Prehranske_Omejitve(ID_Prehranske_Omejitve),
    FOREIGN KEY (TK_Recept) REFERENCES Recept(ID_Recept)
ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Korak_Postopka (
    ID_Korak_Postopka INT PRIMARY KEY AUTO_INCREMENT,
    Postopek TEXT NOT NULL,
    St_Koraka INT NULL,
    TK_Recept INT NOT NULL,
    FOREIGN KEY (TK_Recept) REFERENCES Recept(ID_Recept)
ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Komentarji (
    ID_Komentar INT PRIMARY KEY AUTO_INCREMENT,
    Vsebina TEXT NOT NULL,
    Datum DATETIME NOT NULL,
    Ocena INT NOT NULL,
    TK_Recept INT NOT NULL,
    TK_Vpisan_Uporabnik INT NOT NULL,
    FOREIGN KEY (TK_Recept) REFERENCES Recept(ID_Recept),
    FOREIGN KEY (TK_Vpisan_Uporabnik) REFERENCES Vpisan_Uporabnik(ID_Vpisan_Uporabnik)
ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Sestavine (
    ID_Sestavine INT PRIMARY KEY AUTO_INCREMENT,
    Naziv TEXT NOT NULL,
    Kolicina INT NULL,
    Enota VARCHAR(255) NULL
);

CREATE TABLE Recept_Sestavine (
    ID_Recept_Sestavine INT PRIMARY KEY AUTO_INCREMENT,
    TK_Recept INT NOT NULL,
    TK_Sestavine INT NOT NULL,
    FOREIGN KEY (TK_Recept) REFERENCES Recept(ID_Recept),
    FOREIGN KEY (TK_Sestavine) REFERENCES Sestavine(ID_Sestavine)
ON DELETE RESTRICT ON UPDATE CASCADE
);

ALTER TABLE Korak_Postopka
DROP FOREIGN KEY korak_postopka_ibfk_1;

ALTER TABLE Korak_Postopka
ADD CONSTRAINT korak_postopka_ibfk_1
FOREIGN KEY (TK_Recept) REFERENCES Recept(ID_Recept)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Komentarji
DROP FOREIGN KEY Komentarji_ibfk_1;

ALTER TABLE Komentarji
ADD CONSTRAINT Komentarji_ibfk_1
FOREIGN KEY (TK_Recept) REFERENCES Recept(ID_Recept)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Kategorija_Skupno
DROP FOREIGN KEY Kategorija_Skupno_ibfk_2;

ALTER TABLE Kategorija_Skupno
ADD CONSTRAINT Kategorija_Skupno_ibfk_2
FOREIGN KEY (TK_Recept) REFERENCES Recept(ID_Recept)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Recept_Sestavine
DROP FOREIGN KEY Recept_Sestavine_ibfk_1;

ALTER TABLE Recept_Sestavine
ADD CONSTRAINT Recept_Sestavine_ibfk_1
FOREIGN KEY (TK_Recept) REFERENCES Recept(ID_Recept)
ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO Vpisan_Uporabnik (Ime, Priimek, Elektronski_Naslov, Geslo, Administrator) VALUES
('Maja', 'Kovacic', 'maja.kovacic@example.com', 'geslo123', 0),
('Peter', 'Novak', 'peter.novak@example.com', 'varnoGeslo', 0),
('Ana', 'Vidic', 'ana.vidic@example.com', 'anaVidic', 0),
('Igor', 'Kovacic', 'igor.kovacic@example.com', 'igorK2024', 0),
('Ursa', 'Mihelic', 'ursa.mihelic@example.com', 'ursaM123', 0),
('Miha', 'Zupan', 'miha.zupan@example.com', 'mihaZupan', 0),
('Sara', 'Horvat', 'sara.horvat@example.com', 'saraH2024', 0),
('Luka', 'Zagar', 'luka.zagar@example.com', 'lukaZagar', 0),
('Eva', 'Kos', 'eva.kos@example.com', 'evaK123', 0),
('Gregor', 'Novak', 'gregor.novak@example.com', 'gregorN2024', 0),
('Urska', 'Pirc', 'urska.pirc@example.com', 'urskaP', 0),
('Alen', 'Kobal', 'alen.kobal@example.com', 'alenKobal', 0),
('Anja', 'Zupancic', 'anja.zupancic@example.com', 'anjaZu123', 0),
('Matej', 'Krajnc', 'matej.krajnc@example.com', 'matejKrajnc', 0),
('Nina', 'Matic', 'nina.matic@example.com', 'ninaMatic', 0),
('Jure', 'Kos', 'jure.kos@example.com', 'jureKos', 0),
('Zala', 'Hribar', 'zala.hribar@example.com', 'zalaHribar', 0),
('Blaz', 'Potocnik', 'blaz.potocnik@example.com', 'blazP', 0),
('Ema', 'Babic', 'ema.babic@example.com', 'emaB', 0),
('Nejc', 'Horvat', 'nejc.horvat@example.com', 'nejcH123', 0),
('Katja', 'Meznar', 'katja.meznar@example.com', 'katjaMeznar', 0),
('Alen', 'Kralj', 'alen.kralj@example.com', 'alenKralj', 0),
('Ana', 'Petrovic', 'ana.petrovic@example.com', 'anaPetrovic', 0),
('Rok', 'Zupanc', 'rok.zupanc@example.com', 'rokZupanc', 0),
('Eva', 'Vidmar', 'eva.vidmar@example.com', 'evaVidmar', 0),
('Maja', 'Lah', 'maja.lah@example.com', 'majaLah', 0),
('Ziga', 'Zupan', 'ziga.zupan@example.com', 'zigaZupan', 0),
('Urska', 'Kos', 'urska.kos@example.com', 'urskaKos', 0),
('Andrej', 'Babic', 'andrej.babic@example.com', 'andrejB', 0),
('Anja', 'Majcen', 'anja.majcen@example.com', 'anjaMajcen', 0),
('Miha', 'Potocnik', 'miha.potocnik@example.com', 'mihaPotocnik', 0),
('Ursa', 'Lah', 'ursa.lah@example.com', 'ursaLah', 0),
('Mitja', 'Kralj', 'mitja.kralj@example.com', 'mitjaK123', 0),
('Neza', 'Horvat', 'neza.horvat@example.com', 'nezaH2024', 0),
('Marko', 'Zupan', 'marko.zupan@example.com', 'markoZupan', 0),
('Sara', 'Petrovic', 'sara.petrovic@example.com', 'saraPetrovic', 0),
('Luka', 'Kos', 'luka.kos@example.com', 'lukaK123', 0),
('Ema', 'Zupancic', 'ema.zupancic@example.com', 'emaZupancic', 0),
('Anja', 'Krajnc', 'anja.krajnc@example.com', 'anjaKrajnc', 0),
('Nejc', 'Vidmar', 'nejc.vidmar@example.com', 'nejcVidmar', 0),
('Ursa', 'Meznar', 'ursa.meznar@example.com', 'ursaMeznar', 0),
('Alen', 'Vidic', 'alen.vidic@example.com', 'alenVidic', 0),
('Eva', 'Kralj', 'eva.kralj@example.com', 'evaKralj', 0),
('Nejc', 'Krajnc', 'nejc.krajnc@example.com', 'nejcKrajnc', 0),
('Anja', 'Zupan', 'anja.zupan@example.com', 'anjaZupan', 0),
('Alen', 'Potocnik', 'alen.potocnik@example.com', 'alenPotocnik', 0),
('Urska', 'Kos', 'urska.kos@example.com', 'dfds', 0),
('Ana', 'Kos', 'ana.kos@example.com', 'aaasdsf', 0),
('Jana', 'Kos', 'jana.kos@example.com', 'urssfasfsakaKos', 0),
('Nina', 'Kos', 'nina.kos@example.com', 'saf', 0),
('Jure', 'Jan', 'jure.jan@example.com', 'jureJan123', 0),
('Manca', 'Lah', 'manca.lah@example.com', 'mancaLah', 0),
('Tadej', 'Horvat', 'tadej.horvat@example.com', 'tadejH123', 0),
('Mojca', 'Novak', 'mojca.novak@example.com', 'mojcaN2024', 0),
('Zoran', 'Kobal', 'zoran.kobal@example.com', 'zoranKobal', 0),
('Metka', 'Majcen', 'metka.majcen@example.com', 'metkaMajcen', 0),
('Lea', 'Hribar', 'lea.hribar@example.com', 'leaHribar', 0),
('Nik', 'Pirc', 'nik.pirc@example.com', 'nikPirc', 0),
('Vesna', 'Potocnik', 'vesna.potocnik@example.com', 'vesnaP', 0),
('Matjaz', 'Krajnc', 'matjaz.krajnc@example.com', 'matjazKrajnc', 0),
('Mihaela', 'Kos', 'mihaela.kos@example.com', 'mihaelaKos', 0),
('Klara', 'Zupanc', 'klara.zupanc@example.com', 'klaraZupanc', 0),
('Andrej', 'Novak', 'andrej.novak@example.com', 'andrejNovak', 0),
('Katja', 'Kralj', 'katja.kralj@example.com', 'katjaKralj', 0),
('Spela', 'Zupan', 'spela.zupan@example.com', 'spelaZupan', 0),
('Simon', 'Kos', 'simon.kos@example.com', 'simonKos', 0),
('Barbara', 'Vidic', 'barbara.vidic@example.com', 'barbaraVidic', 0),
('Luka', 'Kobal', 'luka.kobal@example.com', 'lukaKobal', 0),
('Petra', 'Vidmar', 'petra.vidmar@example.com', 'petraVidmar', 0),
('Tomaz', 'Zupanc', 'tomaz.zupanc@example.com', 'tomazZupanc', 0),
('Lea', 'Majcen', 'lea.majcen@example.com', 'leaMajcen', 0),
('Miran', 'Kos', 'miran.kos@example.com', 'miranKos', 0),
('Vanja', 'Horvat', 'vanja.horvat@example.com', 'vanjaH2024', 0),
('Katja', 'Potocnik', 'katja.potocnik@example.com', 'katjaP', 0),
('Miha', 'Zupan', 'miha.zupan@example.com', 'mihaZ123', 0),
('Anja', 'Kovacic', 'anja.kovacic@example.com', 'anjaKovacic', 0),
('Alen', 'Kos', 'alen.kos@example.com', 'alenKos', 0),
('Ziga', 'Novak', 'ziga.novak@example.com', 'zigaNovak', 0),
('Eva', 'Kos', 'eva.kos@example.com', 'evaKos', 0),
('Mitja', 'Zupanc', 'mitja.zupanc@example.com', 'mitjaZupanc', 0),
('Lea', 'Hribar', 'lea.hribar@example.com', 'leaHribar2024', 0),
('Blaz', 'Krajnc', 'blaz.krajnc@example.com', 'blazKrajnc', 0),
('Jure', 'Kos', 'jure.kos@example.com', 'jureKos2024', 0),
('Sara', 'Meznar', 'sara.meznar@example.com', 'saraMeznar', 0),
('Igor', 'Kovacic', 'igor.kovacic@example.com', 'igorKovacic', 0),
('Ema', 'Vidmar', 'ema.vidmar@example.com', 'emaVidmar', 0),
('Tina', 'Novak', 'tina.novak@example.com', 'tinaNovak', 0),
('Simon', 'Kos', 'simon.kos@example.com', 'simonKos123', 0),
('Marta', 'Pirc', 'marta.pirc@example.com', 'martaPirc', 0),
('Zala', 'Kralj', 'zala.kralj@example.com', 'zalaKralj', 0),
('Matjaz', 'Kobal', 'matjaz.kobal@example.com', 'matjazKobal', 0),
('Metka', 'Zupancic', 'metka.zupancic@example.com', 'metkaZupancic', 0),
('Sasa', 'Hribar', 'sasa.hribar@example.com', 'sasaHribar', 0),
('Darja', 'Majcen', 'darja.majcen@example.com', 'darjaMajcen', 0),
('Nina', 'Pirc', 'nina.pirc@example.com', 'ninaPirc', 0),
('Anja', 'Zupan', 'anja.zupan@example.com', 'anjaZupan123', 0),
('Matej', 'Kralj', 'matej.kralj@example.com', 'matejKralj', 0),
('Gregor', 'Hribar', 'gregor.hribar@example.com', 'gregorHribar', 0),
('Ema', 'Potocnik', 'ema.potocnik@example.com', 'emaPotocnik', 0),
('Tina', 'Kos', 'tina.kos@example.com', 'tinaKos', 0),
('Mojca', 'Pirc', 'mojca.pirc@example.com', 'mojcaPirc', 0),
('Janez', 'Kos', 'janez.kos@example.com', 'janezKos', 0),
('Alen', 'Majcen', 'alen.majcen@example.com', 'alenMajcen', 0),
('Klara', 'Hribar', 'klara.hribar@example.com', 'klaraHribar', 0),
('Andrej', 'Zupanc', 'andrej.zupanc@example.com', 'andrejZupanc', 0),
('Marta', 'Kos', 'marta.kos@example.com', 'martaKos', 0),
('Katja', 'Zupanc', 'katja.zupanc@example.com', 'katjaZupanc', 0),
('Mojca', 'Kralj', 'mojca.kralj@example.com', 'mojcaKralj', 0),
('Ziga', 'Potocnik', 'ziga.potocnik@example.com', 'zigaPotocnik', 0),
('Jana', 'Vidic', 'jana.vidic@example.com', 'janaVidic', 0),
('Alen', 'Hribar', 'alen.hribar@example.com', 'alenHribar', 0),
('Ema', 'Kos', 'ema.kos@example.com', 'emaKos2024', 0),
('Darja', 'Zupan', 'darja.zupan@example.com', 'darjaZupan', 0),
('Spela', 'Kos', 'spela.kos@example.com', 'spelaKos', 0),
('Katja', 'Krajnc', 'katja.krajnc@example.com', 'katjaKrajnc', 0),
('Admin', 'User', 'admin@example.com', '$2b$10vpisan_uporabnik$wvI9JfNMBy8sFrk1CnSA/eQMyyS8vPq0JH6o9DMmdtjceL4hcZoKC', 1),
('Admin', 'User', 'admin@example.com', '$2b$10vpisan_uporabnik$wvI9JfNMBy8sFrk1CnSA/eQMyyS8vPq0JH6o9DMmdtjceL4hcZoKC', 1);

INSERT INTO Obrok (ID_Obrok, Naziv) VALUES
(1, 'Zajtrk'),
(2, 'Kosilo'),
(3, 'Večerja'),
(4, 'Sladica'),
(5, 'Prigrizek');



INSERT INTO Regionalna_Kuhinja (Naziv) VALUES
('Mediteranska'),
('Mehiška'),
('Kitajska'),
('Japonska'),
('Indijska');







INSERT INTO Recept (Naziv, Opis, Slika, Priprava_Minute, Stevilo_Oseb, Tezavnost, Javen, Datum_Objave, Datum_Zadnje_Spremembe, TK_Vpisan_Uporabnik, TK_Regionalna_Kuhinja, TK_Obrok ) VALUES 
('Česnove rolice s zeliščnim maslom', 'Da ne bomo vedno pekli le sladkih dobrot, tokrat pripravimo izjemno mehke rolice iz mlečnega testa, ki v svojih spiralah skrivajo obilico česnovega nadeva.', 'images_food/cesnovi_polzki.jpg', 90, 4, 3, 1, '2023-05-10', NULL, 23, NULL, 1), -- ID_RECEPT = 1
('Ovsena kaša s pomarančo', 'Če je za tabo grenek dan, ni boljšega načina, da ga zaključiš, kot s kremno ovseno kašo z osvežilno pomarančo in sladkimi jabolki.', 'images_food/ovsenakasa.jpg', 20, 1, 2, 1, '2019-03-03', NULL, 1, NULL, 1), -- ID_RECEPT = 2
('Poširana jajca iz mikrovalovne pečice', 'Najlepše možno jutro zagotovo vključuje poširana jajčka, ki veselo ždijo na skladovnici iz opečenega kruhka, zrnatega sira in dimljenega lososa.', 'images_food/posiranajajca.jpg', 10, 1, 2, 1, '2019-03-03', '2024-05-16', 2, NULL, 1), -- ID_RECEPT = 3
('Prekonočni ovseni kosmiči s cimetom', 'Pripravi danes, kar lahko poješ jutri! Prav nobenega izgovora nimaš, da se ne bi vsak tvoj dan pričel z bogatim, hranilnim in dobrim zajtrkom.', 'images_food/prekonočniovsenikosmiči.jpeg', 10, 2, 1, 1, '2019-03-03', '2024-05-16', 4, NULL, 1), -- ID_RECEPT = 4
('Juha iz sladkega krompirja', 'Tale juha se poje ravno tako začinjena, kot se skuha! Ti jesensko hladni in mokri dnevi kar kličejo po dobri kremni župi, ki razvedri duha in ogreje telo. ', 'images_food/juhaizsladkegakrompirja.jpg', 40, 4, 1, 1, '2019-03-03', '2024-05-16', 6, NULL, 1), -- ID_RECEPT = 5
('Španska omleta z gobicami', 'Dober okus ji ni španska vas. Tale krompirjeva omleta navduši s polnim okusom po jeseni, saj se med plastmi krompirja skrivajo tako šampinjoni kot sušeni jurčki.', 'images_food/spanskaomletazgobicami.jpg', 60, 4, 2, 1, '2019-07-04', '2021-01-16', 15, NULL, 1), -- ID_RECEPT = 6
('Ajdova kaša z gobami in olivnim oljem', 'Zgodnjejesenska ajdova kaša z zvitimi lisičkami in tolažilnimi jurčki.', 'images_food/ajdovakasazgobamiindimljenimoljem.jpg', 30, 4, 2, 1, '2018-03-13', NULL, 19, NULL, 1), -- ID_RECEPT = 7
('Avokado toast z dimljenim lososom', 'Pikantna kremnost z dimljeno čepico in hrustljavimi temelji. Tole je pa prava bomba, ki z eksplozijo okusov odlično začne ali pa konča tvoj dan.', 'images_food/avokadotoastzdimljenimlososom.jpg', 15, 2, 1, 1, '2019-03-02', NULL, 12, NULL, 1), -- ID_RECEPT = 8
('Solata z ajdovo kašo in bučo', 'Kdo pravi, da morajo biti solate dolgočasne? Tale te bo nasitila pa s svojim izrazitim jesenskim okusom tudi narisala nasmešek na obraz! V njej se skriva ajdova kaša, pečena hokaido buča in lešniki.', 'images_food/solatazajdovokasoinbuco.jpg', 40, 4, 1, 1, '2019-03-03', '2024-05-16', 5, NULL, 1), -- ID_RECEPT =  9
('Tikka masala s piščancem', 'Indijska kulinarika velja za eno najbolj čislanih, predvsem zaradi mojstrskega kombiniranja začimb.', 'images_food/tikkamasalaspiscancem.jpg', 90, 4, 1, 1, '2019-03-03', '2024-05-16', 5, NULL, 2), -- ID_RECEPT = 10
('Ekspresna čičerikina enolončnica', 'Starošolska kuharija nas posredno uči, da je okusnost enolončnice premo sorazmerna času njenega brbotanja. ', 'images_food/ekspresnacicerikinaenoloncnica.jpg', 30, 4, 1, 1, '2020-10-02', NULL, 5, NULL, 2), -- ID_RECEPT = 11
('Piščančji file s timijanom in limono', 'Najprej file dobro začinimo in ga popečemo z obeh strani. Po kratkem obisku pečice pa ga le še glaziramo z maslom, zelišči in limono.', 'images_food/piscancjifile.jpg', 30, 5, 1, 1, '2019-03-03', '2024-05-16', 30, NULL, 2), -- ID_RECEPT = 12
('Špageti carbonara', 'Špageti carbonara so izvrstna klasika, ki pa lahko na krožniku izgleda malce dolgočasno.', 'images_food/spageticarbonara.jpg', 30, 4, 1, 1,'2019-03-03', '2024-05-16', 10, NULL, 2), -- ID_RECEPT = 13
('Mesne kroglice', 'Da ob nedeljskem kosilu ne bi vsi zbrani zehali na polna usta, jih presenetimo s klasiko v moderni preobleki – s pečenicami v obliki sočnih mesnih kroglic, ki se namakajo v gosti omaki s kislim zeljem.', 'images_food/mesnekroglice.jpg', 60, 4, 2, 1, '2019-03-03', '2024-05-16', 16, NULL, 2), -- ID_RECEPT = 14
('Polnjena štruca', 'Fondi je praznična klasika, pri kateri s koščki hrane družno žokaš v bazenček olja, sira ali čokolade.', 'images_food/polnjena_struca.jpg', 60, 4, 2, 1,'2019-03-03', '2024-05-16', 13, NULL, 5), -- ID_RECEPT = 15
('Domača pica', 'Da tako pico potegnemo iz domače pečice, se moramo poslužiti nekaterih trikov.  Največji izziv hišnega picopeka je testo in za najboljše rezultate moramo pečico prepričati, da naj oponaša krušno peč.', 'images_food/domacapica.png', 90, 4, 3, 1,'2019-03-03', '2024-05-16', 17, NULL, 2), -- ID_RECEPT = 16
('Dvobarvni krompirjevi krhlji s parmezanom', 'Hrustljavi napad z obeh strani. Ko v načrtovanju napada na naše brbončice stakneta gomolja tako navaden kot sladek krompir, je jasno, da nas čaka prava krompirjeva poslastica.',  'images_food/krhlji.jpg', 45, 4, 2, 1,'2019-03-03', '2024-05-16', 12, NULL, 2), -- ID_RECEPT = 17
('Slastna BBQ rebrca iz pečice', 'Tale povsem ameriška specialiteta dokazuje, da sva še vedno konkretno pod vtisom izjemnega tritedenskega potepanja po zahodu severne Amerike.', 'images_food/bbq.jpg', 180, 4, 3, 1, '2019-03-03', '2024-05-16', 1, NULL, 3), -- ID_RECEPT =  18
('Pečen ribji file v kremni limonini omaki', 'Tale ribica, ki plava v bogati, a sveži omaki, dokazuje, da dobrega okusa ne gre enačiti s težavnostjo in časom priprave.', 'images_food/ribjifile.png', 40, 3, 2, 1, '2019-03-03', '2024-05-16', 4, NULL, 2), -- ID_RECEPT = 19 
('Sočni in hrustljavi piščančji fingersi', 'Ko je govora o najokusnejših prigrizkih, ki jih lahko postaviš na obljudeno mizo, so ocvrti piščančji fingersi čisto pri vrhu. Hrustljavi, a obenem sočni se imenitno spajdašijo s prav vsemi omakami.', 'images_food/fingersi.jpg', 20, 2, 2, 1, '2019-03-03', '2024-05-16', 3, NULL, 3), -- ID_RECEPT =  20
('Najboljši hrustljav krompir iz pečice', 'Usnjata povrhnjica, robovi zažgani, notranjost tudi votla, hrustljavost - tak rezultat čaka vsakega, ki se v peko krompirja zaleti naivno in ga le nareže, naolji in vrže v pečico.', 'images_food/najboljsihrustljav.jpg', 30, 4, 2, 1,'2019-03-03', '2024-05-16', 1, NULL, 3), -- ID_RECEPT = 21
('Pašta fižol s klobaso in čebulo', 'Pripravljena ekspresno – od prvega sekljaja čebule pa do prvega srkljaja žlice mine le pičlih 20 minut, kar pa se nikakor ne pozna na bogatem okusu.', "images_food/pastafizol.jpg", 40, 2, 2, 1,'2019-03-03', '2024-05-16', 8, NULL, 3), -- ID_RECEPT = 22
('Slastna hobotnica kot pod peko', 'Kot drugih mehkužcev, se tudi hobotnice drži sloves, da lahko v napačno pripravljeni jedi postane grozljivka s teksturo radirke, zaradi česar redkeje najde mesto na običajni nedeljski mizi.', 'images_food/hobotnica.jpg', 60, 3, 4, 1, '2019-03-03', '2024-05-16', 9, NULL, 3), -- ID_RECEPT = 23
('Goveji medaljoni s poprovo omako', 'Okusna in sočna jed, ki združuje mehkobo govejih medaljonov s pikantno poprovo omako ter svežino in hrustljavost brstičnega ohrovta.', 'images_food/slika_medaljoni.jpg', 30, 4, 3, 1, '2024-05-17', '2024-05-17',  1, NULL, 2),-- ID_RECEPT = 24
('Losos v testu s špinačo', 'Losos v testu s špinačo je izjemno okusna in bogata jed, ki združuje sočnost lososa, nežnost špinače ter hrustljavost listnatega testa.', 'images_food/slika_losos_v_testu.jpg', 45, 4, 3, 1, '2024-05-17', '2024-05-17', 14, NULL, 3),  -- ID_ RECEPT =  25
('Kostanjevi svaljki', 'Priprava kostanjevih svaljkov je že otročje preprosta, zato predstavlja super zaposlitev tudi za najmlajše.', 'images_food/slika_kostanjevi_svaljki.jpg', 60, 4, 1, 1, '2024-05-17', '2024-05-17', 15, NULL, 3),  -- ID_ RECEPT = 26
('Gratinirane penne', ' Gratinirane penne s piščancem in brokolijem so odlična izbira za hitro pripravljeno in hranljivo večerjo, ki bo zadovoljila vse člane družine.', 'images_food/slika_gratinirane_penne.jpg', 35, 4, 1, 1, '2024-05-17', '2024-05-17', 26, 5, 3),  -- ID_ RECEPT = 27
('Božična torta', 'Božična jogurtova torta brez peke, s svojim atraktivnim malinovim vzorcem.', 'images_food/bozicnatorta.jpg', 45, 8, 3, 1, '2024-05-17', '2024-05-17', 11, NULL, 4),  -- ID_ RECEPT = 28
('Jagodni kolački', 'Jagode in čokolada – o legendarnem paru so pisane tudi pesmi, kar dobro oriše, kako tesno se ujameta.', 'images_food/slika_jagodni_kolacki.jpg', 60, 12, 3, 1, '2024-05-17', '2024-05-17', 9, NULL, 4),  -- ID_ RECEPT = 29
('Miklavževi kvašeni polži', 'Miklavževi kvašeni polži so mehki in sočni kolački, polnjeni z aromatično marelično marmelado ter sočnim suhim sadjem.', 'images_food/slika_miklavzevi_kvaseni_polzi.jpg', 90, 12, 3, 1, '2024-05-17', '2024-05-17', 8, NULL, 4),  -- ID_ RECEPT = 30 
('Tiramisu kosmiči', 'Tiramisu prekonočni kosmiči so popolna kombinacija zajtrka, kave in posladka v enem kozarčku. Sestavljeni iz polnozrnatih müslijev, kave, čokoladnega pudinga ter sladke smetane za še dodaten užitek.', 'images_food/slika_tiramisu_prekonocni_kosmici.jpg', 10, 2, 1, 1, '2024-05-17', '2024-05-17', 15, NULL, 1),  -- ID_ RECEPT = 31
('Raffaello cheesecake', 'Raffaello cheesecake je bogata tortica s klasičnim okusom Raffaella, ki vsebuje krhko piškotno dno, kremo iz bele čokolade in kokosa ter ganache iz bele čokolade.', 'images_food/slika_raffaello_cheesecake.jpg', 60, 8, 1, 1, '2024-05-17', '2024-05-17', 15, NULL, 4),  -- ID_ RECEPT = 32
('Enostavna presna praznična torta', 'Presna torta je zdrava in okusna sladica, ki temelji na oreščkih, datljih, kakavu in kokosovem mleku.', 'images_food/slika_presna_torta.jpg', 30, 8, 1, 1, '2024-05-17', '2024-05-17', 14, NULL, 4), -- ID_ RECEPT = 33
('Bananini ježki z rumom brez peke', 'Bananini ježki so slastne kroglice, polne nostalgije. Zdrobljeni piškoti, zrele banane, nutella, rum in maslo se združijo v sočno maso, iz katere oblikujemo kroglice, ki jih potem povaljamo v kokosovi moki.', 'images_food/bananini_jezki.jpg', 30, 12, 1, 1, '2024-05-17', '2024-05-17', 12, NULL, 4),  -- ID_ RECEPT = 34
('Puding kozarčki z jagodičevjem in kosmiči', 'Puding kozarčki z jagodičevjem in kosmiči so sladica brez dodanega sladkorja, ki navdušuje s nežno vanilijevo kremo na osnovi pudinga, svežim sadjem in odličnim mueslijem.', 'images_food/puding_kozarcki_jagodicevje.jpg', 20, 4, 1, 1, '2024-05-17', '2024-05-17', 30, NULL, 4),  -- ID_ RECEPT = 35
('Čokoladna torta         Nutella - Lino Lada', 'Torta Nutella-Lino Lada je slastna sladica, ki združuje okuse Nutelle in Lino Lade v sočnem biskvitu, prepojenem s kremo iz maskarpone sira in sladke smetane.', 'images_food/torta_nutella_lino_lada.jpeg', 60, 8, 3, 1, '2024-05-17', '2024-05-17', 22, NULL, 4),  -- ID_ RECEPT = 36
('Torta stracciatella z višnjevim prelivom', 'Slastna torta s stracciatello kremo na mehkem piškotnem dnu, obogatena z višnjevim prelivom, ki poskrbi za osvežilno noto.', 'images_food/torta_stracciatella_visnjev_preliv.jpg', 90, 10, 3, 1, '2024-05-17', '2024-05-17', 21, NULL, 4),  -- ID_ RECEPT = 37
('Pomladna princesa - jagodna kupola', 'Simpatična polkrogelna torta, ki navdušuje s prijetnim okusom po jagodah, kremasto teksturo ter jagodno-sočno noto.', 'images_food/jagodna_kupola.jpg', 45, 8, 3, 1, '2024-05-17', '2024-05-17', 22, NULL, 4),  -- ID_ RECEPT =  38
('Polenta z dimljenim lososom in kaviarjem', 'Okusen prigrizek, ki združuje slastno polento s kremnim sirom, dimljenim lososom in kaviarjem.', 'images_food/polenta.jpg', 30, 4, 3, 1, '2024-05-17', '2024-05-17', 27, NULL, 5),  -- ID_ RECEPT = 39
('Polžki s skuto in feta sirom', 'Mehki polžki s sočnim nadevom iz skute in feta sira, zaviti v puhasto kvašeno testo.','images_food/polzkisskuto.jpg', 90, 4, 3, 0, '2024-05-17', '2024-05-17', 17, NULL, 4),  -- ID_ RECEPT = 40
('Štrukeljci s šunko in hrenom', 'Mali prigrizki, nadevani s šunko in hrenom, odlični za vsako priložnost.','images_food/strukeljci.jpg', 90, 4, 3, 1, '2024-05-17', '2024-05-17', 29, NULL, 4),  -- ID_ RECEPT = 41
('Švicarski rosti iz mladega krompirja', 'Rosti je švicarska jed, ki jo sestavlja nariban in pečen krompir. Lahko se postreže kot priloga ali glavna jed.','images_food/rosti.jpg', 45, 4, 3, 0, '2024-05-17', '2024-05-17', 14, NULL, 3),  -- ID_ RECEPT =  42
('Ocvrt Brie z brusnično pomako', 'Sir Brie, paniran in ocvrt ter postrežen s slastno brusnično pomako, je odlična izbira za prigrizek ali predjed.','images_food/ocvrtbrie.jpg', 30, 4, 3, 1, '2024-05-17', '2024-05-17', 30, NULL, 5),  -- ID_ RECEPT = 43
('Hrenovke v listnatem testu', 'Okusne hrenovke, ovite v hrustljavo listnato testo z dodatkom gorčice in sezama.', 'images_food/hrenovke.jpg', 25, 5, 1, 1, '2024-05-17', '2024-05-17', 22, NULL, 2),  -- ID_ RECEPT = 44
('Božični špinačni venec z rikoto', 'Sladka, sočna špinača z rikoto, zavita v hrustljavo listnato testo.','images_food/spinacnivenec.jpg', 30, 4, 3, 1, '2024-05-17', '2024-05-17', 12, NULL, 2),  -- ID_ RECEPT = 45
('Čemaževo maslo iz dimljene postrvi', 'Recept za čemaževo maslo in dimljeno postrežno mousse je popolna kombinacija okusov in tekstur.', 'images_food/cemazevomaslo.jpg', 45, 4, 3, 1, '2024-05-17', '2024-05-17', 1, 1, 5),  -- ID_ RECEPT =  46
('Mini pica kruhki po italijansko', 'Okusni pica kruhki, idealni za hitro in okusno malico ali prigrizek.', 'images_food/picakruhki.jpg', 50, 15, 4, 1, '2024-05-17', '2024-05-17', 25, NULL, 5), -- ID_ RECEPT =  47



/* REGIONALNE KUHINJE - MEDITERANSKA (1) */
('Italijanski mandljevi piškoti', 'Tradicionalni italijanski mandljevi piškoti so narejeni iz fino mletih mandljev in sladkornega prahu, ki jih povežemo s čvrstimi beljaki in aromo mandljev.', 'images_food/italijanskimandljevipiskoti.jpg', 45, 4, 3, 1, '2024-05-17', '2024-05-17', 22, 1, 4),  -- id_recept =  48
('Tiramisu torta z Bailey’s likerjem in malinami', 'Tiramisu torta z Bailey’s likerjem in malinami je slasten desert, ki združuje bogat okus maskarponeja, sladko smetano, sveže maline in kanček Bailey’s likerja. Idealna izbira za posebne priložnosti.', 'images_food/tiramisutorta.jpg', 60, 8, 3, 1, '2024-05-17', '2024-05-17', 48, 1, 4), -- id_recept = 49
('Piščanec Puttanesca z rezanci', 'Piščanec Puttanesca z rezanci je okusna in nasitna jed, ki združuje bogate okuse paradižnikove omake, oliv in feta sira. Idealna je za hitro pripravo in razveselitev vaših gostov.', 'images_food/piscanecputtanesca.jpg', 40, 4, 3, 1, '2024-05-17', '2024-05-17', 50, 1, 2), -- id_recept = 50
('Fokača s sušenimi paradižniki', 'S kombinacijo sušenih paradižnikov, oliv, rožmarina in oljčnega olja je ta fokača popoln prigrizek ali priloga k jedem.', 'images_food/fokaca.jpg', 90, 8, 3, 1, '2024-05-17', '2024-05-17', 12, 1, 2), -- id_recept = 51
('Bolonjska omaka iz pečice', 'Bolonjska omaka iz pečice je klasična italijanska omaka, ki jo odlikuje bogat in poln okus. Pripravljena v pečici, je ta omaka še bolj aromatična in enostavna za pripravo.', 'images_food/bolonjskaomaka.jpg', 180, 3, 3, 1, '2024-05-17', '2024-05-17', 26, 1, 3), -- id_recept = 52
/* REGIONALNE KUHINJE -  MEHIŠKA (2) */
('Čokočino torta', 'Kava se v sladicah odlično počuti! Ker pa svoje mesto v tortah najde zelo redko, smo se odločili, da skuhamo torto čokoladni kapučino – čokočino!','images_food/cokocino.jpg',  60, 8, 3, 1, '2020-02-03', '2021-01-05', 1, NULL, 4), -- id_recept = 53
('Mehiška quesadilla', 'Mehiška quesadilla je odlična jed, ki združuje mehke tortilje, okusno zelenjavo, nariban sir in različne začimbe. Hitro in enostavno pripravljena, je odlična za kosilo ali večerjo!', 'images_food/mehiskaquesadilla.jpg', 30, 4, 1, 1, '2024-05-17', '2024-05-17', 17, 2, 2),-- id_recept = 54
('Chiles rellenos', 'Chiles rellenos je priljubljena mehiška jed, ki vključuje polnjene paprike, cvrtje in okusno paradižnikovo omako. S poljubnimi nadevi in prilaganjem začimb lahko prilagodite okus vaših chiles rellenos.', 'images_food/chilesrellenos.jpg', 30, 4, 3, 1, '2024-05-17', '2024-05-17', 12, 2, 3), -- id_recept = 55
('Enchilade', 'Enchilade je klasična mehiška jed, ki združuje koruzne tortilje, nadev iz mesa, zelenjave, sira in paradižnikove omake.', 'images_food/enchilade.webp', 30, 4, 3, 1, '2024-05-17', '2024-05-17', 3, 2, 2), -- id_recept = 56
('Chiles en Nogada', 'Klasična mehiška jed, ki združuje pečene poblano paprike, nadev iz mletega govejega mesa in različne okusne sestavine, ter je prelita z bogato omako iz smetane, jogurta, peteršilja, granuliranega sladkorja in pinjol.', 'images_food/chilesennogada.jpg', 60, 6, 3, 1, '2024-05-17', '2024-05-17', 14, 2, 2), -- id_recept = 57
/* REGIONALNE KUHINJE - KITAJSKA (3) */
('Peking Duck', 'Peking Duck je tradicionalna kitajska jed, ki jo odlikuje hrustljava in zlatorjava koža ter sočno meso raca.', 'images_food/pekingduck.jpg', 270, 4, 3, 1, '2024-05-17', '2024-05-17', 41, 3, 2), -- id_recept = 58
('Gong Bao Jī Dīng', 'Gong Bao Jī Dīng je priljubljena kitajska jed, pripravljena s piščančjimi koščki, arašidi, zelenjavo in začimbami. Jed je začinjena in okusna, pogosto jo postrežejo s kuhanim rižem.', 'images_food/gong.jpg', 30, 4, 3, 1, '2024-05-17', '2024-05-17', 2, 3, 2), -- id_recept = 59
('Vegan Mapo Tofu', 'Vegan Mapo Tofu je okusna in začinjena jed, pripravljena s trdim tofujem, zelenjavo in aromatičnimi začimbami. Jed je bogata in polna okusov, odlična za ljubitelje azijske kuhinje.', 'images_food/veganmapotofu.jpg', 30, 4, 3, 1, '2024-05-17', '2024-05-17', 3, 3, 2), -- id_recept = 60
('Dumplings', 'Okusni kitajski nadevani cmoki, pripravljeni iz testa in različnih nadevov, nato skuhani v vreli vodi.', 'images_food/dumplings.jpg', 60, 4, 3, 1, '2024-05-17', '2024-05-17', 20, 3, 3), -- id_recept = 61
('Chicken Chow Mein', 'Piščančji chow mein s tankimi rezanci in raznoliko zelenjavo, začinjen z ingverjem in česnom ter okrašen s sezamovimi semeni in koriandrom.', 'images_food/chicken_chow_mein.jpg', 30, 4, 2, 1, '2024-05-17', '2024-05-17', 30, 3, 2), -- id_recept = 62
('Piščanec v sezamu', 'Piščančje rezine z marinado iz sojine omake in sezamovega olja, okrašene s sezamovimi semeni in zeleno čebulo.', 'images_food/piscanecvsezamu.jpg', 45, 4, 2, 1, '2024-05-17', '2024-05-17', 26, 3, 2),  -- id_recept = 63
/* REGIONALNE KUHINJE - JAPONSKA (4)*/
('Tonkotsu Ramen', 'Ramen juha s svinjskimi kostmi, svinjskim mesom, trdo kuhana jajca, špinačo in drugimi dodatki, ki je priljubljena v japonski kuhinji.', 'images_food/tonkotsu_ramen.jpg', 360, 4, 5, 1,'2024-05-17', '2024-05-17', 4, 4, 5),  -- id_recept = 64
('Chicken Katsu Curry', '4 piščančji fileji, rahlo potolčeni in začinjeni s soljo in poprom', 'images_food/katsu_curry.jpg', 45, 4, 3, 1, '2024-05-17', '2024-05-17', 20, 4, 3),  -- id_recept = 65
('Takoyaki', 'Okusna jed iz japonske kuhinje, ki navdušuje s svojimi kroglicami, polnimi različnih okusov. Ta recept je preprost za pripravo in odličen za druženje s prijatelji.', 'images_food/takoyaki.jpg', 30, 4, 2, 1, '2024-05-17', '2024-05-17', 6, 4, 3),  -- id_recept = 66
('Tori Dango Nabe', 'Okusna in hranljiva enolončnica s piščančjimi mesnimi kroglicami tsukune, svežo zelenjavo in tofu kockami, skuhana v aromatični juhi. Popolna jed za hladne dni!', 'images_food/toridangonabe.jpg', 45, 4, 2, 1, '2024-05-17', '2024-05-17', 17, 4, 2), -- id_recept = 67
('Karaage', 'Okusni hrustljavi piščančji koščki, marinirani v mešanici sojine omake, sakeja, sezamovega olja, ingverja in česna, nato ocvrti do hrustljave zlatorjave barve.', 'images_food/karaage.jpg', 45, 4, 2, 1, '2024-05-17', '2024-05-17', 20, 4, 3),  -- id_recept = 68
('Jjajangmyeon', 'Jjajangmyeon je korejska jed iz rezancev prelitih s črno fižolovo omako, ki je pripravljena s svinjskim mesom, čebulo, zelenjavo in korejsko črno fižolovo pasto.', 'images_food/Jjajangmyeon.jpg',60, 3, 3, 4, '2024-05-17', '2024-05-17', 20, 4, 3),  -- id_recept = 69
/* REGIONALNE KUHINJE - INDIJSKA */
('Masala Chicken', 'Masala Chicken je okusna indijska jed, pripravljena s piščančjim mesom, čebulo, česnom, ingverjem, paradižnikovo omako, smetano, jogurtom in začimbami.', 'images_food/masala_chicken.jpg', 45, 4, 3, 1, '2024-05-17', '2024-05-17', 20, 5, 2),  -- id_recept = 70
('Palak Paneer', 'Palak Paneer je okusna indijska jed, pripravljena s paneer sirom, odmrznjeno špinačo, čebulo, česnom, ingverjem, začimbami in smetano ali jogurtom.', 'images_food/palak_paneer.jpg', 30, 4, 3, 1, '2024-05-17', '2024-05-17', 20, 5, 2),  -- id_recept = 71
('Aloo Gobi', 'Aloo Gobi je priljubljena indijska jed, ki združuje krompir in cvetačo v okusno začinjeno omako.', 'images_food/aloo_gobi.jpg', 40, 4, 3, 1, '2024-05-17', '2024-05-17', 20, 5, 2),  -- id_recept = 72
('Dal Tadka', 'Dal Tadka je klasična indijska jed, ki združuje mehke rdeče leče s čebulo, paradižnikom in začimbami.', 'images_food/dal_tadka.jpg', 40, 4, 3, 1, '2024-05-17', '2024-05-17', 20, 5, 2),  -- id_recept = 73
('Vegetable Biryani ', 'Vegetable Biryani je okusna indijska jed, ki združuje aromatičen basmati riž s pisano mešanico zelenjave in začimb.', 'images_food/vegetable_biryani.jpg', 45, 4, 3, 1, '2024-05-17', '2024-05-17', 20, 5, 2), -- id_recept = 74 
('Baked Mackerel', 'Pečena skuša, začinjena z hariso pasto in limono, je preprosta in okusna jed, polna osvežujočih okusov.', 'images_food/baked_mackerel.jpg', 25, 4, 1, 1, '2024-05-17', '2024-05-17', 20, 5, 2), -- id_recept = 75
('Shakshuka', 'Shakshuka je tradicionalna jed iz Bližnjega vzhoda, ki vključuje omako paradižnikov, začinjeno s čebulo, papriko in začimbami, ter jajca, ki se počasi pečejo v omaki.', 'images_food/shakshuka.jpg', 30, 4, 3, 1, '2024-05-17', '2024-05-17', 20, 5, 2), -- id_recept = 76
('Paella', 'Paella je klasična indijska jed, ki združuje okuse morskih sadežev, piščanca in riža, začinjenih s česnom, papriko in žafrom.', 'images_food/paella.jpg', 60, 4, 3, 1, '2024-05-17', '2024-05-17', 20, 5, 2), -- id_recept = 77


-- Prehranske omejitve = brez glutena (id = 1) ,TK_Prehranske_Omejitve imamo v tabeli Kategorija_Skupno!
('Brezglutenski muffini', 'Okusni muffini brez glutena, obogateni s čokolado in rožičem, ki jih je enostavno pripraviti.', 'images_food/brezglutenskimuffini.jpg', 45, 12, 1, 1, '2024-05-17', '2024-05-17', 20, NULL, 4),  -- id_recept = 78
('Solata Capresse', 'Klasična italijanska solata, sestavljena iz tankih rezin paradižnika, mocarele in svežih bazilikinih listov.', 'images_food/solatacapresse.jpg', 10, 4, 1, 1, '2024-05-17', '2024-05-17', 20, 1, 1),  -- id_recept = 79
('Borovničevi kolački', 'Okusni brezglutenski kolački, obogateni z borovničevo kremo, popolni za vse, ki se izogibajo glutenu.', 'images_food/brezglutenskikolacki.jpg', 45, 12, 3, 1, '2024-05-17', '2024-05-17', 20, NULL, 4),  -- id_recept = 80

-- Prehranske omejitve = vegansko (id = 2), TK_Prehranske_Omejitve imamo v tabeli Kategorija_Skupno!
('Veganska sladka pečenka', 'Okusna in sočna veganska alternativa klasični pečenki, obogatena z oreščki, kostanjem in rozinami.',  'images_food/vegansaksladkapecenka.jpg', 90, 6, 3, 1, '2024-05-17', '2024-05-17', 20, NULL, 4),  -- id_recept = 81
('Veganska torta - Morgan', 'Okusna veganska torta s čokolado in pomarančo, popolna za sladico ali praznovanje.',  'images_food/cokoladnopomarancnatorta.jpg', 90, 8, 3, 1, '2024-05-17', '2024-05-17', 20, NULL, 4);  -- id_recept = 82


INSERT INTO Prehranske_Omejitve (Naziv) VALUES
('Brez glutena'),
('Vegansko');




INSERT INTO Kategorija_Skupno (TK_Recept, TK_Prehranske_Omejitve) VALUES
(78, 1),
(79, 1),
(80, 1),
(81, 2),
(82, 2);




INSERT INTO Korak_Postopka (Postopek, St_Koraka, TK_Recept) VALUES

-- ČESNOVI POLŽKI,  -- id_recept = 1

('Najlažje testo pripravite s pomočjo kuhinjskega robota, vendar bo šlo brez težav tudi ročno.', 1, 1),
('Vse sestavine razen masla stresite v veliko skledo. Zmešajte jih v homogeno zmes, kar traja približno 2 minuti z robotom. Testo bo nekoliko lepljivo, vendar naj vas to ne skrbi.', 2, 1),
('Nato dodajte maslo sobne temperature in gnetite testo še približno 7 minut, oziroma toliko časa, da se maslo popolnoma vmeša in testo postane gladko.', 3, 1),
('Testo oblikujte v gladko kepo tako, da robove spodvihate navznoter in s tem napnete površino kepe.', 4, 1),
('Testo pustite v posodi in ga pokrijte z vlažno kuhinjsko krpo. Naj vzhaja na toplem prostoru, dokler se po prostornini ne podvoji, kar traja približno 1 uro.', 5, 1),
('Pečico segrejte na 180 °C (gretje zgoraj in spodaj).', 6, 1),
('Pekač z visokim robom premažite z maslom.', 7, 1),
('Testo zvrnite na pomokano površino in ga razvaljajte v tanek pravokotnik.', 8, 1),
('Cel pravokotnik premažite s 40 g zmehčanega masla.', 9, 1),
('Enakomerno razporedite sesekljan česen, svež peteršilj in nariban parmezan po celotni površini.', 10, 1),
('Testo tesno zavijte v rulado.', 11, 1),
('Rulado narežite na približno 3 cm debela kolesca.', 12, 1),
('Rolice razporedite po pripravljenem pekaču in jih pokrijte. Pustite jih vzhajati še 30 minut.', 13, 1),
('Rolice premažite z mlekom. Postavite jih v ogreto pečico in pecite 20-25 minut pri 180 °C, dokler ne postanejo zlato rjave.', 14, 1),

-- 2. OVSENA KAŠA S POMARANČO IN JABOLKI, -- id_recept = 2

('Sok iz sveže stisnjenih pomaranč, ovsene kosmiče in cimet kuhaj na srednjem ognju toliko časa, da se zmes zgosti.', 1, 2),
('Če je pomarančni sok prekisel, ga spravi v red z žlico rjavega sladkorja ali erirtitola.', 2, 2),
('Olupi dve jabolki in ju nareži na kocke. Kocke zmešaj s sokom pol limone, dodaj 2 žlici vode in kuhaj 2 minuti. Odstavi jih in jim primešaj žlico medu.', 3, 2),
('V skodelo stresi kašo in jo posuj z medenimi jabolki.', 4, 2),

-- 3. POŠIRANA JAJCA IZ MIKROVALOVNE PEČICE,  id_recept = 3

('Pograbi skledo za kosmiče in vanjo vlij vodo in kis ter frcni ščepec soli.', 1, 3),
('Jajce ubij v kavno skodelico in ga nežno zvrni v sredino pripravljene kopeli. Če je potrebno, dolij toliko vode, da je jajce v celoti potunkano. Vode mora biti ravno toliko, da se jajce skrije pod gladino.', 2, 3),
('Skledo postavi v mikrovalovno pečico in jo pokrij s krožnikom. Poširanje traja 1 minuto in 15 sekund pri polni moči mikrovalovke. Najina ima za 900 W mišic, kar pa se lahko razlikuje od ostalih, zato predlagava, da naj bo prvi jajček preizkusni zajček. Nadaljno kuho prilagodi ugotovitvam.', 3, 3),
('Poširano jajce je treba nekam posaditi, zato najprej popeci toast in nanj nanesi 1 žlico zrnatega sira. Sledi rezina omamnega dimljenega lososa, na katerega pa že spada naš poširanec. Posuj ga s soljo, poprom in drobnjakom.', 4, 3),

-- 4.	PREKONOČNI OVSENI KOSMIČI Z JABOLKI IN CIMETOM, id = 4

('Jabolko olupi, ga naribaj ter zmešaj z ovsenimi kosmiči, medom, chia semeni in celim kupom začimb, ki poskrbijo, da se dobri kosmiči postanejo okusni za prste polizat :).', 1, 4),
('Naštete sestavine zalij z mlekom in dobro premešaj.', 2, 4),
('Dobljeno kašo vlij v kozarce s pokrovom in jih vrzi v hladilnik. Tam naj seveda čakajo preko noči.', 3, 4),
('Prihodnje jutro pograbi kosmiče, na njih stresi semena granatnega jabolka in veselo spokaj v nov uspešen dan!', 4, 4),

-- 5.	JUHA IZ SLADKEGA KROMPIRJA
('Sladki krompir olupi in ga nareži na majhne kocke.', 1, 5),
('Korenček speri, ga oščetkaj ali olupi ter nareži na kolesca.', 2, 5),
('Čebulo na drobno nasekljaj.', 3, 5),
('Večjo posodo pristavi nad srednji-visok ogenj in vanjo zlij olje.', 4, 5),
('Dodaj čebulo in jo praži, dokler ne postekleni.', 5, 5),
('V pisker stresi sladki krompir in korenček in ju praži 5 minut, vmes pa pridno mešaj.', 6, 5),
('Dodaj garam masalo – od ene do treh žličk, odvisno od željene moči arome.', 7, 5),
('Praži in mešaj še kake 2 minuti, nato dolij jušno osnovo.', 8, 5),
('Kuhaj, dokler se sladki krompir in korenček povsem ne zmehčata.', 9, 5),
('Pograbi palični mešalnik in z njim fino spasiraj juho. Za fino kremnost lahko uporabiš blender.', 10, 5),
('Soli jo in popraj po okusu, nato dodaj še sok polovice limone.', 11, 5),
('Juho postrezi v skodelici ali krožniku, na vrh pa čmokni 1-2 žlici jogurta in nasekljano mlado čebulo.', 12, 5),

-- 6.	ŠPANSKA OMLETA Z GOBICAMI
('Krompir skuhaj v oblicah do mehkega, ga ohladi in olupi. Nareži ga na tanke rezine.', 1, 6),
('Šampinjone nareži na rezine.', 2, 6),
('Jurčke zalij z vrelo vodo in počakaj, da se zmehčajo, nato vodo odlij. Na grobo jih nasekljaj.', 3, 6),
('Čebulo na drobno nasekljaj.', 4, 6),
('Slanino nareži na majhne kocke.', 5, 6),
('Globoko ponev pristavi na srednje-visok ogenj, vanjo vlij oljčno olje in stresi nasekljano čebulo.', 6, 6),
('Praži, da prične čebula rjaveti, nato dodaj slanino.', 7, 6),
('Čez kako minuto v ponev skočijo še narezani jurčki in šampinjoni.', 8, 6),
('Praži 10 minut, vmes pa pridno mešaj.', 9, 6),
('Dodaj krompir in pomešaj, ogenj pa zmanjšaj.', 10, 6),
('Jajca razžvrkljaj skupaj s kislo smetano, v to zmes pa dodaj še žličko soli in žličko zdrobljenega pisanega popra.', 11, 6),
('Jajčno zmešnjavo vlij v ponev, jo pokrij s pokrovko in na nizkem ognju kuhaj 30 minut.', 12, 6),
('Omlete nikar ne mešaj, ampak vsake toliko ponev dobro portesi.', 13, 6),
('Po koncu peke omleto zvrni na krožnik in jo posuj z mlado čebulo. Zraven postrezi kepo kisle smetane.', 14, 6),

-- 7. AJDOVA KAŠA Z GOBAMI IN DIMLJENIM OLJEM 
('Ajdovo kašo skuhaj po navodilih z embalaže.', 1, 7),
('Suhe jurčke namoči, dokler se ne napojijo (približno 15 minut), nato jih nareži. Prav tako nareži simpatične lisičke.', 2, 7),
('Čebulo na drobno nasekljaj in popraži na treh žlicah dimljenega oljčnega olja. K njej vrzi narezane gobice in jih praži, da se zmehčajo.', 3, 7),
('Vlij sladko smetano in ob občasnem mešanju kuhaj približno 3 minute.', 4, 7),
('Dobljeno jesensko omako posoli in popopraj, vanjo dodaj par ščepcev timijana in peteršilja ter stresi kuhano in odcejeno ajdovo kašo.', 5, 7),
('Vse skupaj dobro premešaj, da se združi v imenitno jed, ki jo postrežeš v globokih krožnikih.', 6, 7),
('Pred postrežbo kupček kaše še navihano pokapljaj z dimljenim oljem.', 7, 7),

-- 8.	AVOKADO TOAST Z DIMLJENIM LOSOSOM
('Rezine kruha premaži z oljčnim oljem in jih za 10 min postavi v pečico, segreto na 200 ºC.', 1, 8),
('Zrela avokada razpolovi in olupi, nato pa speštaj z vilico.', 2, 8),
('Dodaj žlico limetinega soka in čilijevo mešanico po okusu. Po želji avokado dosoli.', 3, 8),
('Avokado razporedi po popečenih kruhkih, nanj pa povezni rezine dimljenega lososa.', 4, 8),
('Po vrhu potresi še črni sezam in narezano mlado čebulo.', 5, 8),
('To je to! Poskusi ga ne pojesti, še preden se usedeš za mizo.', 6, 8),

-- 9.	SOLATA Z AJDOVO KAŠO IN BUČO
('Pečico segrejemo na 200 °C.', 1, 9),
('Iz buče z žlico postrgamo laske in semena.', 2, 9),
('Bučo narežemo na krhlje. Če nam uspe, jih olupimo z lupilcem za krompir, drugače pa z ostrim nožem.', 3, 9),
('Krhlje narežemo na enakomerne kocke.', 4, 9),
('Bučne kocke razporedimo po pekaču, prekritem s papirjem za peko in jih solimo ter popramo, nato pa še pošpricamo z rastlinskim oljem.', 5, 9),
('Kocke pečemo 20-30 minut pri 200 °C, nato jih ohladimo.', 6, 9),
('Ajdovo kašo skuhamo po navodilih z embalaže, nato jo popolnoma ohladimo.', 7, 9),
('Lešnike popražimo na ponvi in jih na grobo stremo.', 8, 9),
('Čebulo sesekljamo na drobne kocke, špinačo pa stresemo na kupček in jo z nožem z 2-3 rezi na grobo narežemo.', 9, 9),
('Čebulo in špinačo zmešamo z ohlajeno ajdovo kašo.', 10, 9),
('Dodamo mešanico bučnega olja in jabolčnega kisa in znova premešamo.', 11, 9),
('Solimo po okusu. Po vrhu razporedimo bučne kocke, stresemo pražene lešnike in pokapljamo z bučnim oljem.', 12, 9),

-- 10.	TIKKA MASALA S PIŠČANCEM 
('Piščančji file nareži na kocke, velike kot en grižljaj.', 1, 10),
('V posodi ali globokem krožniku zmešaj vse ostale sestavine za marinado.', 2, 10),
('Dodaj piščančje kose in jih temeljito premešaj z marinado.', 3, 10),
('Posodo zatesni s pokrovom ali pa jo tesno pokrij s prozorno folijo.', 4, 10),
('Piščanec naj se v hladilniku marinira vsaj 3 ure.', 5, 10),
('Večjo ponev dodobra segrej in vanjo zlij žlico olja.', 6, 10),
('Na razbeljeno ponev stresi polovico piščančjih koščkov in jih z lopatko razporedi po celotni površini.', 7, 10),
('Pusti jih 1-2 minuti, da se dobro zapečejo – marinada bo počrnela, a ni s tem nič narobe.', 8, 10),
('Kose piščanca obrni in jih do temne zapečenosti peci še na drugi strani.', 9, 10),
('Kose piščanca stresi na krožnik, nato postopek ponovi še za drugo polovico.', 10, 10),
('Lonec pristavi nad srednji ogenj in v njemu segrej 2 žlici olja in 2 žlici masla.', 11, 10),
('Dodaj sesekljano čebulo in dva ščepca soli.', 12, 10),
('Med občasnim mešanjem praži čebulo 7-10 minut.', 13, 10),
('Ingver in česen zares fino sesekljaj ali pa drobno nastrgaj. Dodaj ju k čebuli in med mešanjem praži 2 minuti.', 14, 10),
('Dodaj preostanek začimbne mešanice, pomešaj in praži še 2 minuti.', 15, 10),
('V lonec stresi pasiran paradižnik in vodo.', 16, 10),
('Ogenj povečaj, da omaka zavre, nato ga zmanjšaj, posodo pa pokrij.', 17, 10),
('Tako naj se omaka kuha na nizkem ognju 15 minut – vmes nekajkrat pomešaj.', 18, 10),
('Omako s paličnim mešalnikom fino spasiraj do žametne teksture.', 19, 10),
('Dodaj 100 ml sladke smetane, žličko sladkorja in žlico masla.', 20, 10),
('Pomešaj, nato v pisker končno skoči še piščanec in ves sok, ki je ostal v krožniku.', 21, 10),
('Kuhaj še 5 minut, nato je tikka masala nared za požret!', 22, 10),
('Tikka masalo postrezi z žlico grškega jogurta z basmati rižem in/ali ploskim kruhom naan.', 23, 10),

-- 11.	EKSPRESNA ČIČERIKINA ENOLONČNICA
('Čebulo na drobno nasekljamo, česen pa narežemo na tanke lističe.', 1, 11),
('V pisker vlijemo dve žlici oljčnega olja in ga pristavimo nad ogenj.', 2, 11),
('Na vroče olje stresemo čebulo in jo med mešanjem pražimo, da prične ob robovih rjaveti.', 3, 11),
('Dodamo česen in pražimo, dokler ne zadiši.', 4, 11),
('V kastrolo stresemo sladko rdečo papriko in dimljeno papriko in pomešamo.', 5, 11),
('Še preden se paprika zažge, v lonec stresemo paradižnikove koščke in čičeriko, vključno s tekočino, v kateri plava.', 6, 11),
('V obe pločevinki od paradižnika vlijemo malo vode, pomešamo in jo vlijemo v lonec.', 7, 11),
('Dodamo še lovorjev list, nato pustimo, da enolončnica pridno brbota 15 minut.', 8, 11),
('V pisker stlačimo svežo špinačo.', 9, 11),
('Dodamo žlico sojine omake ter sol, poper in kis po okusu', 10, 11),
('Pustimo, da se enolončnica kuha še 15 minut, vmes pa nekajkrat pomešamo.', 11, 11),

-- 12. PIŠČANČJI FILE S TIMIJANOM IN LIMONO
('Pečico segrejemo na 170 °C.', 1, 12),
('Piščančja fileja z obeh strani dobro posolimo in popopramo ter začinimo z 1 žličko sladke rdeče paprike.', 2, 12),
('Fileja prelijemo z rastlinskim oljem in ju nekajkrat obrnemo, da olje prekrije celotno površino.', 3, 12),
('Nad visok ogenj postavimo ognjevarno ponev, primerno za peko v pečici.', 4, 12),
('V segreto ponev položimo fileja z lepšo stranjo navzdol.', 5, 12),
('Na vsaki strani ju pečemo 2 minuti, da se lepo zlatorumeno zapečeta.', 6, 12),
('Ponev prestavimo v pečico za 5 minut.', 7, 12),
('Po peki v pečici ponev previdno prestavimo nazaj na šporget, pri tem pa uporabljamo kuhinjsko rokavico ali krpo.', 8, 12),
('V ponev vržemo 3 žlice masla, 2 vejici timijana in 1 strt strok česna. Dodamo tudi 1 žlico limoninega soka.', 9, 12),
('Ponev nagnemo proti sebi in z žlico pobiramo stopljeno maslo in ga prelivamo po filejih.', 10, 12),
('V ponev nastrgamo še lupinico ene limone, nato pa masleno omako natočimo v posodico, meso pa prenesemo na rezalno desko.', 11, 12),
('Piščančji file pod kotom narežemo na 5 delov in ga postrežemo na krožniku solate.', 12, 12),


-- 13.	ŠPAGETI CARBONARA Z ZELENJAVO
('Špargljem odstranimo olesenele konce. Nikar jih ne zavrzimo, temveč jih prihranimo za špargljevo osnovo, iz katere lahko nastane izvrstna juha ali rižota.', 1, 13),
('Špargljem odrežemo vršičke, ostalo steblo pa razpolovimo počez. Vsako steblo razpolovimo tudi po dolgem in narežemo na enakomerne palčke, vršičke pa pustimo cele.', 2, 13),
('Korenček olupimo in ga narežemo na tri enako dolge kose, ki jih prav tako narežemo na tanke palčke.', 3, 13),
('Parmezan fino naribamo in ga zmešamo s tremi rumenjaki. Slanino narežemo na palčke. Strok česna olupimo in ga stremo.', 4, 13),
('V velik pisker natočimo vodo, ki jo izdatno solimo in zavremo.', 5, 13),
('V večjo ponev vlijemo žlico oljčnega olja in postavimo strok česna. Ko se olje segreje, v ponev stresemo šparglje in slanino.', 6, 13),
('Nad srednjim-visokim ognjem ju mešamo in pražimo 2 minuti. Dodamo zamrznjen grah in korenček. Zelenjavo pražimo, da se zmehča, približno 6 minut.', 7, 13),
('Solimo jo s ščepcem soli in ščepcem popra, po koncu praženja pa odstranimo strok česna.', 8, 13),
('V lonec s kropom stresemo špagete in jih skuhamo po navodilih z embalaže.', 9, 13),
('Ko so špageti kuhani, jih v ponev prenesemo s prijemalko, da z njimi dodamo tudi tekočino, v kateri so se kuhali.', 10, 13),
('Ogenj v ponvi zmanjšamo, špagete pa zmešamo z zelenjavo.', 11, 13),
('V posodo z rumenjaki in parmezanom natočimo pol zajemalke vode od testenin. Premešamo in stresemo v ponev.', 12, 13),
('Vsebino ponve temeljito premešamo. Cilj so kremni špageti v svilnati omaki, ki se zlahka mešajo. Če je omaka pregosta, dodamo še tekočino od testenin.', 13, 13),
('Špagete carbonara postrežemo takoj, preden pa se jih lotimo, jih pogumno popopramo in zasujemo s sveže naribanim parmezanom.', 14, 13),
('Čebuli in česen na drobno sesekljamo. Velik lonec postavimo nad srednji ogenj in vanj nalijemo za dve žlici olja. Na njej popražimo čebulo, da postekleni, nato dodamo česen.', 1, 13),
('Ko česen zadiši, v pisker stresemo žlico mlete rdeče paprike in pomešamo. Dodamo žlico paradižnikovega koncentrata in zopet dobro premešamo.', 2, 13),

-- 14.	MESNE KROGLICE IZ PEČENIC V OMAKI S KISLIM ZELJEM
('V kastrolo zdaj stresemo rahlo splaknjeno kislo zelje in vržemo lovorjev list. Vse skupaj dobro premešamo, nato pa zalijemo s toliko vode, da povsem pokrije zelje.', 3, 14),
('Pisker pokrijemo in kuhamo toliko časa, da se zelje zmehča, približno 40-50 minut. Lonec odkrijemo in vanj zljemo mešanico dveh žlic moke in 50 ml vode. Dobro premešamo in pustimo, da zelje v omaki še enkrat zavre, nato solimo in popramo po okusu.', 4, 14),
('Pograbimo pečenico, ji odrežemo en konec in skozi nastalo luknjo izstisnemo malo mase, ki je v njej. Z rokami oblikujemo odtrgano maso v kroglico.', 5, 14),
('Na tak način nadaljujemo, dokler ne porabimo vseh pečenic. Njihov ovoj zavržemo.', 6, 14),
('Na vroče kurišče postavimo ponev in vanjo vlijemo za žlico olja. Ko se ponev dodobra segreje, v njej popečemo mesne kroglice. Med veselim kotaljenjem jih pečemo jih toliko časa, da se z vseh strani lepo zapečejo – dobrih 5 minut.', 7, 14),
('Zapečene kroglice z vso maščobo vred stresemo v lonec z zeljem v omaki. Ob brbotanju kuhamo še 10 minut, s tem pa poskrbimo, da so kroglice tudi v sredini kuhane, zelje pa se navzame okusa po njih.', 8, 14),

-- 15. POLNJENA ŠTRUCA
('Dimljene prsi in sušen paradižnik fino nasekljaj – ali v sekljalniku ali pa na roko.Oba sira naribaj. Kislo smetano zmešaj s sirnim namazom, nasekljanimi prsmi in sušenimi paradižniki, poprom, origanom, baziliko in česnom v prahu.', 1, 15),
('Na koncu primešaj nariban sir. Štruci odreži pokrov in jo izdolbi s pomočjo žlice.Maso natlači v sveže izkopano vrtino. Dobro potlači, da zapolniš celo štruco.Pečico nažgi na 180 °C.', 2, 15),
('Štruco postavi na pekač, poleg nje pa vrzi tudi odrezan pokrov. Peci jo 20-25 minut.Polnjeno štruco vrzi na mizo takoj, ko jo ukradeš pečici.', 3, 15),
('Pečen pokrov nareži na več kosov, ki jih nato veselo pomakaš v štruco.Ko zmanjka materiala za pomakanje, štruco nareži in jo razdeli med lakotnike.', 4, 15),

-- 16. DOMAČA PICA
('Čeprav bi marsikateri Italijan pobezljano motovilil z rokami že ob sami misli na mleko v testu za pico, se midva požvižgava na to. Mleko v testu pozitivno vpliva na njegove željene lastnosti, nežen mlečni okus pa je kot nalašč za pico, na kateri počiva burrata.', 1, 16),
('Moko, kvas, olje, sladkor in sol vržemo v večjo skledo, nato pa se pridruži še mlačno mleko.Če želimo pokuriti kako kalorijo, lahko zavihamo rokave in se gnetenja lotimo na lastne roke, tisti bolj leni pa taka opravila pustimo kuhinjskemu robotu.Testo gnetemo 10-15 minut, da postane svetleče in gladko. Po dotiku ne sme na prstu ostati nič testa.', 2, 16),
('Zgneteno testo oblikujemo v kepo, ki jo vržemo v skledo in pomokamo, nato pa pokrijemo s toplo mokro krpo.Testo naj vzhaja 1 uro, nakar ga razdelimo na 2-4 enake dele, odvisno od željene velikosti pice. Vsakega na hitro pregnetemo in oblikujemo v kepo.Kepe postavimo na pomokan pladenj, jih pomokamo in pokrijemo s krpo.', 3, 16),
('Po 30 minutah vzhajanja je čakanja dovolj, končno se lahko lotimo pice!Paradižnikova omaka.Pelate nasekljamo ali pa zmečkamo kar s prsti.Zmešamo jih z oljčnim oljem in česnom v prahu.Solimo in popramo po okusu.', 4, 16),
('Kamen za peko postavimo v pečico vsaj 45 minut pred peko, pečico pa na ventilatorskem režimu nastavimo na najvišjo možno temperaturo. 15 minut pred peko kamen prestavimo na drugo najvišjo režo v pečici, pečico pa nastavimo na žar funkcijo, največja moč.Na dobro pomokano površino vržemo kepo testa in ga narahlo sploščimo v debel disk.S členki določimo debelino roba pice tako, da z njimi odtisnemo kanalček približno 0,5-1 cm od roba.Z vlečenjem testa pričnemo od sredine navzven, nato pa ga malo zarotiramo in ponovimo vlečenje. Pri tem pazimo, da ostane rob čimbolj nedotaknjen.', 5, 16),
('Testo razvlečemo do enakomerne debeline dna, nato pa ga prenesemo na pomokan lopar za pico ali okroglo desko za rezanje.Testo premažemo z nekaj žlicami omake za pico. Ne smemo pretiravati, saj bo pica že tako sočna zaradi burrate.Mocarelo na grobo natrgamo in jo namečemo po omaki.Nekaj listov bazilike razporedimo po pici.', 6, 16),
('Čas peke je odvisen od pečice, približno 2-5 minut. Ko začnejo mehurčki na mocareli rjaveti, na testu pa se pojavijo črne pike, je čas, da na sredo pice z lopatko previdno zvrnemo burrato. Počakamo še 15-30 sekund, da se burrata malce stopi, nato pa je peke konec.Po pečeni pici potresemo še sveže liste bazilike.Preden v pečico spravimo novo pico, jo je priporočljivo pustiti 10 minut pri miru, da se kamen pod žarom ponovno močno segreje. Zažgano moko previdno pobrišemo s papirnato brisačko.To je to! Čeprav je neučakanost na vrhuncu, je zaradi velike količine sira potrebno počakati kako minuto, da se pica malce shladi. Ugriz v kos pice z burrato je vreden sleherne minute časa, ki ga vložimo vanjo. ', 7, 16),

-- 17.	DVOBARVNI KROMPIRJEVI KRHLJI S PARMEZANOM
('Krompirje obeh vrst olupimo in narežemo na enakomerne krhlje.', 1, 17),
('Oljčno olje, česen v prahu, sladko papriko in sol zmešamo in s tem prelijemo krompirjeve krhlje. Dobro jih premešamo.', 2, 17),
('Krompir razveselimo še z naribanim parmezanom in ga ponovno premešamo. Razporedimo ga po pekaču, obdanem s papirjem za peko.', 3, 17),
('Pečico razkurimo do 200 °C in jo nato pomirimo s peko krompirjevih krhljev, ki traja 30-40 minut. O primerni zapečenosti se večkrat prepričamo na lastna usta.', 4, 17),
('Ti dvobarvni krhlji pa ne spadajo le na nedeljsko mizo. Ko se spajdašijo z omako iz kisle smetane, veljajo za idealno družbo ob filmskih večerih.', 5, 17),

-- 18.	BBQ REBRCA IZ PEČICE
('Vse sestavine stresemo v kozico in jih premešamo z metlico.', 1, 18),
('Omako kuhamo na zmernem ognju, dokler ni dovolj gosta. Obnašati se mora podobno kot kečap.', 2, 18),
('Še preden se lotimo priprave, moramo kupiti prava rebra. Običajno na nedeljsko mizo prikolovratijo svinjska rebra, obdana z debelo plastjo maščobe in kožo. Za pripravo na ameriški način ta žal niso primerna, zato je potrebno mesarja pocukati za rokav in ga pobarati za “spare ribs” ali “baby back ribs”.', 3, 18),
('Ko imamo pred sabo pravi kos rebrc, je potrebno z njih odstraniti membrano. Ta poredna membrana preprečuje, da postanejo rebrca res nežna in prežeta z okusi, nahaja pa se na manj mesnati strani reber. Na enem robu z nožem privzdignemo membrano, jo zagrabimo s papirnato brisačko in v enem kosu odlepimo z reber.', 4, 18),
('Začimbe in olje zmešamo v aromatično pasto, s katero temeljito premažemo rebrca.', 5, 18),
('Na kos aluminijaste folije položimo list papirja za peko. Na sredino postavimo rebrca in jih zavijemo s tem dvoplastnim oklepom, ki bo poskrbel, da se rebrca ne bodo izsušila.', 6, 18),
('Ličen paketek postavimo na pekač in ga za vsaj 3 ure postavimo v pečico, segreto na 140 °C.', 7, 18),
('Zavoj rebrc odpremo in z vilico preverimo, če meso z lahkoto odstopa od kosti. V nasprotnem primeru peko podaljšamo za 15 minut.', 8, 18),
('Postopek ponavljamo, dokler meso skoraj samo ne pade s kosti.', 9, 18),
('Paketek razpremo in odstranimo odvečno tekočino. S pripravljeno BBQ omako premažemo kos reber z vseh strani.', 10, 18),
('Pečico nastavimo na žar funkcijo in vanjo postavimo nepokrita rebrca z mesnato stranjo navzgor. Po 3-5 minutah cvrčanja bo omaka karamelizirala, kar označuje konec peke! Ves ta čas moramo preždeti pred pečico in čuvati, da se omaka ne prismodi.', 11, 18),

-- 19.	PEČEN RIBJI FILE V KREMNI LIMONINI OMAKI
('Če se fileja še drži koža, jo lahko odstranimo tako, da file s kožo navzdol postavimo na rezalno desko, z ostrim nožem pa zarežemo na tanjši strani tik nad kožo. S papirnato brisačo zagrabimo ta štrleči del kože, z nožem pa z rahlim potiskom navzdol potegnemo po celi dolžini fileja.', 1, 19),
('Če imamo večji file, ga razrežemo – potrebujemo 4 fileje. S pinceto iz filejev temeljito poberemo vse kosti. Fileje posolimo in popopramo z obeh strani.', 2, 19),
('Pečico segrejemo na 200 ºC.', 3, 19),
('Šalotko narežemo na drobne kocke, česen pa fino sesekljamo.', 4, 19),
('V stekleno posodo stresemo kocke masla, šalotko, česen in nastrgano lupinico ene limone. Dodamo sladko smetano, žličko gorčice in žlico limoninega soka. V omako frcnemo še ščepec popra in dva debela ščepca soli. Omako segrevamo v v mikrovalovni pečici v intervalih po 15 sekund, dokler se maslo povsem ne stopi. Vmes pomešamo.', 5, 19),
('Fileje postavimo v širok pekač z visokim robom ali v široko ognjevarno posodo. Prelijemo jih z omako, nato pa vse skupaj pospravimo v ogreto pečico.', 6, 19),
('Fileje pečemo 9-11 minut, odvisno od njihove debeline. Da so pečeni, lahko preverimo tako, da na debelejšem delu ob robu z vilico razpremo file – na sredini mora biti neprosojen.', 7, 19),
('Sočen file ribe postrežemo z obilico omake in ščepcem sveže sesekljanega peteršilja.', 8, 19),

-- 20.	SOČNI IN HRUSTLJAVI PIŠČANČJI FINGERSI
('Piščančje prsi nareži na približno enako debele trakove. Stresi jih v zamrzovalno vrečko ter dodaj pol žličke soli in 300 ml pinjenca. Iz vrečke iztisni odvečni zrak in jo zapri. Vsebino vrečke premešaj, nato jo postavi v hladilnik za vsaj 4 ure, komot pa lahko tam počaka tudi polnih 24 ur.', 1, 20),
('Piščančje trakove obleci v panado na treh postajah. Na en krožnik stresi kupček moke. V širši posodici razžvrkljaj jajci, žlico pikantne omake in pošten ščepec soli. Nekaj pesti koruznih kosmičev stresi v zamrzovalno vrečko in jih dobro zmečkaj, pretepi in/ali povaljaj. Strte kosmiče stresi v zadnji krožnik, zraven pa dodaj pest naribanega parmezana.', 2, 20),
('Piščančje trakove stresi v cedilo in ga malce potresi, da z njih odteče odvečen pinjenec. Vsak trakec najprej povaljaj v moki, nato ga pomoči v jajčno kopel, na koncu pa ga obleci v kosmiče.', 3, 20),
('Polovico fingersov razporedi po košari cvrtnika Airfryer in jih pošpricaj z žličko olja. Košaro potisni v Airfryer. Izberi program “Manual/Ročno kuhanje”, nastavi čas 12 minut in temperaturo 200 ºC. Ko te aparat opomne, da je potrebno pretresti vsebino košare, fingerse obrni. Na tak način speci še drugo polovico fingersov. To je to, hrustljavi in izredno sočni fingersi so pripravljeni na hrskanje in hrustanje! Poskrbi za pisan spekter omakic in dobro družbo.', 4, 20),

-- 21.	NAJBOLJŠI HRUSTLJAV KROMPIR IZ PEČICE
('Krompir olupimo in ga narežemo na velike kose. V srednji lonec natočimo približno 2 litra vode in vanjo stresemo zvrhano žlico soli in četrt žličke sode bikarbone. Ko voda zavre, vanjo stresemo krompir. Krompir naj se kuha 10–15 minut. Nared je, ko lahko vanj zlahka zapičimo noževo konico. Krompir odcedimo v cedilu in ga pustimo v njem kako minuto, da voda z njega odpari.', 1, 21),
('V veliko skledo zlijemo 3-4 žlice oljčnega olja in dodamo 2-3 žličke začimbne mešanice za krompir (po želji lahko namesto mešanice uporabimo poljubno kombinacijo rožmarina, česna v prahu, mlete paprike, origana, timijana in podobno). V skledo stresemo krompir, pograbimo skledo in jo divje stresamo, da se krompir pomeša z oljem in začimbami, Na krompirju bo nastala plast nekakšne paste, ki je točno tisto, kar iščemo.', 2, 21),
('Pečico nastavimo na ventilatorsko peko in jo segrejemo na 200 ºC. S pečico naj se segreje tudi širok pekač. Po vročem pekaču previdno razmažemo žlico olja, nato nanj stresemo krompir. Krompir naj se peče približno 50–60 minut, vmes pa ga enkrat obrnemo z uporabo tanke kovinske lopatke. Če se kak kos krompirja slučajno prime pekača, pazimo, da ga ne raztrgamo. Če krompirček pečemo sočasno s svinjsko potrebušino, potem posteljico z njeno maščobo prihranimo, potrebušino postavimo na sredino pekača, okoli nje pa razporedimo krompir. Tako pečemo 30 minut, nakar iz pekača odstranimo meso, prilijemo pa za nekaj žlic prihranjene maščobe in previdno, a dobro premešamo. Do konca pečemo še 20–30 minut.', 3, 21),

-- 22. PAŠTA FIŽOL S KLOBASO
('Čebulo nareži na majhne kocke, česen pa na drobno sesekljaj. V pisker vlij žlico oljčnega olja in na njemu nekaj minut praži čebulo, da se zmehča. Dodaj česen in praži še kako minuto. Po čebuli potresi mleto papriko, dodaj lovorjev list in majaron ter mešaj pol minute. Dodaj paradižnikov koncentrat in pomešaj, nato v kastrolo stresi fižol s tekočino vred ter zlij jušno osnovo. Vse skupaj premešaj, nato segrevaj do vretja. Polovico enolončnice prelij v ločeno posodo, kjer jo fino spasiraš s paličnim mešalnikom. Spasirano polovico vrni v lonec in dodaj klobaso in testenine. Kuhaj toliko časa, da se testenine skuhajo. Na koncu v pašto fižol vmešaj še žlico kisa.', 1, 22),

-- 23. HOBOTNICA KOT POD PEKO
('Korenje, čebulo in koromač olupimo in narežemo na večje kose. Stroke česna olupimo in jih stremo. Vso narezano zelenjavo zmešamo v posodi z 1 dl oljčnega olja, 3 ščepci soli in 3 ščepci popra.' , 1, 23), 
('Zamrznjeno očiščeno hobotnico odtajamo in jo splaknemo pod tekočo vodo. Pečico segrejemo na 200 °C. Litoželezno posodo postavimo na visok ogenj in vanjo postavimo hobotnico. Kuhamo jo cca 10 minut, vmes pa jo enkrat obrnemo. Hobotnica bo med kuho izpustila veliko vode, kar tudi želimo. Hobotnico vzamemo iz posode in jo narežemo – odrežemo ji glavo tik nad vrhom lovk, ostalo pa narežemo na štiri dele, da dobimo pare lovk', 1, 23),

-- 24. GOVEJI MEDALJONI S POPROVO OMAKO IN BRSTIČNIM OHROVTOM
('Glavo narežemo kot lignje – na kolobarje. Morebitne ostanke, kot so oči ali kljun, zavržemo. Če je tekočine v posodi preveč, jo malce zreduciramo, nato vanjo stresemo zelenjavo. Na zelenjavo postavimo razrezano hobotnico, nato posodo pokrijemo in jo postavimo v segreto pečico. Pokrito pečemo 1 h 15 min, nato posodo odkrijemo, prilijemo 1 dl belega vina, pomešamo in pečemo še dodatnih 15-30 minut. Tako se bo tekočina zgostila, hobotnica pa zapekla. Ker lahko hobotnice vsebujejo različno količino vode, velja med peko večkrat preveriti, ali je v posodi dovolj tekočine in po potrebi zaliti s kozarcem belega vina. Na krožnik nakupčkamo mehko zelenjavo, nanjo poveznemo par hobotničinih lovk ter jo okrancljamo s čimičuri omako. Zraven se prileže suho belo vino, kot je chardonnay.', 1, 23),
('Preden se spraviš na medaljone, jih 30 minut pusti pri miru na sobni temperaturi.', 1, 24),
('Brstični ohrovt: Pečico nastavi na 220 °C. Malim zelenim frnikolam odreži štrleče steblo in jih razpolovi. Če so ohrovtki mini, pusti kar cele. Ohrovt stresi v ne prevelik pekač in ga pošpricaj z 2 žlicama oljčnega olja ter posuj s konkretnim ščepcem soli in bogatim ščepcem popra. Pekač postavi v pečico in ga tam pusti 20-25 minut. 5 minut pred koncem peke k ohrovtu primešaj še suhe brusnice. Po koncu peke brstični ohrovt zalij z mešanico 1 žlice balzamičnega kisa in 1 žličke oljčnega olja. Dobro ga premešaj.', 2, 24),

-- 25. LOSOS V TESTU S ŠPINAČO
('Šalotko in stroke česna olupi in na drobno nasekljaj.Široko ponev postavi na srednji ogenj in vanjo vrzi 2 žlici masla.Ko se maslo raztopi, dodaj nasekljano šalotko in česen.Praži, da šalotka postekleni, česen pa zadiši.Prilij vino in mešaj, dokler povsem ne izpari.', 1, 25),
('V ponev vrzi kremni sir in pomešaj.Dodaj drobtine in na drobno nariban parmezan. Pomešaj.V ponev zdaj stlači še oprano mlado špinačo.S prijemalko jo mešaj in obračaj toliko časa, da uvene.Soli in popraj po okusu.', 2, 25),
('Najprej je potrebno s fileja odstraniti kožo.Postavi ga na rezalno desko obrnjenega s kožo navzdolPograbi oster in tanek nož in na eni strani zareži v maščobno plast tik ob koži.Na novo štrleč del kože zagrabi in povleči k sebi s kuhinjsko brisačko, potem pa z enim, samozavestnim rezom stran od sebe zareži po celotni dolžini fileja. Rez naj bo vodoraven s podlago.', 3, 1),
('Če je šlo vse po sreči, na koži ne bo ostalo nič mesa (kak milimeter ne predstavlja panike).Površino lososa temeljito prešlataj in odstrani vse koščice, za kar lahko uporabiš čisto pinceto.File lososa razpolovi, da dobiš dva enaka trakova, široka približno 5-6 cm.Oba trakova radodarno posoli in popopraj z vseh strani.', 4, 25),
('Pečico segrej na 200 °C.Razvij listnato testo in nanj postavi file lososa tako, da sta testo in losos obrnjena v isto smer. Postavi ga na sredino testa, od dna pa naj bo oddaljen 3-4 cm.Z vrha odmeri 3-4 cm od lososa in odreži odvečno testo.Po lososu razporedi polovico špinačnega nadeva in ga poravnaj.', 5, 25),
('Razžvrkljaj 1 jajce in 2 žlici mleka.Z jajcem premaži vse robove testa.Testo prepogni čez lososa najprej z leve, nato pa še z desne strani, pri tem pa poskrbi, da se testo tesno prilega lososu.Štrleča dela testa na vrhu in dnu lososa premaži z jajcem in ju prepogni na zavitega lososa.Vse skupaj obrni in pred tabo bo simpatičen paketek. Prestavi ga na eno polovico pekača, prekritega s papirjem za pekoTemeljito ga premaži z jajcem.', 6, 25),
('Z ostrim nožem vanj previdno, brez pritiskanja, zareži poljuben vzorec, pri tem pa pazi, da ne zarežeš do mesa. Midva sva se odločila za klasičen karo vzorec.Po vrhu posuj nadrobljen poper in sol.', 7, 25),
('Na enak način zapakiraj še drug file lososa.Pekač z lososom v testu porini v pečico.Peci približno 25 minut, oziroma toliko časa, da postane testo zlatorumeno zapečeno.Za to svežo omako preprosto zmešaj 1 žlico majoneze, 2 žlici kisle smetane, 2 žlički drobnjaka in 2 žlički limoninega soka.Omako soli po okusu.', 8, 25),

-- 26. KOSTANJEVI SVALJKI
('Za svaljke potrebujemo 300 g kuhanega in olupljenega kostanja. Midva sva skuhala 500 g kostanja, ga olupila in odtehtala, višek pa pojedla. Kuhala sva ga 40 minut v vreli vodi.', 1, 26),
('Kuhan kostanj, jajce in kislo smetano vržemo v multipraktik ali sekljalnik, nato vse skupaj zmiksamo v pire.H kostanjevemu pireju primešamo sol in nastrgan muškatni orešček.Dodamo ostro moko, da dobimo voljno testo s teksturo, malce podobno plastelinu.Dobljeno testo oblikujemo v en velik svaljek. Prestavimo ga na čisto delovno površino.', 2, 26),
('Od mega svaljka odrežemo en kos in ga s prsti obeh rok razvaljamo v dolgo kačo, debelo približno 1 cm.Dobljeno kačo razrežemo na enakomerne svaljke z nožem ali strgalom. Dolgi naj bodo 1-2 cm, odvisno od želene oblike.Svaljkom pogladimo ostre robove in jih prestavimo na pomokan pladenj.Postopek ponavljamo, dokler ne porabimo vsega testa.', 3, 26),
('Večjo ponev pristavimo nad srednji ogenj in vanjo položimo rezine slanine. Rezine naj se med seboj čim manj prekrivajo.Slanino pražimo na vsaki strani približno 3-4 minute, vmes pa parkrat preverimo, da se nam ne žge.Zaradi počasnega praženja se bo maščoba na slanini v veliki meri raztopila in poskrbela, da bo slanina postala krhka in hrustljava.Slanino poberemo iz ponve, pri tem pa pazimo, da čim več maščobe ostane v ponvi.', 4, 26),
('Raporedimo jo po papirnatih kuhinjskih brisačkah in pustimo, da se malce ohladi.Tako pripravljena slanina bo krhka in hrustljava, zato jo lahko brez težav zdrobimo z rokami.Šampinjone pred pripravo oščetkamo ali pa na hitro očistimo s papirnato brisačo.Velike šampinjone narežemo na rezine, manjše le razpolovimo, mini šampinjončke pa pustimo kar cele.', 5, 26),
('V ponvi, v kateri smo pražili slanino, se nahaja maščoba, ki je kot nalašč za praženje gobic. Če nam slučajno mast od slanine ne ustreza, lahko namesto nje uporabimo 1 žlico masla.Ponev pristavimo nad srednji-visok ogenj, v vročo maščobo pa vržemo 3 sveže vejice timijana.Dodamo šampinjone. Ob pogostem mešanju jih pražimo 3-5 minut, da se lepo V velik pisker natočimo obilo vode, ki jo pošteno solimo. Lonec pristavimo na ogenj in počakamo, da voda zavre.', 6, 26),
('V slan krop stresemo polovico svaljkov in počakamo, da priplavajo na površje, nato počakamo še kako minuto, da jih poberemo iz vode.Postopek ponovimo še z drugo polovico svaljkov.Medtem, ko se svaljki svaljkajo po kastroli, mi lahko veselo pripravimo omako.V kozico čmoknemo kremni namaz in natočimo mleko.Pristavimo jo nad ogenj, njeno vsebino pa premešamo z metlico. Segrevamo skoraj do vretja.', 7, 26),
('Omako odstavimo z ognja in vanjo primešamo ribanega tolminca.Iz lonca s svaljki ukrademo 3-5 žlic vroče škrobnate vode, ki bo omako ravno prav razredčila in razpustila. Količino vode prilagodimo željni gostoti omake.Omako popramo in solimo po okusu.V krožnik stresemo kupček jesenskih svaljkov in jih takoj razveselimo s kremno omako.Po kostanjevih lulčkih namečemo popražene šampinjone in nadrobimo hrustljavo slanino.Krožnik zaključimo s ščepcem mletih kostanjev in nekaj listki peteršilja.', 8, 26),

-- 27. GRATINIRANE PENNE S PIŠČANCEM IN BROKOLIJEM
('Piščančje prsi nareži na enakomerne kocke in jih zmešaj s ščepcem soli, sladko rdečo papriko in česnom v prahu.', 1, 27),
('Brokoli razreži na posamezne cvetke.', 2, 27),
('Oba sira na drobno naribaj.', 3, 27),
('Pečico segrej na 200 °C.', 4, 27),
('Na ogenj pristavi večji pisker z vodo in jo posoli.', 5, 27),
('Ko voda zavre, vanjo vrzi penne iz rdeče leče. Kuhajo se naj 5 minut, nato se jim pridruži brokoli. Po dveh minutah je kuhe konec (penne se morajo skupno kuhati 7 minut). Penne in brokoli odcedi.', 6, 27),
('Na srednje-visok ogenj pristavi ponev, primerno za pečico, in vanjo vlij oljčno olje. V ponev zdaj skočijo neučakane piščančje kocke. Praži jih, da so lepo zapečene z vseh strani.', 7, 27),
('Zalij jih z juho in dodaj kremni sir. V ponev stresi penne in brokoli ter nariban grana padano. Mešaj kako minuto, da se sir raztopi, kremna omaka pa se razporedi po pennah in brokoliju.', 8, 27),
('Ponev odstavi, in primešaj še gaudo. Po vrhu potresi za 4 žlice ribanega sira grana padano, nato pa ponev postavi v pečico. Pečica naj peče 20 minut.', 9, 27),

-- 28.  BOŽIČNA TORTA
('Spekulas in maslene piškote zdrobite v drobtine (najlažje s pomočjo kuhinjskega robota).', 1, 28),
('Maslo stopite in ga primešajte piškotnim drobtinam, da dobite enotno zmes.', 2, 28),
('Zmes enakomerno porazdelite po dnu tortnega modela in jo dobro pritisnite ob dno. Postavite v hladilnik, da se strdi.', 3, 28),
('Lističe želatine namočite v hladni vodi za približno 5 minut, da se zmehčajo.', 4, 28),
('Božični jogurt zmešajte s sladkorjem v prahu in vanilijevo aromo.', 5, 28),
('Sladko smetano stepite do čvrstega.', 6, 28),
('Zmehčano želatino ožemite in raztopite v malo tople vode. Dodajte jo jogurtovi mešanici in dobro premešajte.', 7, 28),
('Na koncu nežno vmešajte stepeno sladko smetano.', 8, 28),
('Jogurtovo kremo prelijte čez piškotno dno in postavite v hladilnik za približno 30 minut, da se nekoliko strdi.', 9, 28),
('Zamrznjene maline zmešajte s sladkorjem v prahu in jih segrevajte, dokler se popolnoma ne odtalijo in zmehčajo.', 10, 28),
('Maline pretlačite skozi sito, da odstranite semena.', 11, 28),
('Lističe želatine namočite v hladni vodi za približno 5 minut, da se zmehčajo.', 12, 28),
('Zmehčano želatino ožemite in raztopite v malo tople vode. Dodajte jo k pretlačenim malinam in dobro premešajte.', 13, 28),
('Malinovo osnovo enakomerno prelijte čez strjeno jogurtovo kremo.', 14, 28),
('Torto postavite nazaj v hladilnik in pustite, da se dobro strdi, najbolje čez noč.', 15, 28),

-- 29.	JAGODNI KOLAČKI
('V kozico stresi 100 g zamrznjenih jagod in jih segrevaj, da se zmehčajo. Prilij 100 ml sladke smetane in premešaj, nato zmes fino spasiraj.', 1, 29),
('Kozico odstavi, nato v zmes vmešaj pol žličke rdeče barve za kolače in 180 g bele čokolade. Ganache prelij v posodo in ga tesno pokrij s prozorno folijo za živila. Postavi ga v hladilnik za vsaj 6 ur.', 2, 29),
('V posodo stresi 110 g kock iz masla in 140 g sladkorja. Dodaj vrečko vanilin sladkorja in vse skupaj električno premlati do penastega. Najprej povsem vmešaj eno, nato pa še drugo jajce.', 3, 29),
('Vmešaj še 130 g jogurta in žličko arome vanilije. V posodici zmešaj 150 g moke, 1,5 žličke pecilnega praška in 2 ščepca soli. Suhe sestavine primešaj k mokrim.', 4, 29),
('V pekač za muffine vstavi papirnate modelčke, med njih pa razdeli zmes za kolačke. Pekač nekajkrat potolči ob pult, nato ga za 20-25 minut postavi v pečico, segreto na 180 ºC.', 5, 29),
('Strjen ganache zmiksaj, da popeni. Nadevaj ga v dresirno vrečko s poljubnim nastavkom.', 6, 29),
('S sredine kolačka izreži čepek, v novonastali vulkan pa čmokni žličko jagodne marmelade. Marmelado skrij s čepkom, po vrhu kolačka pa nabrizgaj rdeči ganache.', 7, 29),
('Nanj zatakni polovico sveže jagode in eno okrasno cvetlico.', 8, 29),

-- 30.	MIKLAVŽEVI KVAŠENI POLŽI
('V posodo vsuj moko in dodaj suhi kvas, sladkor, sol, jajce, limonino lupinico, stopljeno maslo in olje. Prilij toplo mleko in vse skupaj zmešaj, nato pa dobro pregneti v voljno in prožno testo, ki se ne lepi na roke. Testo moraš na roke gnesti približno 10 minut, drugače pa to delo najbolje opravi kuhinjski robot. Če namesto suhega uporabljaš sveži kvas, ga prej raztopi v toplem mleku.', 1, 30),
('Testo naj v pokriti posodi vzhaja 1 uro, oziroma toliko, da se njegova prostornina podvoji. Skuhaj dve skodelici božičnega čaja – eno zase, eno pa za suho sadje. Sušene marelice sesekljaj in jih skupaj z brusnicami in rozinami stresi v posodico in zalij z vročim čajem. Počakaj, da se namočeno sadje ohladi, nato ga odcedi.', 2, 30),
('Testo prenesi na pomokano površino in ga splošči, nato pa razvaljaj v pravokotnik, debel 0,5 cm. Testo od roba do roba premaži z marelično marmelado. Po marmeladi razporedi odcejeno sadje.', 3, 30),
('Testo zvij v dolgo kačo, ki ji z obeh koncev odščipneš štrukeljčka (speci ju skupaj s polži). Zvitek nareži na 3 – 4 cm debela kolesca, ki jih razporediš po pekaču, prekritim s peki papirjem.', 4, 30),
('Polži naj se na pekaču ne gužvajo, ker se bodo napihnili. Pekač pokrij s krpo in pusti, da polži vzhajajo še 30 minut, vmes pa segrej pečico na 180 ºC. Polže speci v dveh rundah, 15 – 20 minut pri 180 ºC.', 5, 30),

-- 31.	TIRAMISU PREKONOČNI KOSMIČI
('Skuhaj 100 ml poljubnega kofeta in ga ohladi. Midva najraje poseževa po espresso ali instant kavi.', 1, 31),
('V posodi zmešaj 100 g Vitalis müslija, 200 g čokoladnega pudinga, 2 žlici chia semen, 50 ml mleka, žlico kakava, ščepec soli in 2 ščepca cimeta.', 2, 31),
('Sladkaj po okusu. Kosmičasto zmes razdeli v dva kozarčka, ju pokrij in čez noč postavi v hladilnik.', 3, 31),
('Stepi 100 ml sladke smetane in jo nabrizgaj na vrh prekonočnih kosmičev.', 4, 31),

-- 32.	RAFFAELLO CHEESECAKE
('V sekljalnik natlači 130 g maslenih keksov in 30 g mandljevih lističev. V mikrovalovni pečici stopi 70 g masla in ga primešaj k piškotni masi. Piškotno zmes stresi v tortni model in jo potisni ob dno ter pogladi.', 1, 32),
('Stepi 350 ml smetane za stepanje. V kozici segrej preostalo smetano s 200 g bele čokolade in žličko vanilijeve arome ter dodaj namočeno in stopljeno želatino. Mešaj, da se čokolada povsem stopi.', 2, 32),
('V večjo posodo stresi 250 g mascarpone sira in dodaj stopljeno čokolado. Dodaj še kokosovo moko, sladkor v prahu in premešaj. Na koncu primešaj še stepeno smetano.', 3, 32),
('Kremo stresi na piškotno dno. Poravnaj jo in postavi torto v hladilnik, da se krema strdi.', 4, 32),
('Pripravi ganache iz bele čokolade: V kozici zlij 60 ml sladke smetane in dodaj 120 g bele čokolade. Mešaj, da se čokolada stopi. Ko se malce shladi, prelij ganache po vrhu torte.', 5, 32),
('Potresi kokosovo moko in mandljeve lističe po vrhu torte. V kozici segrej 200 g zamrznjenih jagod in 2 žlici sladkorja v prahu, da se jagode zmehčajo. Spasiraj jih v preliv in ga prelij čez torto.', 6, 32),

-- 33.	PRESNA TORTA
('V blender zatlači 160 g orehovih jedrc, 160 g mehkih medjool datljev in 20 g grenkega kakava v prahu. Zmiksaj, da dobiš gosto zmes.', 1, 33),
('Na tortno podlago postavi obroč za torte, nastavljen na premer 20 cm, in namesti acetatno folijo. Nanesi zmiksano maso na dno tortnega modela in potlači ter poravnaj.', 2, 33),
('Odlij tekočino iz pločevinke kokosovega mleka. Strjeni del, kokosovo maščobo, daj v blender. Dodaj odcejene indijske oreščke, kokosovo olje, med ali javorjev sirup ter začimbe (cimet, kardamom, mleti klinčki, mlet ingver).', 3, 33),
('Zmiksaj vse sestavine v gladko, homogeno maso. Prelij maso po podlagi v tortnem modelu in jo poravnaj. Postavi tortico v hladilnik za vsaj 6 ur ali čez noč.', 4, 33),
('Pred serviranjem okrasi torto s semeni granatnega jabolka.', 5, 33),

-- 34.	BANANINI JEŽKI
('Piškote zdrobimo v skledi ali v vrečki s pomočjo lesenega valjarja. Banani olupimo in ju pretlačimo z vilico na krožniku.', 1, 34),
('V skledi zmešamo zdrobljene piškote, pretlačene banane, nutello, rum, mleko in zmehčano maslo. Po potrebi dodamo sladkor v prahu.', 2, 34),
('Maso pokrijemo in jo postavimo v hladilnik za 2 uri.', 3, 34),
('Po hlajenju od mase odtrgamo pest veliko kepo in jo oblikujemo v kroglico. Kroglico povaljamo v kokosovi moki ali čokoladnih mrvicah, da dobimo ježka.', 4, 34),
('Končane ježke postavimo na papirček za praline ali muffine.', 5, 34),


-- 35.	PUDING KOZARČKI Z JAGODIČEVJEM IN KOSMIČI
('V kozico zlij 300 ml mleka in ga zavri. V manjši posodici z metlico zmešaj 100 ml mleka in eno vrečko vanilijevega pudinga. Pudingovo zmes vlij v vrelo mleko in nad ognjem mešaj, da se puding zgosti.', 1, 35),
('Odstavi ga z ognja in ga tesno pokrij s prozorno folijo za živila – ta se mora prilepiti na površino pudinga. Puding ohladi na sobno temperaturo.', 2, 35),
('V posodo vlij 200 ml sladke smetane in stresi vrečko vanilijevega sladkorja. Smetano premlati v stepeno smetano.', 3, 35),
('Ohlajen puding temeljito električno premešaj, nato ga s zmešaj s stepeno smetano. Kremo natlači v dresirno vrečko in jo malo nabrizgaj v ličen kozarček.', 4, 35),
('V kozarec stresi 2-3 žlice mueslija in dodaj manjšo pest malin in borovnic. Parfait zaključi z drugo plastjo kreme. Okrasi ga z jagodičevjem in mueslijem.', 5, 35),

-- 36.	TORTA NUTELLA-LINO LADA
('Jajca in sladkor stepamo do penastega, približno 6 minut. Primešamo olje in mleko. V drugi posodi zmešamo moko, kakav in pecilni prašek. Suhe sestavine primešamo k mokrim.', 1, 36),
('Biskvitno maso vlijemo v tortni pekač, čigar dno je prekrito s papirjem za peko. Pečico segrejemo na 180 °C in jo za 25-30 minut zaposlimo s peko biskvita. Ko je biskvit pečen, preverimo z zobotrebcem, ki mora po vbodu ostati suh.', 2, 36),
('Ko se biskvit ohladi, ga razpolovimo. Eno polovico biskvita postavimo na tortno podlago in okoli njega zategnemo tortni obroč. Po notranji strani obroča namestimo acetatno folijo.', 3, 36),
('Biskvit dobro namočimo z mlekom in ga na tanko premažemo s poljubno marmelado. V eni posodi stepemo sladko smetano do čvrstega. V drugi posodi zmešamo Lino Lado milk in maskarpone. Liste želatine namočimo v hladni vodi in počakamo, da se napojijo. Ožamemo jih in jih dodamo kremi.', 4, 36),
('Kremo razporedimo po biskvitu in jo poravnamo. Na kremo previdno postavimo drugo polovico biskvita. Tudi tega namočimo z mlekom in premažemo z marmelado. V eni posodi stepemo sladko smetano do čvrstega. V drugi posodi zmešamo Nutello in maskarpone. Liste želatine namočimo v hladni vodi in počakamo, da se napojijo. Ožamemo jih in jih dodamo kremi.', 5, 36),
('Kremo razporedimo po drugem biskvitu in jo poravnamo. Torto postavimo v hladilnik za vsaj 6 ur, še raje pa čez noč. Pred postrežbo torto okrasimo po želji.', 6, 36),

-- 37.	-- TORTA STRACCIATELLA Z VIŠNJEVIM PRELIVOM
('Piškote fino zmelji ali zdrobi. Primešaj eno žlico kakava in eno žlico sladkega prahu.', 1, 37),
('Prilij stopljeno maslo in mleko. Vse skupaj premešaj, da dobiš gosto maso. Na tortno podlago postavi tortni obroč in ga nastavi na premer 24 cm. Po notranji strani obroča namesti acetatno folijo. Na tortno dno stresi piškotni cement ter ga z žlico potlači in poravnaj.', 2, 37),
('Postavi v hladilnik, da se piškotno dno strdi.', 3, 37),
('V kozico zlij 200 ml sladke smetane in 1 žličko vanilijeve arome, nato vanjo nalomi 200 g bele čokolade. Kozico pristavi nad srednji ogenj in mešaj njeno vsebino, da se čokolada povsem stopi. Vse štiri liste želatine namoči v hladni vodi in počakaj, da se napojijo.', 4, 37),
('Ožemi jih in vrzi v kozico k čokoladni zmesi. Mešaj, da se želatina povsem stopi. Preostalih 300 ml sladke smetane stepi v stepeno smetano. V večjo posodo čmokni 500 g maskarpone sira, nato k njemu zlij čokoladno zmes.', 5, 37),
('Kremo električno premešaj, nato vanjo s spatulo postopoma primešaj še stepeno smetano. Primešaj 100 g nastrgane čokolade. Kremo zlij na piškotno dno, nato vse skupaj malce potresi, da se vrh kreme poravna.', 6, 37),
('Torto postavi v hladilnik za vsaj 6 ur, še raje pa za čez noč.', 7, 37),
('V kozico stresi 300 g višnjevega kompota. V kozarcu zmešaj nekaj žlic tekočine iz kompota in 1 žlico gustina. Dobljeno zmes vlij v kozico, dodaj pa še 1 žlico sladkega prahu.', 8, 37),
('Višnje pristavi nad ogenj in jih kuhaj, dokler se ne zgostijo. S torte previdno odstrani obroč in acetatno folijo. Prebutaj 200 ml sladke smetane do čvrstega in jo natlači v dresirno vrečko. Stepeno smetano nabrizgaj po zgornjem robu torte. V vsako rozeto vtakni še višnjo iz kompota. Kos torte postrezi z vročim ali hladnim višnjevim prelivom.', 9, 37),


-- 38.	--JAGODNA KUPOLA
('V skodelici zmešaj 100 ml mleka in vrečko jagodnega pudinga. Preostalih 150 ml mleka zavri, nato ogenj zmanjšaj, v vrelo mleko pa z metlico vmešaj pudingovo zmes. Mešaj, da se puding skuha in zgosti.', 1, 38),
('V večjo posodo stresi 250 g maskarpone sira in mu električno premešaj še topel puding. Dodaj 3 zvrhane žlice sladkega prahu, 1 vrečko vanilijevega sladkorja, 1 žličko vanilijeve paste, vrečko želatine fix in nastrgano lupinico pol limone.', 2, 38),
('500 ml sladke smetane stepi in jo s spatulo primešaj h kremi. Večjo skledo z gladko steno po notranji strani obloži s prozorno folijo za živila.', 3, 38),
('Jagode nareži na enako debele krogce, ki jih razporediš po celi steni kupole tako, da se stikajo med sabo. V kupolo stresi približno tretjino kreme in jo poravnaj, da je vodoravna.', 4, 38),
('Savoiardi piškote enega za drugim namoči v mleku (ali v jagodnem soku za bolj intenziven okus) in jih tesno razporedi po kremi. Na piškote stresi preostalo kremo in jo poravnaj, po njej pa zopet razporedi namočene kekse.', 5, 38),
('S prozorno folijo tesno prekrij vsebino kupole in jo postavi v hladilnik za vsaj 6 ur.', 6, 38),
('Z dna kupole odstrani prozorno folijo, nato pa skledo pokrij s poljubnim tortnim dnom in vse skupaj zvrni na glavo. Kupola bo zdaj pravilno obrnjena, zato odstrani skledo in folijo.', 7, 38),
('Po jagodni kupoli razporedi okrasne cvetlice, nato pa jo razkosaj in postrezi.', 8, 38),


-- 39.	POLENTA Z DIMLJENIM LOSOSOM IN KAVIARJEM
('V kozici zavremo vodo in vanjo stresemo sol ter vlijemo oljčno olje. Dodamo instant polento in z metlico nad ognjem mešamo nekaj minut, da se polenta zgosti. Na koncu v polento vmešamo sesekljan peteršilj.', 1, 39),
('Manjši pekač z ravnim dnom namastimo z oljčnim oljem in vanj stresemo polento. Pokrijemo jo s papirjem za peko, nato pa z desko ali drugim pekačem potisnemo navzdol, da jo potlačimo in poravnamo.', 2, 39),
('Polento hladimo v hladilniku kako uro, da se strdi. Iz polente z modelčkom za piškote izrežemo krogce.', 3, 39),
('Kremni sir zmešamo s hrenom in ga z dresirno vrečko nanesemo na polentine krogce. Na kremni sir postavimo natrganega dimljenega lososa, na vrh pa nadevamo malo kaviarja.', 4, 39),

-- 40.	POLŽKI S SKUTO IN FETA SIROM
('V posodo stresi 520 g moke, vrečko suhega kvasa in 1,5 žličke soli. Dodaj obe jajci, 2 dcl mleka in 50 g stopljenega masla. Sestavine dobro premešaj, nato pa pregneti v testo. Posodo s testom pokrij in pusti na sobni temperaturi, da vzhaja 1 uro.', 1, 40),
('V posodo stresi 300 g skute, 100 g fete, 2 žlici kisle smetane ter ubij 2 jajci. Vse skupaj posoli s pol žličke soli in dobro premešaj.', 2, 40),
('Pečico segrej na 180 °C. Testo zvrni na pomokano delovno površino in ga raztegni z dlanmi, nato pa razvaljaj v pravokotnik, debel nekaj milimetrov. Razvaljano testo premaži z nadevom, nato pa ga zvij v dolgo rulado.', 3, 40),
('Rulado nareži na 2 cm debele polžke, ki jih razporediš po dveh pladnjih za peko, prekritih s papirjem za peko. Polžke premaži z razžvrkljanim jajcem in jih pusti 15 minut na sobni temperaturi.', 4, 40),
('Peci jih 20 minut pri 180 °C.', 5, 40),

-- 41.	ŠTRUKELJCI S ŠUNKO IN HRENOM
('Vse naštete sestavine razen masla stresi v posodo in jih zmešaj skupaj v homogeno testo (z robotom to traja cca. 2 minuti).', 1, 41),
('Dodaj maslo sobne temperature, nato testo gneti 5 minut, oz. toliko časa, da je maslo vmešano, testo pa gladko.', 2, 41),
('Testo oblikuj v gladko kepo tako, da robove spodvihaš navznoter, s tem pa napenjaš površino kepe. Testo pusti v posodi in ga pokrij z vlažno krpo. Vzhaja naj toliko časa, da se po prostornini podvoji, približno 1 uro.', 3, 41),
('Testo razdeli na tretjine, ki jih oblikuješ v kepe. Vsako kepo razvaljaj v podolgovat pravokotnik.', 4, 41),
('Po testu razmaži hren s smetano, po njemu pa razporedi rezine šunke. Vse skupaj tesno zvij v dolgo rulado. Z obeh strani odreži konca, rulado pa nareži na 3 cm dolge štrukeljce.', 5, 41),
('Štrukeljce zberi na pekaču, prekritim s peki papirjem. Pokrij jih s krpo in jih pusti vzhajati 20 minut.', 6, 41),
('Pečico nažgi na 180 ºC. Štrukeljce premaži z mešanico jajca in 5 žlic mleka. Peci jih 10-15 minut pri 180 ºC.', 7, 41),

-- 42.	ROSTI
('Krompir splakni in ga z lupino stresi v večjo količino vrele vode. Kuhaj ga 10 minut, nakar ga odcedi in ohladi.', 1, 42),
('Ohlajen krompir olupi in na grobo naribaj.', 2, 42),
('Nariban krompir zmešaj z 1 žličko sladke rdeče paprike, četrt žličke dimljene paprike, pol žličke popra in 1 žličko soli.', 3, 42),
('Nad nizek ognenj pristavi srednjo ponev in jo pusti, da se segreje. V ponev vrzi pol žlice masla in počakaj, da se stopi.', 4, 42),
('Polovico mase s prsti raztresi po ponvi. S spatulo maso rahlo razporedi, a je nikar ne tlači. Ob robu ponve s spatulo potlači maso, da dobiš lep rob. Na eni strani se bo rosti pekel 8-12 minut, odvisno od temperature ponve.', 5, 42),
('Za obračanje si pripravi krožnik z nizkim robom in ga na tanko premaži z oljem. Čez ponev povezni navzdol obrnjen krožnik, nato vse skupaj zvrni na glavo. Ponev pristavi nazaj nad ogenj in vanjo previdno zdrsni rosti z namaščenega krožnika. Na drugi strani ga peci dodatnih 8-12 minut. Postopek ponovi še z drugo polovico mase.', 6, 42),
('Za nadev preprosto uporabi kislo smetano, ki jo potreseš z nasekljanim svežim drobnjakom.', 7, 42),

-- 43.	OCVRT BRIE Z BRUSNIČNO POMAKO
('Paniranje sledi klasičnemu zaporedju – moka, jajce in drobtine. V prvi posodi zmešaj moko in česen v prahu.', 1, 43),
('V drugi posodi sklofaj jajca, tabasco in 3 konkretne ščepce soli.', 2, 43),
('V tretji posodi pa zmešaj panko drobtine in nasekljan peteršilj.', 3, 43),
('Vsako trikotno kajlo sira brie nareži na 4 dele – nekje na polovici odreži vrh, da dobiš prvi trikotnik, preostanek pa z dvema rezoma nareži na tri približno enake trikotnike.', 4, 43),
('Vsak kos sira povaljaj v moki s česnom, nato potunkaj v jajčni kopeli, na koncu pa obleci v panko drobtine. Sir moramo dvojno spanirati, zato vrni kos nazaj v jajčno kopel in nato zopet povaljaj v drobtinah. Postopek ponovi za vse sirove trikotnike.', 5, 43),
('V lonec zlij toliko olja za cvrenje, da se lahko vsak kos paniranega sirčka potunka pod gladino in obrača po mili volji. Olje pristavi na srednji-visok ogenj in ga pusti 5-10 minut pri miru, da se segreje, nato se loti cvrenja. Naenkrat naj bodo v oljni kopeli le 4 kosi sira. Cvri jih toliko časa, da se napihnejo in dvignejo na površje. Poberi jih iz piskra in razporedi po posteljici iz papirnatih brisač, da se znebiš odvečnega olja.', 6, 43),
('Brusnično marmelado, kislo smetano in sol preprosto zmešaj.', 7, 43),

-- 44.	HRENOVKE V LISTNATEM TESTU
('Hrenovke nareži na tri enake dele.', 1, 44),
('Listnato testo razgrni in premaži z gorčico. Nareži ga na trakove in ovij okoli hrenovk tako, da je gorčica na notranji strani.', 2, 44),
('Zavite hrenovke premaži z razžvrkljanim jajcem in posuj s sezamom.', 3, 44),
('Peci jih na 200 ºC 15 do 20 minut.', 4, 44),

-- 45.	ŠPINAČNI VENEC Z RIKOTO
('Špinačo odtajaj in jo dobro ožemi, da se znebiš odvečne tekočine.', 1, 45),
('Špinačo zmešaj z rikoto, jajcem, parmezanom, poprom in soljo.', 2, 45),
('Razprostri listnato testo in iz njega s pomočjo velike pokrovke izreži največji možen krog.', 3, 45),
('Z nožem v sredino kroga s štirimi rezi zareži tako, kot da bi želel razrezati krog na 8 enakih delov, pri tem pa mora segati vsak rez nekje 5 cm od roba.', 4, 45),
('Špinačni nadev nanesi okoli in okoli ob robu kroga.', 5, 45),
('Iz sredine kroga pograbi eno izmed osmih špic, jo potegni stran od sredine, povezni čez nadev ter špico stisni skupaj z robom kroga. Ko postopek ponoviš še za ostalih 7 krakov, bo pred tabo simpatičen kolobar, nared za peko.', 6, 45),
('Jajce razžvrkljaj in ga premaži po testu. Pečico segrej na 200 °C in jo za 25 minut zaposli s peko venca.', 7, 45),

-- 46.	ČEMAŽEVO MASLO IN MOUSSE IZ DIMLJENE POSTRVI
('Sladko smetano stepemo v stepeno smetano in nato nadaljujemo z mešanjem, dokler se ne loči v tekočino in čvrsto maslo.', 1, 46),
('Čvrsto maslo stisnemo v kepo in ga splaknemo pod hladno tekočo vodo.', 2, 46),
('Čemaž splaknemo in natrgamo liste, ki jih skupaj z maslom in soljo zmešamo v sekljalniku v zelenkasto maslo.', 3, 46),
('Čemaževo maslo nanesemo na krožnik ali stlačimo v poljubne posodice ter postavimo v hladilnik, da se strdi.', 4, 46),
('Sestavine za dimljen mousse prešerno zmiksamo v mešalniku.', 5, 46),
('Na popečene kruhke najprej nanesemo čemaževo maslo, nato pa prekrijemo z dimljenim mousseom.', 6, 46),

-- 47.	PICA KRUHKI
('Paradižnik narežemo na tanke rezine, papriko na tanke trakove, olive na kolute in rukolo operemo ter osušimo.', 1, 47),
('Toaste položimo na pekač, obložen s peki papirjem. Po vsakem kosu toasta razporedimo tanko plast paradižnikove omake (če jo uporabljamo) in nato na vsak kos toasta položimo riban sir.', 2, 47),
('Na polovico kosov toasta položimo rezine kuhanega pršuta. Po želji po vrhu sira in pršuta razporedimo narezano papriko, olive, koruzo ter paradižnikove rezine. Začinimo s svojimi najljubšimi začimbami, kot so origano, bazilika in poper.', 3, 47),
('Pica kruhke pecite v predhodno ogreti pečici na 180°C približno 8-10 minut, ali dokler se sir ne stopi in tosti ne postanejo hrustljavi. Pustite, da se pica kruhki malo ohladijo, nato pa jih postrezite in uživajte v okusnem prigrizku!', 4, 47),
('Te pica kruhke so odlična izbira za hitro in okusno malico ter so zagotovo priljubljene tudi med otroki!', 5, 47),

-- 48.	ITALIJANSKI MANDLJEVI PIŠKOTI
('V eni posodi zmešaj skupaj mlete mandlje in sladki prah.', 1, 48),
('V drugo posodo stresi beljake, limonin sok in ščepec soli. Z električnim mešalnikom jih stepaj, dokler ne dobiš snega s čvrstimi vrhovi – z metlico zajemi sneg, špička na vrhu pa se ne sme upogniti.', 2, 48),
('Snegu primešaj mandljevo aromo.', 3, 48),
('K snegu s spatulo primešaj mešanico mletih mandljev in sladkega prahu, da dobiš lepljivo kepo. Pusti jo stati pri miru 10 minut.', 4, 48),
('Pečico segrej na 150 °C. Na krožnik stresi nekaj žlic sladkega prahu. Od mase odtrgaj košček in ga oblikuj v majhno kroglico (15 g). Povaljaj jo v sladkem prahu in prestavi na pladenj za peko, prekrit s peki papirjem. Postopek ponovi s preostalo maso. Če se ti ta lepi na dlani, jih natri s sladkim prahom.', 5, 48),
('Piškote peci 25 minut pri 150 °C.', 6, 48),


-- 49.	TIRAMISU TORTA Z BAILEY’S LIKERJEM IN MALINAMI
('Instant kavo in 2 žlici sladkorja v prahu zalij z vrelo vodo, nakar se zabavi pridružita še mleko in liker. Liste želatine namoči v hladni vodi, da nabreknejo. Pograbi metlico in z njo nad paro stepaj rumenjake in 140 g sladkorja, da se ves sladkor raztopi.', 1, 49),
('Liste želatine ožemi in jih primešaj k rumenjakom, da se želatina popolnoma raztopi. Sladko smetano stepi. K maskarponeju primešaj rumenjake, nato pa s spatulo še stepeno smetano.', 2, 49),
('Za gradnjo tiramisuja si pripravi tortno podlago, na katero postaviš tortni obroč. Po notranji strani obroča namesti acetatno folijo. Savoiardi kekse namoči v kavni mešanici in z njimi prekrij dno v tortnem obroču. Piškotki naj se ne namakajo predolgo, saj bodo drugače povsem razpadli.', 3, 49),
('Na piškote nanesi tretjino kreme, v katero nato zapičiš polovico malin. Postopek od namakanja piškotov do podtikanja malin ponovi še dvakrat, s tem, da maline v vrhnjo kremo ne spadajo.', 4, 49),
('Nadebudno torto zdaj pospravi v hladilnik, kjer naj čaka na slajše čase. Vsaj 6 ur. Ko torti snameš obroč, jo obdaj z ograjo iz nenamočenih savoiardi keksov. Da so vsi keksi nekje enake dolžine, poskrbiš tako, da vzameš enega, z njim določiš višino (čez rob torte naj gleda za debel prst) in ga uporabiš kot vzorec pri rezanju nadaljnih piškotkov.', 5, 49),

-- 50.	PIŠČANEC PUTTANESCA Z REZANCI
('Meso posoli in popopraj po obeh straneh in ga v večji ponvi na oljčnem olju popeci na vsaki strani 4 minute. Odstrani ga, v posodo pa stresi nasekljano čebulo. Ko postekleni, dodaj česen in ko ta zadiši, dodaj slastne koščke pelatov.', 1, 50),
('V ponev špricni mezgo, stresi origano, frcni sol in dodaj piščanca. Na vrh stresi polovičke češnjevih paradižnikov, premešaj in pokrij ter kuhaj na zmernem ognju.', 2, 50),
('V večji količini slanega kropa skuhaj testenine in jih odcedi. Vse kose piščančka vzemi iz posode, namesto njega pa vanjo vrzi rezance. Vse skupaj dobro premešaj, nato pa na vrh položi meso, nameči liste bazilike ter nadrobi feta sir.', 3, 50),

-- 51.	FOKAČA S SUŠENIMI PARADIŽNIKI, OLIVAMI IN ROŽMARINOM
('V večjo skledo stresi moko in dodaj sol, suhi kvas, 8 žlic oljčnega olja in vodo. S kuhinjskim robotom mešaj sestavine 2 minuti. Testo pokrij in ga pusti stati pol ure.', 1, 51),
('S spatulo ga premešaj v gladko testo. Večji pekač z visokim robom dobro premaži z oljčnim oljem. Testo stresemo naravnost v pekač, ki ga tesno zavijemo v prozorno folijo za živila.', 2, 51),
('Pekač s testom postavimo v hladilnik za 10-12 ur. Naslednji dan naj bo pred peko pekač s testom 3-4 ure na sobni temperaturi. Pečico segrej na 240 ºC', 3, 51),
('Testo radodarno pošpricaj z oljčnim oljem in vanj s prsti vtisni luknje po celotni površini. Po fokači razporedimo črne olive, sušene paradižnike, sveži rožmarin in 2-3 ščepce solnega cveta ali morske soli.', 4, 51),
('Fokačo peci 20-25 minut pri 240 ºC. Še vročo fokačo s čopičem premaži z oljčnim oljem.', 5, 51),

-- 52.	BOLONJSKA OMAKA IZ PEČICE
('Čebulo olupimo in na drobno nasekljamo. Korenček olupimo z lupilcem in ga narežemo na drobne kocke. Zeleno operemo in odrežemo vejice z listki. Stebla narežemo na drobne kocke. Panceto prav tako narežemo na drobne kocke. Česen in sušene paradižnike na drobno nasekljamo.', 1, 52),
('Na srednji ogenj pristavimo veliko litoželezno posodo s pokrovom, ki mora biti primerna za pečico. V posodo vržemo 1 žlico masla in 2 žlici oljčnega olja. Dodamo narezano panceto in jo pražimo 5 minut. Dodamo čebulo, korenček, zeleno, sušene paradižnike in česen, nato vse skupaj temeljito premešamo. Sofrito med pogostim mešanjem pražimo 10 minut.', 2, 52),
('Ogenj povečamo, v posodo pa k sofritu zvrnemo mleto goveje in svinjsko meso. Dobro premešamo in pustimo pri miru 3 minute, da se meso popeče, nato pomešamo in pražimo še 3 minute. S kuhalnico moramo mleto meso temeljito razdrobiti. Pri večjih količinah (ali manjši posodi) najprej popražimo eno, nato pa še drugo polovico mesa.', 3, 52),
('Prilijemo vino, premešamo in počakamo, da povre. V kozici segrejemo juho in v njej raztopimo paradižnikov koncentrat. Vsebino kozice zlijemo v lonec in premešamo. Dodamo mleko, 1 žličko soli, 1 žličko popra in lovorjeve liste. Po želji dodamo še 1-2 žlici worcestershire omake. Vse skupaj dobro premešamo, pokrijemo s pokrovko ter prestavimo v pečico, segreto na 160 °C.', 4, 52),
('Omaka naj se kuha 3 ure. Vmes jo nekajkrat pomešamo. Če se nam zdi, da se je na vrhu omake nabralo preveč maščobe, je nekaj poberemo z žlico. Če se zdi omaka pretekoča, jo lahko zadnjih 30-45 minut kuhamo odkrito. Pred postrežbo iz omake poberemo lovorjeve liste.', 5, 52),

-- 53. ČOKOČINO TORTA
('V obroču za torte ali tortnem pekaču razporedi savoiardi kekse tako, da ležijo na boku. Tesno se morajo prilegati eden ob drugemu, luknje pa zakrpaj z nalomljenimi keksi. Mleko segrej in v njemu raztopi mešanico za instant kapučino.', 1, 53),
('Enakomerno ga prelij čez plast keksov, da se ti napijejo kot pri tiramisuju.400 ml smetane stepi do čvrstega.Želatino namoči v hladni vodi in počakaj, da nabrekne. Ožemi jo in vrzi v kozico s čokolado. Pristavi jo na srednji ogenj in pozorno mešaj, da se želatina popolnoma raztopi.', 2, 53),
('Čokoladno zmes ohladi do mlačnega in jo z mikserjem primešaj k maskarpone siru.Na koncu v kremo s spatulo nežno vmešaš še stepeno smetano.Kremo prelij čez plast keksov, nastajajočo tortico pa postavi v hladilnik, da se krema strdi.V sladko smetano stresi sladkor v prahu, instant kapučino in kremfix.Vse skupaj intenzivno zmiksaj do goste kreme.Kremo stlači v dresirno vrečko in jo s poljubnim nastavkom pobrizgaj po vrhu čokoladne kreme', 3, 53),

-- 54.	Mehiška quesadilla
('Na segretem oljčnem olju prepražimo čebulo in česen, da postaneta mehka in dišeča. Dodamo gobe in jih pražimo, dokler ne postanejo mehke in zlatorjave. Dodamo še narezano papriko ter pražimo še nekaj minut, da se zmehča. Začinimo s soljo in poprom po okusu.', 1, 54),
('Na nekaj olja segrejemo ponev ali žar. Na eno polovico vsake tortilje razporedimo del gobove mešanice, nato pa dodamo malo naribanega sira. Prekrijemo s preostalimi polovicami tortilj in jih enakomerno pritisnemo.', 2, 54),
('Quesadille pečemo na segreti ponvi ali žaru, dokler se na obeh straneh ne zlato rjavo zapečejo in sir stopi. Vsako stran pečemo približno 2-3 minute. Pečene quesadille razrežemo na trikotnike in jih postrežemo še tople.', 3, 54),

-- 55.	Chiles rellenos:
('Paprike operite in jih prepolovite po dolžini. Odstranite semena in bele membrane, da nastanejo votle polovice paprik.', 1, 55),
('V vsako papriko položite nekaj rezin sira. Lahko uporabite tudi druge sestavine po želji, kot so narezane olive ali kuhana mesna nadev.', 2, 55),
('Beljake stepemo v čvrst sneg. Dodamo ščepec soli.', 3, 55),
('Rumenjake ločeno razžvrkljamo v drugi posodi.', 4, 55),
('V vsako polovico paprike vstavite nadev s sirom. Papriko zaprite s pomočjo zobotrebca, da nadev ostane v notranjosti.', 5, 55),
('V veliki ponvi segrejte olje na srednje visoki temperaturi.', 6, 55),
('Vsako papriko najprej povaljajte v moki, nato pa v stepenih beljakih.', 7, 55),
('Paprike položite v vroče olje in jih cvrite, dokler ne postanejo zlato rjave in hrustljave po vseh straneh.', 8, 55),
('Odcedite cvrte paprike na papirnati brisači, da odstranite odvečno olje.', 9, 55),
('Postrezite jih na krožniku, obloženem s paradižnikovo omako in kislo smetano. Okrasite s svežimi korianderjevimi lističi.', 10, 55),
('Chiles rellenos so najboljši, ko so še topli in hrustljavi.', 11, 55),

-- 56.	Enchilade:
('V ponvi segrejte oljčno olje na srednji temperaturi. Dodajte narezano čebulo in papriko ter jih pražite, dokler ne postaneta mehki in rahlo zlato rjavi. Začinite s soljo in poprom po okusu.', 1, 56),
('Dodajte narezano kuhano meso v ponev in ga prepražite, dokler se ne ogreje.', 2, 56),
('Segrejte koruzne tortilje na ponvi ali v mikrovalovni pečici, da postanejo mehke.', 3, 56),
('Na vsako tortiljo položite nekaj žlic nadeva (meso, čebula, paprika).', 4, 56),
('Dodajte malo naribanega sira na vrh nadeva.', 5, 56),
('Enchilado tesno zvijte in položite v pekač za peko.', 6, 56),
('Enchilade prelijte s paradižnikovo omako ali salsi.', 7, 56),
('Potresite jih z dodatnim naribanim sirom.', 8, 56),
('Pekač postavite v predhodno ogreto pečico in pecite pri 180°C približno 15-20 minut, ali dokler se sir na vrhu ne stopi in postane zlato rjav.', 9, 56),
('Enchilade postrezite na krožniku, okrašene s svežimi koriandrovimi lističi.', 10, 56),
('Kot dodatek lahko ponudite kislo smetano.', 11, 56),
('Postrežite in uživajte v okusnih in začinjenih enchiladah!', 12, 56),

-- 57.	Chiles en Nogada
('Paprike pečemo neposredno na plinskem gorilniku ali pod žarom, dokler ne postanejo črne in opečene na vseh straneh. Nato jih damo v plastično vrečko, da se parijo, nato pa odstranimo kožo, odstranimo semena in nadevamo.', 1, 57),
('V ponvi segrejte oljčno olje na srednji temperaturi. Dodajte čebulo in česen ter pražite, dokler ne postaneta mehka in dišeča.', 2, 57),
('Dodajte mleto meso in kuhajte, dokler ni popolnoma kuhano.', 3, 57),
('Dodajte narezane paradižnike, jabolka, rozine, mandlje, orehe, granulirani sladkor, sol in poper. Kuhajte še nekaj minut, da se okusi premešajo.', 4, 57),
('V mešalniku zmešajte smetano, jogurt, peteršilj, granulirani sladkor in pinjole, dokler ne dobite gladke omake.', 5, 57),
('Poblano paprike napolnite z nadevom iz mesa.', 6, 57),
('Na vrh vsake paprike položite orehovo omako.', 7, 57),
('Okrasite s semeni granatnega jabolka.', 8, 57),
('Chiles en Nogada postrezite takoj in uživajte v tradicionalni mehiški poslastici!', 9, 57),

-- 58. Peking Duck 
('Raco operite in jo dobro osušite s papirnato brisačo. Preverite, ali so notranje dele in koža suhi.', 1, 58),
('Prebodite kožo raca s konico noža ali vilicami, da se maščoba med peko izloči.', 2, 58),
('V skledi zmešajte sol, kis, med ali sladkor, sojino omako, temno sojino omako in 5-začimbno mešanico (če jo uporabljate). To bo marinada za raco.', 3, 58),
('Raco položite v globok pekač ali posodo, nato pa jo prelijte s pripravljeno marinado, tako da je enakomerno prekrita.', 4, 58),
('Pokrijte pekač s prozorno folijo in pustite raco marinirati v hladilniku vsaj 4 ure ali čez noč, če je mogoče, da se okusi dobro absorbirajo.', 5, 58),
('Pečico segrejte na 200°C.', 6, 58),
('Raco položite na rešetko v pekaču s prsnim košem navzdol. Dodajte nekaj vroče vode v pekač, da pomagate ustvariti paro in ohranite raco sočno med peko.', 7, 58),
('Pečico pečemo 15-20 minut na 200°C, nato pa zmanjšamo temperaturo na 180°C in pečemo še približno 1 uro in 30 minut (glede na velikost), dokler koža ni zlato rjava in hrustljava, in notranjost je kuhana.', 8, 58),
('Med peko večkrat premažite raco s sokom v pekaču, da ohranite sočnost.', 9, 58),
('Pečeno raco odstranite iz pečice in pustite počivati nekaj minut, preden jo razrežete.', 10, 58),
('Postrezite jo s tradicionalnimi prilogami, kot so rezine kumaric, rezine čebule, palačinke, omaka hoisin in ohlajen ščepec sladkorja.', 11, 58),

-- 59.	Gong Bao Jī Dīng
('V majhni skledi zmešajte sojino omako, rižev kis, sladkor, raztopljeni koruzni škrob in vodo. Postavite na stran.', 1, 59),
('V večji ponvi ali woku segrejte olje na srednji temperaturi.', 2, 59),
('Dodajte narezane piščančje koščke in jih kuhajte, dokler ne postanejo zlatorjavi.', 3, 59),
('Ko je piščanec skoraj kuhan, dodajte arašide in jih pecite še nekaj minut, da postanejo hrustljavi.', 4, 59),
('Odstranite piščanca in arašide iz ponve ter ju postavite na stran.', 5, 59),
('V isti ponvi dodajte še malo olja, če je potrebno, in dodajte suhe čilije, nasekljan ingver in česen. Pražite nekaj sekund, dokler ne zadiši.', 6, 59),
('Dodajte narezane zelenjavne koščke (zeleno čebulo in rdečo papriko) v ponev in jih pražite nekaj minut, da se zmehčajo.', 7, 59),
('Ko je zelenjava mehka, dodajte nazaj piščanca in arašide v ponev.', 8, 59),
('Prelijte z omako, ki ste jo pripravili prej, in kuhajte še nekaj minut, da se omaka zgosti in vsi okusi dobro premešajo.', 9, 59),
('Gong Bao Jī Dīng postrezite s kuhanim rižem in po želji okrasite s sesekljanimi svežimi zelišči, kot so koriander ali peteršilj.', 10, 59),
('Uživajte v tej okusni in začinjeni kitajski jedi!', 11, 59),

-- 60.	VEGAN MAPO TOFU
('Tofu narežite na majhne kocke in jih rahlo popecite v ponvi ali woku na srednji temperaturi, dokler ne postanejo zlato rjavi. Nato jih odstranite iz ponve in jih postavite na stran.', 1, 60),
('V ponvi ali woku segrejte oljčno olje na srednji temperaturi.', 2, 60),
('Dodajte nasekljan česen, ingver, fermentirano črno sojino pasto (ali sojino omako) ter rjavi sladkor ali agavin sirup. Kuhajte nekaj minut, da se okusi premešajo.', 3, 60),
('V ponvi dodajte tofu in ga nežno premešajte, da se prepoji z omako.', 4, 60),
('Nato dodajte kitajsko petejevko (fermentirano črno fižolovo pasto), suhe rdeče čilije, zelenjavno ali gobovo juho, sol in poper. Dobro premešajte.', 5, 60),
('Kuhajte nekaj minut, da se tofu dobro prepoji z omako in začimbami.', 6, 60),
('Nato dodajte raztopljeni koruzni škrob in vodo ter kuhajte še nekaj minut, da se omaka zgosti.', 7, 60),
('Mapo Tofu postrezite vroče, okrašeno s sesekljanimi zelenimi čebulicami in svežim koriandrom.', 8, 60),
('Postrezite s kuhanim rižem ali rezanci po želji.', 9, 60),

-- 61. DUMPLINGS
('V srednji skledi zmešajte moko in postopoma dodajajte vročo vodo, medtem ko mešate z leseno žlico ali kuhalnico. Ko se začne oblikovati testo, ga prestavite na ravnino površino in ga gnetite približno 5-10 minut, da postane gladko in elastično. Testo oblikujte v kroglo, ga pokrijte s čisto krpo in pustite počivati vsaj 30 minut.', 1, 61),
('V veliki skledi zmešajte mleto meso, nasekljano zeleno čebulo, sojino omako, sezamovo olje, nasekljan ingver, nasekljan česen, rižev kis, sladkor, poper in sol. Dobro premešajte, da se vse sestavine enakomerno združijo.', 2, 61),
('Testo razvaljajte na ravnini površini, da dobite tanek krog testa. S krožnikom ali modelčkom za rezanje izrežite kroge iz testa.', 3, 61),
('Na sredino vsakega kroga testa položite majhno količino nadeva (približno 1 žlico). Zmočite robove testa s prsti ali s čopičem, nato pa zaprite dumpling tako, da ga zložite na pol in stisnete robove skupaj, da dobite polmesec.', 4, 61),
('Po želji lahko robove dodatno zavihate, da dobite klasičen videz dumplinga.', 5, 61),
('V velikem loncu zavrite vodo. Dodajte dumplingse v vrelo vodo in kuhajte, dokler ne plavajo na vrhu in so skoraj kuhani, približno 4-5 minut.', 6, 61),
('Odstranite dumplingse iz vode s cedilom in jih odcedite.', 7, 61),
('Postrezite dumplingse vroče, s sojino omako ali čilijevim oljem za potapljanje. Lahko jih okrasite s sesekljano zeleno čebulo ali sezamovimi semeni.', 8, 61),

-- 62. Chicken chow mein
('Rezance chow mein skuhajte v vreli vodi, kot je navedeno na embalaži. Ko so kuhani, jih odcedite in sperite s hladno vodo ter postavite na stran.', 1, 62),
('V veliki ponvi ali woku segrejte oljčno olje na srednji temperaturi.', 2, 62),
('Dodajte narezan piščanec in ga pražite, dokler ni zlatorjavo in popolnoma kuhano. Nato ga odstranite iz ponve in postavite na stran.', 3, 62),
('V isti ponvi dodajte še malo oljčnega olja, česen in ingver ter jih pražite nekaj sekund, da zadišijo.', 4, 62),
('Dodajte narezano rdečo papriko, korenček, beli del zelene čebule in narezano čebulo. Pražite nekaj minut, dokler zelenjava ne postane mehka, a še vedno hrustljava.', 5, 62),
('V manjši skledi zmešajte sojino omako, temno sojino omako, rižev kis, sladkor, sol in poper. Dobro premešajte, da se sladkor raztopi.', 6, 62),
('Vrnite piščanca v ponev z zelenjavo. Dodajte narezane češnjeve paradižnike in pripravljeno omako. Dobro premešajte, da se vse sestavine enakomerno prepojijo z omako.', 7, 62),
('Na koncu dodajte kuhane rezance chow mein in nežno premešajte, da se vse sestavine združijo.', 8, 62),
('Piščančji chow mein postrezite vročega, okrašenega s sezamovimi semeni in nasekljanim koriandrom.', 9, 62),

-- 63. PIŠČANEC V SEZAMU
('V srednji skledi zmešajte sojino omako, sezamovo olje, rižev kis in sladkor. Dobro premešajte, da se sladkor raztopi.', 1, 63), 
('Narezane piščančje rezine položite v marinado in jih temeljito premešajte, da so enakomerno prekrite. Pustite marinirati vsaj 15-20 minut v hladilniku.', 2, 63), 
('Potresemo mariniran piščanec s koruznim škrobom, da se dobro oprime.', 3, 63), 
('V veliki ponvi ali woku segrejte oljčno olje na srednji temperaturi.', 4, 63), 
('Dodajte nasekljan česen in ingver ter pražite, da zadišijo, približno 1 minuto.', 5, 63), 
('Dodajte mariniran piščanec v ponev in ga kuhajte, dokler ni popolnoma kuhano in zlato rjave barve, približno 5-7 minut. Občasno premešajte, da se piščanec enakomerno popeče.', 6, 63), 
('Ko je piščanec skoraj kuhan, dodajte sezamova semena v ponev in jih prepražite še nekaj minut, da postanejo hrustljavo rjave barve.', 7, 63), 
('Piščančje sezamove rezine postrezite vroče, okrašene s sesekljano zeleno čebulo in dodatnimi sezamovimi semeni po želji.', 8, 63),

-- 64. TONKOTSU RAMEN
('Kosti svinjine temeljito operite pod tekočo vodo, da odstranite morebitne krvne ostanke.', 1, 64), 
('V velikem loncu zavrite vodo. Dodajte svinjske kosti in kuhajte 5 minut. Nato kosti odcedite, jih sperite pod hladno vodo in očistite vse umazanije.', 2, 64), 
('V ponvi pražite čebulo, korenje, česen, ingver in zeleno čebulo, dokler ne postanejo rahlo zlato rjavi.', 3, 64), 
('V velikem loncu združite ocvrto zelenjavo, kosti svinjine, alge kombu (če jo uporabljate) in vodo. Pustite, da zavre, nato pa zmanjšajte ogenj in počasi kuhajte juho vsaj 6 ur (lahko tudi več), da se okusi temeljito združijo. Med kuhanjem odstranite morebitno peno, ki nastane na vrhu.', 4, 64), 
('Ko je juha kuhana, jo precedite skozi gosto sito ali cedilo, da odstranite kosti in zelenjavo. Solite po okusu.', 5, 64), 
('V skledi zmešajte nariban ingver, nariban česen, sojino omako in sezamovo olje. Dodajte meso in ga marinirajte vsaj 30 minut.', 6, 64), 
('Ramen testenine skuhajte v skladu z navodili na embalaži. Nato jih odcedite in splaknite pod hladno vodo.', 7, 64), 
('V ponvi segrejte malo olja in pecite marinirano meso, dokler ne postane zlato rjavo in popolnoma kuhano.', 8, 64), 
('Na dno vsake sklede postavite nekaj kuhanih ramen testenin. Dodajte vročo juho Tonkotsu, nato pa na vrh položite rezine mesa, trdo kuhana jajca, špinačo in druge dodatke po vaši izbiri.', 9, 64), 
('Okrasite s praženimi sezamovimi semeni, nasekljano zeleno čebulo in drugimi dodatki po želji.', 10, 64),
('Postrezite takoj in uživajte v okusnem Tonkotsu Ramenu!', 11, 64),

-- 65. Chicken Katsu Curry
('Vsak piščančji file potolcite, da postane enakomerne debeline. Začinite s soljo in poprom.', 1, 65),
('Pripravite tri sklede: v eno dodajte moko, v drugo razžvrkljana jajca, v tretji pa drobtine.', 2, 65),
('Vsak piščančji file najprej povaljajte v moki, nato ga potopite v jajce in na koncu v drobtine, ga temeljito obložite.', 3, 65),
('V globoki ponvi segrejte olje na srednje visoki temperaturi.', 4, 65),
('Piščančje fileje ocvrite, dokler ne postanejo hrustljavo in zlato rjavi na obeh straneh. To običajno traja približno 4-5 minut na vsaki strani, odvisno od debeline mesa.', 5, 65),
('Ocvrte piščančje fileje položite na krožnik obložen s papirnatimi brisačami, da absorbirajo odvečno olje. Hranite jih na toplem, medtem ko pripravljate curry omako.', 6, 65),
('V drugi ponvi segrejte olje na srednji temperaturi.', 7, 65),
('Dodajte nasekljano čebulo in korenje ter pražite, dokler se ne zmehčata.', 8, 65),
('Dodajte nasekljan česen in curry pasto ter kuhajte, dokler ne zadiši.', 9, 65),
('Postopoma dodajajte zelenjavno ali piščančjo juho, da dobite želeno gostoto omake. Dodajte sojino omako, sladkor, kurkumo, sol in poper ter dobro premešajte.', 10, 65),
('Na krožnik položite piščančje Katsu rezine in jih prelijte s curry omako.', 11, 65),
('Postrezite s kuhano rižem ali rezanci ter okrasite s sesekljanimi zelišči, kot so koriander ali peteršilj.', 12, 65),

-- 66. Takoyaki 
('V skledi zmešajte moko, vodo, jajce, dashi prah in ščepec soli. Dobro premešajte, da dobite gladko testo brez grudic.', 1, 66),
('Segrejte takoyaki ponev na srednji temperaturi. Vsako vdolbino na ponev namastite z malo olja ali masla.', 2, 66),
('V vsako vdolbino na ponev položite košček ocvrtega lignja. Dodajte tudi narezano zeleno čebulo, korenček in kozice po želji.', 3, 66),
('Ko je ponev dovolj vroča, nalijte testo v vsako vdolbino na ponev, dokler niso približno tri četrtine polne.', 4, 66),
('Ko se spodnji deli testa začnejo kuhati in postajati trdi, uporabite palčke ali posebno orodje za takoyaki, da obrnete kroglice in jih zavrtite, da se kuhamo enakomerno in postanejo kroglaste.', 5, 66),
('Ko so kroglice lepo zlato rjave barve in enakomerno kuhane, jih previdno odstranite iz ponve in jih položite na krožnik.', 6, 66),
('Po vrhu vsake kroglice pokapljajte takoyaki omako in majonezo, če želite. Potresite s sušeno algo aonori in katsuobushi.', 7, 66),
('Takoyaki postrezite takoj, ko so še topli, in uživajte v njihovem okusu in teksturi!', 8, 66),

-- 67.Tori Dango Nabe (HOT POT)
('V skledi združite mleto piščančje meso, jajce, drobtine, sojino omako, mirin, sezamovo olje, nariban ingver, sesekljan česen, sol in poper. Dobro premešajte, da se vse sestavine enakomerno združijo.', 1, 67),
('Oblikujte majhne kroglice iz mešanice mesa, približno velikosti češnjevega paradižnika.', 2, 67),
('V ponvi segrejte olje in kroglice tsukune ocvrite, dokler niso lepo zlato rjave po vseh straneh. Odcedite na papirnatih brisačah, da se odstrani odvečno olje.', 3, 67),
('V velikem loncu združite piščančjo juho, vodo, sojino omako, mirin, sake in sladkor. Pustite, da zavre.', 4, 67),
('Dodajte narezan por, korenje in gobe v juho. Kuhajte 5-7 minut, da se zelenjava zmehča.', 5, 67),
('V posodo za kuhanje nabranega topla juha dodajte ocvrte mesne kroglice tsukune, tofu in narezano zeleno čebulo.', 6, 67),
('Kuhajte še 2-3 minute, da se vse sestavine enakomerno segrejejo.', 7, 67),
('Postrežite vroče in uživajte v tej okusni in hranljivi enolončnici Tsukune Hot Pot!', 8, 67),

-- 68. Karaage
('V skledi zmešajte sojino omako, sake, sezamovo olje, nariban ingver in sesekljan česen. Dobro premešajte, da se sestavine enakomerno združijo.', 1, 68),
('Piščančje koščke položite v marinado in jih temeljito premešajte, da so enakomerno prekriti. Pokrijte in marinirajte vsaj 30 minut v hladilniku, po možnosti pa lahko tudi čez noč, da se okusi še bolj razvijejo.', 2, 68),
('V večjem loncu ali globoki ponvi segrejte olje na srednje visoki temperaturi. Olje naj bo dovolj globoke, da pokrije piščančje koščke.', 3, 68),
('Piščančje koščke vzemite iz marinade in jih povaljajte v koruznem škrobu ali moki za cvrtje, da jih enakomerno prekrijete.', 4, 68),
('En kos po enega položite v vroče olje in jih ocvrite, dokler ne postanejo hrustljavo zlato rjavi. To običajno traja približno 5-7 minut, odvisno od debeline mesa.', 5, 68),
('Ocvrte koščke odcedite na papirnatih brisačah, da se odstrani odvečno olje.', 6, 68),
('Ocvrte piščančje kose karaage postrezite vroče, okrasite jih lahko s sesekljano zeleno čebulo, rezinami limete ali limone ter sezamovimi semeni.', 7, 68),
('K karaageju ponudite omako ponzu, majonezo ali omako tonkatsu za potapljanje.', 8, 68),

-- 69.Jjajangmyeon
('V ponvi ali woku segrejte olje na srednji temperaturi. Dodajte narezano svinjsko meso in kuhajte, dokler ni meso lepo zapečeno in zlato rjave barve. Odstranite meso iz ponve in ga postavite na stran.', 1, 69),
('V isti ponvi dodajte nasekljano čebulo in kuhajte, dokler ne postane mehka in steklasta.', 2, 69),
('Dodajte korejsko črno fižolovo pasto (jjajang) in jo kuhajte nekaj minut, da se okusi začnejo sproščati.', 3, 69),
('Nato dodajte sladkor, sojino omako, piščančjo ali govejo juho ter narezano zelenjavo. Kuhajte še nekaj minut, da se zelenjava zmehča.', 4, 69),
('V majhni skledi zmešajte koruzni škrob ali moko z malo vode, da dobite pasto. Dodajte to pasto v omako in mešajte, da se omaka zgosti. Po potrebi dodajte več koruznega škroba ali moke za želeno konsistenco.', 5, 69),
('V večjem loncu zavrite vodo. Dodajte rezance in kuhajte glede na navodila na embalaži, dokler niso kuhani. Nato jih odcedite.', 6, 69),
('Na krožnik postavite kuhane rezance, nato jih prelijte s pripravljeno črno fižolovo omako. Na vrh lahko dodate nekaj rezin kumare ali korenja za okras.', 7, 69),

-- 70.Masala Chicken
('Na maslu prepražimo nasekljano čebulo, dodamo sesekljan česen in ingver ter pražimo, dokler ne zadišijo.', 1, 70),
('Dodamo kose piščančjega mesa in jih prepražimo, dokler ne postanejo rahlo zlato rjavi.', 2, 70),
('Vmešamo garam masalo, kurkumo in druge začimbe ter pražimo še nekaj minut.', 3, 70),
('Dodamo paradižnikovo omako, smetano in jogurt ter kuhamo na zmernem ognju približno 15-20 minut.', 4, 70),
('Na koncu dodamo limonin sok in sesekljan koriander.', 5, 70),

-- 71.PALAK PANEER
('Na olju prepražimo nasekljano čebulo, dodamo sesekljan česen in ingver ter pražimo, dokler ne zadišijo.', 1, 71),
('Dodamo začimbe (garam masalo, kumino, koriander, kurkumo) in pražimo še nekaj minut.', 2, 71),
('Dodamo odmrznjeno špinačo in kuhamo, dokler ne zavre.', 3, 71),
('Vmešamo smetano ali jogurt ter dodamo kocke paneer sira.', 4, 71),
('Kuhajte še nekaj minut, dokler se sir ne segreje in omaka zgosti.', 5, 71),

-- 72.Aloo Gobi
('Na olju prepražimo nasekljano čebulo, dodamo sesekljan česen in ingver ter pražimo, dokler ne zadišijo.', 1, 72),
('Dodamo začimbe (garam masalo, kumino, koriander, kurkumo) in pražimo še nekaj minut.', 2, 72),
('Dodamo narezane krompirje in cvetačo ter pražimo, dokler se ne zmehčata.', 3, 72),
('Po potrebi dodamo malo vode in dušimo, dokler se zelenjava ne skuha.', 4, 72),

-- 73.Dal Tadka
('Leče skuhamo v vodi, dokler se ne zmehčajo.', 1, 73),
('Na olju prepražimo nasekljano čebulo, dodamo sesekljan česen in ingver ter pražimo, dokler ne zadišijo.', 2, 73),
('Dodamo začimbe (garam masalo, kumino, koriander, kurkumo) in pražimo še nekaj minut.', 3, 73),
('Dodamo narezane paradižnike in kuhamo, dokler se ne zmehčajo.', 4, 73),
('Dodamo kuhane leče in kuhamo še nekaj minut, da se okusi združijo.', 5, 73),

-- 74. Vegetable Biryani
('V večjem loncu zavrite vodo. Dodajte opran basmati riž in kuhajte, dokler ni riž kuhan, vendar še vedno trd. Odcedite in riž postavite na stran.', 1, 74),
('Na olju ali gheeju prepražite nasekljano čebulo na srednjem ognju, dokler ne postane mehka in prozorna.', 2, 74),
('Dodajte narezane korenčke, grah, cvetačo in krompir ter pražite, dokler zelenjava ne zmehča.', 3, 74),
('Dodajte narezane paradižnike in začimbe (garam masalo, mleti kumin, mleti koriander, kurkuma) ter sol po okusu. Dobro premešajte in kuhajte še nekaj minut.', 4, 74),
('V lonec z zelenjavo dodajte kuhan basmati riž in nežno premešajte, da se zelenjava in začimbe enakomerno porazdelijo med rižem.', 5, 74),
('Pokrijte lonec s pokrovom in kuhajte na nizkem ognju približno 10-15 minut, da se okusi prepojijo med rižem.', 6, 74),
('Ko je biryani pripravljen, ga previdno premešajte z vilicami, da se zelenjava in začimbe enakomerno porazdelijo.', 7, 74),
('Postrezite zelenjavni biryani na krožnikih, okrasite s svežimi lističi koriandra in ga postrezite s kakšno jogurtovo omako ali svežimi kumaricami.', 8, 74),

-- 75. Baked Mackerel
('Pečico segrejte na 200°C.', 1, 75),
('Fileje skuše dobro očistite in osušite s papirnato brisačo.', 2, 75),
('V majhni skledi zmešajte hariso pasto z olivnim oljem. Dodajte sol po okusu.', 3, 75),
('Na pekač položite aluminijasto folijo in nanjo položite fileje skuše.', 4, 75),
('Vsak file skuše obložite s plastjo harise paste.', 5, 75),
('Na vrh vsakega fileja položite rezine konzervirane limone.', 6, 75),
('Pekač postavite v segreto pečico in pecite približno 15-20 minut, ali dokler skuša ni pečena in se lepo zlato rjavo obarva.', 7, 75),
('Pečeno skušo postrezite na krožnikih, okrasite s svežimi listi mete ali peteršilja in postrezite z limoninimi krhlji ter po želji s prilogo, kot je kuhan krompir ali zelenjavna solata.', 8, 75),

-- 76.Shakshuka
('Na segretem olivnem olju prepražimo nasekljano čebulo, dokler ne postane mehka in prozorna.', 1, 76),
('Dodamo narezano papriko in pražimo še nekaj minut, da se zmehča.', 2, 76),
('Dodamo nasekljan česen, mleti kumin, mleto papriko, mleto kumino in kajensko papriko (če jo uporabljamo) ter pražimo še nekaj minut, da se začimbe razvijejo.', 3, 76),
('Dodamo pelate iz konzerve in jih z vilicami ali kuhalnico nežno zdrobimo. Začinimo s soljo in poprom po okusu ter kuhamo omako približno 10-15 minut, da se zgosti.', 4, 76),
('S hrbtno stranjo žlice naredimo vdolbine v omaki in v vsako vdolbino razbijemo eno jajce.', 5, 76),
('Pokrijemo posodo s pokrovko in kuhamo še približno 5-10 minut, odvisno od tega, kako trdno želimo, da so jajca pečena.', 6, 76),
('Ko so jajca pečena po okusu, posodo odstavimo s štedilnika.', 7, 76),
('Potresemo s svežim sesekljanim koriandrom ali peteršiljem in postrežemo toplo, običajno s kruhom ali pita kruhom.', 8, 76),

-- 77. Paella
('V globoki ponvi ali paella ponvi segrejte olivno olje. Dodajte nasekljano čebulo in pražite, dokler ne postane mehka in prozorna.', 1, 77),
('Dodajte narezano papriko in česen ter pražite še nekaj minut, da zadišijo.', 2, 77),
('Dodajte narezano piščančje meso in pražite, dokler ne postane rjavo zlato.', 3, 77),
('Ko je meso skoraj pečeno, dodajte narezane paradižnike, sladko papriko in mešane morske sadeže. Pražite še nekaj minut.', 4, 77),
('Dodajte paella riž in premešajte, da se riž enakomerno prepoji z oljem in okusi.', 5, 77),
('V ponvi ustvarite enakomerno plast sestavin. Nato počasi dodajajte piščančjo ali zelenjavno jušno osnovo. Preverite, ali je dovolj tekočine, da pokrije vse sestavine, in po potrebi dodajte še malo jušne osnove.', 6, 77),
('Dodajte ščepec žafrana za barvo in okus ter začinite s soljo in poprom po okusu.', 7, 77),
('Kuhajte paello na zmernem ognju približno 20-25 minut, dokler riž ni skuhan in vsa tekočina absorbirana. Med kuhanjem ne mešajte, da se ustvari hrustljava skorja (socarrat) na dnu ponve.', 8, 77),
('Ko je paella kuhana, jo odstavite s štedilnika. Po želji jo okrasite z rezinami limone in svežim sesekljanim peteršiljem.', 9, 77),
('Postrezite toplo in uživajte v okusni španski paelli!', 10, 77),

-- 78. BREZGLUTENSKI MUFFINI S ČOKOLADO IN ROŽIČEM
('Jabolko olupi in ga pridno naribaj.', 1, 78),
('Brezglutenski mešanici za muffine dodaj še 2 žlici rožičevega prahu.', 2, 78),
('Mešanico stresi v posodo, dodaj olje, ribano jabolko in jajca.', 3, 78),
('Stepaj približno 3 minute na srednji hitrosti, dokler zmes ne postane gosta in dobi svetlo barvo.', 4, 78),
('Maso vlij v pekač za muffine, ki ga potisneš v pečico, segreto na 170 °C.', 5, 78),
('Peci približno 30 minut oziroma, dokler zobotrebec, ki ga potisneš v sredino muffina, ne ostane čist, ko ga odstraniš. Po peki pusti muffine še 5 minut v pekaču, preden jih prestaviš.', 6, 78),
('Čokolado raztopi nad soparo ali pa v mikrovalovni pečici in jo pošpricaj po vrhu muffinov.', 7, 78),

-- 79. SOLATA CAPRESSE
('Na krožnik ali servirni pladenj položite izmenično rezine paradižnika in mocarele.', 1, 79),
('Med rezine paradižnika in mocarele položite sveže bazilikine liste.', 2, 79),
('Po solati Caprese pokapajte ekstra deviško oljčno olje in balzamični kis po okusu.', 3, 79),
('Začinite s soljo in sveže mletim črnim poprom po okusu.', 4, 79),

-- 80. BREZGLUTENSKI KOLAČKI Z BOROVNIČEVO KREMO
('Pripravi mokre sestavine (jajca, olje, jogurt) in suhe sestavine (moka, sladkor, pecilni prašek).', 1, 80),
('Združi mokre in suhe sestavine ter dobro premešaj.', 2, 80),
('Vlij maso za kolačke v pekač za muffine, obložen s papirčki.', 3, 80),
('Peci kolačke v pečici, segreti na 180 °C, približno 20-25 minut.', 4, 80),
('V kozici zmešaj borovnice s 2 žlicama mletega sladkorja ter jih kuhaj, dokler se ne zmehčajo. Nato jih spasiraj.', 5, 80),
('Primešaj preostali mleti sladkor, limonin sok in kremfix mascarponeju ter primešaj še borovničevo osnovo.', 6, 80),
('Kremo dobro premešaj in jo napolni v dozirno vrečko.', 7, 80),
('Na ohlajene kolačke nabrizgaj borovničevo kremo in jih okrasi z borovnicami ter listki sveže mete.', 8, 80),

-- 81. VEGANSKA PEČENKA
('Olupljene in narezane kose buče solimo in popramo ter jih pečemo v pečici, segreti na 190 °C, 20-30 minut, da se zmehčajo.', 1, 81),
('Oreščke na hitro prepražimo v ponvi, nato jih ohladimo in zmeljemo v sekljalniku.', 2, 81),
('V ponev zlijemo oljčno olje, dodamo 2 vejici rožmarina in segrevamo na srednje-visokem ognju.', 3, 81),
('Nasekljano čebulo prepražimo v vročem olju, nato dodamo pretlačen kostanj, mlete oreščke, pečeno bučo, rozine, drobtine in balzamični kis.', 4, 81),
('Solimo in popramo po okusu, nato vse skupaj dobro zmešamo v lepljivo zmes.', 5, 81),
('Maso stlačimo v model za kruh, obložen s papirjem za peko, in pečemo 50-60 minut v pečici, ogreti na 180 °C.', 6, 81),
('Počakamo, da se pečenka rahlo ohladi, nato jo lahko lepo razrežemo.', 7, 81),
('Jurčke prelijemo s toliko vrele vode, da jih povsem prekrijemo, in pustimo 15 minut, da se napojijo.', 8, 81),
('Nasekljano rdečo čebulo prepražimo na oljčnem olju, dodamo ožete in nasekljane jurčke, nato dodamo moko in jo prepražimo.', 9, 81),
('Primešamo timijan in rožmarin, zalijemo z jušno osnovo in kuhamo, da se zgosti. Nato spasiramo s paličnim mešalnikom in precedimo.', 10, 81),

-- 82.ČOKOLADNO-POMARANČNA TORTA MORGAN – VEGANSKA
('Pečico segrejte na 180 °C. Pripravite pekač za torto (premera približno 20 cm), obložen s peki papirjem.', 1, 82),
('V večji skledi zmešajte moko, rjavi sladkor, kakav v prahu, pecilni prašek in sol.', 2, 82),
('V drugi skledi zmešajte rastlinsko olje, rastlinsko mleko, jabolčni kis, naribano lupinico pomaranče in pomarančni sok.', 3, 82),
('Mokre sestavine dodajte k suhim in dobro premešajte, da dobite enotno zmes. Ne prekomerno mešajte.', 4, 82),
('Testo prelijte v pripravljen pekač in ga poravnajte. Pecite v ogreti pečici približno 25-30 minut ali dokler zobotrebec, vstavljen v sredino, ne izide čist.', 5, 82),
('Ko je torta pečena, jo pustite, da se popolnoma ohladi v pekaču.', 6, 82),
('Medtem pripravite čokoladno-pomarančni nadev. V manjšem loncu segrejte kokosovo mleko, da skoraj zavre. Dodajte nalomljeno temno čokolado in mešajte, dokler se čokolada popolnoma ne stopi.', 7, 82),
('Odstranite s toplote in vmešajte naribano lupinico pomaranče, pomarančni sok in javorjev sirup. Nadev ohladite na sobno temperaturo, nato pa ga postavite v hladilnik za približno 1 uro, da se malo zgosti.', 8, 82),
('Ko je nadev pripravljen, ga prelijte čez ohlajeno torto. Enakomerno razporedite po vrhu.', 9, 82),
('Okrasite s svežimi rezinami pomaranče, nastrgano lupinico pomaranče in, po želji, s stopljeno temno čokolado.', 10, 82);



INSERT INTO Komentarji (Vsebina, Datum, Ocena, TK_Recept, TK_Vpisan_Uporabnik) VALUES
('Odličen recept!', '2024-05-17 10:30:00', 5, 2, 1),
('Super jed, priporočam!', '2024-05-18 15:45:00', 4, 2, 2),
('Preprosto fantastično.', '2024-05-19 09:20:00', 5, 3, 3),
('Nisem bil najbolj navdušen.', '2024-05-20 14:10:00', 3, 4, 4),
('Eden najboljših receptov!', '2024-05-21 11:55:00', 5, 5, 5),
('Priprava je hitra in enostavna.', '2024-05-22 08:30:00', 4, 5, 6),
('Okusno, a malo premalo začinjeno zame.', '2024-05-23 17:20:00', 3, 5, 7),
('Popolnoma slastno!', '2024-05-24 12:15:00', 5, 5, 8),
('Enostaven in hiter recept.', '2024-05-25 09:45:00', 4, 7, 9),
('Zelo dober okus, a nekoliko zahtevnejša priprava.', '2024-05-26 16:10:00', 4, 7, 10),
('Priporočam vsem!', '2024-05-27 13:00:00', 5, 7, 11),
('Super ideja za večerjo.', '2024-05-28 09:20:00', 4, 9, 12),
('Odlična sladica za vroče poletne dni.', '2024-05-29 15:30:00', 5, 9, 13),
('Preprosto čudovito!', '2024-05-30 11:40:00', 5,14, 14),
('Priprava je hitra, a okus je bogat.', '2024-05-31 08:25:00', 4, 9, 15),
('Popolnoma navdušen.', '2024-06-01 14:50:00', 5, 10, 16),
('Dober recept, a manjka nekaj začimb.', '2024-06-02 12:05:00', 3, 11, 17),
('Enostavno in okusno.', '2024-06-03 10:15:00', 4, 12, 18),
('Zelo lepo!', '2024-06-04 16:35:00', 5, 13, 19),
('Odlično kosilo za družino.', '2024-06-05 13:20:00', 5, 14, 20),
('Super ideja za praznovanje!', '2024-06-06 09:55:00', 5, 15, 21),
('Enostavno in hkrati okusno.', '2024-06-07 18:00:00', 4, 16, 22),
('Nekoliko drugačen okus, a vreden poskusa.', '2024-06-08 15:10:00', 4, 23, 23),
('Odlična sladica, ki vedno uspe.', '2024-06-09 11:30:00', 5, 24, 24),
('Priprava je enostavna, a okus božanski!', '2024-06-10 08:40:00', 5, 25, 25),
('Super začetek dneva z odličnim zajtrkom.', '2024-06-11 14:15:00', 5, 26, 26),
('Okusno, a malo preveč mastno.', '2024-06-12 12:20:00', 4, 30, 27),
('Popolnoma zadovoljna.', '2024-06-13 10:00:00', 5, 31, 28),
('Odlična izbira za rojstni dan.', '2024-06-14 16:45:00', 5, 32, 29),
('Preprosto in hitro pripravljeno.', '2024-06-15 13:30:00', 4, 33, 30),
('Super sladica.', '2024-06-16 09:10:00', 5, 34, 31),
('Odlična ideja za zajtrk.', '2024-06-17 18:20:00', 5, 35, 32),
('Nisem navdušen nad okusom.', '2024-06-18 15:05:00', 3, 36, 33),
('Preprosto fantastično!', '2024-06-19 11:55:00', 5, 47, 34),
('Priprava je malo dolgotrajna, a vredno.', '2024-06-20 08:50:00', 4, 48, 35),
('Odlična sladica za vroče dni.', '2024-06-21 14:40:00', 5, 49, 36),
('Zelo dober okus, a malo premalo začinjeno.', '2024-06-22 12:30:00', 4, 50, 37),
('Popolnoma slastno!', '2024-06-23 10:25:00', 5, 51, 38),
('Enostaven in hiter recept.', '2024-06-24 16:15:00', 4, 52, 39),
('Zelo dober okus, a zahteva natančno pripravo.', '2024-06-25 13:50:00', 4, 53, 40),
('Priporočam vsem!', '2024-06-26 09:35:00', 5, 54, 41),
('Odlična večerja za vso družino!', '2024-06-27 12:45:00', 5, 55, 42),
('Priprava je bila enostavna, okus pa vrhunski.', '2024-06-28 17:30:00', 4, 56, 43),
('Zelo okusno, priporočam.', '2024-06-29 15:20:00', 5, 57, 44),
('Dobra jed, a bi dodal več začimb.', '2024-06-30 13:40:00', 3, 58, 45),
('Fantastičen recept!', '2024-07-01 09:50:00', 5, 59, 46),
('Preprosto čudovito!', '2024-07-02 11:35:00', 5, 60, 47),
('Hitra priprava in odličen okus.', '2024-07-03 08:20:00', 4, 61, 48),
('Zelo nasitno kosilo.', '2024-07-04 14:10:00', 5, 62, 49),
('Preveč sladko zame.', '2024-07-05 16:25:00', 3, 63, 50),
('Priporočam!.', '2024-07-06 09:15:00', 5, 64, 51),
('Dobra ideja za zajtrk.', '2024-07-07 10:05:00', 4, 65, 52),
('Zelo zadovoljna z rezultatom.', '2024-07-08 13:50:00', 5, 65, 53),
('Preprosto in okusno.', '2024-07-09 09:25:00', 4, 65, 54),
('Priprava je bila nekoliko zahtevna, a se je splačalo.', '2024-07-10 15:15:00', 4, 65, 55),
('Odlično!', '2024-07-11 11:40:00', 5, 66, 56),
('Super ideja za hitro kosilo.', '2024-07-12 18:05:00', 4, 67, 57),
('Priporočam za posebne priložnosti.', '2024-07-13 14:50:00', 5, 68, 58),
('Okusno, a nekoliko preveč slano.', '2024-07-14 12:20:00', 3, 69, 59),
('Zelo dober recept!', '2024-07-15 10:30:00', 5, 70, 60),
('Preprosto fantastično!', '2024-07-16 11:55:00', 5, 70, 61),
('Hitra in enostavna priprava.', '2024-07-17 13:25:00', 4, 70, 62),
('Okusno, a malo preveč začinjeno.', '2024-07-18 14:40:00', 3, 70, 63),
('Priporočam vsem ljubiteljem sladic.', '2024-07-19 16:10:00', 5, 71, 64),
('Odlična ideja za večerjo.', '2024-07-20 09:55:00', 4, 71, 65),
('Zelo zadovoljna z okusom.', '2024-07-21 11:35:00', 5, 71, 66),
('Preprosto in hitro pripravljeno.', '2024-07-22 08:20:00', 4, 71, 67),
('Nisem bil najbolj navdušen nad rezultatom.', '2024-07-23 15:25:00', 3, 71, 68),
('Super za družinska kosila.', '2024-07-24 13:10:00', 5, 72, 69),
('Priporočam za hitro kosilo.', '2024-07-25 12:45:00', 4, 72, 70),
('Odlična sladica za poletne dni.', '2024-07-26 14:30:00', 5, 13, 71),
('Preprosto in okusno.', '2024-07-27 17:10:00', 4, 33, 72),
('Priprava je bila malo zahtevna, a okus je bil super.', '2024-07-28 09:15:00', 4, 33, 73),
('Zelo zadovoljen z rezultatom.', '2024-07-29 11:45:00', 5, 22, 74),
('Priporočam za vse priložnosti.', '2024-07-30 16:25:00', 5, 24, 75),
('Dobra ideja za zajtrk.', '2024-07-31 09:05:00', 4, 34, 76),
('Super okus, a malo preveč mastno.', '2024-08-01 14:20:00', 3, 44, 77),
('Odlična večerja za vso družino.', '2024-08-02 12:35:00', 5, 45, 78),
('Priprava je bila enostavna, okus pa fantastičen.', '2024-08-03 10:10:00', 4, 45, 79),
('Super torta', '2024-08-04 15:45:00', 5, 32, 80),
('Malo kalorij! Odlično za športnike.', '2024-08-05 13:20:00', 5, 35, 81),
('Dobra sladica za poletne dni.', '2024-08-06 17:30:00', 5, 36, 82),
('Priporočam vsem, ki imajo radi sladko.', '2024-08-07 11:55:00', 4, 36, 83),
('Zelo zadovoljna z rezultatom.', '2024-08-08 13:40:00', 5, 56, 84),
('Priprava je bila nekoliko dolgotrajna, a se je izplačalo.', '2024-08-09 09:25:00', 4, 16, 85),
('Super ideja za hitro kosilo.', '2024-08-10 15:50:00', 4, 27, 86),
('Odličen recept za posebno priložnost.', '2024-08-11 14:35:00', 5, 27, 87),
('Okusno, a malo preveč sladko zame.', '2024-08-12 10:15:00', 3, 27, 88),
('Zelo dobro, priporočam.', '2024-08-13 11:45:00', 5, 71, 89),
('Hitra priprava in odličen okus.', '2024-08-14 09:30:00', 4, 54, 90),
('Preprosto fantastično!', '2024-08-15 14:10:00', 5, 45, 91),
('Dobra ideja za kosilo.', '2024-08-16 12:50:00', 4, 28, 92),
('Priporočam za vse priložnosti.', '2024-08-17 10:05:00', 5, 58, 93),
('Zelo zadovoljen z okusom.', '2024-08-18 15:30:00', 5, 69, 94),
('Odličen prigrizek za vroče dni.', '2024-08-19 13:20:00', 5, 69, 95),
('Preprosto in hitro pripravljeno.', '2024-08-20 09:45:00', 4, 59, 96),
('Nisem bil najbolj navdušen nad okusom.', '2024-08-21 11:35:00', 3, 39, 97),
('Super za družinska kosila.', '2024-08-22 14:10:00', 5, 10, 98),
('Priporočam za hitro večerjo.', '2024-08-23 10:50:00', 4, 20, 99),
('Odlična sladica za vse letne čase.', '2024-08-24 13:20:00', 5, 30, 100),
('Priprava je bila nekoliko zahtevna, a se je splačalo.', '2024-08-25 11:05:00', 4, 30, 101),
('Hitra in enostavna priprava.', '2024-08-26 09:25:00', 4, 31, 102),
('Preprosto čudovito!', '2024-08-27 14:40:00', 5, 31, 103),
('Dobra ideja za kosilo.', '2024-08-28 12:15:00', 4, 41, 104),
('Priporočam za vse priložnosti.', '2024-08-29 10:30:00', 5, 41, 105),
('Zelo zadovoljen z okusom.', '2024-08-30 15:45:00', 5, 42, 106),
('Odlična sladica za vroče dni.', '2024-08-31 13:20:00', 5, 42, 107),
('Preprosto in hitro pripravljeno.', '2024-09-01 09:45:00', 4, 52, 108),
('Nisem bil najbolj navdušen nad okusom.', '2024-09-02 11:35:00', 3, 52, 109),
('Super za družinska kosila.', '2024-09-03 14:10:00', 5, 51, 110),
('Priporočam za hitro večerjo.', '2024-09-04 10:50:00', 4, 62, 111),
('Odlična sladica za vse letne čase.', '2024-09-05 13:20:00', 5, 62, 112),
('Priprava je bila nekoliko zahtevna, a se je splačalo.', '2024-09-06 11:05:00', 4, 63, 113);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Mleka', 250, 'ml'), -- ID_Sestavine = 1
('Masla', 50, 'g'), -- ID_Sestavine = 2
('Soli', 1, 'žlička'), -- ID_Sestavine = 3
('Sladkorja', 2, 'žlici'), -- ID_Sestavine = 4
('Kvasa', 1, 'vrečka'), -- ID_Sestavine = 5
('Moke', 500, 'g'), -- ID_Sestavine = 6
('Česna', 4, 'stroki'), -- ID_Sestavine = 7
('Zeliščnega masla', 100, 'g'); -- ID_Sestavine = 8

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(1, 1), 
(1, 2), 
(1, 3), 
(1, 4), 
(1, 5), 
(1, 6), 
(1, 7), 
(1, 8);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Ovsenih kosmičev', 100, 'g'), -- ID_Sestavine = 9
('Mleka', 200, 'ml'), -- ID_Sestavine = 10
('Pomaranča', 1, ''), -- ID_Sestavine = 11
('Jabolko', 1, ''), -- ID_Sestavine = 12
('Medu', 2, 'žlici'), -- ID_Sestavine = 13
('Cimeta', 1, 'žlička'); -- ID_Sestavine = 14

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(2, 9), 
(2, 10), 
(2, 11), 
(2, 12), 
(2, 13), 
(2, 14);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Jajc', 2, 'kosa'), -- ID_Sestavine = 15
('Kisa', 1, 'žlička'), -- ID_Sestavine = 16
('Vode', 500, 'ml'), -- ID_Sestavine = 17
('Opečenega kruha', 2, 'kosa'), -- ID_Sestavine = 18
('Zrnatega sira', 100, 'g'), -- ID_Sestavine = 19
('Dimljenega lososa', 50, 'g'); -- ID_Sestavine = 20

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(3, 15), 
(3, 16), 
(3, 17), 
(3, 18), 
(3, 19), 
(3, 20);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Ovsenih kosmičev', 100, 'g'), -- ID_Sestavine = 21
('Mleka', 200, 'ml'), -- ID_Sestavine = 22
('Cimeta', 1, 'žlička'), -- ID_Sestavine = 23
('Jabolko', 1, ''), -- ID_Sestavine = 24
('Medu', 2, 'žlici'); -- ID_Sestavine = 25

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(4, 21), 
(4, 22), 
(4, 23), 
(4, 24), 
(4, 25);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Sladkega krompirja', 500, 'g'), -- ID_Sestavine = 26
('Čebule', 1, 'kos'), -- ID_Sestavine = 27
('Česna', 2, 'stroka'), -- ID_Sestavine = 28
('Zelenjavne jušne osnove', 1, 'l'), -- ID_Sestavine = 29
('Soli', 1, 'žlička'), -- ID_Sestavine = 30
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 31
('Olivnega olja', 2, 'žlici'); -- ID_Sestavine = 32

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(5, 26), 
(5, 27), 
(5, 28), 
(5, 29), 
(5, 30), 
(5, 31), 
(5, 32);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Krompirja', 500, 'g'), -- ID_Sestavine = 33
('Jajc', 4, 'kosi'), -- ID_Sestavine = 34
('Šampinjonov', 100, 'g'), -- ID_Sestavine = 35
('Suhih jurčkov', 50, 'g'), -- ID_Sestavine = 36
('Čebule', 1, 'kos'), -- ID_Sestavine = 37
('Česna', 2, 'stroka'), -- ID_Sestavine = 38
('Soli', 1, 'žlička'), -- ID_Sestavine = 39
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 40
('Olivnega olja', 3, 'žlice'); -- ID_Sestavine = 41

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(6, 33), 
(6, 34), 
(6, 35), 
(6, 36), 
(6, 37), 
(6, 38), 
(6, 39), 
(6, 40), 
(6, 41);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Ajdove kaše', 200, 'g'), -- ID_Sestavine = 42
('Gob', 150, 'g'), -- ID_Sestavine = 43
('Olivnega olja', 2, 'žlici'), -- ID_Sestavine = 44
('Česna', 2, 'stroka'), -- ID_Sestavine = 45
('Soli', 1, 'žlička'), -- ID_Sestavine = 46
('Popra', 0.5, 'žličke'); -- ID_Sestavine = 47

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(7, 42), 
(7, 43), 
(7, 44), 
(7, 45), 
(7, 46), 
(7, 47);



INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Avokada', 1, 'kos'), -- ID_Sestavine = 48
('Opečenega kruha', 2, 'kosa'), -- ID_Sestavine = 49
('Dimljenega lososa', 50, 'g'), -- ID_Sestavine = 50
('Soli', 0.5, 'žličke'), -- ID_Sestavine = 51
('Popra', 0.25, 'žličke'), -- ID_Sestavine = 52
('Limone', 0.5, 'kosa'); -- ID_Sestavine = 53

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(8, 48), 
(8, 49), 
(8, 50), 
(8, 51), 
(8, 52), 
(8, 53);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Ajdove kaše', 200, 'g'), -- ID_Sestavine = 54
('Hokaido buče', 300, 'g'), -- ID_Sestavine = 55
('Lešnikov', 50, 'g'), -- ID_Sestavine = 56
('Soli', 1, 'žlička'), -- ID_Sestavine = 57
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 58
('Olivnega olja', 2, 'žlici'), -- ID_Sestavine = 59
('Peteršilja', 1, 'žlica'); -- ID_Sestavine = 60

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(9, 54), 
(9, 55), 
(9, 56), 
(9, 57), 
(9, 58), 
(9, 59), 
(9, 60);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Piščančjih prsi', 500, 'g'), -- ID_Sestavine = 61
('Jogurta', 200, 'g'), -- ID_Sestavine = 62
('Česna', 3, 'stroki'), -- ID_Sestavine = 63
('Ingverja', 1, 'žlica'), -- ID_Sestavine = 64
('Začimbne mešanice', 1, 'žlica'), -- ID_Sestavine = 65
('Limone', 1, 'kos'), -- ID_Sestavine = 66
('Paradižnikove omake', 200, 'ml'), -- ID_Sestavine = 67
('Smetane', 100, 'ml'), -- ID_Sestavine = 68
('Olja', 2, 'žlici'), -- ID_Sestavine = 69
('Soli', 1, 'žlička'), -- ID_Sestavine = 70
('Popra', 0.5, 'žličke'); -- ID_Sestavine = 71

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(10, 61), 
(10, 62), 
(10, 63), 
(10, 64), 
(10, 65), 
(10, 66), 
(10, 67), 
(10, 68), 
(10, 69), 
(10, 70), 
(10, 71);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Čičerike', 400, 'g'), -- ID_Sestavine = 72
('Paradižnikove omake', 200, 'ml'), -- ID_Sestavine = 73
('Čebule', 1, 'kos'), -- ID_Sestavine = 74
('Česna', 2, 'stroka'), -- ID_Sestavine = 75
('Korenja', 1, 'kos'), -- ID_Sestavine = 76
('Soli', 1, 'žlička'), -- ID_Sestavine = 77
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 78
('Olje', 2, 'žlici'), -- ID_Sestavine = 79
('Peteršilja', 1, 'žlica'); -- ID_Sestavine = 80

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(11, 72), 
(11, 73), 
(11, 74), 
(11, 75), 
(11, 76), 
(11, 77), 
(11, 78), 
(11, 79), 
(11, 80);



INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Piščančjega fileja', 4, 'kosi'), -- ID_Sestavine = 81
('Timijana', 2, 'žlički'), -- ID_Sestavine = 82
('Limone', 1, 'kos'), -- ID_Sestavine = 83
('Česna', 2, 'stroka'), -- ID_Sestavine = 84
('Olja', 2, 'žlici'), -- ID_Sestavine = 85
('Soli', 1, 'žlička'), -- ID_Sestavine = 86
('Popra', 0.5, 'žličke'); -- ID_Sestavine = 87

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(12, 81), 
(12, 82), 
(12, 83), 
(12, 84), 
(12, 85), 
(12, 86), 
(12, 87);

# Recept 13: Špageti carbonara
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Špagetov', 400, 'g'), -- ID_Sestavine = 88
('Slanine', 100, 'g'), -- ID_Sestavine = 89
('Jajca', 3, ''), -- ID_Sestavine = 90
('Parmezan', 50, 'g'), -- ID_Sestavine = 91
('Soli', 1, 'žlička'), -- ID_Sestavine = 92
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 93
('Česna', 1, 'strok'); -- ID_Sestavine = 94

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(13, 88), 
(13, 89), 
(13, 90), 
(13, 91), 
(13, 92), 
(13, 93), 
(13, 94);

#Recept 14: Mesne kroglice

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Mletega mesa', 500, 'g'), -- ID_Sestavine = 95
('Čebule', 1, 'kos'), -- ID_Sestavine = 96
('Česna', 2, 'stroka'), -- ID_Sestavine = 97
('Jajce', 1, ''), -- ID_Sestavine = 98
('Drobtin', 100, 'g'), -- ID_Sestavine = 99
('Parmezana', 50, 'g'), -- ID_Sestavine = 100
('Soli', 1, 'žlička'), -- ID_Sestavine = 101
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 102
('Olja', 2, 'žlici'), -- ID_Sestavine = 103
('Paradižnikove omake', 200, 'ml'); -- ID_Sestavine = 104

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(14, 95), 
(14, 96), 
(14, 97), 
(14, 98), 
(14, 99), 
(14, 100), 
(14, 101), 
(14, 102), 
(14, 103), 
(14, 104);

#Recept 15: Polnjena štruca

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Moke', 500, 'g'), -- ID_Sestavine = 105
('Kvasa', 1, 'vrečka'), -- ID_Sestavine = 106
('Soli', 1, 'žlička'), -- ID_Sestavine = 107
('Vode', 300, 'ml'), -- ID_Sestavine = 108
('Šunke', 100, 'g'), -- ID_Sestavine = 109
('Sira', 100, 'g'), -- ID_Sestavine = 110
('Masla', 50, 'g'); -- ID_Sestavine = 111

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(15, 105), 
(15, 106), 
(15, 107), 
(15, 108), 
(15, 109), 
(15, 110), 
(15, 111);


#Recept 16: Domača pica
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Moke', 500, 'g'), -- ID_Sestavine = 112
('Kvasa', 1, 'vrečka'), -- ID_Sestavine = 113
('Sladkorja', 1, 'žlica'), -- ID_Sestavine = 114
('Soli', 1, 'žlička'), -- ID_Sestavine = 115
('Vode', 300, 'ml'), -- ID_Sestavine = 116
('Olivnega olja', 2, 'žlici'), -- ID_Sestavine = 117
('Paradižnikove omake', 200, 'ml'), -- ID_Sestavine = 118
('Mocarele', 200, 'g'), -- ID_Sestavine = 119
('Bazilike', 10, 'listov'); -- ID_Sestavine = 120

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(16, 112), 
(16, 113), 
(16, 114), 
(16, 115), 
(16, 116), 
(16, 117), 
(16, 118), 
(16, 119), 
(16, 120);


#Recept 17: Dvobarvni krompirjevi krhlji s parmezanom
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Navadnega krompirja', 500, 'g'), -- ID_Sestavine = 121
('Sladkega krompirja', 500, 'g'), -- ID_Sestavine = 122
('Olivnega olja', 3, 'žlice'), -- ID_Sestavine = 123
('Parmezana', 50, 'g'), -- ID_Sestavine = 124
('Soli', 1, 'žlička'), -- ID_Sestavine = 125
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 126
('Rožmarina', 1, 'žlica'); -- ID_Sestavine = 127

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(17, 121), 
(17, 122), 
(17, 123), 
(17, 124), 
(17, 125), 
(17, 126), 
(17, 127);

#Recept 18: Slastna BBQ rebrca iz pečice
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Svinjskih rebrc', 1, 'kg'), -- ID_Sestavine = 128
('BBQ omake', 200, 'ml'), -- ID_Sestavine = 129
('Soli', 2, 'žlički'), -- ID_Sestavine = 130
('Popra', 1, 'žlička'), -- ID_Sestavine = 131
('Česna v prahu', 1, 'žlička'), -- ID_Sestavine = 132
('Čebule v prahu', 1, 'žlička'), -- ID_Sestavine = 133
('Rjavega sladkorja', 2, 'žlici'); -- ID_Sestavine = 134

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(18, 128), 
(18, 129), 
(18, 130), 
(18, 131), 
(18, 132), 
(18, 133), 
(18, 134);


#Recept 19: Pečen ribji file v kremni limonini omaki
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Ribjega fileja', 500, 'g'), -- ID_Sestavine = 135
('Limone', 1, 'kos'), -- ID_Sestavine = 136
('Smetane za kuhanje', 200, 'ml'), -- ID_Sestavine = 137
('Česna', 2, 'stroka'), -- ID_Sestavine = 138
('Olivnega olja', 2, 'žlici'), -- ID_Sestavine = 139
('Soli', 1, 'žlička'), -- ID_Sestavine = 140
('Popra', 0.5, 'žličke'); -- ID_Sestavine = 141

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(19, 135), 
(19, 136), 
(19, 137), 
(19, 138), 
(19, 139), 
(19, 140), 
(19, 141);

#Recept 20: Sočni in hrustljavi piščančji fingersi
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Piščančjih prsi', 400, 'g'), -- ID_Sestavine = 142
('Jajci', 2, ''), -- ID_Sestavine = 143
('Moke', 100, 'g'), -- ID_Sestavine = 144
('Drobtin', 200, 'g'), -- ID_Sestavine = 145
('Soli', 1, 'žlička'), -- ID_Sestavine = 146
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 147
('Olja za cvrtje', 500, 'ml'); -- ID_Sestavine = 148

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(20, 142), 
(20, 143), 
(20, 144), 
(20, 145), 
(20, 146), 
(20, 147), 
(20, 148);

#Recept 21: Najboljši hrustljav krompir iz pečice
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Krompirja', 1, 'kg'), -- ID_Sestavine = 149
('Olivnega olja', 3, 'žlice'), -- ID_Sestavine = 150
('Soli', 1, 'žlička'), -- ID_Sestavine = 151
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 152
('Česna v prahu', 1, 'žlička'), -- ID_Sestavine = 153
('Rožmarina', 2, 'žlički'); -- ID_Sestavine = 154

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(21, 149), 
(21, 150), 
(21, 151), 
(21, 152), 
(21, 153), 
(21, 154);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Fižola', 400, 'g'), -- ID_Sestavine = 155
('Klobase', 200, 'g'), -- ID_Sestavine = 156
('Čebule', 1, 'kos'), -- ID_Sestavine = 157
('Česna', 2, 'stroka'), -- ID_Sestavine = 158
('Paradižnikove omake', 200, 'ml'), -- ID_Sestavine = 159
('Soli', 1, 'žlička'), -- ID_Sestavine = 160
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 161
('Lovorjevega lista', 1, 'kos'), -- ID_Sestavine = 162
('Oljčnega olja', 2, 'žlici'); -- ID_Sestavine = 163

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(22, 155), 
(22, 156), 
(22, 157), 
(22, 158), 
(22, 159), 
(22, 160), 
(22, 161), 
(22, 162), 
(22, 163);


#Recept 23: Slastna hobotnica kot pod peko


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Hobotnice', 1.2, 'kg'), -- ID_Sestavine = 164
('Krompirja', 1, 'kg'), -- ID_Sestavine = 165
('Čebule', 2, 'kosa'), -- ID_Sestavine = 166
('Česna', 3, 'stroki'), -- ID_Sestavine = 167
('Olivnega olje', 100, 'ml'), -- ID_Sestavine = 168
('Belega vino', 100, 'ml'), -- ID_Sestavine = 169
('Soli', 2, 'žlički'), -- ID_Sestavine = 170
('Popra', 1, 'žlička'); -- ID_Sestavine = 171

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(23, 164), 
(23, 165), 
(23, 166), 
(23, 167), 
(23, 168), 
(23, 169), 
(23, 170), 
(23, 171);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Govejiih medaljonov', 600, 'g'), -- ID_Sestavine = 172
('Popra', 1, 'žlička'), -- ID_Sestavine = 173
('Soli', 1, 'žlička'), -- ID_Sestavine = 174
('Masla', 50, 'g'), -- ID_Sestavine = 175
('Smetane za kuhanje', 200, 'ml'), -- ID_Sestavine = 176
('Brstičnega ohrovta', 300, 'g'), -- ID_Sestavine = 177
('Olivnega olja', 2, 'žlici'); -- ID_Sestavine = 178

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(24, 172), 
(24, 173), 
(24, 174), 
(24, 175), 
(24, 176), 
(24, 177), 
(24, 178);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Listnatega testa', 1, 'paket'), -- ID_Sestavine = 179
('Lososovega fileja', 500, 'g'), -- ID_Sestavine = 180
('Špinače', 200, 'g'), -- ID_Sestavine = 181
('Smetane za kuhanje', 100, 'ml'), -- ID_Sestavine = 182
('Česna', 2, 'stroka'), -- ID_Sestavine = 183
('Soli', 1, 'žlička'), -- ID_Sestavine = 184
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 185
('Jajce', 1, ''); -- ID_Sestavine = 186

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(25, 179), 
(25, 180), 
(25, 181), 
(25, 182), 
(25, 183), 
(25, 184), 
(25, 185), 
(25, 186);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Kostanja', 300, 'g'), -- ID_Sestavine = 187
('Krompirja', 500, 'g'), -- ID_Sestavine = 188
('Moke', 200, 'g'), -- ID_Sestavine = 189
('Jajce', 1, ''), -- ID_Sestavine = 190
('Soli', 1, 'žlička'), -- ID_Sestavine = 191
('Masla', 50, 'g'); -- ID_Sestavine = 192

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(26, 187), 
(26, 188), 
(26, 189), 
(26, 190), 
(26, 191), 
(26, 192);

#Recept 27: Gratinirane penne
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Penn', 400, 'g'), -- ID_Sestavine = 193
('Piščančjega fileja', 300, 'g'), -- ID_Sestavine = 194
('Brokolija', 200, 'g'), -- ID_Sestavine = 195
('Smetane za kuhanje', 200, 'ml'), -- ID_Sestavine = 196
('Česna', 2, 'stroka'), -- ID_Sestavine = 197
('Parmezana', 50, 'g'), -- ID_Sestavine = 198
('Soli', 1, 'žlička'), -- ID_Sestavine = 199
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 200
('Olivnega olja', 2, 'žlici'); -- ID_Sestavine = 201

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(27, 193), 
(27, 194), 
(27, 195), 
(27, 196), 
(27, 197), 
(27, 198), 
(27, 199), 
(27, 200), 
(27, 201);



INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Jogurta', 500, 'g'), -- ID_Sestavine = 202
('Sladkorja', 200, 'g'), -- ID_Sestavine = 203
('Moke', 300, 'g'), -- ID_Sestavine = 204
('Jajc', 4, 'kosa'), -- ID_Sestavine = 205
('Pecilnega praška', 1, 'vrečka'), -- ID_Sestavine = 206
('Vaniljevega sladkorja', 1, 'vrečka'), -- ID_Sestavine = 207
('Jagod', 300, 'g'), -- ID_Sestavine = 208
('Malin', 200, 'g'); -- ID_Sestavine = 209

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(28, 202), 
(28, 203), 
(28, 204), 
(28, 205), 
(28, 206), 
(28, 207), 
(28, 208), 
(28, 209);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Moke', 300, 'g'), -- ID_Sestavine = 210
('Sladkorja', 150, 'g'), -- ID_Sestavine = 211
('Jajca', 3, ''), -- ID_Sestavine = 212
('Masla', 200, 'g'), -- ID_Sestavine = 213
('Jogurta', 100, 'g'), -- ID_Sestavine = 214
('Jagod', 200, 'g'), -- ID_Sestavine = 215
('Pecilnega praška', 1, 'vrečka'); -- ID_Sestavine = 216

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(29, 210), 
(29, 211), 
(29, 212), 
(29, 213), 
(29, 214), 
(29, 215), 
(29, 216);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Moke', 500, 'g'), -- ID_Sestavine = 217
('Kvasa', 1, 'vrečka'), -- ID_Sestavine = 218
('Mleka', 250, 'ml'), -- ID_Sestavine = 219
('Masla', 100, 'g'), -- ID_Sestavine = 220
('Jajci', 2, ''), -- ID_Sestavine = 221
('Sladkorja', 100, 'g'), -- ID_Sestavine = 222
('Soli', 1, 'žlička'), -- ID_Sestavine = 223
('Marelične marmelade', 200, 'g'), -- ID_Sestavine = 224
('Suhega sadja', 100, 'g'); -- ID_Sestavine = 225

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(30, 217), 
(30, 218), 
(30, 219), 
(30, 220), 
(30, 221), 
(30, 222), 
(30, 223), 
(30, 224), 
(30, 225);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Ovsenih kosmičev', 100, 'g'), -- ID_Sestavine = 226
('Mleka', 200, 'ml'), -- ID_Sestavine = 227
('Kave', 50, 'ml'), -- ID_Sestavine = 228
('Jogurta', 100, 'g'), -- ID_Sestavine = 229
('Kakava', 1, 'žlica'), -- ID_Sestavine = 230
('Sladkorja', 2, 'žlici'), -- ID_Sestavine = 231
('Vaniljevega ekstrakta', 1, 'žlička'), -- ID_Sestavine = 232
('Čokoladnega pudinga', 50, 'g'); -- ID_Sestavine = 233

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(31, 226), 
(31, 227), 
(31, 228), 
(31, 229), 
(31, 230), 
(31, 231), 
(31, 232), 
(31, 233);

# Recept 32: Raffaello cheesecake
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Maslenih keksov', 200, 'g'), -- ID_Sestavine = 234
('Masla', 100, 'g'), -- ID_Sestavine = 235
('Mascarpone sira', 250, 'g'), -- ID_Sestavine = 236
('Bele čokolade', 200, 'g'), -- ID_Sestavine = 237
('Sladke smetane', 200, 'ml'), -- ID_Sestavine = 238
('Kokosove moke', 50, 'g'), -- ID_Sestavine = 239
('Sladkorja v prahu', 100, 'g'), -- ID_Sestavine = 240
('Vaniljevega ekstrakta', 1, 'žlička'); -- ID_Sestavine = 241

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(32, 234), 
(32, 235), 
(32, 236), 
(32, 237), 
(32, 238), 
(32, 239), 
(32, 240), 
(32, 241);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Orehovih jedrc', 200, 'g'), -- ID_Sestavine = 242
('Datljev', 150, 'g'), -- ID_Sestavine = 243
('Kakava v prahu', 30, 'g'), -- ID_Sestavine = 244
('Kokosove moke', 50, 'g'), -- ID_Sestavine = 245
('Kokosovega mleka', 200, 'ml'), -- ID_Sestavine = 246
('Medu', 3, 'žlice'); -- ID_Sestavine = 247

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(33, 242), 
(33, 243), 
(33, 244), 
(33, 245), 
(33, 246), 
(33, 247);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Piškotov', 300, 'g'), -- ID_Sestavine = 248
('Banani', 2, ''), -- ID_Sestavine = 249
('Nutelle', 200, 'g'), -- ID_Sestavine = 250
('Ruma', 3, 'žlice'), -- ID_Sestavine = 251
('Masla', 100, 'g'), -- ID_Sestavine = 252
('Kokosove moke', 50, 'g'); -- ID_Sestavine = 253

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(34, 248), 
(34, 249), 
(34, 250), 
(34, 251), 
(34, 252), 
(34, 253);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Vaniljevega pudinga', 1, 'paket'), -- ID_Sestavine = 254
('Mleka', 500, 'ml'), -- ID_Sestavine = 255
('Sladkorja', 50, 'g'), -- ID_Sestavine = 256
('Jagodičevja', 200, 'g'), -- ID_Sestavine = 257
('Ovsenih kosmičev', 100, 'g'), -- ID_Sestavine = 258
('Jogurta', 200, 'g'); -- ID_Sestavine = 259

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(35, 254), 
(35, 255), 
(35, 256), 
(35, 257), 
(35, 258), 
(35, 259);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Temne čokolade', 100, 'g'), -- ID_Sestavine = 270
('Moke', 200, 'g'), -- ID_Sestavine = 261
('Sladkorja', 200, 'g'), -- ID_Sestavine = 262
('Masla', 200, 'g'), -- ID_Sestavine = 263
('Jajca', 4, ''), -- ID_Sestavine = 264
('Pecilnega praška', 1, 'vrečka'), -- ID_Sestavine = 265
('Kakava v prahu', 50, 'g'), -- ID_Sestavine = 266
('Nutelle', 200, 'g'), -- ID_Sestavine = 267
('Lino Lade', 200, 'g'), -- ID_Sestavine = 268
('Smetane za stepanje', 200, 'ml'), -- ID_Sestavine = 269
('Mlečne čokolade', 100, 'g'); -- ID_Sestavine = 270

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(36, 260), 
(36, 261), 
(36, 262), 
(36, 263), 
(36, 264), 
(36, 265), 
(36, 266), 
(36, 267), 
(36, 268), 
(36, 269), 
(36, 270);



INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Moke', 250, 'g'), -- ID_Sestavine = 271
('Sladkorja', 200, 'g'), -- ID_Sestavine = 272
('Masla', 200, 'g'), -- ID_Sestavine = 273
('Jajca', 4, ''), -- ID_Sestavine = 274
('Pecilnega praška', 1, 'vrečka'), -- ID_Sestavine = 275
('Vanilijeve arome', 1, 'žlička'), -- ID_Sestavine = 276
('Temne čokolade', 200, 'g'), -- ID_Sestavine = 277
('Višenj', 300, 'g'), -- ID_Sestavine = 278
('Sladkorja v prahu', 100, 'g'), -- ID_Sestavine = 279
('Smetane za stepanje', 200, 'ml'), -- ID_Sestavine = 280
('Želatine', 6, 'listov'); -- ID_Sestavine = 281

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(37, 271), 
(37, 272), 
(37, 273), 
(37, 274), 
(37, 275), 
(37, 276), 
(37, 277), 
(37, 278), 
(37, 279), 
(37, 280), 
(37, 281);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Moke', 200, 'g'), -- ID_Sestavine = 282
('Sladkorja', 200, 'g'), -- ID_Sestavine = 283
('Masla', 200, 'g'), -- ID_Sestavine = 284
('Jajca', 4, ''), -- ID_Sestavine = 285
('Pecilnega praška', 1, 'vrečka'), -- ID_Sestavine = 286
('Vanilijeve arome', 1, 'žlička'), -- ID_Sestavine = 287
('Jagod', 300, 'g'), -- ID_Sestavine = 288
('Sladkorja v prahu', 100, 'g'), -- ID_Sestavine = 289
('Smetane za stepanje', 200, 'ml'), -- ID_Sestavine = 290
('Želatine', 6, 'listov'); -- ID_Sestavine = 291

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(38, 282), 
(38, 283), 
(38, 284), 
(38, 285), 
(38, 286), 
(38, 287), 
(38, 288), 
(38, 289), 
(38, 290), 
(38, 291);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Polente', 200, 'g'), -- ID_Sestavine = 292
('Mleka', 500, 'ml'), -- ID_Sestavine = 293
('Vode', 500, 'ml'), -- ID_Sestavine = 294
('Soli', 1, 'žlička'), -- ID_Sestavine = 295
('Masla', 50, 'g'), -- ID_Sestavine = 296
('Dimljenega lososa', 200, 'g'), -- ID_Sestavine = 297
('Kaviarja', 50, 'g'), -- ID_Sestavine = 298
('Sveže zelišče', NULL, 'po okusu'); -- ID_Sestavine = 299

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(39, 292), 
(39, 293), 
(39, 294), 
(39, 295), 
(39, 296), 
(39, 297), 
(39, 298), 
(39, 299);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Kvašenega testa', 500, 'g'), -- ID_Sestavine = 300
('Skute', 200, 'g'), -- ID_Sestavine = 301
('Feta sira', 100, 'g'), -- ID_Sestavine = 302
('Jajce', 1, ''), -- ID_Sestavine = 303
('Soli', 1, 'žlička'), -- ID_Sestavine = 304
('Česna', 1, 'strok'), -- ID_Sestavine = 305
('Olivnega olja', 2, 'žlici'); -- ID_Sestavine = 306

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(40, 300), 
(40, 301), 
(40, 302), 
(40, 303), 
(40, 304), 
(40, 305), 
(40, 306);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Kvašenega testa', 500, 'g'), -- ID_Sestavine = 307
('Šunke', 200, 'g'), -- ID_Sestavine = 308
('Hrena', 100, 'g'), -- ID_Sestavine = 309
('Jajce', 1, ''), -- ID_Sestavine = 310
('Kisle smetane', 100, 'g'), -- ID_Sestavine = 311
('Soli', 1, 'žlička'), -- ID_Sestavine = 312
('Popra', 0.5, 'žličke'); -- ID_Sestavine = 313

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(41, 307), 
(41, 308), 
(41, 309), 
(41, 310), 
(41, 311), 
(41, 312), 
(41, 313);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Mladega krompirja', 500, 'g'), -- ID_Sestavine = 314
('Čebule', 1, 'kos'), -- ID_Sestavine = 315
('Soli', 1, 'žlička'), -- ID_Sestavine = 316
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 317
('Olja', 3, 'žlice'), -- ID_Sestavine = 318
('Masla', 50, 'g'); -- ID_Sestavine = 319

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(42, 314), 
(42, 315), 
(42, 316), 
(42, 317), 
(42, 318), 
(42, 319);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Brie sira', 200, 'g'), -- ID_Sestavine = 320
('Brusnične pomake', 100, 'g'), -- ID_Sestavine = 321
('Jajci', 2, ''), -- ID_Sestavine = 322
('Moke', 100, 'g'), -- ID_Sestavine = 323
('Drobtin', 100, 'g'), -- ID_Sestavine = 324
('Soli', 0.5, 'žličke'), -- ID_Sestavine = 325
('Olja za cvrtje', 500, 'ml'); -- ID_Sestavine = 326

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(43, 320), 
(43, 321), 
(43, 322), 
(43, 323), 
(43, 324), 
(43, 325), 
(43, 326);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Listnatega testa', 1, 'zavitek'), -- ID_Sestavine = 327
('Hrenovk', 8, 'kosov'), -- ID_Sestavine = 328
('Gorčice', 2, 'žlici'), -- ID_Sestavine = 329
('Sezamovih semen', 1, 'žlička'), -- ID_Sestavine = 330
('Jajce', 1, ''); -- ID_Sestavine = 331

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(44, 327), 
(44, 328), 
(44, 329), 
(44, 330), 
(44, 331);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Listnatega testa', 1, 'zavitek'), -- ID_Sestavine = 332
('Špinače', 200, 'g'), -- ID_Sestavine = 333
('Rikote', 150, 'g'), -- ID_Sestavine = 334
('Parmezana', 50, 'g'), -- ID_Sestavine = 335
('Jajce', 1, ''), -- ID_Sestavine = 336
('Soli', 0.5, 'žličke'), -- ID_Sestavine = 337
('Popra', 0.25, 'žličke'); -- ID_Sestavine = 338

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(45, 332), 
(45, 333), 
(45, 334), 
(45, 335), 
(45, 336), 
(45, 337), 
(45, 338);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Čemaža', 100, 'g'), -- ID_Sestavine = 339
('Masla', 200, 'g'), -- ID_Sestavine = 340
('Dimljene postrvi', 150, 'g'), -- ID_Sestavine = 341
('Soli', 0.5, 'žličke'), -- ID_Sestavine = 342
('Popra', 0.25, 'žličke'), -- ID_Sestavine = 343
('Limona', 1, ''); -- ID_Sestavine = 344

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(46, 339), 
(46, 340), 
(46, 341), 
(46, 342), 
(46, 343), 
(46, 344);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Belega kruha', 4, 'rezine'), -- ID_Sestavine = 345
('Paradižnikove omake', 100, 'ml'), -- ID_Sestavine = 346
('Mozzarelle', 100, 'g'), -- ID_Sestavine = 347
('Oljčnega olja', 2, 'žlici'), -- ID_Sestavine = 348
('Origana', 1, 'žlička'), -- ID_Sestavine = 349
('Bazilike', NULL, 'po okusu'); -- ID_Sestavine = 350

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(47, 345), 
(47, 346), 
(47, 347), 
(47, 348), 
(47, 349), 
(47, 350);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Mletih mandljev', 200, 'g'), -- ID_Sestavine = 351
('Sladkorja v prahu', 100, 'g'), -- ID_Sestavine = 352
('Jajčnih beljakov', 3, 'kosa'), -- ID_Sestavine = 353
('Vanilijeve arome', 1, 'žlička'), -- ID_Sestavine = 354
('Soli', 1, 'ščepec'), -- ID_Sestavine = 355
('Sladkorja', NULL, 'za posip'); -- ID_Sestavine = 356

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(48, 351), 
(48, 352), 
(48, 353), 
(48, 354), 
(48, 355), 
(48, 356);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Piškotov Savoiardi', 200, 'g'), -- ID_Sestavine = 357
('Mascarpone sira', 250, 'g'), -- ID_Sestavine = 358
('Sladke smetane', 200, 'ml'), -- ID_Sestavine = 359
('Sladkorja v prahu', 100, 'g'), -- ID_Sestavine = 360
('Bailey’s likerja', 100, 'ml'), -- ID_Sestavine = 361
('Malin', 200, 'g'), -- ID_Sestavine = 362
('Kakava v prahu', NULL, 'za posip'); -- ID_Sestavine = 363

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(49, 357), 
(49, 358), 
(49, 359), 
(49, 360), 
(49, 361), 
(49, 362), 
(49, 363);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Piščančjega fileja', 400, 'g'), -- ID_Sestavine = 364
('Paradižnikove omake', 200, 'ml'), -- ID_Sestavine = 365
('Črnih oliv', 50, 'g'), -- ID_Sestavine = 366
('Kaper', 30, 'g'), -- ID_Sestavine = 367
('Česna', 2, 'stroka'), -- ID_Sestavine = 368
('Rdečega čilija', 1, 'kos'), -- ID_Sestavine = 369
('Oljčnega olja', 2, 'žlici'), -- ID_Sestavine = 370
('Soli', 1, 'žlička'), -- ID_Sestavine = 371
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 372
('Rezancev', 300, 'g'); -- ID_Sestavine = 373

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(50, 364), 
(50, 365), 
(50, 366), 
(50, 367), 
(50, 368), 
(50, 369), 
(50, 370), 
(50, 371), 
(50, 372), 
(50, 373);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Moke', 500, 'g'), -- ID_Sestavine = 374
('Kvasa', 1, 'vrečka'), -- ID_Sestavine = 375
('Sladkorja', 1, 'žlica'), -- ID_Sestavine = 376
('Soli', 1, 'žlička'), -- ID_Sestavine = 377
('Vode', 300, 'ml'), -- ID_Sestavine = 378
('Oljčnega olja', 50, 'ml'), -- ID_Sestavine = 379
('Sušenih paradižnikov', 100, 'g'), -- ID_Sestavine = 380
('Rožmarina', 2, 'žlički'); -- ID_Sestavine = 381

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(51, 374), 
(51, 375), 
(51, 376), 
(51, 377), 
(51, 378), 
(51, 379), 
(51, 380), 
(51, 381);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Mletega mesa', 500, 'g'), -- ID_Sestavine = 382
('Čebula', 1, ''), -- ID_Sestavine = 383
('Korenja', 1, 'kos'), -- ID_Sestavine = 384
('Zelene', 1, 'steblo'), -- ID_Sestavine = 385
('Paradižnikove omake', 400, 'ml'), -- ID_Sestavine = 386
('Rdečega vina', 100, 'ml'), -- ID_Sestavine = 387
('Oljčnega olja', 3, 'žlice'), -- ID_Sestavine = 388
('Soli', 1, 'žlička'), -- ID_Sestavine = 389
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 390
('Česna', 2, 'stroka'); -- ID_Sestavine = 391

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(52, 382), 
(52, 383), 
(52, 384), 
(52, 385), 
(52, 386), 
(52, 387), 
(52, 388), 
(52, 389), 
(52, 390), 
(52, 391);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Moke', 250, 'g'), -- ID_Sestavine = 392
('Sladkorja', 200, 'g'), -- ID_Sestavine = 393
('Masla', 200, 'g'), -- ID_Sestavine = 394
('Jajca', 4, ''), -- ID_Sestavine = 395
('Pecilnega praška', 1, 'vrečka'), -- ID_Sestavine = 396
('Kakava v prahu', 50, 'g'), -- ID_Sestavine = 397
('Kave', 200, 'ml'), -- ID_Sestavine = 398
('Temne čokolade', 100, 'g'), -- ID_Sestavine = 399
('Smetane za stepanje', 200, 'ml'), -- ID_Sestavine = 400
('Vanilijeve arome', 1, 'žlička'); -- ID_Sestavine = 401

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(53, 392), 
(53, 393), 
(53, 394), 
(53, 395), 
(53, 396), 
(53, 397), 
(53, 398), 
(53, 399), 
(53, 400), 
(53, 401);



INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Tortilje', 4, ''), -- ID_Sestavine = 402
('Piščančjega fileja', 300, 'g'), -- ID_Sestavine = 403
('Sira', 200, 'g'), -- ID_Sestavine = 404
('Čebula', 1, ''), -- ID_Sestavine = 405
('Paprika', 1, ''), -- ID_Sestavine = 406
('Česna', 2, 'stroka'), -- ID_Sestavine = 407
('Paradižnik', 1, ''), -- ID_Sestavine = 408
('Soli', 1, 'žlička'), -- ID_Sestavine = 409
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 410
('Olja', 2, 'žlici'); -- ID_Sestavine = 411

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(54, 402), 
(54, 403), 
(54, 404), 
(54, 405), 
(54, 406), 
(54, 407), 
(54, 408), 
(54, 409), 
(54, 410), 
(54, 411);




INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Zelene paprike', 4, 'kosi'), -- ID_Sestavine = 412
('Mletega mesa', 300, 'g'), -- ID_Sestavine = 413
('Čebula', 1, ''), -- ID_Sestavine = 414
('Paradižnikove omake', 200, 'ml'), -- ID_Sestavine = 415
('Česna', 2, 'stroka'), -- ID_Sestavine = 416
('Sira', 200, 'g'), -- ID_Sestavine = 417
('Soli', 1, 'žlička'), -- ID_Sestavine = 418
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 419
('Olja', 2, 'žlici'); -- ID_Sestavine = 420

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(55, 412), 
(55, 413), 
(55, 414), 
(55, 415), 
(55, 416), 
(55, 417), 
(55, 418), 
(55, 419), 
(55, 420);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Tortilje', 4, ''), -- ID_Sestavine = 421
('Mletega mesa', 300, 'g'), -- ID_Sestavine = 422
('Čebula', 1, 'kos'), -- ID_Sestavine = 423
('Paradižnikove omake', 200, 'ml'), -- ID_Sestavine = 424
('Česna', 2, 'stroka'), -- ID_Sestavine = 425
('Sira', 200, 'g'), -- ID_Sestavine = 426
('Soli', 1, 'žlička'), -- ID_Sestavine = 427
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 428
('Olja', 2, 'žlici'); -- ID_Sestavine = 429

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(56, 421), 
(56, 422), 
(56, 423), 
(56, 424), 
(56, 425), 
(56, 426), 
(56, 427), 
(56, 428), 
(56, 429);



# Recept 57: Chiles en Nogada
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Zelene paprike', 4, 'kosi'), -- ID_Sestavine = 430
('Mletega mesa', 300, 'g'), -- ID_Sestavine = 431
('Čebula', 1, ''), -- ID_Sestavine = 432
('Paradižnikove omake', 200, 'ml'), -- ID_Sestavine = 433
('Česna', 2, 'stroka'), -- ID_Sestavine = 434
('Sira', 200, 'g'), -- ID_Sestavine = 435
('Soli', 1, 'žlička'), -- ID_Sestavine = 436
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 437
('Olja', 2, 'žlici'), -- ID_Sestavine = 438
('Smetane', 200, 'ml'), -- ID_Sestavine = 439
('Jogurta', 100, 'g'), -- ID_Sestavine = 440
('Peteršilj', NULL, 'po okusu'), -- ID_Sestavine = 441
('Granuliranega sladkorja', 2, 'žlici'), -- ID_Sestavine = 442
('Pinjol', 50, 'g'); -- ID_Sestavine = 443

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(57, 430), 
(57, 431), 
(57, 432), 
(57, 433), 
(57, 434), 
(57, 435), 
(57, 436), 
(57, 437), 
(57, 438), 
(57, 439), 
(57, 440), 
(57, 441), 
(57, 442), 
(57, 443);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Raca', 1, ''), -- ID_Sestavine = 444
('Soli', 2, 'žlički'), -- ID_Sestavine = 445
('Popra', 1, 'žlička'), -- ID_Sestavine = 446
('Ingverja', 50, 'g'), -- ID_Sestavine = 447
('Česna', 4, 'stroki'), -- ID_Sestavine = 448
('Sojine omake', 100, 'ml'), -- ID_Sestavine = 449
('Medu', 50, 'ml'), -- ID_Sestavine = 450
('Sezamovega olja', 2, 'žlici'), -- ID_Sestavine = 451
('Zelene čebule', 2, 'kosi'); -- ID_Sestavine = 452

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(58, 444), 
(58, 445), 
(58, 446), 
(58, 447), 
(58, 448), 
(58, 449), 
(58, 450), 
(58, 451), 
(58, 452);


# Recept 59: Gong Bao Jī Dīng
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Piščančjega fileja', 400, 'g'), -- ID_Sestavine = 453
('Arašidov', 100, 'g'), -- ID_Sestavine = 454
('Čebula', 1, ''), -- ID_Sestavine = 455
('Paprika', 1, ''), -- ID_Sestavine = 456
('Česna', 2, 'stroka'), -- ID_Sestavine = 457
('Sojine omake', 100, 'ml'), -- ID_Sestavine = 458
('Čili omake', 50, 'ml'), -- ID_Sestavine = 459
('Riževega kisa', 2, 'žlici'), -- ID_Sestavine = 460
('Sladkorja', 2, 'žlici'), -- ID_Sestavine = 461
('Soli', 1, 'žlička'), -- ID_Sestavine = 462
('Popra', 0.5, 'žličke'); -- ID_Sestavine = 463

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(59, 453), 
(59, 454), 
(59, 455), 
(59, 456), 
(59, 457), 
(59, 458), 
(59, 459), 
(59, 460), 
(59, 461), 
(59, 462), 
(59, 463);



# Recept 60: Vegan Mapo Tofu

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Tofuja', 400, 'g'), -- ID_Sestavine = 464
('Čebula', 1, ''), -- ID_Sestavine = 465
('Česna', 2, 'stroka'), -- ID_Sestavine = 466
('Ingverja', 20, 'g'), -- ID_Sestavine = 467
('Sojine omake', 100, 'ml'), -- ID_Sestavine = 468
('Čili omake', 50, 'ml'), -- ID_Sestavine = 469
('Rastlinske juhe', 200, 'ml'), -- ID_Sestavine = 470
('Gob', 200, 'g'), -- ID_Sestavine = 471
('Riževega vina', 50, 'ml'), -- ID_Sestavine = 472
('Korianderja', NULL, 'po okusu'), -- ID_Sestavine = 473
('Soli', 1, 'žlička'), -- ID_Sestavine = 474
('Popra', 0.5, 'žličke'); -- ID_Sestavine = 475

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(60, 464), 
(60, 465), 
(60, 466), 
(60, 467), 
(60, 468), 
(60, 469), 
(60, 470), 
(60, 471), 
(60, 472), 
(60, 473), 
(60, 474), 
(60, 475);


INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Testa za dumplingse', 500, 'g'), -- ID_Sestavine = 476
('Mletega mesa', 300, 'g'), -- ID_Sestavine = 477
('Čebula', 1, ''), -- ID_Sestavine = 478
('Česna', 2, 'stroka'), -- ID_Sestavine = 479
('Ingverja', 20, 'g'), -- ID_Sestavine = 480
('Sojine omake', 100, 'ml'), -- ID_Sestavine = 481
('Riževega vina', 50, 'ml'), -- ID_Sestavine = 482
('Zelja', 200, 'g'), -- ID_Sestavine = 483
('Soli', 1, 'žlička'), -- ID_Sestavine = 484
('Popra', 0.5, 'žličke'); -- ID_Sestavine = 485

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(61, 476), 
(61, 477), 
(61, 478), 
(61, 479), 
(61, 480), 
(61, 481), 
(61, 482), 
(61, 483), 
(61, 484), 
(61, 485);




INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Piščančjega fileja', 300, 'g'), -- ID_Sestavine = 486
('Chow Mein rezancev', 200, 'g'), -- ID_Sestavine = 487
('Čebula', 1, ''), -- ID_Sestavine = 488
('Paprika', 1, ''), -- ID_Sestavine = 489
('Korenja', 1, 'kos'), -- ID_Sestavine = 490
('Česna', 2, 'stroka'), -- ID_Sestavine = 491
('Ingverja', 20, 'g'), -- ID_Sestavine = 492
('Sojine omake', 100, 'ml'), -- ID_Sestavine = 493
('Sezamovega olja', 2, 'žlici'), -- ID_Sestavine = 494
('Soli', 1, 'žlička'), -- ID_Sestavine = 495
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 496
('Sezamovih semen', 1, 'žlica'); -- ID_Sestavine = 497

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(62, 486), 
(62, 487), 
(62, 488), 
(62, 489), 
(62, 490), 
(62, 491), 
(62, 492), 
(62, 493), 
(62, 494), 
(62, 495), 
(62, 496), 
(62, 497);



INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Piščančjega fileja', 400, 'g'), -- ID_Sestavine = 498
('Sezamovih semen', 50, 'g'), -- ID_Sestavine = 499
('Sojine omake', 100, 'ml'), -- ID_Sestavine = 500
('Sezamovega olja', 2, 'žlici'), -- ID_Sestavine = 501
('Česna', 2, 'stroka'), -- ID_Sestavine = 502
('Ingverja', 20, 'g'), -- ID_Sestavine = 503
('Medu', 50, 'ml'), -- ID_Sestavine = 504
('Soli', 1, 'žlička'), -- ID_Sestavine = 505
('Popra', 0.5, 'žličke'); -- ID_Sestavine = 506

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(63, 498), 
(63, 499), 
(63, 500), 
(63, 501), 
(63, 502), 
(63, 503), 
(63, 504), 
(63, 505), 
(63, 506);

# Recept 64: Tonkotsu Ramen
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Svinjskih kosti', 1, 'kg'), -- ID_Sestavine = 507
('Svinjskega trebuha', 500, 'g'), -- ID_Sestavine = 508
('Ramen rezancev', 200, 'g'), -- ID_Sestavine = 509
('Česna', 4, 'stroki'), -- ID_Sestavine = 510
('Ingverja', 50, 'g'), -- ID_Sestavine = 511
('Sojine omake', 100, 'ml'), -- ID_Sestavine = 512
('Miso paste', 50, 'g'), -- ID_Sestavine = 513
('Špinače', 100, 'g'), -- ID_Sestavine = 514
('Trdo kuhanih jajc', 2, 'kosa'), -- ID_Sestavine = 515
('Zelene čebule', 2, 'kosi'), -- ID_Sestavine = 516
('Soli', 1, 'žlička'), -- ID_Sestavine = 517
('Popra', 0.5, 'žličke'); -- ID_Sestavine = 518

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(64, 507), 
(64, 508), 
(64, 509), 
(64, 510), 
(64, 511), 
(64, 512), 
(64, 513), 
(64, 514), 
(64, 515), 
(64, 516), 
(64, 517), 
(64, 518);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Piščančjega fileja', 400, 'g'), -- ID_Sestavine = 519
('Panko drobtin', 200, 'g'), -- ID_Sestavine = 520
('Jajci', 2, ''), -- ID_Sestavine = 521
('Moke', 100, 'g'), -- ID_Sestavine = 522
('Soli', 1, 'žlička'), -- ID_Sestavine = 523
('Popra', 0.5, 'žličke'), -- ID_Sestavine = 524
('Curry omake', 200, 'ml'), -- ID_Sestavine = 525
('Riža', 200, 'g'), -- ID_Sestavine = 526
('Čebula', 1, ''), -- ID_Sestavine = 527
('Korenja', 1, 'kos'), -- ID_Sestavine = 528
('Krompir', 1, ''); -- ID_Sestavine = 529

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(65, 519), 
(65, 520), 
(65, 521), 
(65, 522), 
(65, 523), 
(65, 524), 
(65, 525), 
(65, 526), 
(65, 527), 
(65, 528), 
(65, 529);

# Recept 66: Takoyaki
INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Testa za takoyaki', 500, 'g'), -- ID_Sestavine = 530
('Hobotnice', 200, 'g'), -- ID_Sestavine = 531
('Zelja', 100, 'g'), -- ID_Sestavine = 532
('Zelene čebule', 2, 'kosi'), -- ID_Sestavine = 533
('Ingverja', 20, 'g'), -- ID_Sestavine = 534
('Takoyaki omake', 100, 'ml'), -- ID_Sestavine = 535
('Majoneze', 50, 'ml'), -- ID_Sestavine = 536
('Bonito kosmičev', 30, 'g'), -- ID_Sestavine = 537
('Aonorija', 20, 'g'); -- ID_Sestavine = 538

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(66, 530), 
(66, 531), 
(66, 532), 
(66, 533), 
(66, 534), 
(66, 535), 
(66, 536), 
(66, 537), 
(66, 538);

INSERT INTO Sestavine (Naziv, Kolicina, Enota) VALUES 
('Piščančjega fileja', 400, 'g'), -- ID_Sestavine = 539
('Tofuja', 200, 'g'), -- ID_Sestavine = 540
('Zelja', 200, 'g'), -- ID_Sestavine = 541
('Šitaki gob', 100, 'g'), -- ID_Sestavine = 542
('Korenja', 1, 'kos'), -- ID_Sestavine = 543
('Daikon redkve', 100, 'g'), -- ID_Sestavine = 544
('Sojine omake', 100, 'ml'), -- ID_Sestavine = 545
('Mirina', 50, 'ml'), -- ID_Sestavine = 546
('Dashi juhe', 500, 'ml'), -- ID_Sestavine = 547
('Soli', 1, 'žlička'), -- ID_Sestavine = 548
('Popra', 0.5, 'žličke'); -- ID_Sestavine = 549

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(67, 539), 
(67, 540), 
(67, 541), 
(67, 542), 
(67, 543), 
(67, 544), 
(67, 545), 
(67, 546), 
(67, 547), 
(67, 548), 
(67, 549);





-- Karaage
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(550, 'Piščančjega fileja', 400, 'g'),
(551, 'Sojine omaka', 100, 'ml'),
(552, 'Sake', 50, 'ml'),
(553, 'Česna', 2, 'stroka'),
(554, 'Ingverja', 20, 'g'),
(555, 'Koruznega škroba', 100, 'g'),
(556, 'Soli', 1, 'žlička'),
(557, 'Popra', 0.5, 'žličke'),
(558, 'Olja za cvrtje', 500, 'ml');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(68, 550), 
(68, 551), 
(68, 552), 
(68, 553), 
(68, 554), 
(68, 555), 
(68, 556), 
(68, 557), 
(68, 558);

-- Jjajangmyeon
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(559, 'Narezanega svinjskega mesa', 300, 'g'),
(560, 'Čebule (narezane na kocke)', 1, 'kos'),
(561, 'Krompir (narezan na kocke)', 1, ''),
(562, 'Korenja (narezano na kocke)', 1, 'kos'),
(563, 'Gomoljne zelene (narezane na kocke)', 1, 'kos'),
(564, 'Oljčnega olja', 2, 'žlici'),
(565, 'Soli', 1, 'žlička'),
(566, 'Mlete črna paprike', 1, 'žlička'),
(567, 'Mlete kumine', 1, 'žlička'),
(568, 'Mletih koriandrovih semen', 1, 'žlička'),
(569, 'Sveže mletih koriandrovih listov', 2, 'žlici'),
(570, 'Vode', 500, 'ml');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(69, 559), 
(69,  560), 
(69,  561), 
(69,  562), 
(69,  563), 
(69, 564), 
(69,  565), 
(69,  566), 
(69,  567), 
(69,  568), 
(69, 569), 
(69, 570);


-- Masala Chicken
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(571, 'Narezanega piščančjega fileja', 500, 'g'),
(572, 'Naribane ingverjeve korenina', 1, 'žlica'),
(573, 'Sesekljanega česnaa', 2, 'kos'),
(574, 'Naribane limonine lupine', 1, 'žlica'),
(575, 'Sveže iztisnjenega limoninega soka', 2, 'žlici'),
(576, 'Mlete kurkume', 1, 'žlička'),
(577, 'Mlete kumine', 1, 'žlička'),
(578, 'Mletih koriandrovih semen', 1, 'žlička'),
(579, 'Mletih kardamomovih semen', 3, 'žličke'),
(580, 'Mlete kajenske paprike', 1, 'žlička'),
(581, 'Mletega črnega popra', 1, 'žlička'),
(582, 'Oljčnega olja', 2, 'žlici'),
(583, 'Naribane kokosove kaše', 2, 'žlici'),
(584, 'Sesekljanega svežega korianderja', 2, 'žlici'),
(585, 'Soli', 1, 'žlička'),
(586, 'Mletega popra', 1, 'žlička');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(70, 571), 
(70, 572), 
(70, 573), 
(70, 574), 
(70, 575), 
(70, 576), 
(70, 577), 
(70, 578), 
(70, 579), 
(70, 580), 
(70, 581), 
(70, 582), 
(70, 583), 
(70, 584), 
(70, 585), 
(70, 586);


-- Palak Paneer
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(587, 'Narezanih špinačnih listov', 500, 'g'),
(588, 'Kock paneerja', 250, 'g'),
(589, 'Oljčnega olja', 2, 'žlici'),
(590, 'Sesekljanega česna', 2, 'kosa'),
(591, 'Naribane ingverjeve korenine', 1, 'žlica'),
(592, 'Naribane čebule', 1, 'kos'),
(593, 'Narezanega paradižnika', 2, 'kos'),
(594, 'Mlete kurkume', 1, 'žlička'),
(595, 'Mlete kumine', 1, 'žlička'),
(596, 'Mletih koriandrovih semen', 1, 'žlička'),
(597, 'Mletih kardamomovih semen', 3, 'žličke'),
(598, 'Mlete kajenske paprike', 1, 'žlička'),
(599, 'Mletega korianderja', 1, 'žlička'),
(600, 'Soli', 1, 'žlička'),
(601, 'Sveže smetane', 2, 'žlici');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(71, 587),
(71, 588),
(71, 589),
(71, 590),
(71, 591),
(71, 592),
(71, 593),
(71, 594),
(71, 595),
(71, 596),
(71, 597),
(71, 598),
(71, 599),
(71, 600),
(71, 601);



-- Aloo Gobi
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(602, 'Krompirja (narezanega na kocke)', 2, 'kos'),
(603, 'Cvetače (narezane na cvetove)', 1, 'glava'),
(604, 'Oljčnega olja', 3, 'žlice'),
(605, 'Mletih gorčičnih semen', 1, 'žlička'),
(606, 'Mlete kumine', 1, 'žlička'),
(607, 'Kurkume', 1, 'žlička'),
(608, 'Sveže mletega ingverja', 1, 'žlica'),
(609, 'Sveže mletega česna', 2, 'stroka'),
(610, 'Paradižnika (narezanega)', 1, 'kos'),
(611, 'Soli', 1, 'žlička'),
(612, 'Svežega korianderja (sesekljanega)', 2, 'žlici');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(72, 602),
(72, 603),
(72, 604),
(72, 605),
(72, 606),
(72, 607),
(72, 608),
(72, 609),
(72, 610),
(72, 611),
(72, 612);



INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(613, 'Rumene leče', 1, 'skodelica'),
(614, 'Vode', 3, 'skodelice'),
(615, 'Paradižnika (narezanega)', 1, 'kos'),
(616, 'Čebule (narezane)', 1, 'kos'),
(617, 'Zelene čili paprike (narezane)', 1, 'kos'),
(618, 'Mlete kurkume', 1, 'žlička'),
(619, 'Mlete kumine', 1, 'žlička'),
(620, 'Svežega korianderja (sesekljanega)', 2, 'žlici'),
(621, 'Sveže mletega ingverja', 1, 'žlica'),
(622, 'Sveže mletega česna', 2, 'stroka'),
(623, 'Oljčnega olja', 2, 'žlici'),
(624, 'Semen kumine', 1, 'žlička'),
(625, 'Gorčičnih semen', 1, 'žlička'),
(626, 'Suha+e rdeče paprike', 1, 'kos'),
(627, 'Asafetide (hing)', 1, 'ščepec'),
(628, 'Soli', 1, 'žlička');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(73, 613),
(73, 614),
(73, 615),
(73, 616),
(73, 617),
(73, 618),
(73, 619),
(73, 620),
(73, 621),
(73, 622),
(73, 623),
(73, 624),
(73, 625),
(73, 626),
(73, 627),
(73, 628);



-- Vegetable Biryani
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(629, 'Basmati riža', 2, 'skodelici'),
(630, 'Vode', 4, 'skodelice'),
(631, 'Krompirja (narezaneha na kocke)', 2, 'kos'),
(632, 'Cvetače (narezane na cvetove)', 1, 'glava'),
(633, 'Korenja (narezanega na kocke)', 2, 'kos'),
(634, 'Zelenega fižola (narezan)', 1, 'skodelica'),
(635, 'Zamrznjenega graha', 1, 'skodelica'),
(636, 'Oljčnega olja', 4, 'žlice'),
(637, 'Čebule (narezane)', 1, 'kos'),
(638, 'Svežega ingverja (naribanega)', 1, 'žlica'),
(639, 'Svežega česna (sesekljanega)', 2, 'stroka'),
(640, 'Zelenjavne jušne kocke', 1, 'kos'),
(641, 'Mlete kurkume', 1, 'žlička'),
(642, 'Mletega kumina', 1, 'žlička'),
(643, 'Mletih kardamomovih semen', 1, 'žlička'),
(644, 'Mlete klinčke', 3, 'žličke'),
(645, 'Mlete cimetove skorjice', 1, 'žlička'),
(646, 'Gorčičnih semen', 1, 'žlička'),
(647, 'Soli', 1, 'žlička'),
(648, 'Vročega mleka', 0.5, 'skodelice'),
(649, 'Šafrana', 1, 'ščepec'),
(650, 'Vroče vode', 2, 'žlici'),
(651, 'Svežega korianderja (sesekljanega)', 2, 'žlici');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(74, 629),
(74, 630),
(74, 631),
(74, 632),
(74, 633),
(74, 634),
(74, 635),
(74, 636),
(74, 637),
(74, 638),
(74, 639),
(74, 640),
(74, 641),
(74, 642),
(74, 643),
(74, 644),
(74, 645),
(74, 646),
(74, 647),
(74, 648),
(74, 649),
(74, 650),
(74, 651);


-- Baked Mackerel
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(652, 'Makrele (očiščene in razčetvrjene)', 4, 'kos'),
(653, 'Limona (narezana na tanke rezine)', 1, ''),
(654, 'Čebula (narezana na tanke rezine)', 1, ''),
(655, 'Svežega koriandra (sesekljanega)', 2, 'žlici'),
(656, 'Oljčnega olja', 2, 'žlici'),
(657, 'Mlete kurkume', 1, 'žlička'),
(658, 'Mlete kumine', 1, 'žlička'),
(659, 'Mletih koriandrovih semen', 1, 'žlička'),
(660, 'Mlete črne paprike', 1, 'žlička'),
(661, 'Soli', 1, 'žlička'),
(662, 'Mletega popra', 1, 'žlička');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(75, 652),
(75, 653),
(75, 654),
(75, 655),
(75, 656),
(75, 657),
(75, 658),
(75, 659),
(75, 660),
(75, 661),
(75, 662);


-- Shakshuka
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(663, 'Oljčnega olja', 2, 'žlici'),
(664, 'Čebula (narezana)', 1, ''),
(665, 'Rdeče paprike (narezane na kocke)', 1, 'kos'),
(666, 'Paradižnika (narezana)', 2, 'kos'),
(667, 'Svežega česna (sesekljanega)', 2, 'stroka'),
(668, 'Mlete kumine', 1, 'žlička'),
(669, 'Mlete paprike', 1, 'žlička'),
(670, 'Soli', 1, 'žlička'),
(671, 'Mletiega črnega popra', 1, 'žlička'),
(672, 'Jajca', 4, ''),
(673, 'Svežega koriandra (sesekljanega)', 2, 'žlici');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(76, 663),
(76, 664),
(76, 665),
(76, 666),
(76, 667),
(76, 668),
(76, 669),
(76, 670),
(76, 671),
(76, 672),
(76, 673);


-- Paella
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(674, 'Oljčnega olja', 2, 'žlici'),
(675, 'Piščančjega fileja (narezanega na koščke)', 300, 'g'),
(676, 'Klobase (narezane na kolobarje)', 200, 'g'),
(677, 'Čebule (narezane)', 1, 'kos'),
(678, 'Svežega česna (sesekljanega)', 2, 'stroka'),
(679, 'Rdeče paprike (narezane na kocke)', 1, 'kos'),
(680, 'Paradižnika (narezanega)', 2, 'kos'),
(681, 'Arborio riža', 1, 'skodelica'),
(682, 'Zelenjavne ali piščančje juhe ', 2, 'skodelici'),
(683, 'Šafrana', 1, 'ščepec'),
(684, 'Soli', 1, 'žlička'),
(685, 'Mletega črnega popra', 1, 'žlička'),
(686, 'Limonine rezine', 2, 'kos'),
(687, 'Svežega peteršilja (sesekljanega)', 2, 'žlici');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(77, 674),
(77, 675),
(77, 676),
(77, 677),
(77, 678),
(77, 679),
(77, 680),
(77, 681),
(77, 682),
(77, 683),
(77, 684),
(77, 685),
(77, 686),
(77, 687);



-- Brezglutenski Muffini
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(688, 'Brezglutenske moke', 1.5, 'skodelice'),
(689, 'Kokosovega sladkorja', 0.5, 'skodelice'),
(690, 'Praška za pecivo', 2, 'čajni žlički'),
(691, 'Sode bikarbone', 0.5, 'čajne žličke'),
(692, 'Soli', 0.25, 'čajne žličke'),
(693, 'Mletega cimeta', 1, 'čajna žlička'),
(694, 'Jabolčnega pireja', 0.5, 'skodelice'),
(695, 'Naribane jabolke', 0.5, 'skodelice'),
(696, 'Jajci', 2, ''),
(697, 'Kokosovega olja (stopljenega)', 0.5, 'skodelice'),
(698, 'Vanilijevega ekstrakta', 1, 'čajna žlička'),
(699, 'Orehov (nasekljanih)', 0.5, 'skodelice');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(78, 688),
(78, 689),
(78, 690),
(78, 691),
(78, 692),
(78, 693),
(78, 694),
(78, 695),
(78, 696),
(78, 697),
(78, 698),
(78, 699);


-- Solata Capresse
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(700, 'Paradižnika (narezanega na rezine)', 3, 'kos'),
(701, 'Bivolji mozarele (narezane)', 200, 'g'),
(702, 'Sveže bazilike (listov)', 1, 'skodelica'),
(703, 'Ekstra deviškega oljčnega olja', 2, 'žlici'),
(704, 'Balzamičnega kisa', 1, 'žlica'),
(705, 'Soli', 1, 'ščepec'),
(706, 'Sveže mletega črnega popra', 1, 'ščepec');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(79, 700),
(79, 701),
(79, 702),
(79, 703),
(79, 704),
(79, 705),
(79, 706);


-- Brezglutenski Borovničevi Kolački
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(707, 'Svežih borovnic', 1, 'skodelica'),
(708, 'Moke brez glutena', 1.5, 'skodelice'),
(709, 'Praška za pecivo', 2, 'čajni žlički'),
(710, 'Sode bikarbone', 0.5, 'čajne žličke'),
(711, 'Soli', 0.25, 'čajne žličke'),
(712, 'Mletega cimeta', 1, 'čajna žlička'),
(713, 'Jajce', 1, ''),
(714, 'Kokosovega sladkorja', 0.5, 'skodelice'),
(715, 'Kokosovega olja (stopljenega)', 0.5, 'skodelice'),
(716, 'Vanilijevega ekstrakta', 1, 'čajna žlička'),
(717, 'Limone (sok in lupina)', 1, 'kos'),
(718, 'Mandljevih lističev', 0.25, 'skodelice');

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(80, 707),
(80, 708),
(80, 709),
(80, 710),
(80, 711),
(80, 712),
(80, 713),
(80, 714),
(80, 715),
(80, 716),
(80, 717),
(80, 718);


-- Veganska Sladka Pečenka
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(719, 'Ovsene moke', 2, 'skodelici'),
(720, 'Kokosovega sladkorja', 1, 'skodelica'),
(721, 'Kakava v prahu', 0.5, 'skodelice'),
(722, 'Praška za pecivo', 1, 'čajna žlička'),
(723, 'Sode bikarbone', 1, 'čajna žlička'),
(724, 'Soli', 0.25, 'čajne žličke'),
(725, 'Mletih lanenih semen', 2, 'žlici'),
(726, 'Vode', 6, 'žlic'),
(727, 'Mandljevega mleko', 1.5, 'skodelice'),
(728, 'Jabolčnega kisa', 1, 'žlica'),
(729, 'Vanilijevega ekstrakta', 1, 'čajna žlička'),
(730, 'Jabolčnega pireja', 0.5, 'skodelice'),
(731, 'Kokosovega olja (stopljenega)', 0.25, 'skodelice'),
(732, 'Mandljevih lističev (za posip)', NULL, NULL),
(733, 'Kokosovih kosmičev (za posip)', NULL, NULL);

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(81, 719),
(81, 720),
(81, 721),
(81, 722),
(81, 723),
(81, 724),
(81, 725),
(81, 726),
(81, 727),
(81, 728),
(81, 729),
(81, 730),
(81, 731),
(81, 732),
(81, 733);


-- Veganska Pomarančno-Čokoladna Torta
INSERT INTO Sestavine (ID_Sestavine, Naziv, Kolicina, Enota) VALUES 
(734, 'Pirine moke', 1.5, 'skodelice'),
(735, 'Kakava v prahu', 0.5, 'skodelice'),
(736, 'Praška za pecivo', 1, 'čajna žlička'),
(737, 'Sode bikarbone', 0.5, 'čajne žličke'),
(738, 'Sol', 0.25, 'čajne žličke'),
(739, 'Kokosovega sladkorja', 1, 'skodelica'),
(740, 'Mandljevega mleka', 1, 'skodelica'),
(741, 'Jabolčnega kisa', 2, 'žlici'),
(742, 'Jabolčnega pireja', 0.5, 'skodelice'),
(743, 'Kokosovega olja (stopljenega)', 0.25, 'skodelice'),
(744, 'Naribane lupine pomaranče', 1, 'kos'),
(745, 'Izolata čokoladnega proteina', 0.5, 'skodelice'),
(746, 'Soka pomaranče', 0.5, 'skodelice'),
(747, 'Mandljevih lističev (za posip)', NULL, NULL),
(748, 'Kakavove čokolade (stopljene, za preliv)', NULL, NULL);

INSERT INTO Recept_Sestavine (TK_Recept, TK_Sestavine) VALUES 
(82, 734),
(82, 735),
(82, 736),
(82, 737),
(82, 738),
(82, 739),
(82, 740),
(82, 741),
(82, 742),
(82, 743),
(82, 744),
(82, 745),
(82, 746),
(82, 747),
(82, 748);

