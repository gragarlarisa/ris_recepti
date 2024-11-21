package com.example.service;

import com.example.model.Sestavine;
import com.example.repository.SestavineRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SestavineService {

    private final SestavineRepository sestavineRepository;

    public SestavineService(SestavineRepository sestavineRepository) {
        this.sestavineRepository = sestavineRepository;
    }

    public List<Sestavine> findAll() {
        return sestavineRepository.findAll();
    }

    public Optional<Sestavine> findById(Long id) {
        return sestavineRepository.findById(id);
    }

    public Sestavine save(Sestavine sestavina) {
        return sestavineRepository.save(sestavina);
    }

    public void deleteById(Long id) {
        sestavineRepository.deleteById(id);
    }
}
