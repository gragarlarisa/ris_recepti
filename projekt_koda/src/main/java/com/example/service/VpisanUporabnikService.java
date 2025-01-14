package com.example.service;

import com.example.model.VpisanUporabnik;
import com.example.repository.VpisanUporabnikRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class VpisanUporabnikService {

    private final VpisanUporabnikRepository vpisanUporabnikRepository;

    public VpisanUporabnikService(VpisanUporabnikRepository vpisanUporabnikRepository) {
        this.vpisanUporabnikRepository = vpisanUporabnikRepository;
    }

    public List<VpisanUporabnik> findAll() {
        return vpisanUporabnikRepository.findAll();
    }

    public Optional<VpisanUporabnik> findById(Long id) {
        return vpisanUporabnikRepository.findById(id);
    }

    public VpisanUporabnik save(VpisanUporabnik uporabnik) {
        return vpisanUporabnikRepository.save(uporabnik);
    }

    public void deleteById(Long id) {
        vpisanUporabnikRepository.deleteById(id);
    }
    public String registrirajUporabnika(VpisanUporabnik uporabnik) {
        // Preveri, če uporabnik z tem e-naslovom že obstaja
        Optional<VpisanUporabnik> obstoječiUporabnik = vpisanUporabnikRepository.findByElektronskiNaslov(uporabnik.getElektronskiNaslov());
        if (obstoječiUporabnik.isPresent()) {
            return "E-naslov že obstaja";
        }
    
        // Shrani novega uporabnika v bazo
        vpisanUporabnikRepository.save(uporabnik);
        return "Uspešna registracija";
    }
    
    // Validate user by email and password
    public Optional<VpisanUporabnik> validateUser(String email, String password) {
        return vpisanUporabnikRepository.findAll()
                .stream()
                .filter(user -> user.getElektronskiNaslov().equals(email) && user.getGeslo().equals(password))
                .findFirst();
    }

    // Validate admin user by email and password
    public Optional<VpisanUporabnik> validateAdmin(String email, String password) {
        return vpisanUporabnikRepository.findAll()
                .stream()
                .filter(user -> user.getElektronskiNaslov().equals(email)
                        && user.getGeslo().equals(password)
                        && user.getAdministrator() != null
                        && user.getAdministrator()) // Checks if the user is an administrator
                .findFirst();
    }

    // Dodana metoda za pronalaženje korisnika po emailu
    public Optional<VpisanUporabnik> findByUsername(String email) {
        return vpisanUporabnikRepository.findByElektronskiNaslov(email);
    }
}
