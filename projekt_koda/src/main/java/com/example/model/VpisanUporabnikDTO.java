package com.example.model;

public class VpisanUporabnikDTO {
    private Long id;
    private String ime;
    private String priimek;
    private String elektronskiNaslov;
    private boolean administrator;

    // Constructor
    public VpisanUporabnikDTO(Long id, String ime, String priimek, String elektronskiNaslov, boolean administrator) {
        this.id = id;
        this.ime = ime;
        this.priimek = priimek;
        this.elektronskiNaslov = elektronskiNaslov;
        this.administrator = administrator;
    }

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

    public boolean isAdministrator() {
        return administrator;
    }

    public void setAdministrator(boolean administrator) {
        this.administrator = administrator;
    }
}
