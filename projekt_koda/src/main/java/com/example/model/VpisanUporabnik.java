package com.example.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Vpisan_Uporabnik")
public class VpisanUporabnik {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Vpisan_Uporabnik")
    private Long id;

    @Column(name = "Ime", nullable = false)
    private String ime;

    @Column(name = "Priimek", nullable = false)
    private String priimek;

    @Column(name = "Elektronski_Naslov", nullable = false, unique = true)
    private String elektronskiNaslov;

    @Column(name = "Geslo", nullable = false)
    private String geslo;

    @Column(name = "Administrator", nullable = false)
    private Boolean administrator;

    @Column(name = "Avatar")
    private String avatar;

    @OneToMany(mappedBy = "uporabnik")
    @JsonIgnore // Prevents serialization of the 'recepti' field in the response
    private List<Recept> recepti;

    @OneToMany(mappedBy = "uporabnik", cascade = CascadeType.ALL)
    @JsonIgnore // Prevents serialization of 'komentarji' to avoid recursion
    private List<Komentarji> komentarji;

    // Getters and setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getIme() {
        return ime;
    }

    public void setIme(String ime) {
        this.ime = ime;
    }

    public String getPriimek() {
        return priimek;
    }

    public void setPriimek(String priimek) {
        this.priimek = priimek;
    }

    public String getElektronskiNaslov() {
        return elektronskiNaslov;
    }

    public void setElektronskiNaslov(String elektronskiNaslov) {
        this.elektronskiNaslov = elektronskiNaslov;
    }

    public String getGeslo() {
        return geslo;
    }

    public void setGeslo(String geslo) {
        this.geslo = geslo;
    }

    public Boolean getAdministrator() {
        return administrator;
    }

    public void setAdministrator(Boolean administrator) {
        this.administrator = administrator;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public List<Recept> getRecepti() {
        return recepti;
    }

    public void setRecepti(List<Recept> recepti) {
        this.recepti = recepti;
    }

}