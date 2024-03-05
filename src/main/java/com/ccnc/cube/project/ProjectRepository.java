package com.ccnc.cube.project;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.user.Users;

@Repository
public interface ProjectRepository extends JpaRepository<Project, Integer>{
	
	List<Project> findByProjectWriter(Users user);

}
