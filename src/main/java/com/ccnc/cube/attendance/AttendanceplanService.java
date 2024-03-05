package com.ccnc.cube.attendance;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccnc.cube.user.Users;

import jakarta.transaction.Transactional;

@Service
public class AttendanceplanService {
	
	@Autowired
	private AttendanceplanRepository attendanceplanRepository;
	
	@Transactional
	public List<Attendanceplan> findAttPlan(Users user) {
	    return attendanceplanRepository.findByUserId(user);
	}
	
	@Transactional
	public void saveAttPlan(Attendanceplan attplan) {
		attendanceplanRepository.save(attplan);
	}
	
	@Transactional
	public Attendanceplan findAttplanBydate(Users user, LocalDate date){
		return attendanceplanRepository.findByUserIdAndApDate(user, date);
	}
	
	@Transactional
	public Attendanceplan getAttplan(Integer apId) {
		return attendanceplanRepository.findById(apId).get();
		 
	}
}
