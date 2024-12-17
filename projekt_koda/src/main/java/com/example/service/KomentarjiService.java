package com.example.service;

import com.example.model.Komentarji;
import com.example.repository.KomentarjiRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class KomentarjiService {

    private final KomentarjiRepository komentarjiRepository;

    public KomentarjiService(KomentarjiRepository komentarjiRepository) {
        this.komentarjiRepository = komentarjiRepository;
    }

    public List<Komentarji> findAll() {
        return komentarjiRepository.findAll();
    }

    public Optional<Komentarji> findById(Integer id) {
        return komentarjiRepository.findById(id);
    }

    public Komentarji save(Komentarji komentar) {
        return komentarjiRepository.save(komentar);
    }

    public void deleteById(Integer  id) {
        komentarjiRepository.deleteById(id);
    }
}
