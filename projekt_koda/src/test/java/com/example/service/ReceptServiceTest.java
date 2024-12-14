
package com.example.service;

import com.example.model.Recept;
import com.example.repository.ReceptRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class ReceptServiceTest {

    @Mock
    private ReceptRepository receptRepository;

    @InjectMocks
    private ReceptService receptService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("Pozitivni scenarij: Pridobitev vseh receptov")
    void testFindAllRecepti_Positive() {
        // Priprava podatkov
        Recept recept1 = new Recept();
        recept1.setIdRecept(1);
        recept1.setNaziv("Recept 1");

        Recept recept2 = new Recept();
        recept2.setIdRecept(2);
        recept2.setNaziv("Recept 2");

        when(receptRepository.findAll()).thenReturn(List.of(recept1, recept2));

        // Klic metode
        List<Recept> result = receptService.findAll();

        // Preverjanje rezultatov
        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Recept 1", result.get(0).getNaziv());
        verify(receptRepository, times(1)).findAll();
    }

    @Test
    @DisplayName("Negativni scenarij: Ni najdenih receptov")
    void testFindAllRecepti_Negative() {
        // Simulacija prazne baze
        when(receptRepository.findAll()).thenReturn(Collections.emptyList());

        // poklicem metodo
        List<Recept> result = receptService.findAll();

        // preverim rezultate
        assertNotNull(result);
        assertTrue(result.isEmpty());
        verify(receptRepository, times(1)).findAll();
    }

    @Test
    @DisplayName("Pozitivni scenarij: Prikaz podrobnosti recepta")
    void testFindReceptById_Positive() {
        // pripravimo podatke
        Recept recept = new Recept();
        recept.setIdRecept(1);
        recept.setNaziv("Recept 1");

        when(receptRepository.findById(1)).thenReturn(Optional.of(recept));

        // Klic metode
        Optional<Recept> result = receptService.findById(1);

        //  rezultati
        assertTrue(result.isPresent());
        assertEquals("Recept 1", result.get().getNaziv());
        verify(receptRepository, times(1)).findById(1);
    }

    @Test
    @DisplayName("Negativni scenarij: Recept ni najden")
    void testFindReceptById_Negative() {
        // Simulacija manjkajočega recepta
        when(receptRepository.findById(1)).thenReturn(Optional.empty());

        //  metodo klicem
        Optional<Recept> result = receptService.findById(1);

        // rezultati
        assertFalse(result.isPresent());
        verify(receptRepository, times(1)).findById(1);
    }
}
