package com.decorruptify.backend.repository;

import com.decorruptify.backend.model.Verdict;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VerdictRepository extends JpaRepository<Verdict, Long> {
}
