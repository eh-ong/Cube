package com.ccnc.cube.user;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccnc.cube.attendance.AttendanceController;
import com.ccnc.cube.common.CommonEnum.UserPosition;
import com.ccnc.cube.common.CommonEnum.UserRole;
import com.ccnc.cube.common.CommonEnum.UserStatus;
import com.ccnc.cube.common.ResponseDTO;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	UserService userService;

	@Autowired
	AttendanceController attendanceController;

	@Autowired
	EmailService emailService;

	@GetMapping({ "/", "/login" })
	public String login(HttpSession session) {
		System.out.println("로그인 페이지 요청됨");
		session.invalidate();
		return "certification/login";
	}

	@PostMapping("/login")
	public @ResponseBody ResponseDTO<?> login(@RequestBody Users user, HttpSession session) {
		System.out.println("로그인 요청됨");

		Users findUser = userService.getUser(user.getUserId());
		if (findUser.getUserId() == null) {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "존재하지 않는 아이디입니다.");
		} else if (findUser.getUserStatus().equals(UserStatus.비활성화)) { return new
			 ResponseDTO<>(HttpStatus.BAD_REQUEST.value(),
			 "사용할 수 없는 아이디입니다. 인사팀에 문의해주세요."); }
			 else {
			if (findUser.getUserPw().equals(user.getUserPw())) {
				session.setAttribute("login_user", findUser);
				loginAtt(findUser);
				return new ResponseDTO<>(HttpStatus.OK.value(), findUser.getUserName() + "님 안녕하세요.");
			} else {
				return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "로그인 실패");
			}
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		System.out.println("로그아웃 요청됨");
		session.invalidate();
		return "certification/login";
	}

	@GetMapping("/signUp")
	public String signUp() {
		System.out.println("회원가입 페이지 요청됨");
		return "certification/signUp";
	}

	// 아이디 중복검사
	@PostMapping("/checkId")
	public @ResponseBody ResponseDTO<?> checkId(@RequestBody Users user, Model model) {
		System.out.println("아이디 중복검사 요청됨");
		Users findUser = userService.getUser(user.getUserId());
		if (findUser.getUserId() == null) {
			model.addAttribute("userId", user.getUserId());
			return new ResponseDTO<>(HttpStatus.OK.value(), "사용 가능한 아이디입니다.");
		} else {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "사용 불가능한 아이디입니다.");
		}
	}

	// 휴대전화번호 중복 검사
	@PostMapping("/checkMobile")
	public @ResponseBody ResponseDTO<?> checkMobile(@RequestBody Users user) {
		System.out.println("휴대전화번호 중복검사 요청됨");
		Users findUser = userService.findByUserMobile(user.getUserMobile());
		if (findUser == null) {
			return new ResponseDTO<>(HttpStatus.OK.value(), "사용 가능한 휴대전화번호입니다.");
		} else {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "사용 불가능한 휴대전화번호입니다.");
		}
	}

	// 이메일 중복 검사
	@PostMapping("/checkEmailEx")
	public @ResponseBody ResponseDTO<?> checkEmailEx(@RequestBody Users user) {
		System.out.println("외부 이메일 중복검사 요청됨");
		Users findUser = userService.findByUserEmailEx(user.getUserEmailEx());
		if (findUser == null) {
			return new ResponseDTO<>(HttpStatus.OK.value(), "사용 가능한 이메일입니다.");
		} else {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "사용 불가능한 이메일입니다.");
		}
	}

	@PostMapping("/signUp")
	public @ResponseBody ResponseDTO<?> signUp(@RequestBody Users user) {
		System.out.println("회원가입 요청됨");
		if (userService.findByUserNum(user.getUserNum()) != null) {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "사번을 확인해주세요.");
		} else if (user.getUserZipCode().equals("") || user.getUserZipCode() == null || user.getUserAddr().equals("")
				|| user.getUserAddr() == null) {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "주소를 입력해주세요.");
		} else if (userService.findByUserMobile(user.getUserMobile()) != null) {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "휴대전화번호를 확인해주세요.");
		} else if (userService.findByUserEmailEx(user.getUserEmailEx()) != null) {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "외부 이메일을 확인해주세요.");
		} else {
			user.setUserEmail(user.getUserId() + "@cube.com");
			user.setUserStatus(UserStatus.비활성화);
			user.setUserRole(UserRole.USER);
			user.setUserPosition(UserPosition.팀원);
			userService.saveUser(user);
			return new ResponseDTO<>(HttpStatus.OK.value(), "회원가입 신청이 완료되었습니다.");
		}
	}

	@GetMapping("/findIdPw")
	public String findIdPw() {
		System.out.println("회원정보 찾기 페이지 요청됨");
		return "certification/findIdPw";
	}

	@GetMapping("/findId")
	public String findId() {
		System.out.println("아이디찾기 페이지 요청됨");
		return "certification/findId";
	}

	@PostMapping("/findId")
	public @ResponseBody ResponseDTO<?> findId(@RequestBody Users user, HttpSession session) {
		System.out.println("아이디찾기 회원정보 확인 요청됨");
		Users findUser = userService.findByUserNum(user.getUserNum());
		if (user.getUserName().equals(findUser.getUserName())
				&& user.getUserMobile().equals(findUser.getUserMobile())) {
			System.out.println(findUser.getUserId());
			session.setAttribute("findUser", findUser);
			return new ResponseDTO<>(HttpStatus.OK.value(), "아이디 찾기 성공");
		} else {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "아이디 찾기 실패");
		}

	}

	@GetMapping("/findIdComplete")
	public String findIdComplete() {
		System.out.println("아이디찾기 성공 페이지 요청됨");
		return "certification/findIdComplete";
	}

	@GetMapping("/findPw")
	public String findPw() {
		System.out.println("비밀번호찾기 페이지 요청됨");
		return "certification/findPw";
	}

	@PostMapping("/findPwCheckUser")
	public @ResponseBody ResponseDTO<?> findPwCheckUser(@RequestBody Users user, HttpSession session) {
		System.out.println("비밀번호찾기 회원정보 확인 요청됨");
		Users findUser = userService.getUser(user.getUserId());
		if (user.getUserNum().equals(findUser.getUserNum()) && user.getUserName().equals(findUser.getUserName())
				&& user.getUserMobile().equals(findUser.getUserMobile())) {
			session.setAttribute("findUser", findUser);
			return new ResponseDTO<>(HttpStatus.OK.value(), "회원정보 확인 성공");
		} else {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "회원정보 확인 실패");
		}
	}

	@GetMapping("/findPwCheckCode")
	public String findPwCheckCode(HttpSession session) throws MessagingException, IOException {
		System.out.println("비밀번호찾기 인증번호 확인 페이지 요청됨");
		Users findUser = (Users) session.getAttribute("findUser");

		EmailMessage emailMessage = new EmailMessage(findUser.getUserEmailEx(), "[CUBE] 인증번호 확인", "");
		String sentCode = emailService.sendEmailCheckCode(emailMessage);
		System.out.println(sentCode);
		session.setAttribute("sentCode", sentCode);
		return "certification/findPwCheckCode";
	}

	@PostMapping("/findPwCheckCode")
	public @ResponseBody ResponseDTO<?> findPwCheckCode(@RequestParam("code") String code, HttpSession session) {
		System.out.println("비밀번호찾기 인증번호 확인 요청됨");
		System.out.println(code);
		String sentCode = (String) session.getAttribute("sentCode");
		System.out.println(sentCode);
		if (code.equals(sentCode)) {
			return new ResponseDTO<>(HttpStatus.OK.value(), "인증 성공");
		} else {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "인증 실패");
		}

	}

	@GetMapping("/changePw")
	public String changePw() {
		System.out.println("비밀번호 변경 페이지 요청됨");
		return "certification/changePw";
	}

	@PostMapping("/changePw")
	public @ResponseBody ResponseDTO<?> changePw(@RequestBody Users user, HttpSession session) {
		System.out.println("비밀번호 변경 요청됨");
		Users findUser = (Users) session.getAttribute("findUser");
		findUser.setUserPw(user.getUserPw());
		userService.saveUser(findUser);
		return new ResponseDTO<>(HttpStatus.OK.value(), "비밀번호 변경이 완료되었습니다.");
	}

	// 출석 메소드
	public void loginAtt(Users user) {
		LocalDate currentDate = LocalDate.now();
		LocalTime currentTime = LocalTime.now();
		attendanceController.insertAtt(user, currentDate, currentTime);
	}

}