package com.ccnc.cube.hr;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccnc.cube.common.CommonEnum.QnaStatus;
import com.ccnc.cube.common.ResponseDTO;
import com.ccnc.cube.common.Team;
import com.ccnc.cube.common.TeamService;
import com.ccnc.cube.user.EmailMessage;
import com.ccnc.cube.user.EmailService;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

@Controller
public class HrController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private TeamService teamService;
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private EmailService emailService;

	
	@GetMapping("/hrPage")
	public String attendancePage(Model model) {
		model.addAttribute("asidePage", "./hr/hr_aside.jsp");
		model.addAttribute("mainPage", "./hr/hr_main.jsp");
		return "index";
	}
	
	@GetMapping("/hr_employeePage")
	public String userListPage(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size, Model model) {
		// 요청한 페이지가 1 미만일 경우, 1페이지로 강제 지정
		if (page < 1) {
			page = 1;
		}
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.ASC, "userStatus", "userTeamId.teamName"));

		Page<Users> userPage = userService.getUserListPage(pageable);
		
		// 페이지에 게시글이 없는 경우
		if (!userPage.hasContent()) {
			return "redirect:/hr_employeePage?page=" + (page - 1); // 이전 페이지로 이동
		}
		model.addAttribute("userList", userPage.getContent());
		model.addAttribute("currentPage", userPage.getNumber() + 1);
		model.addAttribute("totalPages", userPage.getTotalPages());
		
		model.addAttribute("teamList", teamService.getTeamList());
		model.addAttribute("asidePage", "./hr/hr_aside.jsp");
		model.addAttribute("mainPage", "./hr/employee.jsp");
		return "index";
	}
	
	@GetMapping("/hr_updateEmployee/{userId}")
	public String updateEmployeePage(@PathVariable String userId, @RequestParam(defaultValue = "1") int page,
		@RequestParam(defaultValue = "10") int size, Model model) {
		System.out.println("임직원 정보 수정 페이지 요청됨");
		
		// 요청한 페이지가 1 미만일 경우, 1페이지로 강제 지정
		if (page < 1) {
			page = 1;
		}
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.ASC, "userStatus", "userTeamId.teamName"));

		Page<Users> userPage = userService.getUserListPage(pageable);
		
		// 페이지에 게시글이 없는 경우
		if (!userPage.hasContent()) {
			return "redirect:/hr_employeePage?page=" + (page - 1); // 이전 페이지로 이동
		}
		model.addAttribute("userList", userPage.getContent());
		model.addAttribute("currentPage", userPage.getNumber() + 1);
		model.addAttribute("totalPages", userPage.getTotalPages());
		
		model.addAttribute("teamList", teamService.getTeamList());
		
		System.out.println(userId);
		model.addAttribute("userId", userId);
		model.addAttribute("asidePage", "./hr/hr_aside.jsp");
		model.addAttribute("mainPage", "./hr/updateEmployee.jsp");
		return "index";
	}
	
	@PostMapping("/hr_updateEmployee")  //팀 소속 없는 경우
	public @ResponseBody ResponseDTO<?> updateEmployee(@RequestBody Users user) {
		System.out.println("임직원 정보 수정 요청됨");
		Users findUser = userService.getUser(user.getUserId());
		findUser.setUserTeamId(null);
		findUser.setUserPosition(user.getUserPosition());
		findUser.setUserStatus(user.getUserStatus());
		userService.saveUser(findUser);
		return new ResponseDTO<>(HttpStatus.OK.value(), "임직원 정보 수정 성공");
	}
	
	@PostMapping("/hr_updateEmployee/{teamId}")  //팀 소속 있는 경우
	public @ResponseBody ResponseDTO<?> updateEmployee(@RequestBody Users user, @PathVariable Integer teamId) {
		System.out.println("임직원 정보 수정 요청됨");
		Users findUser = userService.getUser(user.getUserId());
		findUser.setUserTeamId(teamService.getTeam(teamId));
		findUser.setUserPosition(user.getUserPosition());
		findUser.setUserStatus(user.getUserStatus());
		userService.saveUser(findUser);
		return new ResponseDTO<>(HttpStatus.OK.value(), "임직원 정보 수정 성공");
	}
	
	@GetMapping("/hr_searchEmployee/{searchType}/{searchInput}")
	public String searchEmployee(@PathVariable String searchType, @PathVariable String searchInput, Model model) {
		System.out.println("임직원 정보 검색 요청됨");
		System.out.println(searchType);
		System.out.println(searchInput);
		
		if(searchType.equals("userName")) {
			System.out.println("이름으로 검색 실행");
			model.addAttribute("userList", userService.findByUserNameLike(searchInput));
			
		} else if(searchType.equals("userTeamId")) {
			System.out.println("팀으로 검색 실행");
			List<Users> userList = new ArrayList<>();
			for (Team team : teamService.findByTeamNameLike(searchInput)) {
				userList.addAll(userService.findByTeamId(team));				
			}
			model.addAttribute("userList", userList);
		}
		model.addAttribute("teamList", teamService.getTeamList());
		model.addAttribute("asidePage", "./hr/hr_aside.jsp");
		model.addAttribute("mainPage", "./hr/employee.jsp");
		System.out.println("세팅완료");
		
		return "index";
	}
	
	@GetMapping("/hr_qna")
	public String qna() {
		return "/hr/qna";
	}
	
	@PostMapping("/hr_qna")
	public @ResponseBody ResponseDTO<?> insertQna(@RequestBody Qna qna) {
		qnaService.saveQna(qna);
		return new ResponseDTO<>(HttpStatus.OK.value(),"문의 등록이 완료되었습니다.");
	}
	
	@GetMapping("/hr_qnaList")
	public String qnaListPage(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size, Model model) {
		// 페이지가 1페이지보다 작을 때는 첫 페이지로 강제 지정
		if (page < 1) {
		    return "redirect:/hr_qnaList?page=1";
		}

		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "qnaId"));

		Page<Qna> qnaPage = qnaService.getQnaListPage(pageable);

		// 페이지에 게시글이 없는 경우
		if (!qnaPage.hasContent()) {
		    // 현재 페이지가 1페이지라면 리디렉션을 발생시키지 않고 그대로 뷰를 반환
		    if (page == 1) {
		        model.addAttribute("qnaList", qnaPage.getContent());
		        model.addAttribute("currentPage", qnaPage.getNumber() + 1);
		        model.addAttribute("totalPages", qnaPage.getTotalPages());
		        model.addAttribute("asidePage", "./hr/hr_aside.jsp");
		        model.addAttribute("mainPage", "./hr/qnaList.jsp");
		        return "index";
		    } else {
		        // 이전 페이지로 이동
		        return "redirect:/hr_qnaList?page=" + (page - 1);
		    }
		}

		model.addAttribute("qnaList", qnaPage.getContent());
		model.addAttribute("currentPage", qnaPage.getNumber() + 1);
		model.addAttribute("totalPages", qnaPage.getTotalPages());
		model.addAttribute("asidePage", "./hr/hr_aside.jsp");
		model.addAttribute("mainPage", "./hr/qnaList.jsp");
		return "index";
	}
	
	@GetMapping("/hr_qnaPage/{qnaId}")
	public String qnaPage(@PathVariable Integer qnaId, Model model) {
		model.addAttribute("qna", qnaService.getQna(qnaId));
		model.addAttribute("asidePage", "./hr/hr_aside.jsp");
		model.addAttribute("mainPage", "./hr/qnaPage.jsp");
		return "index";
	}

	
	@PostMapping("/hr_qnaReply")
	public @ResponseBody ResponseDTO<?> qnaReply(@RequestBody Qna qna, HttpSession session) throws MessagingException, IOException {
		System.out.println("문의 답변 등록 및 메일 전송 요청됨");
		
		EmailMessage emailMessage = new EmailMessage(qna.getQnaEmail(), "[CUBE] 문의 사항에 대한 답변 드립니다.", "");
		emailService.sendEmailQnaReply(emailMessage, qna);
		
		Users loginUser = (Users) session.getAttribute("login_user");
		Qna findQna = qnaService.getQna(qna.getQnaId());
		
		findQna.setQnaStatus(QnaStatus.답변완료);
		findQna.setQnaReWriter(loginUser);
		findQna.setQnaReply(qna.getQnaReply());
		findQna.setQnaReplyed(LocalDateTime.now());
		qnaService.saveQna(findQna);
		
		return new ResponseDTO<>(HttpStatus.OK.value(), "문의 답변 메일 전송 완료");
	}
	

}
