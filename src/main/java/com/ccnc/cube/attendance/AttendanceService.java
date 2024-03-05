package com.ccnc.cube.attendance;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccnc.cube.user.Users;

import jakarta.transaction.Transactional;

@Service
public class AttendanceService {
	
	@Autowired
	private AttendanceRepository attendanceRepository;
	
	@Transactional
	public void InsertAtt(Attendance att) { // 근태 저장
		attendanceRepository.save(att);
	}
	
	@Transactional // 처음 저장
	public Attendance firstAtt(Users user, LocalDate date) {
		return attendanceRepository.findByUserIdAndAttDate(user, date).orElse(null);
	}
	
	@Transactional
	public List<Attendance> attList(Users user){
		return attendanceRepository.findByUserId(user).get();
	}
	
	@Transactional
	public Attendance getAtt(Integer attId) { // 근태 조회
		return attendanceRepository.findById(attId).get();
	}
}
