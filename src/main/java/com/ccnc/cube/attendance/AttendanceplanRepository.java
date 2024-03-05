package com.ccnc.cube.attendance;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.user.Users;

@Repository
public interface AttendanceplanRepository extends JpaRepository<Attendanceplan, Integer> {

	List<Attendanceplan> findByUserId(Users userId);
	
	Attendanceplan findByUserIdAndApDate(Users userId, LocalDate date);
}
