
package com.example.service;

import com.example.model.Recept;
import com.example.repository.ReceptRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReceptService {
    private final ReceptRepository receptRepository;

    public ReceptService(ReceptRepository receptRepository) {
        this.receptRepository = receptRepository;
    }

    public List<Recept> findAll() {
        return receptRepository.findAll();
    }

    public Optional<Recept> findById(Long id) {
        return receptRepository.findById(id);
    }

    public Recept save(Recept recept) {
        return receptRepository.save(recept);
    }

    public void deleteById(Long id) {
        receptRepository.deleteById(id);
    }
}