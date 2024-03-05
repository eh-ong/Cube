package com.ccnc.cube.project;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccnc.cube.common.CommonEnum.PrStatus;
import com.ccnc.cube.common.ResponseDTO;
import com.ccnc.cube.common.TeamService;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class ProjectController {
		
	@Autowired
	UserService userService;
	
	@Autowired
	TeamService teamService;

	@Autowired
	ProjectService projectService;
	
	@Autowired
	PrMemberService prMemberService;
	
	@Autowired
	PrProgressService prProgressService;
		
	@GetMapping("/pr_main")
	public String prMainPage(Model model) {
		System.out.println("프로젝트 페이지 요청됨");
		model.addAttribute("asidePage", "./project/pr_aside.jsp");
		model.addAttribute("mainPage", "./project/pr_main.jsp");
		return "index";
	}
	
	@GetMapping("/pr_new")
	public String prNewPage(Model model) {
		System.out.println("프로젝트 새프로젝트 페이지 요청됨");
		model.addAttribute("userList", userService.getUserList());
		model.addAttribute("teamList", teamService.getTeamList());
		model.addAttribute("asidePage", "./project/pr_aside.jsp");
		model.addAttribute("mainPage", "./project/pr_new.jsp");
		return "index";
	}

//새프로젝트 저장 참가자가 추가된 경우
	@PostMapping("/pr_saveNewPr/{usersNumStr}")
	public @ResponseBody ResponseDTO<?> saveNewPr(@RequestBody Project project, @PathVariable String usersNumStr, HttpSession session, Model model) {
		System.out.println("프로젝트 새프로젝트 저장 요청됨");
						
		Users loginUser = (Users) session.getAttribute("login_user");
		project.setProjectWriter(loginUser);
		project.setProjectCreated(LocalDateTime.now());		
		Project pr = projectService.saveProject(project);
		
		PrMember prMember = new PrMember();
		prMember.setPrMemberProject(pr);
		prMember.setPrMemberUser(loginUser);
		prMemberService.savePrMember(prMember);
		
		System.out.println(usersNumStr);
			
		if(!usersNumStr.equals("-") && usersNumStr != null) {
			String[] usersNumList = usersNumStr.split("&");
			
			for (String userNum : usersNumList) {
				System.out.println(userNum);
				PrMember pm = new PrMember();
				pm.setPrMemberProject(pr);
				pm.setPrMemberUser(userService.findByUserNum(userNum));
				prMemberService.savePrMember(pm);
			}			
		}
			 
		model.addAttribute("pr", pr);
		
		return new ResponseDTO<> (HttpStatus.OK.value(), pr.getProjectId());
	}

//프로젝트 상세 페이지	
	@GetMapping("/pr_detail/{projectId}")
	public String prMainPage(@PathVariable Integer projectId, Model model) {
		System.out.println("프로젝트 상세 페이지 요청됨");
		Project pr = projectService.findProject(projectId);
		model.addAttribute("project", pr);
		model.addAttribute("prMemberList", prMemberService.findByProject(pr));
		model.addAttribute("prProgressList", prProgressService.findByProject(pr));
		model.addAttribute("asidePage", "./project/pr_aside.jsp");
		model.addAttribute("mainPage", "./project/pr_detail.jsp");
		return "index";
	}
	
//프로젝트 수정 페이지	
	@GetMapping("/pr_updatePrPage/{projectId}")
	public String prUpdatePage(@PathVariable Integer projectId, Model model) {
		System.out.println("프로젝트 상세 페이지 요청됨");
		
		Project pr = projectService.findProject(projectId);
		
		List<PrMember> prMemberList = prMemberService.findByProject(pr);
		
		List<Users> userList = userService.getUserList();
		
		for (PrMember prm : prMemberList) {
			userList.remove(prm.getPrMemberUser());			
		}
		model.addAttribute("userList", userList);
		model.addAttribute("project", pr);
		model.addAttribute("prMemberList", prMemberList);
		model.addAttribute("teamList", teamService.getTeamList());
		model.addAttribute("asidePage", "./project/pr_aside.jsp");
		model.addAttribute("mainPage", "./project/pr_update.jsp");
		return "index";
	}
	
//프로젝트 수정
	@PostMapping("/pr_updatePr/{deleteUsersNumStr}/{usersNumStr}")
	public @ResponseBody ResponseDTO<?> updatePr(@RequestBody Project project, @PathVariable String deleteUsersNumStr, @PathVariable String usersNumStr, Model model) {
		System.out.println("프로젝트 수정 요청됨");
		
		Project findPr = projectService.findProject(project.getProjectId());
		findPr.setProjectTitle(project.getProjectTitle());
		findPr.setProjectStartDate(project.getProjectStartDate());
		findPr.setProjectEndDate(project.getProjectEndDate());
		findPr.setProjectCost(project.getProjectCost());
		findPr.setProjectContent(project.getProjectContent());
		findPr.setProjectUpdated(LocalDateTime.now());
		
		Project pr = projectService.saveProject(findPr);
		
		System.out.println(deleteUsersNumStr);
		
		if(!deleteUsersNumStr.equals("-") && deleteUsersNumStr != null) {
			String[] deleteUsersNumList = deleteUsersNumStr.split("&");
			
			for (String deleteUserNum : deleteUsersNumList) {
				System.out.println(deleteUserNum);
				PrMember prm = prMemberService.findByProjectNUser(findPr, userService.findByUserNum(deleteUserNum));
				prMemberService.deletePrMember(prm.getPrMemberId());
			}
		}
		
		System.out.println(usersNumStr);
			
		if(!usersNumStr.equals("-") && usersNumStr != null) {
			String[] usersNumList = usersNumStr.split("&");
			
			for (String userNum : usersNumList) {
				System.out.println(userNum);
				PrMember pm = new PrMember();
				pm.setPrMemberProject(pr);
				pm.setPrMemberUser(userService.findByUserNum(userNum));
				prMemberService.savePrMember(pm);
			}			
		}
			 
		model.addAttribute("pr", pr);
		
		return new ResponseDTO<> (HttpStatus.OK.value(), pr.getProjectId());
	}

//프로젝트 진행함 페이지
	@GetMapping("/pr_inProgressList")
	public String prInProListPage(Model model, HttpSession session) {
		System.out.println("프로젝트 진행함 페이지 요청됨");
		
		Users loginUser = (Users) session.getAttribute("login_user");
		
		List<Project> projectList = new ArrayList<>();
		
		for (PrMember pm : prMemberService.findByUser(loginUser)) {
			projectList.add(pm.getPrMemberProject());
		}
		
		model.addAttribute("projectList", projectList);
		model.addAttribute("asidePage", "./project/pr_aside.jsp");
		model.addAttribute("mainPage", "./project/pr_inProgressList.jsp");
		return "index";
	}
	
//프로젝트 완료함 페이지
	@GetMapping("/pr_completedList")
	public String prComplListPage(Model model, HttpSession session) {
		System.out.println("프로젝트 완료함 페이지 요청됨");
		
		Users loginUser = (Users) session.getAttribute("login_user");
		
		List<Project> projectList = new ArrayList<>();
		
		for (PrMember pm : prMemberService.findByUser(loginUser)) {
			projectList.add(pm.getPrMemberProject());
		}
		
		model.addAttribute("projectList", projectList);
		model.addAttribute("asidePage", "./project/pr_aside.jsp");
		model.addAttribute("mainPage", "./project/pr_completedList.jsp");
		return "index";
	}
	
//프로젝트 중단함 페이지
	@GetMapping("/pr_terminatedList")
	public String prterminatedListPage(Model model, HttpSession session) {
		System.out.println("프로젝트 중단함 페이지 요청됨");
		
		Users loginUser = (Users) session.getAttribute("login_user");
		
		List<Project> projectList = new ArrayList<>();
		
		for (PrMember pm : prMemberService.findByUser(loginUser)) {
			projectList.add(pm.getPrMemberProject());
		}
		
		model.addAttribute("projectList", projectList);
		model.addAttribute("asidePage", "./project/pr_aside.jsp");
		model.addAttribute("mainPage", "./project/pr_terminatedList.jsp");
		return "index";
	}
	
//프로젝트 완료
	@PostMapping("/pr_completePr")
	public @ResponseBody ResponseDTO<?> completePr(@RequestBody Project project, Model model) {
		System.out.println("프로젝트 완료 처리 요청됨");
		Project findPr = projectService.findProject(project.getProjectId());
		findPr.setProjectStatus(PrStatus.완료);
		findPr.setProjectUpdated(LocalDateTime.now());
		projectService.saveProject(findPr);
		
		return new ResponseDTO<> (HttpStatus.OK.value(), findPr.getProjectId());
	}
	
//프로젝트 중단
	@PostMapping("/pr_terminatePr")
	public @ResponseBody ResponseDTO<?> terminatePr(@RequestBody Project project, Model model) {
		System.out.println("프로젝트 중단 처리 요청됨");
		Project findPr = projectService.findProject(project.getProjectId());
		findPr.setProjectStatus(PrStatus.중단);
		findPr.setProjectUpdated(LocalDateTime.now());
		projectService.saveProject(findPr);
		
		return new ResponseDTO<> (HttpStatus.OK.value(), findPr.getProjectId());
	}
	
//프로젝트 진행사항 저장
	@PostMapping("/pr_savePrProgress/{projectId}")
	public @ResponseBody ResponseDTO<?> savePrProgress(@RequestBody PrProgress prProgress, @PathVariable Integer projectId, HttpSession session, Model model) {
		System.out.println("프로젝트 진행사항 저장 요청됨");
		Users loginUser = (Users) session.getAttribute("login_user");
		prProgress.setPrProgressProject(projectService.findProject(projectId));
		prProgress.setPrProgressWriter(loginUser);
		
		prProgressService.savePrProgress(prProgress);
		
		return new ResponseDTO<> (HttpStatus.OK.value(), projectId);
	}
	
//프로젝트 진행사항 삭제
	@PostMapping("/pr_deletePrProgress/{projectId}")
	public @ResponseBody ResponseDTO<?> deletePrProgress(@RequestBody PrProgress prProgress, @PathVariable Integer projectId) {
		System.out.println("프로젝트 진행사항 삭제 요청됨");
		prProgressService.deletePrProgress(prProgress.getPrProgressId());
		
		return new ResponseDTO<> (HttpStatus.OK.value(), projectId);
	}
	
//프로젝트 상세 진행사항 수정 페이지	
	@GetMapping("/pr_updatePrProgressPage/{projectId}/{prProgressId}")
	public String prUpdatePrProgressPage(@PathVariable Integer projectId, @PathVariable Integer prProgressId, Model model) {
		System.out.println("프로젝트 상세 페이지 요청됨");
		Project pr = projectService.findProject(projectId);
		model.addAttribute("project", pr);
		model.addAttribute("prMemberList", prMemberService.findByProject(pr));
		model.addAttribute("prProgressList", prProgressService.findByProject(pr));
		model.addAttribute("prProId", prProgressId);
		model.addAttribute("asidePage", "./project/pr_aside.jsp");
		model.addAttribute("mainPage", "./project/pr_detail_updatePrProgress.jsp");
		return "index";
	}
	
//프로젝트 진행사항 수정
	@PostMapping("/pr_updatePrProgress/{projectId}")
	public @ResponseBody ResponseDTO<?> updatePrProgress(@RequestBody PrProgress prProgress, @PathVariable Integer projectId, HttpSession session, Model model) {
		System.out.println("프로젝트 진행사항 수정 요청됨");
		PrProgress findPrP = prProgressService.findPrProgress(prProgress.getPrProgressId());
		findPrP.setPrProgressContent(prProgress.getPrProgressContent());
		findPrP.setPrProgressUpdated(LocalDateTime.now());
		
		prProgressService.savePrProgress(findPrP);
		
		return new ResponseDTO<> (HttpStatus.OK.value(), projectId);
	}
	
	

}
