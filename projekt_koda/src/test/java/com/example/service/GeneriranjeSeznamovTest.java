package com.example.service;

import com.example.controller.ReceptController;
import com.example.service.ReceptService;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.ResponseEntity;
import org.mockito.Mockito;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class GeneriranjeSeznamovTest {

    @MockBean
    private ReceptService receptService;

    @Autowired
    private ReceptController receptController;

    @Test
    void testGenerateShoppingList() {
        List<Map<String, Object>> mockedShoppingList = Arrays.asList(
                Map.of("imeSestavine", "Sugar", "kolicina", 200.0),
                Map.of("imeSestavine", "Flour", "kolicina", 400.0)
        );

        // When service method is called, return mocked data
        Mockito.when(receptService.generateShoppingList(Mockito.anyList(), Mockito.anyInt()))
                .thenReturn(mockedShoppingList);

        // Prepare test input data
        List<Integer> receptIds = Arrays.asList(1, 2);
        Integer steviloOseb = 4;

        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("receptIds", receptIds);
        requestBody.put("steviloOseb", steviloOseb);

        // Simulate the request to the controller
        ResponseEntity<Map<String, Object>> response = receptController.generateShoppingList(requestBody);

        // Verify the response
        assertNotNull(response);
        assertEquals(200, response.getStatusCodeValue(), "Status code should be 200 OK");
        assertTrue(response.getBody().containsKey("seznamNakupov"), "Response should contain 'seznamNakupov' key");

        // Ensure the shopping list is not empty
        List<Map<String, Object>> seznamNakupov = (List<Map<String, Object>>) response.getBody().get("seznamNakupov");
        assertFalse(seznamNakupov.isEmpty(), "Shopping list should not be empty");

        // Ensure the mocked data is returned in the response
        assertEquals(2, seznamNakupov.size(), "Shopping list should contain 2 items");
        assertEquals("Sugar", seznamNakupov.get(0).get("imeSestavine"), "First ingredient should be 'Sugar'");
        assertEquals(200.0, seznamNakupov.get(0).get("kolicina"), "First ingredient quantity should be 200.0");
    }
}
