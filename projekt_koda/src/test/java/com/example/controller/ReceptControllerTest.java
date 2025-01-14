package com.example.controller;

import com.example.model.Recept;
import com.example.service.ReceptService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
public class ReceptControllerTest {

    @Mock
    private ReceptService receptService;

    @InjectMocks
    private ReceptController receptController;

    private Recept recept1;
    private Recept recept2;

    @BeforeEach
    public void setup() {
        recept1 = new Recept("Recept 1", "Opis 1", "slika1.jpg", 30, 4, 2, true, null, null);
        recept2 = new Recept("Recept 2", "Opis 2", "slika2.jpg", 45, 2, 3, true, null, null);
    }

    @Test
    public void testGetFavoriteRecipes_Positive() {
        // Simulirajmo, da receptService vrne seznam receptov.
        when(receptService.findAll()).thenReturn(Arrays.asList(recept1, recept2));

        List<Integer> favoriteIds = Arrays.asList(recept1.getIdRecept(), recept2.getIdRecept());
        ResponseEntity<List<Map<String, Object>>> response = receptController.getFavoriteRecipes(favoriteIds);

        // Preverimo, da je odgovor pravilen.
        assertNotNull(response);
        assertEquals(HttpStatus.OK, response.getStatusCode());
        List<Map<String, Object>> simplifiedRecepti = response.getBody();
        assertNotNull(simplifiedRecepti);
        assertEquals(2, simplifiedRecepti.size());

        // Preverimo, da so vsi recepti pravilno vrnjeni.
        assertEquals(recept1.getIdRecept(), simplifiedRecepti.get(0).get("idRecept"));
        assertEquals(recept2.getIdRecept(), simplifiedRecepti.get(1).get("idRecept"));
    }

    @Test
    public void testGetFavoriteRecipes_Negative() {
        // Simulirajmo, da receptService vrne seznam receptov.
        when(receptService.findAll()).thenReturn(Arrays.asList(recept1, recept2));

        List<Integer> favoriteIds = Arrays.asList(999); // ID, ki ni v bazi.
        ResponseEntity<List<Map<String, Object>>> response = receptController.getFavoriteRecipes(favoriteIds);

        // Preverimo, da je odgovor pravilen.
        assertNotNull(response);
        assertEquals(200, response.getStatusCode().value());

        List<Map<String, Object>> simplifiedRecepti = response.getBody();
        assertNotNull(simplifiedRecepti);
        assertTrue(simplifiedRecepti.isEmpty()); // Prazni seznam, ker ni zadetkov.
    }
}
