package com.example.model;

import com.example.model.Recept;
import jakarta.persistence.*;

@Entity
@Table(name = "Korak_Postopka")
public class KorakPostopka {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Korak_Postopka")
    private Long id;

    @Column(name = "Postopek", nullable = false)
    private String postopek;

    @Column(name = "St_Koraka")
    private Integer stKoraka;

    @ManyToOne
    @JoinColumn(name = "TK_Recept", nullable = false)
    private Recept recept;

    // Getterji in setterji
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPostopek() {
        return postopek;
    }

    public void setPostopek(String postopek) {
        this.postopek = postopek;
    }

    public Integer getStKoraka() {
        return stKoraka;
    }

    public void setStKoraka(Integer stKoraka) {
        this.stKoraka = stKoraka;
    }

    public Recept getRecept() {
        return recept;
    }

    public void setRecept(Recept recept) {
        this.recept = recept;
    }
}
