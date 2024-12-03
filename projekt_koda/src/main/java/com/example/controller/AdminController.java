package com.example.controller;

import com.example.model.VpisanUporabnikDTO;
import com.example.service.VpisanUporabnikService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/admin")
public class AdminController {

    private final VpisanUporabnikService vpisanUporabnikService;

    public AdminController(VpisanUporabnikService vpisanUporabnikService) {
        this.vpisanUporabnikService = vpisanUporabnikService;
    }

    // Endpoint for getting the list of users
    @GetMapping("/users")
    public ResponseEntity<List<VpisanUporabnikDTO>> getUsers() {
        List<VpisanUporabnikDTO> usersDTO = vpisanUporabnikService.findAll().stream()
                .map(user -> new VpisanUporabnikDTO(
                        user.getId(),
                        user.getIme(),
                        user.getPriimek(),
                        user.getElektronskiNaslov(),
                        user.getAdministrator()))
                .collect(Collectors.toList());

        return ResponseEntity.ok(usersDTO);
    }
}
