package com.ccnc.cube.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
public class PrProgressService {
	
	@Autowired
	private PrProgressRepository prProgressRepository;
	
	@Transactional
	public void savePrProgress(PrProgress prProgress) {
		prProgressRepository.save(prProgress);
	}
	
	@Transactional
	public List<PrProgress> findByProject(Project project) {
		return prProgressRepository.findByPrProgressProject(project);
	}
	
	@Transactional
	public void deletePrProgress(Integer prProgressId) {
		prProgressRepository.deleteById(prProgressId);
	}
	
	@Transactional
	public PrProgress findPrProgress(Integer prProgressId) {
		return prProgressRepository.findById(prProgressId).orElseGet(()->{
			return new PrProgress();
		});
	}

}
