# Z MEŠALCEM DO USPEHA

"Z mešalcem do uspeha" je aplikacija za upravljanje receptov, kjer lahko uporabniki dodajajo, pregledujejo, urejajo in brišejo recepte. Aplikacija uporablja Spring Boot za zaledje, MySQL za bazo podatkov in ponuja REST API-je za izvajanje CRUD operacij nad recepti.

## Uporabljene tehnologije

- **Jezik**: Java 17
- **Framework**: Spring Boot 3.3.4
- **ORM**: Hibernate 6.5.3
- **Baza podatkov**: MySQL 8.0
- **Gradnik**: Maven 3.8.1

### Navodila za nameščanje

#### Predpogoji

- **Java 17**: Prepričajte se, da imate nameščen JDK 17.
  - [Prenesite JDK 17](https://www.oracle.com/java/technologies/javase-jdk17-downloads.html)
- **MySQL 8.0**: MySQL mora biti nameščen in zagnan.
  - [Prenesite MySQL 8.0](https://dev.mysql.com/downloads/mysql/)
- **Maven**: Prepričajte se, da imate nameščen Maven.
  - [Prenesite Maven](https://maven.apache.org/download.cgi)

#### Namestitev in zagon

1. Klonirajte repozitorij:

   ```bash
   git clone https://github.com/vase_uporabnisko_ime/zMesalcemDoUspeha.git
   cd zMesalcemDoUspeha
   ```

2. Ustvarite bazo podatkov MySQL:

   ```sql
   CREATE DATABASE zMesalcemDoUspeha;
   ```

3. Posodobite nastavitve v `application.properties` datoteki:

   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/zMesalcemDoUspeha
   spring.datasource.username=user
   spring.datasource.password=password
   ```

4. Namestite odvisnosti in zaženite aplikacijo:
   ```bash
   mvn clean install
   mvn spring-boot:run
   ```

### Navodila za razvijalce

- **Standardi kodiranja**: Sledite standardnim Java konvencijam za poimenovanje in formatiranje. Uporabljajte Javadoc komentarje za metode.
- **Struktura projekta**:
  - `src/main/java`: Vsebuje izvorno kodo.
  - `src/main/resources`: Vsebuje nastavitvene datoteke in druge vire.
  - `pom.xml`: Mavenova datoteka za upravljanje odvisnosti.
- **Prispevanje k projektu**:
  1. Forkajte repozitorij.
  2. Ustvarite novo vejo za vašo funkcionalnost (`git checkout -b nova-funkcionalnost`).
  3. Po opravljenem delu pošljite pull request.

=======
### Vizija

- Projekt "Z mešalcem do uspeha" je spletna aplikacija, ki uporabnikom omogoča hitro in enostavno iskanje, pregledovanje ter deljenje preverjenih receptov za raznovrstne jedi.
- Naš cilj je pomagati uporabnikom, da dobijo navdih in dostopajo do kakovostnih receptov, ki so enostavni za pripravo ali prilagojeni različnim prehranskim potrebam.
- Platforma omogoča iskanje receptov po sestavinah, kar uporabnikom pomaga bolje izkoristiti obstoječe zaloge in zmanjša prehranski odpadek.
- Recepti.si je namenjen tako ljubiteljskim kuharjem kot tudi začetnikom, ki iščejo navodila po korakih za okusne jedi.

### Besednjak

**Recept:** Podrobno navodilo za pripravo določene jedi, ki vsebuje seznam sestavin, količine in korake za pripravo jedi.  
**Sestavina:** Posamezni živilski izdelek ali predmet, ki je potreben za pripravo recepta (npr. moka, sladkor, jajca).  
**Vrsta jedi:** Kategorija, pod katero spada recept (npr. predjed, glavna jed, sladica, prigrizek).  
**Uporabnik:** Posameznik, ki uporablja aplikacijo za iskanje, pregledovanje ali objavo receptov; lahko je registriran ali neregistriran.  
**Filter:** Funkcija, ki omogoča uporabnikom, da omejijo prikaz receptov na podlagi določenih kriterijev (npr. vrsta jedi, čas priprave, sestavine).  
**Iskalna vrstica:** Polje na vrhu strani, kjer lahko uporabniki vnesejo besede za iskanje specifičnih receptov ali sestavin.  
**Avtor recepta:** Uporabnik, ki je ustvaril in objavil recept na platformi.  
**Priprava recepta:** Koraki oziroma postopki, ki opisujejo, kako pripraviti določeno jed.  
**Čas priprave:** Približen čas, potreben za pripravo jedi, vključno s pripravljalnimi in kuhalnimi koraki.  
**Prijava:** Postopek, s katerim registrirani uporabniki dostopajo do svojega računa in dodatnih funkcionalnosti platforme.  
**Registracija:** Postopek, s katerim novi uporabniki ustvarijo račun, kar jim omogoča objavo receptov.  
**Seznam sestavin:** Prikaz vseh sestavin, potrebnih za določen recept, z natančnimi količinami in enotami.  
**Postopek priprave:** Sistematičen prikaz posameznih korakov, ki uporabnikom pomaga slediti navodilom za pripravo jedi.  
**Marinada:** Mešanica tekočine, začimb in zelišč, v kateri pustimo sestavine (največkrat meso) pred kuhanjem, da absorbirajo okuse.  
**Porcija:** Količina jedi, ki je namenjena eni osebi; pogosto navedena v receptih, da uporabniki vedo, za koliko ljudi je recept.  
**Stopnja težavnosti:** Oznaka, ki nakazuje, kako zahtevna je priprava recepta (npr. začetni, srednje zahteven, napreden).


# Opis razrednega diagrama

Diagram prikazuje razrede in njihove povezave v aplikaciji za upravljanje receptov.

## Razredi in njihove vloge

### Recept
- **Vloga:** Osrednji razred, ki predstavlja recept v aplikaciji.
- **Atributi:**
  - `ime`: Ime recepta.
  - `sestavine`: Seznam sestavin, ki so uporabljene v receptu.
  - `navodila`: Seznam korakov (navodil) za pripravo recepta.
  - `časPriprave`: Čas, potreben za pripravo.
  - `težavnost`: Nivo težavnosti recepta (povezan z razredom Težavnost).
  - `ocena`: Povprečna ocena recepta.
  - `komentarji`: Seznam komentarjev uporabnikov.
- **Ključne metode:**
  - `pridobiPodrobnosti()`: Vrne podrobnosti o receptu.
  - `dodajKomentar(komentar: Komentar)`: Omogoča dodajanje komentarja receptu.
  - `oceniRecept(ocena: Double)`: Omogoča ocenjevanje recepta.

### Sestavina
- **Vloga:** Predstavlja posamezno sestavino, ki je potrebna za recept.
- **Atributi:**
  - `ime`: Ime sestavine.
  - `količina`: Količina sestavine.
- **Ključne metode:**
  - `pridobiIme()`: Vrne ime sestavine.
  - `pridobiKoličino()`: Vrne količino sestavine.

### Težavnost
- **Vloga:** Predstavlja stopnjo težavnosti recepta.
- **Atributi:**
  - `stopnja`: Besedni opis težavnosti (npr. lahko, srednje, težko).
- **Ključne metode:**
  - `pridobiStopnjo()`: Vrne stopnjo težavnosti.

### Kategorija (enumeracija)
- **Vloga:** Določa različne kategorije receptov (zajtrk, malica, kosilo, večerja).
- **Povezava:** Povezana je z razredom `Recept`.

### Navodilo
- **Vloga:** Predstavlja posamezni korak priprave recepta.
- **Atributi:**
  - `korak`: Številka koraka.
  - `opis`: Besedni opis koraka.
- **Ključne metode:**
  - `prikažiKorak(trenutniKorak: int)`: Vrne vsebino trenutnega koraka.

### Komentar
- **Vloga:** Predstavlja komentar uporabnika za določen recept.
- **Atributi:**
  - `uporabnik`: Uporabnik, ki je dodal komentar.
  - `vsebina`: Besedilo komentarja.
  - `datum`: Datum dodajanja komentarja.
- **Ključne metode:**
  - `pridobiVsebino()`: Vrne vsebino komentarja.

### Uporabnik
- **Vloga:** Predstavlja registriranega uporabnika aplikacije.
- **Atributi:**
  - `uporabniškoIme`, `email`, `geslo`, `profilnaSlika`: Podatki o uporabniku.
  - `shranjeniRecepti`: Seznam receptov, ki jih je uporabnik shranil.
- **Ključne metode:**
  - `spremeniGeslo(novoGeslo: String)`: Omogoča spremembo gesla.
  - `spremeniEmail(novEmail: String)`: Omogoča spremembo e-poštnega naslova.
  - `shraniRecept(recept: Recept)`, `odstraniRecept(recept: Recept)`, `urediRecept(recept: Recept)`: Operacije nad recepti uporabnika.

### Administrator
- **Vloga:** Predstavlja skrbnika aplikacije z dodatnimi pravicami za upravljanje receptov in sestavin.
- **Atributi:**
  - `adminPravice`: Označuje, ali je uporabnik administrator.
- **Ključne metode:**
  - `potrdiRecept(recept: Recept)`: Potrditev recepta.
  - `odstraniRecept(recept: Recept)`: Odstranitev recepta.
  - `posodobiSestavine(sestavina: Sestavina)`: Posodabljanje sestavin.
  - `posodobiTežavnost(težavnost: Težavnost)`: Posodabljanje težavnosti recepta.

## Povezave med razredi
- `Recept` je povezan z razredi `Sestavina`, `Navodilo`, in `Komentar` (agregacija), kar pomeni, da vsak recept vsebuje več teh entitet.
- `Težavnost` in `Kategorija` sta razreda, ki določata dodatne informacije o receptih.
- `Uporabnik` in `Administrator` omogočata upravljanje aplikacije in vsebine.


### Avtorji
- Larisa Gragar
- Maida Ćivić
- Jurij Dumić

![alt text](umlris-1.jpg)
