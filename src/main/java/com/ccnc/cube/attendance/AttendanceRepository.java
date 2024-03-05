package com.ccnc.cube.attendance;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.user.Users;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Integer>{
	
	Optional<Attendance> findByUserIdAndAttDate(Users user, LocalDate aDate);
	
	Optional<List<Attendance>> findByUserId(Users user);
	
}
