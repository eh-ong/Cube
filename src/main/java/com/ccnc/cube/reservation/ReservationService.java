package com.ccnc.cube.reservation;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccnc.cube.common.CommonEnum.UserRole;
import com.ccnc.cube.user.Users;

@Service
public class ReservationService {

	@Autowired
	private ReservationRepository reservationRepository;

	@Autowired
	private MeetingroomService meetingroomService;

	@Transactional(readOnly = true)
	public Reservation getReservation(Integer reId) {
		Reservation findReservation = reservationRepository.findById(reId).orElseGet(() -> {
			return new Reservation();
		});

		return findReservation;
	}

	@Transactional
	public void insertRev(Reservation reservation) {
		reservationRepository.save(reservation);
	}
	
	//====================================================================================================================================================================	
	
	
    public Page<Reservation> findRevuserListByDateAndCarReservation(Users user, LocalDate reservationDate, Pageable pageable) {
        return reservationRepository.findByUserIdAndReDate(user, reservationDate, pageable);
    }

    public Page<Reservation> findRevByDate(LocalDate reservationDate, Pageable pageable) {
        return reservationRepository.findByReDate(reservationDate, pageable);
    }
    
    
	 //====================================================================================================================================================================
	

    
    
	@Transactional
	public List<Reservation> getReservationlist() {
		List<Reservation> reservationList = new ArrayList<>(reservationRepository.findAll());

		// 날짜와 시작 시간을 모두 고려하여 정렬
		Collections.sort(reservationList,
				Comparator.comparing(Reservation::getReDate).thenComparing(Reservation::getReStart));

		return reservationList;
	}
	
	public Page<Reservation> getReservationPage(Pageable pageable) {
	    return reservationRepository.findAllByOrderByReDateAsc(pageable);
	}
	
	public Page<Reservation> findRevuserListPage(Users user,Pageable pageable){
		return reservationRepository.findByUserId(user, pageable);
	}
	
    //====================================================================================================================================================================
    
    
	@Transactional
	public void deleteRev(Integer reId) {
		reservationRepository.deleteById(reId);
	}

	public boolean isTimeSlotAvailable(LocalTime start, LocalTime end, LocalDate date, Meetingroom meetingRoom) {
	    // 해당 시간에 이미 예약이 있는지 데이터베이스에서 조회
	    List<Reservation> overlappingReservations = reservationRepository
	            .findByReDateAndReStartLessThanEqualAndReEndGreaterThanAndReNum(date, end, start, meetingRoom);

	    // 겹치는 예약이 없으면 true 반환
	    return overlappingReservations.isEmpty();
	}

	public void insertcheckRev(Reservation reservation) {
	    LocalTime start = reservation.getReStart();
	    LocalTime end = reservation.getReEnd();
	    LocalDate date = reservation.getReDate();
	    Meetingroom meetingroom = reservation.getReNum();

	    if (isTimeSlotAvailable(start, end, date, meetingroom)) {
	        reservationRepository.save(reservation);
	    } else {
	        throw new RuntimeException("해당 일정에 이미 예약이 존재합니다.!!");
	    }
	}

	@Transactional
	public void updateRev(Reservation reservation) {
	    LocalTime start = reservation.getReStart();
	    LocalTime end = reservation.getReEnd();
	    LocalDate date = reservation.getReDate();
	    Meetingroom meetingroom = reservation.getReNum();

	    if (!isTimeSlotAvailable(start, end, date, meetingroom)) {
	        reservationRepository.save(reservation);
	    } else {
	        throw new RuntimeException("해당 일정에 이미 예약이 존재합니다.!!");
	    }
	}

	
	public boolean isAdmin(Users user) {
		return UserRole.ADMIN.equals(user.getUserRole());
	}

	public List<Reservation> findRevuserList(Users userId) {
		return reservationRepository.findByUserId(userId);
	}
	
	

}
