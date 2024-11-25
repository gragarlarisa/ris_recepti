package com.example.controller;

import com.example.model.VpisanUporabnik;
import com.example.service.VpisanUporabnikService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;
import java.util.Map;

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

    // New endpoint for login
    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(@RequestBody Map<String, String> loginData) {
        String email = loginData.get("email");
        String password = loginData.get("password");

        Optional<VpisanUporabnik> user = vpisanUporabnikService.validateUser(email, password);

        if (user.isPresent()) {
            VpisanUporabnik loggedInUser = user.get();
            Map<String, String> response = new HashMap<>();
            if (loggedInUser.getAdministrator()) {
                response.put("redirect", "admin.html");
            } else {
                response.put("redirect", "index.html");
            }
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.status(401).body(Map.of("error", "Invalid email or password"));
        }
    }
}
