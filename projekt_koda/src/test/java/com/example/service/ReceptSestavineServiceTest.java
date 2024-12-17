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
        MockitoAnnotations.openMocks(this); 

        recept = new Recept();
        recept.setIdRecept(1);

        sestavine = new Sestavine();
        sestavine.setId(1L);
        sestavine.setNaziv("Jabolko");
        sestavine.setKolicina(2); 
        sestavine.setEnota("kg"); 

        receptSestavine = new ReceptSestavine();
        receptSestavine.setId(1L);
        receptSestavine.setRecept(recept);
        receptSestavine.setSestavine(sestavine);
    }

    @Test
    void testFindAll() {

        when(receptSestavineRepository.findAll()).thenReturn(List.of(receptSestavine));

        var result = receptSestavineService.findAll();

        assertNotNull(result);
        assertFalse(result.isEmpty());
        assertEquals(1, result.size());
        assertEquals("Jabolko", result.get(0).getNaziv());

        verify(receptSestavineRepository, times(1)).findAll();
    }

    @Test
    void testFindById() {
        
        when(receptSestavineRepository.findById(1)).thenReturn(Optional.of(receptSestavine));

        Optional<ReceptSestavine> result = receptSestavineService.findById(1);

        assertTrue(result.isPresent());
        assertEquals("Jabolko", result.get().getNaziv());

        verify(receptSestavineRepository, times(1)).findById(1);
    }

    @Test
    void testSave() {
        when(receptSestavineRepository.save(receptSestavine)).thenReturn(receptSestavine);
        ReceptSestavine result = receptSestavineService.save(receptSestavine);

        assertNotNull(result);
        assertEquals("Jabolko", result.getNaziv());

        verify(receptSestavineRepository, times(1)).save(receptSestavine);
    }

    @Test
    void testDeleteById() {
      
        receptSestavineService.deleteById(1);

        
        verify(receptSestavineRepository, times(1)).deleteById(1);
    }
}
