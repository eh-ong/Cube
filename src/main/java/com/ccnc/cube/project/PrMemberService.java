package com.ccnc.cube.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccnc.cube.user.Users;

import jakarta.transaction.Transactional;

@Service
public class PrMemberService {
	
	@Autowired
	private PrMemberRepository prMemberRepository;
	
	@Transactional
	public void savePrMember(PrMember prMember) {
		prMemberRepository.save(prMember);
	}
	
	@Transactional
	public List<PrMember> findByProject(Project project) {
		return prMemberRepository.findByPrMemberProject(project);
	}
	
	@Transactional
	public List<PrMember> findByUser(Users user) {
		return prMemberRepository.findByPrMemberUser(user);
	}	
	
	@Transactional
	public PrMember findByProjectNUser(Project project, Users users) {
		return prMemberRepository.findByPrMemberProjectAndPrMemberUser(project, users);
	}
	
	@Transactional
	public void deletePrMember(Integer prMemberId) {
		prMemberRepository.deleteById(prMemberId);
	}

}
