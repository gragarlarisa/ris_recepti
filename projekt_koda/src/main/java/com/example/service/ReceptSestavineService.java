package com.example.service;

import com.example.model.ReceptSestavine;
import com.example.repository.ReceptSestavineRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReceptSestavineService {

    private final ReceptSestavineRepository receptSestavineRepository;

    public ReceptSestavineService(ReceptSestavineRepository receptSestavineRepository) {
        this.receptSestavineRepository = receptSestavineRepository;
    }

    public List<ReceptSestavine> findAll() {
        return receptSestavineRepository.findAll();
    }

    public Optional<ReceptSestavine> findById(Long id) {
        return receptSestavineRepository.findById(id);
    }

    public ReceptSestavine save(ReceptSestavine receptSestavine) {
        return receptSestavineRepository.save(receptSestavine);
    }

    public void deleteById(Long id) {
        receptSestavineRepository.deleteById(id);
    }
}
