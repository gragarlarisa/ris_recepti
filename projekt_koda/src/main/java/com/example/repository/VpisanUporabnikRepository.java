package com.example.repository;

import com.example.model.VpisanUporabnik;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VpisanUporabnikRepository extends JpaRepository<VpisanUporabnik, Long> {
}
