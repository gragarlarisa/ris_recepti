/*

package com.example.service;

import com.example.model.VpisanUporabnik;
import com.example.repository.VpisanUporabnikRepository;
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

class VpisanUporabnikServiceTest {

    @Mock
    private VpisanUporabnikRepository vpisanUporabnikRepository;

    @InjectMocks
    private VpisanUporabnikService vpisanUporabnikService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this); // Inicializacija Mockito objektov
    }

    @Test
    @DisplayName("Pozitivni scenarij: Pridobitev vseh uporabnikov")
    void testFindAllUsers_Positive() {
        // Priprava podatkov
        VpisanUporabnik uporabnik1 = new VpisanUporabnik();
        uporabnik1.setId(1L);
        uporabnik1.setElektronskiNaslov("user1@example.com");

        VpisanUporabnik uporabnik2 = new VpisanUporabnik();
        uporabnik2.setId(2L);
        uporabnik2.setElektronskiNaslov("user2@example.com");

        when(vpisanUporabnikRepository.findAll()).thenReturn(List.of(uporabnik1, uporabnik2));

        // Klic metode
        List<VpisanUporabnik> result = vpisanUporabnikService.findAll();

        // Preverjanje rezultatov
        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("user1@example.com", result.get(0).getElektronskiNaslov());
        verify(vpisanUporabnikRepository, times(1)).findAll();
    }

    @Test
    @DisplayName("Negativni scenarij: Ni najdenih uporabnikov")
    void testFindAllUsers_Negative() {
        // Simulacija prazne baze
        when(vpisanUporabnikRepository.findAll()).thenReturn(Collections.emptyList());

        // Klic metode
        List<VpisanUporabnik> result = vpisanUporabnikService.findAll();

        // Preverjanje rezultatov
        assertNotNull(result);
        assertTrue(result.isEmpty());
        verify(vpisanUporabnikRepository, times(1)).findAll();
    }

    @Test
    @DisplayName("Pozitivni scenarij: Prikaz podrobnosti uporabnika")
    void testFindUserById_Positive() {
        // Priprava podatkov
        VpisanUporabnik uporabnik = new VpisanUporabnik();
        uporabnik.setId(1L);
        uporabnik.setElektronskiNaslov("user1@example.com");

        when(vpisanUporabnikRepository.findById(1L)).thenReturn(Optional.of(uporabnik));

        // Klic metode
        Optional<VpisanUporabnik> result = vpisanUporabnikService.findById(1L);

        // Preverjanje rezultatov
        assertTrue(result.isPresent());
        assertEquals("user1@example.com", result.get().getElektronskiNaslov());
        verify(vpisanUporabnikRepository, times(1)).findById(1L);
    }

    @Test
    @DisplayName("Negativni scenarij: Uporabnik ni najden")
    void testFindUserById_Negative() {
        // Simulacija manjkajočega uporabnika
        when(vpisanUporabnikRepository.findById(1L)).thenReturn(Optional.empty());

        // Klic metode
        Optional<VpisanUporabnik> result = vpisanUporabnikService.findById(1L);

        // Preverjanje rezultatov
        assertFalse(result.isPresent());
        verify(vpisanUporabnikRepository, times(1)).findById(1L);
    }

    @Test
    @DisplayName("Pozitivni scenarij: Brisanje uporabnika")
    void testDeleteUser_Positive() {
        // Simulacija obstoječega uporabnika
        VpisanUporabnik uporabnik = new VpisanUporabnik();
        uporabnik.setId(1L);

        when(vpisanUporabnikRepository.existsById(1L)).thenReturn(true);

        // Klic metode
        vpisanUporabnikService.deleteById(1L);

        // Preverjanje rezultatov
        verify(vpisanUporabnikRepository, times(1)).existsById(1L);
        verify(vpisanUporabnikRepository, times(1)).deleteById(1L);
    }

    @Test
    @DisplayName("Negativni scenarij: Brisanje uporabnika, ki ne obstaja")
    void testDeleteUser_Negative() {
        // Simulacija manjkajočega uporabnika
        when(vpisanUporabnikRepository.existsById(1L)).thenReturn(false);

        // Klic metode
        vpisanUporabnikService.deleteById(1L);

        // Preverjanje rezultatov
        verify(vpisanUporabnikRepository, times(1)).existsById(1L);
        verify(vpisanUporabnikRepository, times(0)).deleteById(1L);
    }

    @Test
    @DisplayName("Pozitivni scenarij: Preverjanje veljavnosti uporabnika")
    void testValidateUser_Positive() {
        // Priprava podatkov
        VpisanUporabnik uporabnik = new VpisanUporabnik();
        uporabnik.setElektronskiNaslov("user1@example.com");
        uporabnik.setGeslo("password123");

        when(vpisanUporabnikRepository.findAll()).thenReturn(List.of(uporabnik));

        // Klic metode
        Optional<VpisanUporabnik> result = vpisanUporabnikService.validateUser("user1@example.com", "password123");

        // Preverjanje rezultatov
        assertTrue(result.isPresent());
        assertEquals("user1@example.com", result.get().getElektronskiNaslov());
        verify(vpisanUporabnikRepository, times(1)).findAll();
    }

    @Test
    @DisplayName("Negativni scenarij: Neveljaven uporabnik")
    void testValidateUser_Negative() {
        // Simulacija neveljavnega uporabnika
        when(vpisanUporabnikRepository.findAll()).thenReturn(Collections.emptyList());

        // Klic metode
        Optional<VpisanUporabnik> result = vpisanUporabnikService.validateUser("user1@example.com", "wrongpassword");

        // Preverjanje rezultatov
        assertFalse(result.isPresent());
        verify(vpisanUporabnikRepository, times(1)).findAll();
    }

    @Test
    @DisplayName("Pozitivni scenarij: Preverjanje veljavnosti administratorja")
    void testValidateAdmin_Positive() {
        // Priprava podatkov
        VpisanUporabnik admin = new VpisanUporabnik();
        admin.setElektronskiNaslov("admin@example.com");
        admin.setGeslo("admin123");
        admin.setAdministrator(true);

        when(vpisanUporabnikRepository.findAll()).thenReturn(List.of(admin));

        // Klic metode
        Optional<VpisanUporabnik> result = vpisanUporabnikService.validateAdmin("admin@example.com", "admin123");

        // Preverjanje rezultatov
        assertTrue(result.isPresent());
        assertEquals("admin@example.com", result.get().getElektronskiNaslov());
        assertTrue(result.get().getAdministrator());
        verify(vpisanUporabnikRepository, times(1)).findAll();
    }

    @Test
    @DisplayName("Negativni scenarij: Neveljaven administrator")
    void testValidateAdmin_Negative() {
        // Simulacija neveljavnega administratorja
        when(vpisanUporabnikRepository.findAll()).thenReturn(Collections.emptyList());

        // Klic metode
        Optional<VpisanUporabnik> result = vpisanUporabnikService.validateAdmin("admin@example.com", "wrongpassword");

        // Preverjanje rezultatov
        assertFalse(result.isPresent());
        verify(vpisanUporabnikRepository, times(1)).findAll();
    }
}

*/