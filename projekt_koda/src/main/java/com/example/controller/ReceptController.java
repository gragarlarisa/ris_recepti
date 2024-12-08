package com.example.controller;

import com.example.model.Recept;
import com.example.model.KorakPostopka;
import com.example.model.Sestavine;
import com.example.repository.ReceptRepository;
import com.example.service.ReceptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/recepti")
public class ReceptController {
    private final ReceptService receptService;

    public ReceptController(ReceptService receptService) {
        this.receptService = receptService;
    }

    @GetMapping
    public ResponseEntity<List<Map<String, Object>>> getAllRecepti() {
        List<Recept> recepti = receptService.findAll();
        List<Map<String, Object>> simplifiedRecepti = recepti.stream().map(recept -> {
            Map<String, Object> map = new HashMap<>();
            map.put("idRecept", recept.getIdRecept());
            map.put("naziv", recept.getNaziv());
            map.put("pripravaMinute", recept.getPripravaMinute());
            map.put("steviloOseb", recept.getSteviloOseb());
            map.put("tezavnost", recept.getTezavnost());
            map.put("obrok", recept.getObrok() != null ? Map.of("naziv", recept.getObrok().getNaziv()) : null);
            map.put("slika", recept.getSlika());
            return map;
        }).collect(Collectors.toList());

        return ResponseEntity.ok(simplifiedRecepti);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Map<String, Object>> getReceptDetails(@PathVariable Integer id) {
        return receptService.findById(id)
                .map(recept -> {
                    Map<String, Object> receptDetails = new HashMap<>();
                    receptDetails.put("idRecept", recept.getIdRecept());
                    receptDetails.put("naziv", recept.getNaziv());
                    receptDetails.put("opis", recept.getOpis());
                    receptDetails.put("slika", recept.getSlika());

                    // Format ingredients
                    List<String> sestavineFormatted = recept.getSestavine().stream()
                            .map(rs -> {
                                String kolicinaEnota = (rs.getKolicina() != null ? rs.getKolicina() + " " : "") +
                                        (rs.getEnota() != null ? rs.getEnota() + " " : "");
                                return kolicinaEnota + rs.getNaziv();
                            })
                            .toList();
                    receptDetails.put("sestavine", sestavineFormatted);

                    // Format steps (koraki)
                    List<String> korakiFormatted = recept.getKoraki().stream()
                            .sorted(Comparator.comparingInt(KorakPostopka::getStKoraka)) // Sort steps by step number
                            .map(korak -> {
                                // Check and log any missing or null values
                                System.out.println(
                                        " | Step: " + korak.getPostopek());
                                return korak.getPostopek();
                            })
                            .toList();
                    receptDetails.put("koraki", korakiFormatted);

                    return ResponseEntity.ok(receptDetails);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    // API to create a recipe
    @PostMapping
    public ResponseEntity<Recept> createRecept(@RequestBody Recept recept) {
        return ResponseEntity.ok(receptService.save(recept));
    }

    // API to delete a recipe
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRecept(@PathVariable Integer id) {
        receptService.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/seznam-nakupov")
    public ResponseEntity<Map<String, Object>> generateShoppingList(@RequestBody Map<String, Object> requestBody) {
        @SuppressWarnings("unchecked")
        List<Integer> receptIds = (List<Integer>) requestBody.get("receptIds");
        Integer steviloOseb = (Integer) requestBody.get("steviloOseb");

        // Validacija vhodnih podatkov
        if (receptIds == null || steviloOseb == null || steviloOseb <= 0) {
            return ResponseEntity.badRequest().body(Map.of("error", "Neveljavni podatki v zahtevi"));
        }

        // Klic metode iz servisa
        List<Map<String, Object>> seznamNakupov = receptService.generateShoppingList(receptIds, steviloOseb);

        // Oblikovanje odgovora
        return ResponseEntity.ok(Map.of("seznamNakupov", seznamNakupov));
    }
            @Autowired
        private ReceptRepository receptRepository;

        @GetMapping("/seznam")
        public List<Recept> vrniSeznam() {
            // Vrnite vse recepte iz baze
            return receptRepository.findAll();
        }
    }



