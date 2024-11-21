package com.example.repository;

import com.example.model.KategorijaSkupno;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface KategorijaSkupnoRepository extends JpaRepository<KategorijaSkupno, Long> {
}
