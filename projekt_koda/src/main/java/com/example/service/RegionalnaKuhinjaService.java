package com.example.service;

import com.example.model.RegionalnaKuhinja;
import com.example.repository.RegionalnaKuhinjaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RegionalnaKuhinjaService {

    private final RegionalnaKuhinjaRepository regionalnaKuhinjaRepository;

    public RegionalnaKuhinjaService(RegionalnaKuhinjaRepository regionalnaKuhinjaRepository) {
        this.regionalnaKuhinjaRepository = regionalnaKuhinjaRepository;
    }

    public List<RegionalnaKuhinja> findAll() {
        return regionalnaKuhinjaRepository.findAll();
    }

    public Optional<RegionalnaKuhinja> findById(Integer id) {
        return regionalnaKuhinjaRepository.findById(id);
    }

    public RegionalnaKuhinja save(RegionalnaKuhinja regionalnaKuhinja) {
        return regionalnaKuhinjaRepository.save(regionalnaKuhinja);
    }

    public void deleteById(Integer id) {
        regionalnaKuhinjaRepository.deleteById(id);
    }
}
