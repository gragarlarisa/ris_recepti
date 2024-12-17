package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.model.KorakPostopka; 

public interface KorakPostopkaRepository extends JpaRepository<KorakPostopka, Integer> {
    
}
