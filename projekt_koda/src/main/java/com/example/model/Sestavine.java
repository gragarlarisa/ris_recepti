package com.example.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Sestavine")
public class Sestavine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Sestavine")
    private Long id;

    @Column(name = "Naziv", nullable = false)
    private String naziv;

    @Column(name = "Kolicina")
    private Integer kolicina;

    @Column(name = "Enota")
    private String enota;

    @OneToMany(mappedBy = "sestavine", cascade = CascadeType.ALL)
    private List<ReceptSestavine> receptSestavine;

    // Getterji in setterji
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

    public Integer getKolicina() {
        return kolicina;
    }

    public void setKolicina(Integer kolicina) {
        this.kolicina = kolicina;
    }

    public String getEnota() {
        return enota;
    }

    public void setEnota(String enota) {
        this.enota = enota;
    }

    public List<ReceptSestavine> getReceptSestavine() {
        return receptSestavine;
    }

    public void setReceptSestavine(List<ReceptSestavine> receptSestavine) {
        this.receptSestavine = receptSestavine;
    }
}
