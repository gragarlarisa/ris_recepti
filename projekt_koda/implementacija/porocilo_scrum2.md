# **Scrum dokumentacija**

---

## **Vizija projekta**
Aplikacija za upravljanje receptov je zasnovana za poenostavitev upravljanja in iskanja receptov. Uporabnikom omogoča:
- Brskanje, filtriranje in iskanje receptov.
- Označevanje receptov kot priljubljene in njihovo upravljanje v ločeni sekciji.
- Pregled zgodovine ogledov.
- Dodajanje novih receptov v zbirko.
- Generiranje nakupovalnega seznama na podlagi izbranih receptov.
- Uporabo intuitivnega in vizualno privlačnega uporabniškega vmesnika za enostavno navigacijo in interakcijo.

---

## **Seznam funkcionalnosti (Product Backlog)**

### **Uporabniške zgodbe**
1.**Kot uporabnik želim označiti recepte kot priljubljene in jih upravljati v ločeni sekciji.**
    - Funkcionalnost "Dodaj v priljubljene" in "Odstrani iz priljubljenih".
    - Shranjevanje priljubljenih receptov z uporabo `sessionStorage`.

2.**Kot uporabnik želim prejeti obvestila (toast) za dejanja, kot so dodajanje/odstranjevanje priljubljenih receptov.**
    - Toast obvestila za povratne informacije uporabniku.

3.**Kot uporabnik želim imeti vizualno privlačen in dosleden uporabniški vmesnik.**
    - Stilizacija gumbov, kartic in celotnega dizajna za moderen videz.

4.**Kot uporabnik želim potrditi dejanja, kot je odstranjevanje recepta iz priljubljenih, da se izognem nenamernim izbrisom.**
    - Modalno okno za potrditev pred odstranitvijo receptov iz priljubljenih.

---


## **Izzivi**
1. **Upravljanje priljubljenih receptov**:
    - Zagotavljanje brezhibne integracije `sessionStorage` na več straneh.
    - Obvladovanje robnih primerov, kot je večkratno dodajanje istega recepta.

2. **Doslednost oblikovanja**:
    - Zagotavljanje vizualno privlačnega in doslednega dizajna gumbov, kartic in postavitve.
    - Reševanje težav z gumbi, ki so se premikali ob prehodu miške.

3. **Dinamične posodobitve**:
    - Zagotavljanje, da se uporabniški vmesnik dinamično posodobi pri dodajanju/odstranjevanju receptov iz priljubljenih.

4. **Povratne informacije uporabniku**:
    - Implementacija toast obvestil za jasne povratne informacije o uporabniških dejanjih.

---

## **Rezultati**
- Uspešno razvita odzivna aplikacija za upravljanje receptov.
- Implementirane funkcionalnosti za pregled, filtriranje, dodajanje in upravljanje priljubljenih receptov.
- Izboljšana uporabniška izkušnja z modernimi UI elementi, toast obvestili in modalnimi potrditvami.
- Dostavljen čist in vzdržljiv izvorni kôd.

---

## **Načrti za prihodnje izboljšave**
1. **Avtentikacija uporabnikov**:
    - Omogočanje prijave in shranjevanja priljubljenih receptov v uporabniški račun.

2. **Deljenje receptov**:
    - Omogočanje deljenja receptov na družbenih omrežjih.

3. **Način brez povezave**:
    - Predpomnjenje receptov za dostop brez internetne povezave.

4. **Napredni filtri**:
    - Dodajanje filtrov, kot so sestavine in prehranske preference.

5. **Lokalizacija**:
    - Podpora za več jezikov za globalno dostopnost.

---

Ta dokumentacija povzema razvoj aplikacije za upravljanje receptov in prihodnje izboljšave. Služi kot referenca za vse vključene deležnike.
