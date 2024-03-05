package com.ccnc.cube.common;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeamRepository extends JpaRepository<Team, Integer>{
	
Team findByTeamName(String teamName);
	
	List<Team> findByTeamNameContaining(String teamName);
}
