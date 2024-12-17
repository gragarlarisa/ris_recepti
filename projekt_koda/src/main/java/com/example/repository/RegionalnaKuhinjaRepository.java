package com.example.repository;

import com.example.model.RegionalnaKuhinja;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RegionalnaKuhinjaRepository extends JpaRepository<RegionalnaKuhinja, Integer> {
}
