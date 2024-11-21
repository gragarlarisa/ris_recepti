package com.example.repository;

import com.example.model.Komentarji;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface KomentarjiRepository extends JpaRepository<Komentarji, Long> {
}
