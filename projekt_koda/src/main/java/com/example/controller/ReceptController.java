package com.example.controller;

import com.example.model.Recept;
import com.example.service.ReceptService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
            map.put("opis", recept.getOpis());
            map.put("slika", recept.getSlika());
            map.put("pripravaMinute", recept.getPripravaMinute());
            map.put("steviloOseb", recept.getSteviloOseb());
            map.put("tezavnost", recept.getTezavnost());
            map.put("datumObjave", recept.getDatumObjave());
            map.put("obrok", recept.getObrok() != null ? recept.getObrok().getNaziv() : null);
            return map;
        }).collect(Collectors.toList());

        return ResponseEntity.ok(simplifiedRecepti);
    }


    @GetMapping("/{id}")
    public ResponseEntity<Recept> getReceptById(@PathVariable Long id) {
        return receptService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Recept> createRecept(@RequestBody Recept recept) {
        return ResponseEntity.ok(receptService.save(recept));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRecept(@PathVariable Long id) {
        receptService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
