
package com.example.service;

import com.example.model.Recept;
import com.example.model.ReceptSestavine;
import com.example.model.Sestavine;
import com.example.model.KorakPostopka;
import com.example.repository.ReceptRepository;
import com.example.repository.SestavineRepository;
import com.example.repository.KorakPostopkaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class ReceptService {

    private final ReceptRepository receptRepository;
    private final SestavineRepository sestavineRepository;
    private final KorakPostopkaRepository korakPostopkaRepository;

    @Autowired
    public ReceptService(ReceptRepository receptRepository, 
                         SestavineRepository sestavineRepository, 
                         KorakPostopkaRepository korakPostopkaRepository) {
        this.receptRepository = receptRepository;
        this.sestavineRepository = sestavineRepository;
        this.korakPostopkaRepository = korakPostopkaRepository;
    }

    // Shranjevanje recepta
    public Recept save(Recept recept) {
        return receptRepository.save(recept);
    }

    // Shranjevanje sestavine
    public Sestavine saveSestavina(Sestavine sestavina) {
        return sestavineRepository.save(sestavina);
    }

    // Shranjevanje koraka postopka
    public KorakPostopka saveKorak(KorakPostopka korak) {
        return korakPostopkaRepository.save(korak);
    }

    public List<Recept> findAll() {
        return receptRepository.findAll();
    }

    public Optional<Recept> findById(Integer id) {
        return receptRepository.findById(id);
    }

    public void deleteById(Integer id) {
        receptRepository.deleteById(id);
    }
    public List<Map<String, Object>> generateShoppingList(List<Integer> receptIds, int steviloOseb) {
        List<Recept> recepti = receptRepository.findAllById(receptIds);

        // Mapa za združevanje količin sestavin
        Map<String, Double> shoppingMap = new HashMap<>();

        // Združevanje sestavin in prilagajanje količin
        for (Recept recept : recepti) {
            for (ReceptSestavine sestavina : recept.getSestavine()) {
                double prilagojenaKolicina = sestavina.getKolicina() * (steviloOseb / (double) recept.getSteviloOseb());
                shoppingMap.merge(sestavina.getNaziv(), prilagojenaKolicina, Double::sum);
            }
        }

        // Pretvorba v seznam map s pravilnimi tipi
        return shoppingMap.entrySet().stream()
                .map(entry -> {
                    Map<String, Object> sestavinaMap = new HashMap<>();
                    sestavinaMap.put("imeSestavine", entry.getKey());
                    sestavinaMap.put("kolicina", entry.getValue());
                    return sestavinaMap;
                })
                .collect(Collectors.toList());
    }




}