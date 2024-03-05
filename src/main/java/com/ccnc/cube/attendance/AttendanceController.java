package com.ccnc.cube.attendance;

import java.time.DayOfWeek;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.time.YearMonth;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccnc.cube.common.BookmarkService;
import com.ccnc.cube.common.CommonEnum.AIsWeekend;
import com.ccnc.cube.common.CommonEnum.AStatus;
import com.ccnc.cube.common.CommonEnum.AType;
import com.ccnc.cube.common.CommonEnum.ApIsWeekend;
import com.ccnc.cube.common.CommonEnum.ApStatus;
import com.ccnc.cube.common.CommonEnum.ApType;
import com.ccnc.cube.common.CommonEnum.UserStatus;
import com.ccnc.cube.common.CommonEnum.VaStatus;
import com.ccnc.cube.common.ResponseDTO;
import com.ccnc.cube.common.Team;
import com.ccnc.cube.common.TeamService;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class AttendanceController {

	@Autowired
	private AttendanceService attendanceService;

	@Autowired
	private AttendanceplanService attendanceplanService;

	@Autowired
	private TeamService teamService;

	@Autowired
	private UserService userService;

	@Autowired
	private VacationService vacationService;
	
	@Autowired
	private BookmarkService bookmarkService;

//	@GetMapping("/attendancePage") // 근태 메인페이지
//	public String attendance(Model model, HttpSession session) {
//		Users user = (Users) session.getAttribute("login_user");
//		List<Attendance> attList = attendanceService.attList(user);
//		model.addAttribute("attList", attList);
//		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
//		model.addAttribute("mainPage", "./attendance/att_find.jsp");
//		return "index";
//	}

	@GetMapping("/att_FindPage") // 근태 조회
	public String attendanceFind(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		calVacation(user);
		calRemainingVacation(user);
		List<Attendance> attList = attendanceService.attList(user);

		model.addAttribute("attList", attList);
		model.addAttribute("user", user);
		
		model.addAttribute("bookmarkList", bookmarkService.getBookmarkList(user));
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_find.jsp");
		return "index";
	}

	@GetMapping("/attplan_InsertPage") // 근태 계획 등록
	public String attendancePlanInsert(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		List<Attendanceplan> attplanList = new ArrayList<>();
		Double[] vacationArr = calRemainingVacation(user);
		int nextMonth = LocalDate.now().getMonthValue() + 1;
		if (attendanceplanService.findAttplanBydate(user,
				LocalDate.of(LocalDate.now().getYear(), nextMonth, 1)) == null) {
			generateAttplan(user);
			System.out.println("근태 계획 기본 생성");
		}
		;
		int dataSize = attendanceplanService.findAttPlan(user).size();
		for (int i = 0; i < dataSize; i++) {
			int month = attendanceplanService.findAttPlan(user).get(i).getApDate().getMonthValue();
			if (LocalDate.now().plusMonths(1).getMonthValue() == month
					&& attendanceplanService.findAttPlan(user).get(i).getApIsweekend().equals(ApIsWeekend.평일)) {
				attplanList.add(attendanceplanService.findAttPlan(user).get(i));
			}
		}
		model.addAttribute("vacationArr", vacationArr);
		model.addAttribute("attplanList", attplanList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attplan_insert.jsp");
		return "index";
	}

	@PostMapping("/attplanUpdate") // 근태 업데이트
	public String attplanUpdate(@RequestBody List<Map<String, String>> attendanceList, Model model) {
		for (Map<String, String> attendance : attendanceList) {
			Attendanceplan att = attendanceplanService.getAttplan(Integer.parseInt(attendance.get("apId")));
			att.setApStart(attendance.get("apStart") == null ? null : LocalTime.parse(attendance.get("apStart")));
			att.setApEnd(attendance.get("apEnd") == null ? null : LocalTime.parse(attendance.get("apEnd")));
			att.setApType(ApType.valueOf(attendance.get("apType")));
			if (att.getApStatus() == ApStatus.미등록) {
				att.setApStatus(ApStatus.대기중);
			}
			attendanceplanService.saveAttPlan(att);
		}

		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attplan_insert.jsp");
		return "index";
	}

	public List<Attendanceplan> generateAttplan(Users user) {
		LocalDate nextMonth = LocalDate.now().plusMonths(1);
		List<Attendanceplan> attplanList = new ArrayList<>();
		for (int i = 1; i <= nextMonth.lengthOfMonth(); i++) {
			Attendanceplan attplan = new Attendanceplan();
			LocalDate date = LocalDate.of(nextMonth.getYear(), nextMonth.getMonth(), i);
			attplan.setUserId(user);
			attplan.setApDate(date);
			DayOfWeek week = date.getDayOfWeek();
			if (week == DayOfWeek.SATURDAY || week == DayOfWeek.SUNDAY) {
				attplan.setApIsweekend(ApIsWeekend.주말);
				attplan.setApType(null);
				attplan.setApStart(null);
				attplan.setApEnd(null);
			}
			attplanList.add(attplan);
			attendanceplanService.saveAttPlan(attplan);
		}
		return attplanList;
	}

	@GetMapping("/att_Ot_InsertPage") // 초과근무 신청
	public String attendanceOtInsert(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		Attendance findAtt = attendanceService.firstAtt(user, LocalDate.now());
		if (findAtt.getAttOtStart() != null && findAtt.getAttOtEnd() != null) {
			Duration duration = Duration.between(findAtt.getAttOtStart(), findAtt.getAttOtEnd());
			long hours = duration.toHours();
			long minutes = duration.toMinutesPart();
			String time = hours + "시 " + minutes + "분";
			model.addAttribute("time", time);
		}
		model.addAttribute("att", findAtt);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attot_insert.jsp");

		return "index";

	}

	@PostMapping("/otInsert")
	@ResponseBody
	public ResponseDTO<?> otInsert(@RequestBody String otDes, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		Attendance findAtt = attendanceService.firstAtt(user, LocalDate.now());
		if (findAtt.getAttIsweekend() != AIsWeekend.주말) {
			if (LocalDateTime.now().getHour() < 18) {
				return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "초과근무 신청은 오후 18시 이후만 가능합니다.");
			} else {
				findAtt.setAttOtDes(otDes);
				findAtt.setAttOtStart(LocalTime.now());
				attendanceService.InsertAtt(findAtt);
				return new ResponseDTO<>(HttpStatus.OK.value(), "초과근무 신청완료");
			}
		} else {
			findAtt.setAttOtDes(otDes);
			findAtt.setAttOtStart(LocalTime.now());
			attendanceService.InsertAtt(findAtt);
			return new ResponseDTO<>(HttpStatus.OK.value(), "초과근무 신청완료");
		}
	}

	@ResponseBody
	@PostMapping("/otEnd")
	public ResponseDTO<?> otEnd(HttpSession session, @RequestBody Attendance data) {
		Users user = (Users) session.getAttribute("login_user");
		Attendance findAtt = attendanceService.firstAtt(user, LocalDate.now());
		findAtt.setAttOtEnd(LocalTime.now());
		LocalTime endTime = findAtt.getAttOtEnd();
		LocalTime startTime = findAtt.getAttOtStart();
		Duration time = Duration.between(startTime, endTime);
		findAtt.setAttOtTime(time.toHours() + "시간 " + (time.toMinutes() % 60) + "분");
		attendanceService.InsertAtt(findAtt);
		return new ResponseDTO<>(HttpStatus.OK.value(),
				"초과근무 완료: " + time.toHours() + "시간 " + (time.toMinutes() % 60) + "분");
	}

	@GetMapping("/att_Ot_FindPage") // 초과근무 신청내역
	public String attendanceOtFind(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		List<Attendance> attList = attendanceService.attList(user);
		List<Attendance> attotList = new ArrayList<>();
		for (Attendance attot : attList) {
			if (attot.getAttOtStart() != null) {
				attotList.add(attot);
			}
		}
		model.addAttribute("attotList", attotList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attot_find.jsp");
		return "index";
	}

	@GetMapping("/att_Va_InsertPage") // 휴가 신청
	public String attendanceVaInsert(Model model) {
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attva_insert.jsp");
		return "index";
	}

	@ResponseBody
	@PostMapping("/insertVacation") // 휴가신청 등록
	public ResponseDTO<?> vacationInsert(@RequestBody Vacation va, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		va.setUserId(user);

		List<Vacation> vaList = vacationService.vaList(user);
		LocalDate vaStart = va.getVaStartDate(); // 입력한 휴가 시작
		LocalDate vaEnd = va.getVaEndDate(); // 입력한 휴가 종료
		for (Vacation vacation : vaList) {
			LocalDate start = vacation.getVaStartDate(); // 기존 휴가 시작
			LocalDate end = vacation.getVaEndDate(); // 기존 휴가 종료
			if ((vaStart.isBefore(end) || vaStart.isEqual(end)) && (vaEnd.isAfter(start) || vaEnd.isEqual(start))) {
				return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "휴가 기간은 중복될 수 없습니다.");
			}
		}
		vacationService.insertVa(va);
		return new ResponseDTO<>(HttpStatus.OK.value(), "휴가신청 완료");
	}

	public void calVacation(Users user) { // 연차계산기
		LocalDate today = LocalDate.now();
		LocalDate hireDate = user.getUserHireDate();
		if ((today.getDayOfMonth() == 1) || user.getUserVacationDay() == null) { // 1월 1일 아니면 값이 null일때만 실행
			if (hireDate.plusDays(30).isAfter(today)) {
				user.setUserVacationDay(0);
			} else {
				if (today.isBefore(hireDate.plusYears(1))) { // 근속년수 1년미만
					if (today.getYear() == hireDate.getYear()) { // 1년미만 같은 년도이면
						int month = today.getMonthValue()-hireDate.getMonthValue();
						user.setUserVacationDay(month);
					} else {
						int month = today.getMonthValue() + (12 - hireDate.getMonthValue());
						user.setUserVacationDay(month);
					}
				} else if (today.isBefore(hireDate.plusYears(3))) { // 3년 미만은 15일 고정
					user.setUserVacationDay(15);
				} else {
					int duration = 0;
					duration = today.getYear() - hireDate.getYear();
					duration = today.isAfter(hireDate) ? duration : duration--;
					duration = duration / 2;
					if (duration > 10) {
						duration = 10;
					}
					user.setUserVacationDay(15 + duration);
				}
			}
		}
		userService.saveUser(user);
	}

	public Double[] calRemainingVacation(Users user) {
		List<Attendance> attList = attendanceService.attList(user);
		List<Attendanceplan> attplanList = attendanceplanService.findAttPlan(user);
		Double used = 0.0;
		Double use = 0.0;
		Double plan = 0.0;
		Double[] vacationArr = new Double[3];
		for (Attendance att : attList) {
			if (att.getAttType().equals(AType.연차) && (att.getAttDate().getYear() == LocalDate.now().getYear())) {
				used++;
			} else if (att.getAttType().equals(AType.오전반차)
					&& (att.getAttDate().getYear() == LocalDate.now().getYear())) {
				used = used + 0.5;
			} else if (att.getAttType().equals(AType.오전반차)
					&& (att.getAttDate().getYear() == LocalDate.now().getYear())) {
				used = used + 0.5;
			}
		}
		for (Attendanceplan attplan : attplanList) {
			if (attplan.getApType() != null) {
				if (attplan.getApDate().getYear() == LocalDate.now().getYear()) { // 올해
					if (attplan.getApType().equals(ApType.연차) && attplan.getApStatus().equals(ApStatus.승인)) {
						use++;
					} else if (attplan.getApType().equals(ApType.연차) && attplan.getApStatus().equals(ApStatus.대기중)) {
						plan++;
					} else if ((attplan.getApType().equals(ApType.오전반차) || attplan.getApType().equals(ApType.오후반차))
							&& attplan.getApStatus().equals(ApStatus.승인)) {
						use = use + 0.5;
					} else if ((attplan.getApType().equals(ApType.오전반차) || attplan.getApType().equals(ApType.오후반차))
							&& attplan.getApStatus().equals(ApStatus.대기중)) {
						plan = plan + 0.5;
					}
				}
			}
		}
		Double remaining = (user.getUserVacationDay() - used - use - plan);
//		if(LocalDate.now().isBefore(user.getUserHireDate().plusYears(1))){ // 입사한지 1년 미만이면
//		remaining = LocalDate.now().getMonthValue() + (12 - user.getUserHireDate().getMonthValue());
//		}
		user.setUserRemainVacation(remaining);
		userService.saveUser(user);
		vacationArr[0] = use;
		vacationArr[1] = used;
		vacationArr[2] = plan;
		return vacationArr;

	}

	@GetMapping("/att_Va_FindPage") // 휴가 신청 내역 조희
	public String attendanceVaFind(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		List<Vacation> vaList = vacationService.vaList(user);
		model.addAttribute("vaList", vaList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attva_find.jsp");
		return "index";
	}

	@ResponseBody
	@DeleteMapping("/deleteVa/{vaId}") // 휴가 삭제
	public ResponseDTO<?> deleteVa(@PathVariable Integer vaId, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		Vacation va = vacationService.getVa(vaId);
		Attendanceplan vaAtt = attendanceplanService.findAttplanBydate(user, va.getVaStartDate());
		if(vaAtt != null) {
			if (!vaAtt.getApStatus().equals(ApStatus.승인)) {
				vacationService.deleteVa(vaId);
				return new ResponseDTO<>(HttpStatus.OK.value(), "휴가를 취소하였습니다.");
			} else {
				return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "근태 계획을 취소해 주세요.");
			}
		}else {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "근태 계획이 삭제되어 있습니다. 관리자에게 문의해주세요");
		}
		
	}

	@GetMapping("/att_StatisticsPage") // 통계
	public String attendanceStatistics(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		List<Attendance> attList = new ArrayList<>();
		List<Map<LocalDate, Integer>> attTimeList = new ArrayList<>();
		List<Integer> totalOtList = new ArrayList<>(); 
		LocalDate today = LocalDate.now();
		int week = getWeekOfYear(today);
		int otHour = 0;
		int otMinute = 0;
		List<Vacation> vaList = vacationService.vaList(user);

		for (Attendance att : attendanceService.attList(user)) {
			if (getWeekOfYear(att.getAttDate()) == week) { // 이번주만
				LocalTime attStart = att.getAttStart();
				LocalTime attEnd = att.getAttEnd();
				
				if (attStart != null || attEnd != null) { // 근무가 끝난 평일
					Duration attTime = Duration.between(attStart, attEnd);
					int H = attTime.toHoursPart();
					int M = attTime.toMinutesPart();
					int dayTotal = (H * 60) + M;
					dayTotal = (dayTotal > 480) ? 480 : dayTotal;
					Map<LocalDate, Integer> day = new HashMap<>();
					day.put(att.getAttDate(), dayTotal);
					attTimeList.add(day);
					if (att.getAttOtTime() != null) { 
						String ottime = att.getAttOtTime();
						String otHstr = ottime.split(" ")[0];
						String otMstr = ottime.split(" ")[1];
						int otH = Integer.parseInt(otHstr.replace("시간", ""));
						int otM = Integer.parseInt(otMstr.replace("분", ""));
						int totalot = (otH * 60) + otM;
						totalot = (totalot > 240) ? 240 : totalot;
						totalOtList.add(totalot);
					}else {
						totalOtList.add(0);
					}
				}else { // 오늘이거나 주말
					if (att.getAttOtTime() != null) { //주말 출근 초과근무 완료
						String ottime = att.getAttOtTime();
						String otHstr = ottime.split(" ")[0];
						String otMstr = ottime.split(" ")[1];
						int otH = Integer.parseInt(otHstr.replace("시간", ""));
						int otM = Integer.parseInt(otMstr.replace("분", ""));
						int totalot = (otH * 60) + otM;
						totalOtList.add(totalot);
						Map<LocalDate, Integer> day = new HashMap<>();
						day.put(att.getAttDate(),0);
						attTimeList.add(day);
					}
				}
			}
		}
		for (Attendance attot : attendanceService.attList(user)) {
			if (attot.getAttOtEnd() != null && attot.getAttOtStart() != null) {
				if (getWeekOfYear(attot.getAttDate()) == week) {
					Duration time = Duration.between(attot.getAttOtStart(), attot.getAttOtEnd());
					otHour = otHour + time.toHoursPart();
					otMinute = otMinute + time.toMinutesPart();
					if (otMinute > 60) {
						otMinute = otMinute - 60;
						otHour = otHour + 1;
					}
				}
			}
		}
		int workDay = 0;
		for (int i = 1; i <= today.lengthOfMonth(); i++) {
			if (today.withDayOfMonth(i).getDayOfWeek() != DayOfWeek.SATURDAY
					&& today.withDayOfMonth(i).getDayOfWeek() != DayOfWeek.SUNDAY) {
				workDay++;
			}
		}
		for (Attendance att : attendanceService.attList(user)) {
			if (att.getAttDate().getMonthValue() == LocalDate.now().getMonthValue()) {
				if (att.getAttDate().getDayOfWeek() != DayOfWeek.SATURDAY && att.getAttDate().getDayOfWeek() != DayOfWeek.SUNDAY) {
					attList.add(att);
				}
			}
		}
		model.addAttribute("vaList", vaList);
		model.addAttribute("totalOtList", totalOtList);
		model.addAttribute("otHour", otHour);
		model.addAttribute("otMinute", otMinute);
		model.addAttribute("workDay", workDay);// 평일
		model.addAttribute("attTimeList", attTimeList);// 사용자 일주일 근태
		model.addAttribute("attList", attList);// 사용자 근태
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_statistics.jsp");
		return "index";
	}

	public static int getWeekOfYear(LocalDate date) {
		WeekFields weekFields = WeekFields.of(Locale.getDefault());
		return date.get(weekFields.weekOfWeekBasedYear());
	}

	@PostMapping("/insertAtt")
	@ResponseBody
	public void insertAtt(@RequestBody Users user, LocalDate date, LocalTime time) {
		Attendance findAtt = attendanceService.firstAtt(user, date);
		if (findAtt == null) {
			findAtt = new Attendance();
			findAtt.setUserId(user);
			DayOfWeek week = findAtt.getAttDate().getDayOfWeek();
			if (week == DayOfWeek.SATURDAY || week == DayOfWeek.SUNDAY) {
				findAtt.setAttIsweekend(AIsWeekend.주말);
				findAtt.setAttStart(null);
				findAtt.setAttType(AType.주말근무);

				attendanceService.InsertAtt(findAtt);
			} else {
				Attendanceplan att = attendanceplanService.findAttplanBydate(user, date);
				if (att != null) {
					if (att.getApType() != ApType.공가 || att.getApType() != ApType.연차) { // 연차나 공가를 쓴 경우가 아니면
						LocalTime attTime = (att.getApStatus() != ApStatus.승인) ? LocalTime.parse("09:00:00")
								: att.getApStart();

						if (findAtt.getAttStart().isAfter(attTime)) {
							findAtt.setAttType(AType.지각);
						}
					}
					findAtt.setAttEnd(LocalTime.of(18, 0));
//					else {
//						findAtt.setAttType(att.getApType() != ApType.공가 ? AType.공가 : AType.연차); // 이거 왜 만듦?
//					}
				} else {
					if (findAtt.getAttStart().isAfter(LocalTime.parse("09:00:00"))) {
						findAtt.setAttType(AType.지각);
					}
					findAtt.setAttEnd(LocalTime.of(18, 0));
				}
				attendanceService.InsertAtt(findAtt);
			}
		}
	}

	@GetMapping("/att_find_admin") // 관리자 근태 조회
	public String attFindAdmin(Model model, HttpSession sesssion) {
		List<List<Users>> getAllUsers = new ArrayList<List<Users>>();
		List<List<Users>> attUserList = new ArrayList<List<Users>>();
		for (Team team : teamService.getTeamList()) {
			List<Users> userList = userService.findByTeamId(team);
			List<Users> attTeamUsers = new ArrayList<>();
			for (Users user : userList) {
				if (attendanceService.firstAtt(user, LocalDate.now()) != null) {
					attTeamUsers.add(user);
				}
			}
			attUserList.add(attTeamUsers);
			getAllUsers.add(userList);
		}
		model.addAttribute("attUserList", attUserList);
		model.addAttribute("getAllUsers", getAllUsers);
		model.addAttribute("teamList", teamService.getTeamList());
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_find_admin.jsp");
		return "index";
	}

	@ResponseBody
	@PutMapping("/approveAtt") // 관리자 근태 승인
	public void approveAtt(@RequestParam Integer attId) {
		Attendance userAtt = attendanceService.getAtt(attId);
		userAtt.setAttStatus(AStatus.승인);
		attendanceService.InsertAtt(userAtt);
	}

	@ResponseBody
	@PutMapping("/rejectAtt") // 관리자 근태 반려
	public void rejectAtt(@RequestParam Integer attId) {
		Attendance userAtt = attendanceService.getAtt(attId);
		userAtt.setAttStatus(AStatus.반려);
		attendanceService.InsertAtt(userAtt);
	}

	@ResponseBody
	@PutMapping("/approveVa") // 관리자 휴가 승인
	public void approveVa(@RequestParam Integer vaId) {
		Vacation userVa = vacationService.getVa(vaId);
		userVa.setVaStatus(VaStatus.승인);
		vacationService.insertVa(userVa);
	}

	@ResponseBody
	@PutMapping("/rejectVa") // 관리자 휴가 반려
	public void rejectVa(@RequestParam Integer vaId) {
		Vacation userVa = vacationService.getVa(vaId);
		userVa.setVaStatus(VaStatus.반려);
		vacationService.insertVa(userVa);
	}

	@GetMapping("/att_app_admin") // 관리자 근태 계획 승인
	public String attAppAdmin(Model model) {
		List<Users> userList = userService.getUserList();
		List<List<String>> apList = new ArrayList<List<String>>();
		int year = LocalDate.now().getYear();
		for (Users user : userList) {
			List<String> color = new ArrayList<>();
			for (int i = 1; i <= 12; i++) {
				if (LocalDate.now().getMonthValue() + 2 > i) {
					Attendanceplan ap = attendanceplanService.findAttplanBydate(user, LocalDate.of(year, i, 1));
					int lastDay = YearMonth.of(year, i).lengthOfMonth();
					if (ap == null) {
						color.add("red");
					} else {
						if (ap.getApStatus().equals(ApStatus.미등록)) {
							color.add("red");
						} else { // 미등록이 아닐때
							int q = 0;
							for (int k = 1; k <= lastDay; k++) {

								Attendanceplan plan = attendanceplanService.findAttplanBydate(user,
										LocalDate.of(year, i, k));
								if (plan.getApStatus().equals(ApStatus.승인) || plan.getApStatus().equals(ApStatus.반려)) {
									q++;
								}
							}
							if (q >= 0 && q < 10) {
								color.add("green");
							} else if (q > 10 && q < 20) {
								color.add("teal");
							} else {
								color.add("blue");
							}
						}
					}
				} else {
					color.add("grey");
				}
			}
			apList.add(color);
		}
		model.addAttribute("apList", apList);
		model.addAttribute("userList", userList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_app_admin.jsp");
		return "index";
	}

	@GetMapping("/att_appuser_admin/{userId}/{inputMonth}") // 관리자 사용자 근태계획 조회 및 승인
	public String attAppUser(Model model, @PathVariable String userId, @PathVariable int inputMonth) {
		Users user = userService.getUser(userId);
		Month month = Month.of(inputMonth);
		int lastDay = YearMonth.of(LocalDate.now().getYear(), month).lengthOfMonth();
		List<Attendanceplan> apList = new ArrayList<>();
		for (int i = 1; i <= lastDay; i++) {
			if (attendanceplanService.findAttplanBydate(user,LocalDate.of(LocalDate.now().getYear(), month, i)) == null) {
				LocalDate date = LocalDate.of(LocalDate.now().getYear(), month, i);
				Attendanceplan attplan = new Attendanceplan();
				attplan.setUserId(user);
				attplan.setApDate(date);
				DayOfWeek week = date.getDayOfWeek();
				if (week == DayOfWeek.SATURDAY || week == DayOfWeek.SUNDAY) {
					attplan.setApIsweekend(ApIsWeekend.주말);
					attplan.setApType(null);
					attplan.setApStart(null);
					attplan.setApEnd(null);
				}
				attendanceplanService.saveAttPlan(attplan);
				if (attplan.getApIsweekend().equals(ApIsWeekend.평일)) {
					apList.add(attplan);
				}
			} else {
				Attendanceplan attplan = attendanceplanService.findAttplanBydate(user,
						LocalDate.of(LocalDate.now().getYear(), month, i));
				if (attplan.getApIsweekend().equals(ApIsWeekend.평일)) {
					apList.add(attplan);
				}
			}
		}
		List<Map<LocalDate, String[]>> vaTypeList = new ArrayList<>();
		List<Map<LocalDate, String[]>> vaTypeResult = new ArrayList<>();
		for (Vacation va : vacationService.vaList(user)) {
			String[] vaStr = va.getVaType().split(",");
			for (int i = 0; i < vaStr.length; i++) {
				Map<LocalDate, String[]> vaType = new HashMap<>();
				vaType.put(va.getVaStartDate().plusDays(i), new String[] { vaStr[i], va.getVaStatus().name() });
				vaTypeList.add(vaType);
			}
		}
		for (int j = 1; j <= lastDay; j++) { // 리스트 생성
			LocalDate today = LocalDate.of(LocalDate.now().getYear(), inputMonth, j);
			if (today.getDayOfWeek() != DayOfWeek.SATURDAY && today.getDayOfWeek() != DayOfWeek.SUNDAY) {
				Map<LocalDate, String[]> vaTypeMap = new HashMap<>();
				for (Map<LocalDate, String[]> vaType : vaTypeList) {
					if (vaType.containsKey(today)) {
						vaTypeMap.put(today, vaType.get(today));
					}
				}
				vaTypeResult.add(vaTypeMap);
			}
		}
		model.addAttribute("vaTypeResult", vaTypeResult);
		model.addAttribute("inputMonth", inputMonth);
		model.addAttribute("apList", apList);
		model.addAttribute("user", user);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_appuser_admin.jsp");
		return "index";
	}

	@ResponseBody
	@PostMapping("/apSaveAll") // 근태 업데이트
	public void apSaveAll(@RequestBody List<Attendanceplan> apList) {
		for (Attendanceplan ap : apList) {
			Attendanceplan attplan = attendanceplanService.getAttplan(ap.getApId());
			if (!ap.getApStatus().equals(ApStatus.반려)) {
				attplan.setApStatus(ApStatus.승인);
				attendanceplanService.saveAttPlan(attplan);
			}
		}
	}

	@ResponseBody
	@PutMapping("/approveAp") // 관리자 근태계획 승인
	public void approveAp(@RequestParam Integer apId) {
		Attendanceplan userAp = attendanceplanService.getAttplan(apId);
		userAp.setApStatus(ApStatus.승인);
		attendanceplanService.saveAttPlan(userAp);
	}

	@ResponseBody
	@PutMapping("/rejectAp") // 관리자 근태계획 반려
	public void rejectAp(@RequestParam Integer apId) {
		Attendanceplan userAp = attendanceplanService.getAttplan(apId);
		userAp.setApStatus(ApStatus.반려);
		attendanceplanService.saveAttPlan(userAp);
	}

	@GetMapping("/att_allfind_admin/{userId}") // 관리자 사용자 전체 근태 조회
	public String attAllFind(Model model, @PathVariable String userId) {
		Users user = userService.getUser(userId);
		List<Attendance> attList = attendanceService.attList(user);
		model.addAttribute("user", user);
		model.addAttribute("attList", attList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_allfind_admin.jsp");
		return "index";
	}

	@GetMapping("/att_va_admin") // 관리자 휴가 승인
	public String attVaAdmin(Model model) {
		List<Vacation> vaList = vacationService.getVaList();
		List<VaCalendar> vaEventsList = new ArrayList<>();
		for (Vacation va : vaList) {
			VaCalendar event = new VaCalendar();
			event.setVaId(va);
			event.setStartDate(va.getVaStartDate());
			event.setEndDate(va.getVaEndDate().plusDays(1));
			event.setBgcolor(va.getVaStatus() == VaStatus.승인 ? "#007bff"
					: (va.getVaStatus() == VaStatus.대기중 ? "#DADEAA" : "#D34040"));
			vaEventsList.add(event);
		}
		model.addAttribute("vaEventsList", vaEventsList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_va_admin.jsp");
		return "index";
	}

	@GetMapping("/getAttTeam/{teamId}") // 관리자 팀 근태 조회
	public String getAttTeam(Model model, @PathVariable Integer teamId) {
		Team team = teamService.getTeam(teamId);

		List<Attendance> firstAttList = new ArrayList<>();
		List<Attendanceplan> noAttList = new ArrayList<>();
		List<Attendanceplan> noAttPlanUser = new ArrayList<>();
		for (Users user : userService.findByTeamId(team)) {
			if (user.getUserStatus() != UserStatus.비활성화) { // 비활성화 체크
				if (attendanceService.firstAtt(user, LocalDate.now()) != null) { // 오늘 출근 안한사람 체크
					firstAttList.add(attendanceService.firstAtt(user, LocalDate.now()));
				} else {
					if (attendanceplanService.findAttplanBydate(user, LocalDate.now()) != null) { // 출근 안하고, 근태 계획없는사람
																									// 체크
						noAttList.add(attendanceplanService.findAttplanBydate(user, LocalDate.now()));
					} else {
						Attendanceplan attplan = new Attendanceplan();
						attplan.setUserId(user);
						attplan.setApDate(LocalDate.now());
						noAttPlanUser.add(attplan);
					}
				}
			}
		}
		model.addAttribute("noAttPlanUser", noAttPlanUser);
		model.addAttribute("noAttList", noAttList);
		model.addAttribute("firstAttList", firstAttList);
		model.addAttribute("team", team);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_team_admin.jsp");
		return "index";
	}
	
	@GetMapping("/userSearch/{searchType}/{searchInput}")
	public String userSearch(Model model, @PathVariable String searchType, @PathVariable String searchInput) {

		List<Users> userList = new ArrayList<>();
		if(searchType.equals("userName")) {
			userList= userService.findByUserNameLike(searchInput);
			
		} else if(searchType.equals("userTeamId")) {
			
			
			for (Team team : teamService.findByTeamNameLike(searchInput)) {
				for(Users user : userService.findByTeamId(team)) {
					userList.add(user);
				}
			}
			
			
		}
		List<List<String>> apList = new ArrayList<List<String>>();
		int year = LocalDate.now().getYear();
		for (Users user : userList) {
			List<String> color = new ArrayList<>();
			for (int i = 1; i <= 12; i++) {
				if (LocalDate.now().getMonthValue() + 2 > i) {
					Attendanceplan ap = attendanceplanService.findAttplanBydate(user, LocalDate.of(year, i, 1));
					int lastDay = YearMonth.of(year, i).lengthOfMonth();
					if (ap == null) {
						color.add("red");
					} else {
						if (ap.getApStatus().equals(ApStatus.미등록)) {
							color.add("red");
						} else { // 미등록이 아닐때
							int q = 0;
							for (int k = 1; k <= lastDay; k++) {

								Attendanceplan plan = attendanceplanService.findAttplanBydate(user,
										LocalDate.of(year, i, k));
								if (plan.getApStatus().equals(ApStatus.승인) || plan.getApStatus().equals(ApStatus.반려)) {
									q++;
								}
							}
							if (q >= 0 && q < 10) {
								color.add("green");
							} else if (q > 10 && q < 20) {
								color.add("teal");
							} else {
								color.add("blue");
							}
						}
					}
				} else {
					color.add("grey");
				}
			}
			apList.add(color);
		}
		model.addAttribute("apList", apList);
		model.addAttribute("userList", userList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_app_admin.jsp");
		
		return "index";
	}
	
	//--------------------------------------------------------------------------------
	@GetMapping("/attDB") // DB 기입
	public String attDB(Model model, HttpSession sesssion) {
		List<Users> userList = userService.getUserList();
		model.addAttribute("userList", userList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attDB.jsp");
		return "index";
	}
	
	@ResponseBody
	@PostMapping("/addAP")
	public void addAP(@RequestParam String month, @RequestParam String userId, @RequestParam ApStatus status) {
		LocalDate now = LocalDate.of(2024, Integer.parseInt(month), 1);
		if(attendanceplanService.findAttplanBydate(userService.getUser(userId), now) == null) {
			List<Attendanceplan> attplanList = new ArrayList<>();
			for (int i = 1; i <= now.lengthOfMonth(); i++) {
				Attendanceplan attplan = new Attendanceplan();
				LocalDate date = LocalDate.of(now.getYear(), now.getMonth(), i);
				Users user = userService.getUser(userId);
				attplan.setUserId(user);
				attplan.setApDate(date);
				DayOfWeek week = date.getDayOfWeek();
				if (week == DayOfWeek.SATURDAY || week == DayOfWeek.SUNDAY) {
					attplan.setApIsweekend(ApIsWeekend.주말);
					attplan.setApType(null);
					attplan.setApStart(null);
					attplan.setApEnd(null);
				}else {
					attplan.setApStatus(status);
				}
				attplanList.add(attplan);
				attendanceplanService.saveAttPlan(attplan);
			}
		}else {
			for (int i = 1; i <= now.lengthOfMonth(); i++) {
				
				LocalDate date = LocalDate.of(now.getYear(), now.getMonth(), i);
				Users user = userService.getUser(userId);
				Attendanceplan attplan = attendanceplanService.findAttplanBydate(user, date);
				DayOfWeek week = date.getDayOfWeek();
				if (week == DayOfWeek.SATURDAY || week == DayOfWeek.SUNDAY) {
				}else {
					attplan.setApStatus(status);
				}
				attendanceplanService.saveAttPlan(attplan);
			}
		}
	}
	
	@ResponseBody
	@PostMapping("/addAtt")
	public void addAtt(@RequestParam LocalDate day, @RequestParam String userId, @RequestParam String start,@RequestParam String ottime,@RequestParam String ottimeend ) {
		Attendance att = new Attendance();
		LocalTime starttime = LocalTime.parse(start);
		
			LocalTime otstarttime = null;
			LocalTime otendtime = null;
			if(!ottime.equals("") && !ottimeend.equals("")) {
				otstarttime = LocalTime.parse(ottime);
				otendtime = LocalTime.parse(ottimeend);
			
			}
			
		if(attendanceService.firstAtt(userService.getUser(userId), day) == null){
			att.setAttDate(day);
			att.setUserId(userService.getUser(userId));
			att.setAttStart(starttime);
			att.setAttEnd(LocalTime.of(18, 00));
			if(otstarttime != null && otendtime != null) {
				att.setAttOtStart(otstarttime);
				att.setAttOtEnd(otendtime);
			}
		}
		attendanceService.InsertAtt(att);
	}
	
	@ResponseBody
	@PostMapping("/createAtt")
	public void creaetAtt(@RequestParam String month, @RequestParam String userId) {
		LocalDate now = LocalDate.of(2024, Integer.parseInt(month), 1);
		for(int i = 1; i <= now.lengthOfMonth(); i++) {
			if(attendanceService.firstAtt(userService.getUser(userId),LocalDate.of(2024, Integer.parseInt(month), i)) == null) {
				Attendance att = new Attendance();
				att.setAttDate(LocalDate.of(2024, Integer.parseInt(month), i));
				att.setUserId(userService.getUser(userId));
				DayOfWeek week = LocalDate.of(2024, Integer.parseInt(month), i).getDayOfWeek();
				if(week == DayOfWeek.SATURDAY || week == DayOfWeek.SUNDAY) {
					att.setAttIsweekend(AIsWeekend.주말);
					att.setAttType(AType.주말근무);
					att.setAttStart(null);
				}else {
					int m = (int)(Math.random() * (65 - 30 + 1)) + 30;
					int s = (int)(Math.random() * (59 - 1 + 1)) + 1;
					if(m >= 60) {
						att.setAttStart(LocalTime.of(9, m-60, s));
						att.setAttType(AType.지각);
					}else {
						att.setAttStart(LocalTime.of(8, m, s));
						att.setAttType(AType.정상근무);
					}
					att.setAttEnd(LocalTime.of(18, 00));
				}
				attendanceService.InsertAtt(att);
			}
			
		}
	}
	//-----------------------------------------------------------------------------------------
}
