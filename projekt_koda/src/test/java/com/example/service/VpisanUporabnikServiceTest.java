package com.example.service;

import com.example.model.VpisanUporabnik;
import com.example.repository.VpisanUporabnikRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class VpisanUporabnikServiceTest {

    @Mock
    private VpisanUporabnikRepository vpisanUporabnikRepository;

    @InjectMocks
    private VpisanUporabnikService vpisanUporabnikService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this); // Initialize Mockito mocks
    }

    // Positive Test
    @Test
    @DisplayName("Pozitivni scenarij: Prikaz podrobnosti uporabnika")
    void testFindUserById_Positive() {
        // Prepare data
        VpisanUporabnik uporabnik = new VpisanUporabnik();
        uporabnik.setId(1L);
        uporabnik.setElektronskiNaslov("user1@example.com");

        // Simulate the repository returning the user
        when(vpisanUporabnikRepository.findById(1L)).thenReturn(Optional.of(uporabnik));

        // Call the service method
        Optional<VpisanUporabnik> result = vpisanUporabnikService.findById(1L);

        // Verify the result
        assertTrue(result.isPresent());
        assertEquals("user1@example.com", result.get().getElektronskiNaslov());
        verify(vpisanUporabnikRepository, times(1)).findById(1L);
    }

    // Negative Test
    @Test
    @DisplayName("Negativni scenarij: Uporabnik ni najden")
    void testFindUserById_Negative() {
        // Simulate the repository returning no user
        when(vpisanUporabnikRepository.findById(1L)).thenReturn(Optional.empty());

        // Call the service method
        Optional<VpisanUporabnik> result = vpisanUporabnikService.findById(1L);

        // Verify the result
        assertFalse(result.isPresent());
        verify(vpisanUporabnikRepository, times(1)).findById(1L);
    }
}