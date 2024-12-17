package com.example.service;
import com.example.model.Recept;
import com.example.model.ReceptSestavine;
import com.example.model.Sestavine;
import com.example.repository.ReceptSestavineRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.List;
import java.util.Optional;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class ReceptSestavineServiceTest {
    @Mock
    private ReceptSestavineRepository receptSestavineRepository;

    @InjectMocks
    private ReceptSestavineService receptSestavineService;

    private ReceptSestavine receptSestavine;
    private Recept recept;
    private Sestavine sestavine;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this); // Inicializacija Mockito

        // Inicializacija povezane entitete
        recept = new Recept();
        recept.setIdRecept(1);
        // nastaviti ostale lastnosti recepta po potrebi

        sestavine = new Sestavine();
        sestavine.setId(1L);
        sestavine.setNaziv("Jabolko");
        sestavine.setKolicina(2); // Nastavite po potrebi
        sestavine.setEnota("kg"); // Nastavite po potrebi

        // Inicializacija objekta ReceptSestavine
        receptSestavine = new ReceptSestavine();
        receptSestavine.setId(1L);
        receptSestavine.setRecept(recept);
        receptSestavine.setSestavine(sestavine);
    }

    @Test
    void testFindAll() {
        // Mokiramo metodo findAll, da vrne seznam sestavin
        when(receptSestavineRepository.findAll()).thenReturn(List.of(receptSestavine));

        // Klic storitve
        var result = receptSestavineService.findAll();

        // Preverjanje rezultata
        assertNotNull(result);
        assertFalse(result.isEmpty());
        assertEquals(1, result.size());
        assertEquals("Jabolko", result.get(0).getNaziv());

        // Preverimo, ali je metoda findAll poklicana
        verify(receptSestavineRepository, times(1)).findAll();
    }

    @Test
    void testFindById() {
        // Mokiramo metodo findById, da vrne prisotno sestavino
        when(receptSestavineRepository.findById(1)).thenReturn(Optional.of(receptSestavine));

        // Klic storitve
        Optional<ReceptSestavine> result = receptSestavineService.findById(1);

        // Preverjanje rezultata
        assertTrue(result.isPresent());
        assertEquals("Jabolko", result.get().getNaziv());

        // Preverimo, ali je metoda findById poklicana
        verify(receptSestavineRepository, times(1)).findById(1);
    }

    @Test
    void testSave() {
        // Mokiramo metodo save, da vrne shranjeno sestavino
        when(receptSestavineRepository.save(receptSestavine)).thenReturn(receptSestavine);

        // Klic storitve
        ReceptSestavine result = receptSestavineService.save(receptSestavine);

        // Preverjanje rezultata
        assertNotNull(result);
        assertEquals("Jabolko", result.getNaziv());

        // Preverimo, ali je metoda save poklicana
        verify(receptSestavineRepository, times(1)).save(receptSestavine);
    }

    @Test
    void testDeleteById() {
        // Pokličemo metodo deleteById
        receptSestavineService.deleteById(1);

        // Preverimo, ali je metoda deleteById poklicana
        verify(receptSestavineRepository, times(1)).deleteById(1);
    }
}
