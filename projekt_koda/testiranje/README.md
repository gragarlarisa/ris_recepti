# Poročilo o testiranju

## Opis testov

### Testi za funkcionalnost: Prikaz vseh receptov

1. **Test: `testFindAllRecepti_Positive`**

    - **Opis:** Test preverja, ali metoda `findAll()` vrne seznam vseh receptov iz baze podatkov.
    - **Pomembnost:** Zagotavlja, da aplikacija lahko prikaže vse razpoložljive recepte uporabnikom, kar je ključna funkcionalnost.

2. **Test: `testFindAllRecepti_Negative`**

    - **Opis:** Test preverja obnašanje metode `findAll()` v primeru, ko je baza podatkov prazna.
    - **Pomembnost:** Preveri robustnost aplikacije in zagotavlja ustrezno obravnavo situacij, ko ni podatkov za prikaz.

### Testi za funkcionalnost: Prikaz podrobnosti recepta

1. **Test: `testFindReceptById_Positive`**

    - **Opis:** Test preverja, ali metoda `findById()` vrne pravilne podrobnosti recepta za veljavni ID recepta.
    - **Pomembnost:** Zagotavlja pravilnost in zanesljivost prikaza podrobnosti posameznega recepta.

2. **Test: `testFindReceptById_Negative`**

    - **Opis:** Test preverja, kako metoda `findById()` obravnava situacijo, ko je podan neveljaven ID recepta.
    - **Pomembnost:** Preveri odpornost aplikacije na napake in zagotavlja, da so nepravilne zahteve ustrezno obravnavane.

* Anotacije: @Test, @DisplayName, @BeforeEach
---

### Testi za funkcionalnost:
Povzetek testov:
* Pozitivni test (prikaz podrobnosti uporabnika):

Preverja, ali metoda findById v VpisanUporabnikService pravilno vrne uporabnika, če je ta najden v repozitoriju. Test je uspel, ker je bila vrnjena pravilna uporabnikova elektronska pošta.


* Negativni test (uporabnik ni najden):

Preverja, ali metoda findById v VpisanUporabnikService vrne prazen rezultat (Optional.empty()), če uporabnik ni najden v repozitoriju. Test je uspel, ker je metoda pravilno vrnila prazen rezultat.

---

### Testi za funkcionalnost:
1. Test: testSaveReceptSestavine_Positive

**Opis:**
Test preverja, ali metoda save() pravilno shrani objekt ReceptSestavine v repozitorij, ko so podani veljavni podatki.
Pomembnost: Zagotavlja, da se novi zapisi pravilno shranjujejo v bazo podatkov in da aplikacija deluje brez težav pri vstavljanju podatkov.

2. Test: testSaveReceptSestavine_Negative

**Opis:** 
Test preverja, kako metoda save() obravnava situacijo, ko je podan neveljaven objekt ReceptSestavine (npr. manjkajoči obvezni podatki).
Pomembnost: Preveri, ali aplikacija pravilno zazna napake pri vnosu podatkov in prepreči shranjevanje neveljavnih zapisov.

3. Test: testDeleteReceptSestavineById_Positive

**Opis:**
Test preverja, ali metoda deleteById() uspešno izbriše zapis ReceptSestavine iz repozitorija za veljaven ID.
Pomembnost: Zagotavlja, da aplikacija omogoča brisanje obstoječih zapisov brez napak.

4. Test: testDeleteReceptSestavineById_Negative

**Opis:**
Test preverja, kako metoda deleteById() obravnava situacijo, ko je podan neveljaven ali neobstoječ ID.
Pomembnost: Preveri odpornost aplikacije proti napakam pri brisanju in zagotavlja, da se sistem ustrezno odzove na nepravilne zahteve.

**Anotacije:** 
@Test: Označuje metodo kot testni primer.
@DisplayName: Doda prijazen opis testa za boljše razumevanje izpisov pri testiranju.
@BeforeEach: Inicializira testne podatke ali odvisnosti pred vsakim testom.

### Testi za funkcionalnost:
**Opis:** 
Test preverja, kako metoda getFavoriteRecipes() deluje, ko so podani veljavni ID-ji. Ta test preverja, ali metoda uspešno vrne seznam receptov na podlagi posredovanih ID-jev, če so le-ti prisotni v podatkovni bazi.

**Pomembnost:** 
Preveri, da aplikacija pravilno deluje, ko so podani veljavni ID-ji in da se recepti vrnejo v pravilni obliki. Ta test zagotavlja, da funkcionalnost za pridobivanje priljubljenih receptov deluje, kot je pričakovano.

**Anotacije:**
@Test: Označuje metodo kot testni primer, ki ga bo JUnit izvedel.
@DisplayName: Doda prijazen opis za ta test, da bo jasno, kaj ta test počne.
@BeforeEach: Inicializira potrebne podatke pred vsakim testom, da se zagotovi pravilno izvajanje testov.

2. Test: testGetFavoriteRecipes_Negative

**Opis:** 
Test preverja, kako metoda getFavoriteRecipes() deluje, ko so podani neveljavni ID-ji. Ta test preverja, ali metoda ustrezno obravnava situacijo, ko so posredovani ID-ji, ki niso prisotni v podatkovni bazi.

**Pomembnost:** 
Preveri odpornost aplikacije na napake, kot so neveljavni ID-ji, in zagotavlja, da sistem ustrezno vrne prazni seznam brez napak ali napovedi, ko ni zadetkov. Pomembno je, da se uporabnikom prikaže pravilno obnašanje aplikacije v primeru napak.

**Anotacije:**
@Test: Označuje metodo kot testni primer, ki ga bo JUnit izvedel.
@DisplayName: Doda prijazen opis za ta test, da bo jasno, kaj ta test počne.
@BeforeEach: Inicializira potrebne podatke pred vsakim testom, da se zagotovi pravilno izvajanje testov.
---

## Imena članov skupine in odgovornosti

| Član skupine  | Odgovoren za teste              |
|---------------|---------------------------------|
| Maida Ćivić   | `testFindAllRecepti_Positive`   |
| Maida Ćivić   | `testFindAllRecepti_Negative`   |
| Maida Ćivić   | `testFindReceptById_Positive`   |
| Maida Ćivić   | `testFindReceptById_Negative`   |
| Jurij Dumić   | `testUporabnikNajden_Positive`  |
| Jurij Dumić   | `testUporabnikNajden_Negative ` |
| Larisa Gragar | `testSaveReceptSestavine_Positive`|
| Larisa Gragar | `testSaveReceptSestavine_Negative`|
| Larisa Gragar | `testDeleteReceptSestavineById_Positive`|
| Larisa Gragar | `testDeleteReceptSestavineById_Negative`|
| Larisa Gragar | `testGetFavoriteRecipes_Positive`|
| Larisa Gragar | `testGetFavoriteRecipes_Negative`|

---

## Analiza uspešnosti testov člana Maida Ćivić

1. **Uspešnost testov:**

    - Vsi testi so bili uspešno opravljeni brez napak.
    - Testi so pokrili tako pozitivne kot negativne scenarije, kar zagotavlja celovito preverjanje delovanja aplikacije.

2. **Odpravljene napake:**

    - Med razvojem testov je bila odkrita manjša težava pri metodi `findById()`, ki ni ustrezno vračala praznega odgovora za neveljavne ID-je.
    - Težava je bila odpravljena z dodatno obravnavo primerov, ko rezultat ni najden (dodano `orElseThrow`).

3. **Sklep:**

    - Testiranje je pokazalo, da aplikacija ustrezno deluje v vseh predvidenih scenarijih.
    - Ni bilo odkrite nobene večje napake, kar kaže na robustnost in zanesljivost implementacije.

---


## Analiza uspešnosti testov člana Larisa Gragar

**Uspešnost testov:**

Vsi testi so bili uspešno opravljeni brez napak.
Testi so pokrili tako pozitivne kot negativne scenarije, kar zagotavlja celovito preverjanje delovanja metod save(), findById() in deleteById().
Metode so bile preverjene za pravilno delovanje ob veljavnih vhodih in obvladovanje napak ob neveljavnih podatkih.

**Odpravljene napake:**

Med razvojem testov je bila odkrita težava pri metodi save(), kjer je bilo mogoče shraniti objekt z nepopolnimi podatki (npr. manjkajoča polja v ReceptSestavine).
Težava je bila odpravljena z dodano validacijo podatkov pred shranjevanjem in ustrezno obravnavo napak.
Pri metodi findById() je bila dodana obravnava praznih rezultatov, da se ob neveljavnem ID-ju vrne ustrezen odgovor ali izjema.

**Sklep:**

Testiranje je pokazalo, da metode v razredu ReceptSestavineService ustrezno delujejo v vseh predvidenih scenarijih.
Implementacija je robustna in zanesljiva, saj uspešno obravnava tako pravilne kot nepravilne zahteve.
Z izvedenimi popravki aplikacija ustreza vsem funkcionalnim zahtevam.
---




## Analiza uspešnosti testov člana Jurij Dumić

1. **Uspešnost testov:**

    - Vsi testi so bili uspešno opravljeni brez napak.
    - Testi so pokrili tako pozitivne kot negativne scenarije, kar zagotavlja celovito preverjanje delovanja aplikacije.

2. **Odpravljene napake:**

    -
    -

3. **Sklep:**

    -
    -


