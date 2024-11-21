package com.example.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "Komentarji")
public class Komentarji {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Komentar")
    private Long id;

    @Column(name = "Vsebina", nullable = false)
    private String vsebina;

    @Column(name = "Datum", nullable = false)
    private LocalDateTime datum;

    @Column(name = "Ocena", nullable = false)
    private Integer ocena;

    @ManyToOne
    @JoinColumn(name = "TK_Recept", nullable = false)
    private Recept recept;

    @ManyToOne
    @JoinColumn(name = "TK_Vpisan_Uporabnik", nullable = false)
    private VpisanUporabnik uporabnik;

    // Getterji in setterji
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getVsebina() {
        return vsebina;
    }

    public void setVsebina(String vsebina) {
        this.vsebina = vsebina;
    }

    public LocalDateTime getDatum() {
        return datum;
    }

    public void setDatum(LocalDateTime datum) {
        this.datum = datum;
    }

    public Integer getOcena() {
        return ocena;
    }

    public void setOcena(Integer ocena) {
        this.ocena = ocena;
    }

    public Recept getRecept() {
        return recept;
    }

    public void setRecept(Recept recept) {
        this.recept = recept;
    }

    public VpisanUporabnik getUporabnik() {
        return uporabnik;
    }

    public void setUporabnik(VpisanUporabnik uporabnik) {
        this.uporabnik = uporabnik;
    }
}
