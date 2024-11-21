package com.example.repository;

import com.example.model.ReceptSestavine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReceptSestavineRepository extends JpaRepository<ReceptSestavine, Long> {
}
