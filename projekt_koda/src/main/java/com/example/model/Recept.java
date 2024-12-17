package com.example.model;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Recept")
public class Recept {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Recept")
    private Integer idRecept;

    @Column(name = "Naziv", nullable = false, length = 255)
    private String naziv;

    @Column(name = "Opis", nullable = false, columnDefinition = "TEXT")
    private String opis;

    @Column(name = "Slika", nullable = false, columnDefinition = "TEXT")
    private String slika;

    @Column(name = "Priprava_Minute", nullable = false)
    private Integer pripravaMinute;

    @Column(name = "Stevilo_Oseb", nullable = false)
    private Integer steviloOseb;

    @Column(name = "Tezavnost", nullable = false)
    private Integer tezavnost;

    @Column(name = "Javen", nullable = false)
    private Boolean javen;

    @Column(name = "Datum_Objave")
    private Date datumObjave;

    @Column(name = "Datum_Zadnje_Spremembe")
    private Date datumZadnjeSpremembe;

    @ManyToOne
    @JoinColumn(name = "TK_Vpisan_Uporabnik", referencedColumnName = "ID_Vpisan_Uporabnik", nullable = true)
    private VpisanUporabnik uporabnik;

    @ManyToOne
    @JoinColumn(name = "TK_Regionalna_Kuhinja", referencedColumnName = "ID_Regionalna_Kuhinja", nullable = true)
    private RegionalnaKuhinja regionalnaKuhinja;

    @ManyToOne
    @JoinColumn(name = "TK_Obrok", referencedColumnName = "ID_Obrok", nullable = false)
    private Obrok obrok;

    @OneToMany(mappedBy = "recept", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<KorakPostopka> koraki;    

    @OneToMany(mappedBy = "recept", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<KategorijaSkupno> prehranskeOmejitve;

    @OneToMany(mappedBy = "recept", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ReceptSestavine> sestavine;
    

    // Constructors
    public Recept() {}

    public Recept(String naziv, String opis, String slika, Integer pripravaMinute, Integer steviloOseb, Integer tezavnost, Boolean javen, Date datumObjave, Date datumZadnjeSpremembe) {
        this.naziv = naziv;
        this.opis = opis;
        this.slika = slika;
        this.pripravaMinute = pripravaMinute;
        this.steviloOseb = steviloOseb;
        this.tezavnost = tezavnost;
        this.javen = javen;
        this.datumObjave = datumObjave;
        this.datumZadnjeSpremembe = datumZadnjeSpremembe;
    }

    // Getters and Setters
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

    public List<KorakPostopka> getKoraki() {
        return koraki;
    }

    public void setKoraki(List<KorakPostopka> koraki) {
        this.koraki = koraki;
    }

    public List<KategorijaSkupno> getPrehranskeOmejitve() {
        return prehranskeOmejitve;
    }

    public void setPrehranskeOmejitve(List<KategorijaSkupno> prehranskeOmejitve) {
        this.prehranskeOmejitve = prehranskeOmejitve;
    }

    public List<ReceptSestavine> getSestavine() {
        return sestavine;
    }

    public void setSestavine(List<ReceptSestavine> sestavine) {
        this.sestavine = sestavine;
    }
}