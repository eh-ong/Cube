package com.ccnc.cube.reservation;

import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccnc.cube.common.CommonEnum.CarStatus;
import com.ccnc.cube.common.CommonEnum.MrStatus;
import com.ccnc.cube.common.CommonEnum.ReservationItem;
import com.ccnc.cube.common.ResponseDTO;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class ReservationController {

	@Autowired
	private UserService userService;

	@Autowired
	private ReservationService reservationService;

	@Autowired
	private CarReservationService carReservationService;

	@Autowired
	private CarService carService;

	@Autowired
	private MeetingroomService meetingroomService;

	@GetMapping("/reservationPage")
	public String reservationPage(Model model) {
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/rev_main.jsp");
		return "index";
	}

	@GetMapping("/getrevlist")
	public String getRevList(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page,
	        @RequestParam(defaultValue = "10") int size) {

	    // 페이지와 페이지 크기를 기반으로 Pageable 객체 생성 (날짜 순으로 오름차순 정렬)
	    Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.ASC, "reDate"));

	    // 페이징된 예약 목록 가져오기 (날짜 기준으로 오름차순 정렬)
	    Page<Reservation> revPage = reservationService.getReservationPage(pageable);

	    // 만약 현재 페이지가 마지막 페이지보다 크거나 같거나 페이지에 포함된 항목이 10개 이하일 때 다음 페이지로 이동하지 않음
	    if (page > revPage.getTotalPages()) {
	        page = revPage.getTotalPages(); // 페이지를 마지막 페이지로 설정하여 다음 페이지로 이동되지 않도록 함
	    }

	    // 현재 페이지 및 페이지 관련 정보 계산
	    int nowPage = page;
	    int startPage = Math.max(nowPage - 4, 1);
	    int endPage = Math.min(nowPage + 9, revPage.getTotalPages());

	    // 모델에 필요한 데이터 추가
	    model.addAttribute("revList", revPage.getContent());
	    model.addAttribute("nowPage", nowPage);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);

	    Users user = (Users) session.getAttribute("login_user");
	    model.addAttribute("isAdmin", reservationService.isAdmin(user));
	    model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
	    model.addAttribute("mainPage", "./reservation/getmeetlist.jsp");

	    return "index";
	}




	@GetMapping("/insertRev")
	public String insertRevPage(Model model) {
		System.out.println("예약페이지 요청");
		model.addAttribute("mrList", meetingroomService.getMeetingroomlist());
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/insertmeet.jsp");
		return "index";
	}

	@PostMapping("/insertRev/{reNum}")
	public @ResponseBody ResponseDTO<?> insertRev(@RequestBody Reservation reservation, @PathVariable Integer reNum,
			HttpSession session) {
		// 인증된 사용자 정보 가져오기
		Users user = (Users) session.getAttribute("login_user");

		Meetingroom meetingRoom = meetingroomService.getMeetingroom(reNum);

		// 회의실 정보 설정
		reservation.setReNum(meetingRoom);

		// 사용자 정보 설정
		reservation.setUserId(user);

		reservation.setUserName(user);

		// 예약 항목 설정
		reservation.setReItem(ReservationItem.회의실);

		// 예약 날짜 설정
		reservation.setReDate(reservation.getReDate());

		// 예약 시간, 날짜 확인
		LocalTime start = reservation.getReStart();
		LocalTime end = reservation.getReEnd();
		LocalDate date = reservation.getReDate();
		Integer reCount = reservation.getReCount(); // reCount 값 가져오기

		// 회의실 수용 인원 확인
		if (reCount != null && reCount > meetingRoom.getMrCapacity()) {
			// 회의실 수용 인원을 초과하는 경우 에러 메시지 반환
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "회의실의 수용 인원을 초과했습니다.");
		}

		// 예약 가능한지 여부 확인
		if (!reservationService.isTimeSlotAvailable(start, end, date, meetingRoom)) {
			// 이미 예약된 경우 예약 처리하지 않고 에러 메시지 반환
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "해당 시간에 이미 예약이 있습니다.");
		}

		// 예약 가능한 경우 예약 처리
		reservationService.insertRev(reservation);
		return new ResponseDTO<>(HttpStatus.OK.value(), "예약 완료");
	}

	@GetMapping("/updateRev/{reId}")
	public String updateRev(@PathVariable Integer reId, Model model) {
		System.out.println("업데이트 페이지 이동");
		model.addAttribute("reId", reId);
		model.addAttribute("mrList", meetingroomService.getMeetingroomlist());
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/updatemeet.jsp");
		return "index";
	}

	@PostMapping("/updateRev/{reNum}")
	public @ResponseBody ReservationDTO<?> updateRev(@RequestBody Reservation reservation, @PathVariable Integer reNum,
			Model model) {
		// 업데이트 전의 예약 정보 가져오기
		Reservation existingReservation = reservationService.getReservation(reservation.getReId());
		Meetingroom meetingroom = meetingroomService.getMeetingroom(reNum);

		// 업데이트된 예약 정보 설정
		existingReservation.setReDate(reservation.getReDate());
		existingReservation.setReNum(meetingroom);
		existingReservation.setReStart(reservation.getReStart());
		existingReservation.setReEnd(reservation.getReEnd());

		// 변경된 예약 정보에 대한 유효성 검사
		LocalTime startTime = reservation.getReStart();
		LocalTime endTime = reservation.getReEnd();
		LocalDate date = reservation.getReDate();

		// 시작 시간이 종료 시간보다 이후인지 확인
		if (startTime.isAfter(endTime)) {
			return new ReservationDTO<>(HttpStatus.BAD_REQUEST.value(), "시작 시간은 종료 시간보다 이전이어야 합니다.");
		}

		// 예약이 겹치는지 확인
		if (!reservationService.isTimeSlotAvailable(startTime, endTime, date, meetingroom)) {
			return new ReservationDTO<>(HttpStatus.BAD_REQUEST.value(), "해당 시간대에 이미 예약이 있습니다.");
		}

		// 변경된 예약 정보 업데이트
		reservationService.updateRev(existingReservation);
		return new ReservationDTO<>(HttpStatus.OK.value(), "변경 완료");
	}

	@DeleteMapping("/deleteRev/{reId}")
	public ResponseEntity<ReservationDTO<?>> deleteRev(@PathVariable Integer reId) {
		try {
			reservationService.deleteRev(reId);
			return ResponseEntity.ok(new ReservationDTO<>(HttpStatus.OK.value(), "예약이 성공적으로 취소되었습니다."));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ReservationDTO<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "예약 취소 중 오류가 발생했습니다."));
		}
	}

	// ========================================= ↓ 차 량 예 약 코 드 ↓
	// ==============================================================================================//

	@GetMapping("/insertCar")
	public String insertCarPage(Model model) {
		System.out.println("예약페이지 요청");
		model.addAttribute("carList", carService.getCarlist());
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/insertcar.jsp");
		return "index";
	}

	@PostMapping("/insertCar/{creNum}")
	public @ResponseBody ResponseDTO<?> insertCar(@RequestBody CarReservation carReservation,
			@PathVariable Integer creNum, HttpSession session) {
		// 인증된 사용자 정보 가져오기
		Users user = (Users) session.getAttribute("login_user");

		Car car = carService.getCar(creNum);

		// 차량 정보 설정
		carReservation.setCreNum(car);

		// 사용자 정보 설정
		carReservation.setUserId(user);

		carReservation.setUserName(user);

		// 예약 항목 설정
		carReservation.setCreItem(ReservationItem.차량);

		// 예약 날짜 설정
		carReservation.setCreDate(carReservation.getCreDate());

		// 예약 시간, 날짜 확인
		LocalTime start = carReservation.getCreStart();
		LocalTime end = carReservation.getCreEnd();
		LocalDate date = carReservation.getCreDate();
		Integer creCount = carReservation.getCreCount();

		// 회의실 수용 인원 확인
		if (creCount != null && creCount > car.getCarCapacity()) {
			// 회의실 수용 인원을 초과하는 경우 에러 메시지 반환
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "차량 탑승 인원을 초과했습니다.");
		}

		// 예약 가능한지 여부 확인
		if (!carReservationService.isTimeSlotAvailable(start, end, date, car)) {
			// 이미 예약된 경우 예약 처리하지 않고 에러 메시지 반환
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "해당 시간에 이미 예약이 있습니다.");
		}

		// 예약 가능한 경우 예약 처리
		carReservationService.insertCar(carReservation);
		return new ResponseDTO<>(HttpStatus.OK.value(), "예약 완료");
	}

	@GetMapping("/getcarlist")
	public String getCarlist(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int size) {

		// 페이지와 페이지 크기를 기반으로 Pageable 객체 생성
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.ASC, "creDate", "creStart"));

		// 페이지에 해당하는 차량 예약 목록 가져오기 (날짜 및 시작 시간으로 정렬)
		Page<CarReservation> carReservationPage = carReservationService.getCarrevlistPage(pageable);

		// 현재 페이지 및 페이지 관련 정보 계산
		int nowPage = carReservationPage.getNumber() + 1;
		int startPage = Math.max(nowPage - 4, 1);
		int endPage = Math.min(nowPage + 9, carReservationPage.getTotalPages());

		// 만약 현재 페이지가 마지막 페이지보다 작고 페이지에 포함된 항목이 10개 미만이면 다음 페이지로 이동
		if (nowPage < carReservationPage.getTotalPages() && carReservationPage.getContent().size() < 10) {
			return "redirect:/getcarlist?page=" + (page + 1);
		}

		// 모델에 필요한 데이터 추가
		model.addAttribute("carList", carReservationPage.getContent());
		Users user = (Users) session.getAttribute("login_user");
		model.addAttribute("isAdmin", carReservationService.isAdmin(user));
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/getcarlist.jsp");

		return "index";
	}

	@GetMapping("/updateCar/{creId}")
	public String updateCar(@PathVariable Integer creId, Model model) {
		System.out.println("업데이트 페이지 이동");
		model.addAttribute("creId", creId);
		model.addAttribute("creList", carService.getCarlist());
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/updatecar.jsp");
		return "index";
	}

	@PostMapping("/updateCar/{creNum}")
	public @ResponseBody ReservationDTO<?> updateCarReservation(@RequestBody CarReservation carReservation,
			@PathVariable Integer creNum) {
		CarReservation existingReservation = carReservationService.getCarReservation(carReservation.getCreId());
		Car car = carService.getCar(creNum);

		// 업데이트된 예약 정보 설정
		existingReservation.setCreDate(carReservation.getCreDate());
		existingReservation.setCreNum(car);
		existingReservation.setCreStart(carReservation.getCreStart());
		existingReservation.setCreEnd(carReservation.getCreEnd());

		// 변경된 예약 정보에 대한 유효성 검사
		LocalTime startTime = carReservation.getCreStart();
		LocalTime endTime = carReservation.getCreEnd();
		LocalDate date = carReservation.getCreDate();

		// 시작 시간이 종료 시간보다 이후인지 확인
		if (startTime.isAfter(endTime)) {
			return new ReservationDTO<>(HttpStatus.BAD_REQUEST.value(), "시작 시간은 종료 시간보다 이전이어야 합니다.");
		}

		// 예약이 겹치는지 확인
		if (!carReservationService.isTimeSlotAvailable(startTime, endTime, date, car)) {
			return new ReservationDTO<>(HttpStatus.BAD_REQUEST.value(), "해당 시간대에 이미 예약이 있습니다.");
		}

		// 변경된 예약 정보 업데이트
		carReservationService.updateCarReservation(existingReservation);
		return new ReservationDTO<>(HttpStatus.OK.value(), "변경완료");
	}

	@DeleteMapping("/deleteCar/{creId}")
	public @ResponseBody ReservationDTO<?> deleteCar(@PathVariable Integer creId) {
		carReservationService.deleteCar(creId);
		return new ReservationDTO<>(HttpStatus.OK.value(), "예약취소");

	}

	// ============================================= ↓ 마 이 페 이 지 ↓
	// ===================================================================================================//

	@GetMapping("/myRevpage")
	public String getMeetingLists(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int size,
			@RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate reservationDate) {

		// 세션에서 로그인한 유저 정보 가져오기
		Users user = (Users) session.getAttribute("login_user");

		// 페이지와 페이지 크기를 기반으로 Pageable 객체 생성
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "reDate"));

		Page<Reservation> revPage;

		if (reservationDate != null) {
			// 선택된 날짜에 해당하는 예약 목록 가져오기
			revPage = reservationService.findRevByDate(reservationDate, pageable);
		} else {
			// 모든 예약 목록 가져오기
			revPage = reservationService.getReservationPage(pageable);
		}

		// 현재 페이지 및 페이지 관련 정보 계산
		int nowPage = revPage.getNumber() + 1;
		int startPage = Math.max(nowPage - 4, 1);
		int endPage = Math.min(nowPage + 9, revPage.getTotalPages());

		// 모델에 필요한 데이터 추가
		model.addAttribute("revList", revPage.getContent());
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		// 회의실 예약 목록 페이지로 이동
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/myrevpage.jsp");

		return "index";
	}

	@GetMapping("/meetinglist")
	public String getMeetingList(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int size) {
		// 세션에서 로그인한 유저 정보 가져오기
		Users user = (Users) session.getAttribute("login_user");

		// 페이지와 페이지 크기를 기반으로 Pageable 객체 생성 (날짜 빠른 순으로 정렬)
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.ASC, "reDate", "reStart"));

		// 해당 유저의 예약 목록을 가져오기
		Page<Reservation> myRevPage = reservationService.findRevuserListPage(user, pageable);

		// 현재 페이지 및 페이지 관련 정보 계산
		int nowPage = myRevPage.getNumber() + 1;
		int startPage = Math.max(nowPage - 4, 1);
		int endPage = Math.min(nowPage + 9, myRevPage.getTotalPages());

		// 모델에 필요한 데이터 추가
		model.addAttribute("revList", myRevPage.getContent());
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		// 회의실 예약 목록 페이지로 이동
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/meetinglist.jsp");
		return "index";
	}

	@GetMapping("/carlist")
	public String getCarList(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int size) {
		// 세션에서 로그인한 유저 정보 가져오기
		Users user = (Users) session.getAttribute("login_user");

		// 페이지와 페이지 크기를 기반으로 Pageable 객체 생성 (날짜 빠른 순으로 정렬)
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.ASC, "creDate", "creStart"));

		// 해당 유저의 차량 예약 목록을 가져오기
		Page<CarReservation> myCarRevPage = carReservationService.findRevuserListPage(user, pageable);

		// 현재 페이지 및 페이지 관련 정보 계산
		int nowPage = myCarRevPage.getNumber() + 1;
		int startPage = Math.max(nowPage - 4, 1);
		int endPage = Math.min(nowPage + 9, myCarRevPage.getTotalPages());

		// 모델에 필요한 데이터 추가
		model.addAttribute("carList", myCarRevPage.getContent());
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		// 차량 예약 목록 페이지로 이동
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/carlist.jsp");
		return "index";
	}

	// ===============================================대 회 의
	// 실↓========================================================//
//	@GetMapping("/insertLRev")
//	public String insertLRev(Model model) {
//		model.addAttribute("mrList", meetingroomService.getMeetingroomlist());
//		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
//		model.addAttribute("mainPage", "./reservation/insertLRev.jsp");
//		return "index";
//	}

	// ===============================================관 리 대
	// 장↓========================================================//

//	@GetMapping("/carManageMent")
//	public String showCarRegistrationForm(Model model) {
//		System.out.println("showCarList 메서드 호출됨");
//
//		List<Car> carList = carService.getCarlist();
//		model.addAttribute("carList", carList);
//		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
//		model.addAttribute("mainPage", "./reservation/carManagelist.jsp");
//		return "index";
//	}
//	
//
//	@GetMapping("/insertWriting")
//	public String insertWriting(Model model) {
//		System.out.println("예약페이지 요청");
//		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
//		model.addAttribute("mainPage", "./reservation/insertdiary.jsp");
//		return "index";
//	}
//	
//	
//	@PostMapping("/insertWriting/{carId}")
//	public @ResponseBody ResponseDTO<?> insertWriting(@RequestBody CarReservation carReservation,
//	        @PathVariable Integer creNum, HttpSession session) {
//	    // 인증된 사용자 정보 가져오기
//	    Users user = (Users) session.getAttribute("login_user");
//
//	    Car car = carService.getCar(creNum);
//	    
//		return null;
//
//	  
//	}

	// ===============================================관리자
	// 페이지========================================================//
	@GetMapping("/meetRegister")
	public String registerMeet(Model model) {
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/meetRegister.jsp");
		return "index";
	}

	@PostMapping("/meetRegister")
	public @ResponseBody ResponseDTO<?> registerMeet(@RequestBody Meetingroom meetingroom) {

		System.out.println("회의실 신규등록");
		meetingroom.setMrStatus(MrStatus.사용가능);

		meetingroomService.registerMeet(meetingroom);

		return new ResponseDTO<>(HttpStatus.OK.value(), "등록 완료");

	}

	@GetMapping("/carRegister")
	public String registerCar(Model model) {
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/carRegister.jsp");
		return "index";
	}

	@PostMapping("/carRegister")
	public @ResponseBody ResponseDTO<?> registerCar(@RequestBody Car car) {

		System.out.println("차량신규등록");
		car.setCarStatus(CarStatus.사용가능);

		carService.regiserCar(car);

		return new ResponseDTO<>(HttpStatus.OK.value(), "등록완료");
	}

}
