package com.example.repository;

import com.example.model.Sestavine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SestavineRepository extends JpaRepository<Sestavine, Long> {
    Optional<Sestavine> findByNaziv(String naziv);
}
