package com.example.repository;

import com.example.model.PrehranskeOmejitve;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PrehranskeOmejitveRepository extends JpaRepository<PrehranskeOmejitve, Long> {
}
