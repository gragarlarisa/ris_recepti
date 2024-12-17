# POROČILO KANBAN

## Uvod

Preizkusili smo metodo **Kanban** za razvoj novih funkcionalnosti v našem sistemu. Naš cilj je izboljšati uporabniško izkušnjo z dodajanjem naslednjih funkcionalnosti:

- **Prikaz zgodovine receptov**
- **Vpogled v pogostost uporabe določenih sestavin**
- **Predlaganje receptov glede na pogostost sestavin preteklih receptov**

## Projektni cilji

Kot ekipa razvijamo aplikacijo za upravljanje receptov, ki uporabnikom omogoča:

1. **Prikaz zgodovine receptov** – Omogoča uporabnikom ogled zgodovine pregledanih receptov.
2. **Vpogled v pogostost uporabe določenih sestavin** – Analizira in prikazuje, kako pogosto so uporabljene določene sestavine v receptih.
3. **Predlaganje receptov glede na pogostost sestavin preteklih receptov** – Predlaga recepte na podlagi pogostosti uporabljenih sestavin v preteklih receptih.

## Vloge v ekipi

- **Maida Ćivić** – Razvijalec za prikaz zgodovine receptov.
- **[]** – Razvijalec za vpogled v pogostost uporabe določenih sestavin.
- **[]** – Razvijalec za predlaganje receptov glede na pogostost sestavin preteklih receptov.
- **Maida Ćivić** – Product Owner, odgovoren za komunikacijo s strankami in posodabljanje zahtev.

## Kanban tabla

Kanban tabla je prikazana na našem git-u.

### Upravljanje nalog

- **Razdelitelili smo funkcionalnosti na manjše naloge:**

- **Definiranje prioritet:**
  - Uporabili smo oznake za prioritete:
    - **Visoka**
    - **Srednja**
    - **Nizka**

### Sledenje napredku

- **Beleženje napredka na Kanban tabli:**
  - Sproti premikamo naloge med stolpci **To Do**, **In Progress** in **Done**.
  - Upoštevamo načela Kanbana za učinkovito upravljanje nalog.

### Komunikacija in prilagajanje

- **Sodelovanje s asistenti:**
  - Product Owner je bil odgovoren za komunikacijo z asistenti preko **e-maila**.
  - Asistenta sta nas tekom tedna kontaktirala za pregled stanja in morebitne popravke.
  - Prilagodili smo razvoj na podlagi povratnih informacij in sprememb zahtev.

## Funkcionalnosti

### 1. Prikaz zgodovine receptov

**Razvijalec**: Maida Ćivić

**Opis**: Implementirali smo funkcionalnost **prikaza zgodovine receptov**, ki uporabnikom omogoča ogled vseh prej pregledanih receptov. Ta funkcionalnost je zasnovana z uporabo **Local Storage** za shranjevanje in prikazovanje zgodovine. Vsakič, ko uporabnik pregleda recept, se ta doda v zgodovino, omejeno na zadnjih 10 receptov.

**Ključne značilnosti**:

- **Dinamično prikazovanje pregledanih receptov** – Prikazuje seznam receptov, ki jih je uporabnik prej pregledal.
- **Datum in čas pregleda recepta** – Vsak recept v zgodovini ima pripisan datum in čas pregleda.
- **Možnost ponovnega pregleda recepta** – Uporabnik lahko enostavno ponovno odpre prej pregledan recept.
- **Opcija za brisanje zgodovine receptov** – Uporabnik lahko izbriše celotno zgodovino pregledanih receptov.

### 2. Vpogled v pogostost uporabe določenih sestavin

**Razvijalec**: Jurij Dumić

**Opis**: Implementirali smo funkcionalnost vpogleda v pogostost uporabe sestavin, ki omogoča uporabnikom, da si ogledajo seznam sestavin, ki so bile uporabljene v receptih, ki jih je uporabnik že pregledal. Funkcionalnost samodejno zbira in prikaže sestavine, vključno z njihovimi količinami in enotami (npr. gram, kos, žlica), ter število pojavitev posamezne sestavine v zgodovini receptov.

Ključne značilnosti:

Seznam sestavin – Prikazuje vse sestavine, ki so bile uporabljene v pregledanih receptih, skupaj z njihovimi količinami in enotami.
Količine in enote – Sešteje in prikaže skupno količino vsake sestavine v ustrezni enoti (npr. 500g piščančjega fileja, 3 žlice olja).
Pogostost uporabe sestavin – Prikazuje, koliko receptov vsebuje določeno sestavino.
Dinamično posodabljanje – Ko uporabnik ogleda nov recept, se pogostost in količine sestavin samodejno posodobijo.
Vizualno prijazen dizajn – Seznam sestavin je predstavljen v pregledni tabeli, ki vključuje količino, ime sestavine in njeno pogostost.

### 3. Predlaganje receptov glede na pogostost sestavin preteklih receptov

**Razvijalec**: Larisa Gragar

**Opis**: Implementirali smo funkcionalnost predlaganja receptov na podlagi zgodovine ogledanih receptov. Sistem analizira sestavine iz že pregledanih receptov, izračuna njihovo pogostost in pošlje najpogostejše sestavine na backend, ki vrne priporočene recepte.

Ključne značilnosti:

Zbiranje sestavin – Iz zgodovine ogledanih receptov se pridobijo vse sestavine.
Izračun pogostosti – Sestavine se združijo, pri čemer se izračuna njihova pogostost pojavljanja v receptih.
Filtriranje – Izberejo se sestavine z najvišjo pogostostjo.
Pošiljanje podatkov – Najpogostejše sestavine se pošljejo na backend za pridobitev priporočil.
Prikaz priporočil – Backend vrne seznam receptov, ki najbolj ustrezajo izbranim sestavinam, in jih prikaže uporabniku v preglednem formatu.
Namen: Personalizirano predlaganje receptov glede na pretekle interese uporabnika.
