package com.example.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Prehranske_Omejitve")
public class PrehranskeOmejitve {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Prehranske_Omejitve")
    private Long id;

    @Column(name = "Naziv", nullable = false)
    private String naziv;

    @OneToMany(mappedBy = "prehranskeOmejitve", cascade = CascadeType.ALL)
    private List<KategorijaSkupno> kategorijaSkupno;

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

    public List<KategorijaSkupno> getKategorijaSkupno() {
        return kategorijaSkupno;
    }

    public void setKategorijaSkupno(List<KategorijaSkupno> kategorijaSkupno) {
        this.kategorijaSkupno = kategorijaSkupno;
    }
}
