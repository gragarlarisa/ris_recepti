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
    - Product Owner je bil odgovoren za komunikacijo z asistenti preko  **e-maila**.
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

**Razvijalec**:

**Opis**: 

### 3. Predlaganje receptov glede na pogostost sestavin preteklih receptov

**Razvijalec**: 

**Opis**: 

