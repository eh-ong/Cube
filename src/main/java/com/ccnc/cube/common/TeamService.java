package com.ccnc.cube.common;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.transaction.Transactional;

@Service
public class TeamService {
	
	@Autowired
	private TeamRepository teamRepository;
	
	@Transactional
	public List<Team> getTeamList(){ //모든 팀 출력
		return teamRepository.findAll();
	}
	
	@Transactional
	public Team getTeam(int teamId) { //팀 가져오기
		return teamRepository.findById(teamId).orElseGet(null);
	}
	
	@Transactional
	public Team findByTeamName(String teamName) {
		return teamRepository.findByTeamName(teamName);
	}
	
	@Transactional
	public List<Team> findByTeamNameLike(String teamName) {
		return teamRepository.findByTeamNameContaining(teamName);
	}
	
}
