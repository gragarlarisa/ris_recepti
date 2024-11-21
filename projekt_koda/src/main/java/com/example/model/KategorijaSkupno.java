package com.example.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Kategorija_Skupno")
public class KategorijaSkupno {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Kategorija_Skupno")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "TK_Recept", nullable = false)
    private Recept recept;

    @ManyToOne
    @JoinColumn(name = "TK_Prehranske_Omejitve", nullable = false)
    private PrehranskeOmejitve prehranskeOmejitve;

    // Getterji in setterji
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Recept getRecept() {
        return recept;
    }

    public void setRecept(Recept recept) {
        this.recept = recept;
    }

    public PrehranskeOmejitve getPrehranskeOmejitve() {
        return prehranskeOmejitve;
    }

    public void setPrehranskeOmejitve(PrehranskeOmejitve prehranskeOmejitve) {
        this.prehranskeOmejitve = prehranskeOmejitve;
    }
}
