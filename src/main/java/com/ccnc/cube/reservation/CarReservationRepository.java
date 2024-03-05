package com.ccnc.cube.reservation;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.user.Users;

@Repository
public interface CarReservationRepository extends JpaRepository<CarReservation, Integer> {

	List<CarReservation> findByCreDateAndCreStartLessThanEqualAndCreEndGreaterThanEqualAndCreNum(LocalDate creDate,
			LocalTime end, LocalTime start, Car car);
	
	 Page<CarReservation> findByCreDateAndCreStartLessThanEqualAndCreEndGreaterThanEqualAndCreNum(
	            LocalDate creDate, LocalTime end, LocalTime start, Car car, Pageable pageable);

	// 차량을 고려한 예약 업데이트
	List<CarReservation> findByCreDateAndCreStartLessThanEqualAndCreEndGreaterThanAndCreNum(LocalDate date,
			LocalTime end, LocalTime start, Car car);
	
	//마이페이지 페이징을 위한 유저정보찾기
	Page<CarReservation> findByUserId(Users userId, Pageable pageable);

	
	List<CarReservation> findByUserId(Users userId);

	
}
