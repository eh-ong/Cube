package com.ccnc.cube.attendance;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.user.Users;

@Repository
public interface VacationRepository extends JpaRepository<Vacation, Integer>{
	
	List<Vacation> findByUserId(Users user);
}
