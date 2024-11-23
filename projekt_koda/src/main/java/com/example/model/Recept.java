package com.example.model;

import com.example.model.*;
import jakarta.persistence.*;

import java.util.Date;
import java.util.List;

@Entity
public class Recept {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idRecept;

    private String naziv;
    private String opis;
    private String slika;
    private Integer pripravaMinute;
    private Integer steviloOseb;
    private Integer tezavnost;
    private Boolean javen;
    private Date datumObjave;
    private Date datumZadnjeSpremembe;

    @ManyToOne
    @JoinColumn(name = "TK_Vpisan_Uporabnik", referencedColumnName = "ID_Vpisan_Uporabnik")
    private VpisanUporabnik uporabnik;

    @ManyToOne
    @JoinColumn(name = "TK_Regionalna_Kuhinja", referencedColumnName = "ID_Regionalna_Kuhinja")
    private RegionalnaKuhinja regionalnaKuhinja;

    @ManyToOne
    @JoinColumn(name = "TK_Obrok", referencedColumnName = "ID_Obrok")
    private Obrok obrok;

    @OneToMany(mappedBy = "recept", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<KorakPostopka> koraki;

    @OneToMany(mappedBy = "recept", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<KategorijaSkupno> prehranskeOmejitve;

    public Integer getIdRecept() {
        return idRecept;
    }



    public void setIdRecept(Integer idRecept) {
        this.idRecept = idRecept;
    }

    public String getNaziv() {
        return naziv;
    }

    public void setNaziv(String naziv) {
        this.naziv = naziv;
    }

    public String getOpis() {
        return opis;
    }

    public void setOpis(String opis) {
        this.opis = opis;
    }

    public String getSlika() {
        return slika;
    }

    public void setSlika(String slika) {
        this.slika = slika;
    }

    public Integer getPripravaMinute() {
        return pripravaMinute;
    }

    public void setPripravaMinute(Integer pripravaMinute) {
        this.pripravaMinute = pripravaMinute;
    }

    public Integer getSteviloOseb() {
        return steviloOseb;
    }

    public void setSteviloOseb(Integer steviloOseb) {
        this.steviloOseb = steviloOseb;
    }

    public Integer getTezavnost() {
        return tezavnost;
    }

    public void setTezavnost(Integer tezavnost) {
        this.tezavnost = tezavnost;
    }

    public Boolean getJaven() {
        return javen;
    }

    public void setJaven(Boolean javen) {
        this.javen = javen;
    }

    public Date getDatumObjave() {
        return datumObjave;
    }

    public void setDatumObjave(Date datumObjave) {
        this.datumObjave = datumObjave;
    }

    public Date getDatumZadnjeSpremembe() {
        return datumZadnjeSpremembe;
    }

    public void setDatumZadnjeSpremembe(Date datumZadnjeSpremembe) {
        this.datumZadnjeSpremembe = datumZadnjeSpremembe;
    }

    public VpisanUporabnik getUporabnik() {
        return uporabnik;
    }

    public void setUporabnik(VpisanUporabnik uporabnik) {
        this.uporabnik = uporabnik;
    }

    public RegionalnaKuhinja getRegionalnaKuhinja() {
        return regionalnaKuhinja;
    }

    public void setRegionalnaKuhinja(RegionalnaKuhinja regionalnaKuhinja) {
        this.regionalnaKuhinja = regionalnaKuhinja;
    }

    public Obrok getObrok() {
        return obrok;
    }

    public void setObrok(Obrok obrok) {
        this.obrok = obrok;
    }



    // Getter and Setter
    public List<KorakPostopka> getKoraki() {
        return koraki;
    }

    public void setKoraki(List<KorakPostopka> koraki) {
        this.koraki = koraki;
    }



    @OneToMany(mappedBy = "recept", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ReceptSestavine> sestavine;

    public List<ReceptSestavine> getSestavine() {
        return sestavine;
    }

    public void setSestavine(List<ReceptSestavine> sestavine) {
        this.sestavine = sestavine;
    }


    public List<KategorijaSkupno> getPrehranskeOmejitve() {
        return prehranskeOmejitve;
    }

    public void setPrehranskeOmejitve(List<KategorijaSkupno> prehranskeOmejitve) {
        this.prehranskeOmejitve = prehranskeOmejitve;
    }
}
