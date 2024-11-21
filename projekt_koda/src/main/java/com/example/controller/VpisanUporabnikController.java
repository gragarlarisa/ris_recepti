package com.example.controller;

import com.example.model.VpisanUporabnik;
import com.example.service.VpisanUporabnikService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/uporabniki")
public class VpisanUporabnikController {

    private final VpisanUporabnikService vpisanUporabnikService;

    public VpisanUporabnikController(VpisanUporabnikService vpisanUporabnikService) {
        this.vpisanUporabnikService = vpisanUporabnikService;
    }

    @GetMapping
    public ResponseEntity<List<VpisanUporabnik>> getAllUporabniki() {
        return ResponseEntity.ok(vpisanUporabnikService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<VpisanUporabnik> getUporabnikById(@PathVariable Long id) {
        return vpisanUporabnikService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<VpisanUporabnik> createUporabnik(@RequestBody VpisanUporabnik uporabnik) {
        return ResponseEntity.ok(vpisanUporabnikService.save(uporabnik));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUporabnik(@PathVariable Long id) {
        vpisanUporabnikService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
