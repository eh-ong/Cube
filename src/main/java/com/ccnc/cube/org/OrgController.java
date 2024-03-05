package com.ccnc.cube.org;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccnc.cube.common.CommonEnum.UserStatus;
import com.ccnc.cube.common.Team;
import com.ccnc.cube.common.TeamService;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class OrgController {

	@Autowired
	private TeamService teamService;
	@Autowired
	private UserService userService;

	@GetMapping("/orgPage") // 조직도 메인페이지
	public String orgPage(Model model) {
		List<List<Users>> getAllUsers = new ArrayList<List<Users>>();
		List<Team> teamList = teamService.getTeamList();
		for(Team team : teamService.getTeamList()) {
			List<Users> userList = userService.findByTeamId(team);
			List<Users> activeUserList = new ArrayList<>();
			for(Users user: userList) {
				if(user.getUserStatus().equals(UserStatus.활성화)) {
					activeUserList.add(user);
				}
			}
			getAllUsers.add(activeUserList);
		}
		model.addAttribute("getAllUsers",getAllUsers);
		model.addAttribute("teamList", teamList);
		return "/org/org_main";
	}

	@ResponseBody
	@GetMapping("/orgUsers/{teamId}") //팀원들 출력
	public List<Users> orgUsers(Model model,@PathVariable Integer teamId) {
		List<Users> userList = userService.findByTeamId(teamService.getTeam(teamId));
		List<Users> teamUserList = new ArrayList<>();
		for(Users user: userList) {
			if(user.getUserStatus().equals(UserStatus.활성화)) {
				teamUserList.add(user);
			}
		}
		return teamUserList;
	}
	
	@ResponseBody
	@GetMapping("/userInfo/{userId}") // 유저정보 출력
	public Users orgUserInfo(Model model,@PathVariable String userId) {
		return userService.getUser(userId);
	}
	
	@GetMapping("/orgTeam") // 팀 수정 페이지
	public String orgTeam(Model model, HttpSession session) {
		Team team = ((Users)session.getAttribute("login_user")).getUserTeamId();
		model.addAttribute("userList", userService.getUserList());
		model.addAttribute("team", team);
		model.addAttribute("asidePage", "./org/org_aside.jsp");
		model.addAttribute("mainPage", "./org/org_team.jsp");
		return "index";
	}

	@GetMapping("/getTeamList") // 모든 팀 출력
	@ResponseBody
	public List<Team> getTeamList(Model model) {
		List<Team> teamList = teamService.getTeamList();
		return teamList;
	}

	@GetMapping("/getTeamUsers/{userTeamId}") // 팀 아이디로 팀원들 출력
	@ResponseBody
	public List<Users> getTeamUsers(@PathVariable int userTeamId) {
		Team userTeam = teamService.getTeam(userTeamId);
		List<Users> teamUsers = userService.findByTeamId(userTeam);
		return teamUsers;

	}

	@GetMapping("/mail_send/{receiverEmail}") // 메일로 보내기
	public String orgMailSend(@PathVariable String receiverEmail, Model model) {
		model.addAttribute("receiverEmail", receiverEmail);
		model.addAttribute("asidePage", "./mail/mail_aside.jsp");
		model.addAttribute("mainPage", "./mail/mail_send.jsp");
		return "index";
	}

	@PostMapping("/saveUsersTeam")
	public String saveUsersTeam(@RequestBody List<Map<String, String>> userTeams) {
		for (Map<String, String> userTeam : userTeams) {
			String userId = userTeam.get("userId");
			String teamId = userTeam.get("teamId");
			Integer userTeamId;
			if (teamId != null) {
				userTeamId = teamId.isEmpty() ? null : Integer.parseInt(teamId);
			} else {
				userTeamId = null;
			}
			Users user = userService.getUser(userId);
			if (userTeamId != null) {
				user.setUserTeamId(teamService.getTeam(userTeamId));
				userService.saveUser(user);
			} else {
				user.setUserTeamId(null);
				userService.saveUser(user);
			}
		}
		return "index";
	}

}
