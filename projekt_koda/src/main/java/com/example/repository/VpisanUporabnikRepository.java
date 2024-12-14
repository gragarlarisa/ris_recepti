package com.example.repository;

import com.example.model.VpisanUporabnik;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface VpisanUporabnikRepository extends JpaRepository<VpisanUporabnik, Long> {
    Optional<VpisanUporabnik> findByElektronskiNaslov(String elektronskiNaslov);
}
