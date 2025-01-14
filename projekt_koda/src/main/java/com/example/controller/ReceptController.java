package com.example.controller;

import com.example.model.*;
import com.example.repository.*;
import com.example.service.ReceptService;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/recepti")
public class ReceptController {

    private final ReceptService receptService;
    private final SestavineRepository sestavineRepository;
    private final ReceptSestavineRepository receptSestavineRepository;
    private final ObrokRepository obrokRepository;
    private final RegionalnaKuhinjaRepository regionalnaKuhinjaRepository;
    private final ReceptRepository receptRepository;

    @Autowired
    public ReceptController(ReceptService receptService,
                            SestavineRepository sestavineRepository,
                            ReceptSestavineRepository receptSestavineRepository,
                            ObrokRepository obrokRepository,
                            RegionalnaKuhinjaRepository regionalnaKuhinjaRepository,
                            ReceptRepository receptRepository) {
        this.receptService = receptService;
        this.sestavineRepository = sestavineRepository;
        this.receptSestavineRepository = receptSestavineRepository;
        this.obrokRepository = obrokRepository;
        this.regionalnaKuhinjaRepository = regionalnaKuhinjaRepository;
        this.receptRepository = receptRepository;
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
            map.put("priljubljeni", false); // Privzeto polje za priljubljenost
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
                            .map(korak -> korak.getPostopek())
                            .toList();
                    receptDetails.put("koraki", korakiFormatted);

                    return ResponseEntity.ok(receptDetails);
                })
                .orElse(ResponseEntity.notFound().build());
    }

 @GetMapping("/priporoceni")
public ResponseEntity<List<Map<String, Object>>> getRecommendedRecipes(@RequestParam("ogledaneSestavine") String ogledaneSestavineParam) {
    // 1. Preverimo, ali imamo seznam sestavin ali samo eno
    List<String> ogledaneSestavine;
    try {
        // Poskusimo parsirati, če gre za seznam sestavin
        ogledaneSestavine = new ObjectMapper().readValue(ogledaneSestavineParam, List.class);
    } catch (Exception e) {
        // Če ni seznam, potem obravnavamo kot eno sestavino
        ogledaneSestavine = Collections.singletonList(ogledaneSestavineParam);
    }
    
    // 2. Poiščemo najpogostejše sestavine v poslanem seznamu
    List<String> mostFrequentIngredients = getMostFrequentIngredients(ogledaneSestavine);

    if (mostFrequentIngredients.isEmpty()) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
    }

    // 3. Poiščemo recepte, ki vsebujejo vsaj eno izmed najpogostejših sestavin
    List<Recept> recommendedRecepti = receptService.findAll().stream()
            .filter(recept -> containsAnyIngredient(recept, mostFrequentIngredients))
            .collect(Collectors.toList());

    // Omejimo število priporočil na 6
    recommendedRecepti = recommendedRecepti.stream()
            .limit(10)
            .collect(Collectors.toList());

    // 4. Pretvorimo filtrirane recepte v želeni odgovor
    List<Map<String, Object>> simplifiedRecepti = recommendedRecepti.stream().map(recept -> {
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

private List<String> getMostFrequentIngredients(List<String> ogledaneSestavine) {
    Map<String, Long> ingredientFrequency = ogledaneSestavine.stream()
            .collect(Collectors.groupingBy(ingredient -> ingredient, Collectors.counting()));

    Long maxFrequency = ingredientFrequency.values().stream()
            .max(Long::compare).orElse(0L);

    return ingredientFrequency.entrySet().stream()
            .filter(entry -> entry.getValue().equals(maxFrequency))
            .map(Map.Entry::getKey)
            .collect(Collectors.toList());
}

private boolean containsAnyIngredient(Recept recept, List<String> ingredients) {
    return recept.getSestavine().stream()
            .anyMatch(sestavina -> ingredients.contains(sestavina.getNaziv().toLowerCase()));
}
    @PostMapping
    public ResponseEntity<Recept> createRecept(@RequestBody Recept recept) {
        return ResponseEntity.ok(receptService.save(recept));
    }

    @PostMapping("/dodaj")
    public ResponseEntity<Recept> addRecept(@RequestBody Map<String, Object> receptRequest) {
        try {
            // Ustvari osnovne podatke za recept
            Recept recept = new Recept();
            recept.setNaziv((String) receptRequest.get("naziv"));
            recept.setOpis((String) receptRequest.get("opis"));
            recept.setSlika((String) receptRequest.get("slika"));
            recept.setPripravaMinute((Integer) receptRequest.get("pripravaMinute"));
            recept.setSteviloOseb((Integer) receptRequest.get("steviloOseb"));
            recept.setTezavnost((Integer) receptRequest.get("tezavnost"));
            recept.setJaven((Boolean) receptRequest.getOrDefault("javen", false));
        
            // Nastavite obvezna polja
            Integer obrokId = (Integer) receptRequest.get("obrok");
            if (obrokId == null) {
                throw new IllegalArgumentException("Manjkajoča vrednost za polje obrok!");
            }
        
            // Poiščite entiteto Obrok v bazi podatkov
            Obrok obrok = obrokRepository.findById(obrokId)
                    .orElseThrow(() -> new IllegalArgumentException("Obrok z ID-jem " + obrokId + " ne obstaja!"));
    
            // Nastavite obrok v recept
            recept.setObrok(obrok);
    
            // Poiščite entiteto RegionalnaKuhinja v bazi podatkov (če obstaja)
            Integer regionalnaKuhinjaId = (Integer) receptRequest.get("regionalnaKuhinja");
            if (regionalnaKuhinjaId != null) {
                RegionalnaKuhinja regionalnaKuhinja = regionalnaKuhinjaRepository.findById(regionalnaKuhinjaId)
                        .orElseThrow(() -> new IllegalArgumentException("Regionalna kuhinja z ID-jem " + regionalnaKuhinjaId + " ne obstaja!"));
                recept.setRegionalnaKuhinja(regionalnaKuhinja);
            }
    
            // Nastavite ostale privzete vrednosti
            recept.setDatumObjave(new Date());
            recept.setDatumZadnjeSpremembe(new Date());
        
            // Shranimo recept
            Recept savedRecept = receptService.save(recept);
        
            return ResponseEntity.ok(savedRecept);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }
    
    
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

        // Validate input data
        if (receptIds == null || steviloOseb == null) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", "Invalid input"));
        }

        Map<String, Double> shoppingList = new HashMap<>();
        for (Integer receptId : receptIds) {
            Recept recept = receptRepository.findById(receptId).orElseThrow(() -> new RuntimeException("Recept not found"));

            for (ReceptSestavine receptSestavine : recept.getSestavine()) {
                String sestavinaName = receptSestavine.getSestavine().getNaziv();
                double kolicina = receptSestavine.getKolicina() * steviloOseb;

                shoppingList.put(sestavinaName, shoppingList.getOrDefault(sestavinaName, 0.0) + kolicina);
            }
        }

        return ResponseEntity.ok(Collections.singletonMap("shoppingList", shoppingList));
    }

    @PostMapping("/favorites")
    public ResponseEntity<List<Map<String, Object>>> getFavoriteRecipes(@RequestBody List<Integer> favoriteIds) {
        List<Recept> favoriteRecepti = receptService.findAll().stream()
                .filter(recept -> favoriteIds.contains(recept.getIdRecept()))
                .collect(Collectors.toList());

        List<Map<String, Object>> simplifiedRecepti = favoriteRecepti.stream().map(recept -> {
            Map<String, Object> map = new HashMap<>();
            map.put("idRecept", recept.getIdRecept());
            map.put("naziv", recept.getNaziv());
            map.put("pripravaMinute", recept.getPripravaMinute());
            map.put("steviloOseb", recept.getSteviloOseb());
            map.put("tezavnost", recept.getTezavnost());
            map.put("slika", recept.getSlika());
            return map;
        }).collect(Collectors.toList());

        return ResponseEntity.ok(simplifiedRecepti);
    }

}
