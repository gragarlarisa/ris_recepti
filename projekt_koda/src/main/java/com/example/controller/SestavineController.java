package com.example.controller;

import com.example.model.Sestavine;
import com.example.service.SestavineService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/sestavine")
public class SestavineController {

    private final SestavineService sestavineService;

    public SestavineController(SestavineService sestavineService) {
        this.sestavineService = sestavineService;
    }

    @GetMapping
    public ResponseEntity<List<Sestavine>> getAllSestavine() {
        return ResponseEntity.ok(sestavineService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Sestavine> getSestavineById(@PathVariable Long id) {
        return sestavineService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Sestavine> createSestavine(@RequestBody Sestavine sestavina) {
        return ResponseEntity.ok(sestavineService.save(sestavina));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSestavine(@PathVariable Long id) {
        sestavineService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
