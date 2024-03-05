package com.ccnc.cube.my;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ccnc.cube.common.ResponseDTO;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class MyController {
	
	@Autowired
	UserService userService;
		
	@GetMapping("/my_main")
	public String myPage(Model model) {
		System.out.println("마이 메인 페이지 요청됨");
		model.addAttribute("asidePage", "./my/my_aside.jsp");
		model.addAttribute("mainPage", "./my/my_main.jsp");
		return "index";
	}
	
	@GetMapping("/my_profileCheckPw")
	public String myProfileCheckPwPage(Model model) {
		System.out.println("마이 비밀번호 확인 페이지 요청됨");
		model.addAttribute("asidePage", "./my/my_aside.jsp");
		model.addAttribute("mainPage", "./my/profileCheckPw.jsp");
		return "index";
	}
	
	@PostMapping("/my_checkPw")
	public @ResponseBody ResponseDTO<?> myCheckPw(@RequestBody Users user, HttpSession session, Model model) {
		System.out.println("마이 비밀번호 확인 요청됨");
		Users loginUser = (Users) session.getAttribute("login_user");
		if(loginUser.getUserPw().equals(user.getUserPw())) {
			return new ResponseDTO<>(HttpStatus.OK.value(), "비밀번호 확인 완료");
		} else {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "비밀번호가 일치하지 않습니다.");
		}
	}
	
	@GetMapping("/my_profile")
	public String myProfilePage(HttpSession session, Model model) {
		System.out.println("마이 프로필 페이지 요청됨");
		model.addAttribute("user", (Users) session.getAttribute("login_user"));
		model.addAttribute("asidePage", "./my/my_aside.jsp");
		model.addAttribute("mainPage", "./my/profile.jsp");
		return "index";
	}
	
	@GetMapping("/my_updateProfile")
	public String updateProfilePage(HttpSession session, Model model) {
		System.out.println("마이 프로필 수정 페이지 요청됨");
		model.addAttribute("user", (Users) session.getAttribute("login_user"));
		model.addAttribute("asidePage", "./my/my_aside.jsp");
		model.addAttribute("mainPage", "./my/updateProfile.jsp");
		return "index";
	}
	
	@PostMapping("/my_updateProfile")
	public @ResponseBody ResponseDTO<?> updateProfile(@RequestBody Users user, HttpSession session, Model model) {
		System.out.println("마이 프로필 수정 요청됨");
		Users findUser = userService.getUser(user.getUserId());
		if(user.getUserZipCode() != null && !user.getUserZipCode().equals("")) {
			findUser.setUserZipCode(user.getUserZipCode());
		}
		if(user.getUserAddr() != null && !user.getUserAddr().equals("")) {
			findUser.setUserAddr(user.getUserAddr());
		}
		if(user.getUserAddrDetail() != null && !user.getUserAddrDetail().equals("")) {
			findUser.setUserAddrDetail(user.getUserAddrDetail());
		}
		if(user.getUserMobile() != null && !user.getUserMobile().equals("")) {
			findUser.setUserMobile(user.getUserMobile());
		}
		if(user.getUserEmailEx() != null && !user.getUserEmailEx().equals("")) {
			findUser.setUserEmailEx(user.getUserEmailEx());
		}
		System.out.println(findUser);
		
		userService.saveUser(findUser);
		
		session.setAttribute("login_user", findUser);
		
		return new ResponseDTO<>(HttpStatus.OK.value(), "내 정보 수정 성공");
	}
	
	@PostMapping("/my_uploadFile/{userId}")
	public @ResponseBody ResponseDTO<?> uploadFile(@PathVariable String userId, @RequestParam("file") MultipartFile file, HttpSession session) throws Exception{
		System.out.println("마이 프로필 사진 업로드 요청됨");
		Users findUser = userService.getUser(userId);
		
		//파일 업로드 시작
		
//		(window용)
//		String projectPath = System.getProperty("user.dir") //프로젝트 경로 가져오기
//				+ "\\src\\main\\resources\\static\\files"; //파일이 저장될 폴더 경로
		
//		(MAC용)
		String projectPath = System.getProperty("user.dir") //프로젝트 경로 가져오기
				+ "/src/main/resources/static/files";
		
		UUID uuid = UUID.randomUUID(); //랜덤으로 식별자 생성
		
		String filename = uuid + "_" + file.getOriginalFilename(); //UUID와 파일 이름을 포함한 파일 이름으로 저장
		
		File saveFile = new File(projectPath, filename);
		
		file.transferTo(saveFile);
		
		findUser.setUserFileName(filename);
		findUser.setUserFilePath("/files/" + filename);
		
		userService.saveUser(findUser);
		
		session.setAttribute("login_user", findUser);		
		
		return new ResponseDTO<>(HttpStatus.OK.value(), "");
	}
	
	@GetMapping("/my_changePwCheckPw")
	public String myChanePwCheckPage(Model model) {
		System.out.println("마이 비밀번호 변경 비밀번호 확인 페이지 요청됨");
		model.addAttribute("asidePage", "./my/my_aside.jsp");
		model.addAttribute("mainPage", "./my/changePwCheckPw.jsp");
		return "index";
	}
	
	@GetMapping("/my_changePw")
	public String myChanePwPage(HttpSession session, Model model) {
		System.out.println("마이 비밀번호 변경 페이지 요청됨");
		model.addAttribute("user", (Users) session.getAttribute("login_user"));
		model.addAttribute("asidePage", "./my/my_aside.jsp");
		model.addAttribute("mainPage", "./my/changePw.jsp");
		return "index";
	}
	
	@PostMapping("/my_changePw")
	public @ResponseBody ResponseDTO<?> myChangePw(@RequestBody Users user) {
		System.out.println("마이 비밀번호 변경 요청됨");
		Users findUser = userService.getUser(user.getUserId());
		findUser.setUserPw(user.getUserPw());
		userService.saveUser(findUser);
		return new ResponseDTO<>(HttpStatus.OK.value(), "비밀번호 변경이 완료되었습니다.");
	}

}
