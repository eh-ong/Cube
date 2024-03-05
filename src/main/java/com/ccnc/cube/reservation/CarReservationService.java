package com.ccnc.cube.reservation;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccnc.cube.common.CommonEnum.UserRole;
import com.ccnc.cube.user.Users;

@Service
public class CarReservationService {
	
	@Autowired
	private CarReservationRepository carReservationRepository;

	@Transactional
	public void insertCar(CarReservation carReservation) {
		carReservationRepository.save(carReservation);	
	}
	
	@Transactional
	public List<CarReservation> getCarrevlist() {
		List<CarReservation> carrevList = new ArrayList<>(carReservationRepository.findAll());
		
		Collections.sort(carrevList,
				Comparator.comparing(CarReservation::getCreDate).thenComparing(CarReservation::getCreStart));
		 
		return carrevList;
	}
	
	public Page<CarReservation> getCarrevlistPage(Pageable pageable) {
		
		return carReservationRepository.findAll(pageable);
	}
	
    public Page<CarReservation> findRevuserListPage(Users user, Pageable pageable) {
        return carReservationRepository.findByUserId(user, pageable);
    }
    
    
	
	
	@Transactional
	public void deleteCar(Integer creId) {
		carReservationRepository.deleteById(creId);
	}

	@Transactional(readOnly = true)
	public CarReservation getCarReservation(Integer creId) {
		CarReservation findCarReservation = carReservationRepository.findById(creId).orElseGet(() -> {
			return new CarReservation();
		});
		return findCarReservation;
	}
	
	 @Transactional
	    public void updateCarReservation(CarReservation carReservation) {
	        CarReservation existingReservation = carReservationRepository.findById(carReservation.getCreId()).orElse(null);

	        if (existingReservation != null) {
	            existingReservation.setCreStart(carReservation.getCreStart());
	            existingReservation.setCreEnd(carReservation.getCreEnd());
	            // 다른 필요한 업데이트 작업 수행
	            // ...

	            carReservationRepository.save(existingReservation);
	        } else {
	            throw new NoSuchElementException("해당 ID를 가진 예약이 존재하지 않습니다.");
	        }
	    }

	    public boolean isCarReservationUpdateable(LocalTime start, LocalTime end, LocalDate date,Car car) {
	        List<CarReservation> overlappingReservations = carReservationRepository
	                .findByCreDateAndCreStartLessThanEqualAndCreEndGreaterThanAndCreNum(date, end, start, car);
	        return overlappingReservations.isEmpty();
	    }

	    public void updateCarReservationCheck(CarReservation carReservation) {
	        LocalTime start = carReservation.getCreStart();
	        LocalTime end = carReservation.getCreEnd();
	        LocalDate date = carReservation.getCreDate();
	        Car car = carReservation.getCreNum();

	        if (isCarReservationUpdateable(start, end, date, car)) {
	            carReservationRepository.save(carReservation);
	        } else {
	            throw new RuntimeException("해당 일정에 이미 예약이 존재합니다.");
	        }
	    }
	
	public boolean isTimeSlotAvailable(LocalTime start, LocalTime end,LocalDate date,Car car) {
        // 해당 시간에 이미 예약이 있는지 데이터베이스에서 조회
        List<CarReservation> overlappingReservations = carReservationRepository.findByCreDateAndCreStartLessThanEqualAndCreEndGreaterThanAndCreNum(date, end, start, car);

        // 겹치는 예약이 없으면 true 반환
        return overlappingReservations.isEmpty();
    }
	
	public void insertcheckRev(CarReservation carReservation) {
        LocalTime start = carReservation.getCreStart();
        LocalTime end = carReservation.getCreEnd();
        LocalDate date = carReservation.getCreDate();
        Car car = carReservation.getCreNum();

        if (isTimeSlotAvailable(start, end, date, car)) {
            carReservationRepository.save(carReservation);
        } else {
            throw new RuntimeException("해당 일정에 이미 예약이 존재합니다.");
        }
    } 


	
	public boolean isAdmin(Users user) {
		return UserRole.ADMIN.equals(user.getUserRole());
	}
	
	
	public List<CarReservation> findRevuserList(Users userId){
		return carReservationRepository.findByUserId(userId);
	}




}
