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

---

### Testi za funkcionalnost:
1. **Test: ` `**

    - **Opis:** 
    - **Pomembnost:** 

2. **Test: ` `**

    - **Opis:** 
    - **Pomembnost:** 

### Testi za funkcionalnost:
1. **Test: ` `**

    - **Opis:**
    - **Pomembnost:**

2. **Test: ` `**

    - **Opis:**
    - **Pomembnost:**

---

### Testi za funkcionalnost:
1. **Test: ` `**

    - **Opis:**
    - **Pomembnost:**

2. **Test: ` `**

    - **Opis:**
    - **Pomembnost:**

### Testi za funkcionalnost:
1. **Test: ` `**

    - **Opis:**
    - **Pomembnost:**

2. **Test: ` `**

    - **Opis:**
    - **Pomembnost:**

---

## Imena članov skupine in odgovornosti

| Član skupine | Odgovoren za teste            |
|--------------|-------------------------------|
| Maida Ćivić  | `testFindAllRecepti_Positive` |
| Maida Ćivić  | `testFindAllRecepti_Negative` |
| Maida Ćivić  | `testFindReceptById_Positive` |
| Maida Ćivić  | `testFindReceptById_Negative` |
|              | ` `                           |
|              | ` `                           |
|              | ` `                           |
|              | ` `                           |
|              | ` `                           |
|              | ` `                           |
|              | ` `                           |
|              | ` `                           |

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

1. **Uspešnost testov:**

    - Vsi testi so bili uspešno opravljeni brez napak.
    - Testi so pokrili tako pozitivne kot negativne scenarije, kar zagotavlja celovito preverjanje delovanja aplikacije.

2. **Odpravljene napake:**

    -
    -  

3. **Sklep:**

    -
    -


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
