/*package com.example.controller;

import com.example.model.Komentarji;
import com.example.service.KomentarjiService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/komentarji")
public class KomentarjiController {

    private final KomentarjiService komentarjiService;

    public KomentarjiController(KomentarjiService komentarjiService) {
        this.komentarjiService = komentarjiService;
    }

    @GetMapping
    public ResponseEntity<List<Komentarji>> getAllKomentarji() {
        return ResponseEntity.ok(komentarjiService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Komentarji> getKomentarById(@PathVariable Long id) {
        return komentarjiService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Komentarji> createKomentar(@RequestBody Komentarji komentar) {
        return ResponseEntity.ok(komentarjiService.save(komentar));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteKomentar(@PathVariable Long id) {
        komentarjiService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}*/
