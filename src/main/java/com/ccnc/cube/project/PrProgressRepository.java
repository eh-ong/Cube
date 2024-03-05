package com.ccnc.cube.project;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PrProgressRepository extends JpaRepository<PrProgress, Integer>{

	List<PrProgress> findByPrProgressProject(Project project);
}
