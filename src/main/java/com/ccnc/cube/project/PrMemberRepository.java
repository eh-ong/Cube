package com.ccnc.cube.project;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.user.Users;

@Repository
public interface PrMemberRepository extends JpaRepository<PrMember, Integer>{
	
	List<PrMember> findByPrMemberProject(Project project);
	
	List<PrMember> findByPrMemberUser(Users user);
	
	PrMember findByPrMemberProjectAndPrMemberUser(Project project, Users user);

}
