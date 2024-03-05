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
public interface ReservationRepository extends JpaRepository<Reservation, Integer>{

	// 예약 시 조건
	List<Reservation> findByReDateAndReStartLessThanEqualAndReEndGreaterThanEqualAndReNum(LocalDate reDate, LocalTime end, LocalTime start, Meetingroom meetingRoom);
	
	// 예약 변경 시 조건
	List<Reservation> findByReDateAndReStartLessThanEqualAndReEndGreaterThanAndReNum(LocalDate date, LocalTime end, LocalTime start, Meetingroom meetingRoom);

	//페이징
    Page<Reservation> findByReDateAndReStartLessThanEqualAndReEndGreaterThanEqualAndReNum(
            LocalDate reDate, LocalTime end, LocalTime start, Meetingroom meetingRoom, Pageable pageable);

	//마이페이지 페이징을 위한 유저정보찾기
	Page<Reservation> findByUserId(Users userId, Pageable pageable);
    
    List<Reservation> findByUserId(Users userId);
    
    //메인페이지 날짜별 예약스케줄 가져오기 위한 메소드
    Page<Reservation> findByUserIdAndReDate(Users userId, LocalDate reDate, Pageable pageable);
    
	Page<Reservation> findByReDate(LocalDate reservationDate, Pageable pageable);

	Page<Reservation> findAllByOrderByReDateAsc(Pageable pageable);
    
}
 	