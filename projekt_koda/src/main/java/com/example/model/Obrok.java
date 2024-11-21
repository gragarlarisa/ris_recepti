package com.example.model;

import jakarta.persistence.*;

@Entity
public class Obrok {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Obrok")
    private Long id;

    @Column(name = "Naziv")
    private String naziv;

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
}
