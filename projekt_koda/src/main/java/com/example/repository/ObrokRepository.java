package com.example.repository;

import com.example.model.Obrok;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ObrokRepository extends JpaRepository<Obrok, Long> {
}
