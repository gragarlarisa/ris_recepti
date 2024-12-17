package com.example.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import java.util.List;

@Entity
public class RegionalnaKuhinja {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Regionalna_Kuhinja")
    private Long id;

    private String naziv;

    @OneToMany(mappedBy = "regionalnaKuhinja")
    @JsonIgnore
    private List<Recept> recepti;

    // Privzeti konstruktor
    public RegionalnaKuhinja() {
    }

    // Konstruktor, ki sprejme String (če potrebujete)
    public RegionalnaKuhinja(String naziv) {
        this.naziv = naziv;
    }

    // Getterji in Setterji
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNaziv() {
        return naziv;
    }

    public void setNaziv(String naziv) {
        this.naziv = naziv;
    }

    public List<Recept> getRecepti() {
        return recepti;
    }

    public void setRecepti(List<Recept> recepti) {
        this.recepti = recepti;
    }
}
