package com.ccnc.cube.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccnc.cube.user.Users;

import jakarta.transaction.Transactional;

@Service
public class ProjectService {
	
	@Autowired
	private ProjectRepository projectRepository;
	
	@Transactional
	public Project saveProject(Project project) {
		Project pr = projectRepository.save(project);
		return pr;
	}
	
	@Transactional
	public Project findProject(Integer projectId) {
		return projectRepository.findById(projectId).orElseGet(()->{
			return new Project();
		});
	}
	
	@Transactional
	public List<Project> findByProjectWriter(Users user) {
		return projectRepository.findByProjectWriter(user);
	}

}
