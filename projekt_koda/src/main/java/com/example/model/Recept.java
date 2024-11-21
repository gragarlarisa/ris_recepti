package com.example.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import java.util.Date;

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
    @JsonBackReference
    private VpisanUporabnik uporabnik;

    @ManyToOne
    @JoinColumn(name = "TK_Regionalna_Kuhinja", referencedColumnName = "ID_Regionalna_Kuhinja")
    private RegionalnaKuhinja regionalnaKuhinja;

    @ManyToOne
    @JoinColumn(name = "TK_Obrok", referencedColumnName = "ID_Obrok")
    private Obrok obrok;

    public Integer getIdRecept() {
        return idRecept;
    }

    public void setIdRecept(Integer idRecept) {
        this.idRecept = idRecept;
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

    // Getter in setter
    public VpisanUporabnik getUporabnik() {
        return uporabnik;
    }

    public void setUporabnik(VpisanUporabnik uporabnik) {
        this.uporabnik = uporabnik;
    }
}
