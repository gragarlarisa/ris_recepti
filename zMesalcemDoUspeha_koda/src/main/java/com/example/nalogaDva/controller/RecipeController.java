package com.example.nalogaDva.controller;

import com.example.nalogaDva.exception.ResourceNotFoundException;
import com.example.nalogaDva.model.Recipe;
import com.example.nalogaDva.repository.RecipeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@RestController
@RequestMapping("/api/recepti")
@CrossOrigin(origins = "http://localhost:3000") // Dodajte to vrstico
public class RecipeController {



    @Autowired
    private RecipeRepository recipeRepository;

    @GetMapping
    public List<Recipe> vsiRecepti(@RequestParam(required = false) String query) {
        if (query != null && !query.isEmpty()) {
            return recipeRepository.findByNaslovContainingIgnoreCase(query); // Adjusted for search
        }
        return recipeRepository.findAll();
    }

    @GetMapping("/{id}")
    public Recipe enRecept(@PathVariable Long id) {
        return recipeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Recept ni bil najden z id " + id)); // Read: Get one recipe
    }

    @PostMapping
    public Recipe ustvariteRecept(@RequestBody Recipe recept) {
        System.out.println("Prejemam recept: " + recept);
        return recipeRepository.save(recept); // Create: Add new recipe
    }


    @PutMapping("/{id}")
    public Recipe posodobiRecept(@PathVariable Long id, @RequestBody Recipe podrobnostiRecepta) {
        Recipe recept = recipeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Recept ni bil najden z id " + id));
        recept.setNaslov(podrobnostiRecepta.getNaslov());
        recept.setOpis(podrobnostiRecepta.getOpis());
        recept.setSestavine(podrobnostiRecepta.getSestavine());
        recept.setNavodila(podrobnostiRecepta.getNavodila());
        return recipeRepository.save(recept);
    }



    @DeleteMapping("/{id}")
    public void izbrisiRecept(@PathVariable Long id) {
        recipeRepository.deleteById(id); // Delete: Remove recipe
    }

    @GetMapping("/search")
    public List<Recipe> searchRecipes(@RequestParam String query) {
        return recipeRepository.findByNaslovContainingIgnoreCase(query);
    }



}
