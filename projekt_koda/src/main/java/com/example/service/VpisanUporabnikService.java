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
}
