package com.example.controller;

import com.example.model.Recept;
import com.example.service.ReceptService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/recepti")
public class ReceptController {
    private final ReceptService receptService;

    public ReceptController(ReceptService receptService) {
        this.receptService = receptService;
    }

    @GetMapping
    public ResponseEntity<List<Recept>> getAllRecepti() {
        return ResponseEntity.ok(receptService.findAll());
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
