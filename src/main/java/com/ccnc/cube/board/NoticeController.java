package com.ccnc.cube.board;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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

import com.ccnc.cube.common.ResponseDTO;
import com.ccnc.cube.common.TeamService;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class NoticeController {

	@Autowired
	private NoticeBoardService noticeBoardService;

	@Autowired
	private TeamService teamService;

	@Autowired
	private UserService userService;

	// 페이징 되면 좋겠다.!
	@GetMapping("/listNotice")
	public String getListNoticeBoard(@RequestParam(defaultValue = "1") int page,
	        @RequestParam(defaultValue = "10") int size, Model model, HttpSession session) {
	    // 페이지가 1 미만으로 가지 않도록 처리
	    if (page < 1) {
	        page = 1;
	    }

	    System.out.println("Requested Page: " + page); // 로그 추가

	    Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "nboardId"));
	    Page<NoticeBoard> noticeBoardPage = noticeBoardService.getListNoticeBoard(pageable);

	    if (!noticeBoardPage.hasContent()) {
	        if (page > 1) {
	           
	            return "redirect:/listNotice?page=" + (page - 1);
	        }
	        model.addAttribute("NoticeBoard", new ArrayList<>());
	    } else {
	        
	        model.addAttribute("NoticeBoard", noticeBoardPage.getContent());
	    }

	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", noticeBoardPage.getTotalPages());
	    session.setAttribute("teamList", teamService.getTeamList());
	    model.addAttribute("asidePage", "./board/board_aside.jsp");
	    model.addAttribute("mainPage", "./board/board_getListNotice.jsp");
	    return "index";
	}

	// 조회
	@GetMapping("/getNotice/{nboardId}")
	public String getNotice(@PathVariable Integer nboardId, Model model) {
		NoticeBoard noticeBoard = noticeBoardService.getNoticeBoard(nboardId);
		model.addAttribute("NoticeBoard", noticeBoard);
		model.addAttribute("nboardId", nboardId);
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_getNotice.jsp");
		return "index";
	}

	// 조조회
	@GetMapping("/listNotice/nboardTitle/getNotice/{nboardId}")
	public String getgetNotice(@PathVariable Integer nboardId, Model model) {
		NoticeBoard noticeBoard = noticeBoardService.getNoticeBoard(nboardId);
		model.addAttribute("NoticeBoard", noticeBoard);
		model.addAttribute("nboardId", nboardId);
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_getNotice.jsp");
		return "index";
	}

	@GetMapping("/insertNotice") // 글등록 페이지로 이동
	public String getInsertNotice(Model model) {
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_insertNotice.jsp");
		return "index";
	}

	// 등록 !!!
	@PostMapping("/insertNotice")
	@ResponseBody
	public ResponseDTO<?> insertNoticeBoard(@RequestBody NoticeBoard noticeBoard, HttpSession session) {
		Users users = (Users) session.getAttribute("login_user");
		if (noticeBoard.getNboardContent().equals("") || noticeBoard.getNboardTitle().equals("")) {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "내용을 입력해 주세요");
		} else {
			noticeBoard.setNboardWriter(users);
			noticeBoardService.insertNoticeBoard(noticeBoard);
			return new ResponseDTO<>(HttpStatus.OK.value(), "글 등록 완료");
		}
	}

	// 업데이트 !!!!
	@PostMapping("/updateNotice")
	@ResponseBody
	public ResponseDTO<?> updateNoticeBoard(@RequestBody NoticeBoard noticeBoard, HttpSession session, Model model) {

		Users users = (Users) session.getAttribute("login_user");

		if (noticeBoard.getNboardContent().equals("") || noticeBoard.getNboardTitle().equals("")) {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "내용을 입력해 주세요");

		} else {
			NoticeBoard findNoticeBoard = noticeBoardService.getNoticeBoard(noticeBoard.getNboardId());

			findNoticeBoard.setNboardTitle(noticeBoard.getNboardTitle());
			findNoticeBoard.setNboardContent(noticeBoard.getNboardContent());
			findNoticeBoard.setNboardUpdated(LocalDateTime.now());
			noticeBoardService.updateNoticeBoard(findNoticeBoard);

			model.addAttribute("asidePage", "./board/board_aside.jsp");
			model.addAttribute("mainPage", "./board/board_updateNotice.jsp");

			return new ResponseDTO<>(HttpStatus.OK.value(), "글 수정 완료");
		}
	}

	@GetMapping("/updateNotice/{nboardId}") // 글수정 페이지로 이동
	public String updateNotice(@PathVariable Integer nboardId, Model model) {

		model.addAttribute("NoticeBoard", noticeBoardService.getNoticeBoard(nboardId));
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_updateNotice.jsp");
		return "index";
	}

	// 삭제 !!
	@DeleteMapping("/deleteNotice/{nboardId}")
	public ResponseEntity<?> deleteNoticeBoard(@PathVariable Integer nboardId, Model model) {

		noticeBoardService.deleteNoticeBoard(nboardId);
		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_main.jsp");

		return new ResponseEntity<>(new ResponseDTO<>(HttpStatus.OK.value(), "글 삭제 성공"), HttpStatus.OK);

	}

	/*--------------------------------------------------------------------------------------------------------------------------------
	이름 제목 검색  */
	@GetMapping("/listNotice/{searchType}/{searchInput}")
	public String searchNoticeBoard(@PathVariable String searchType, @PathVariable String searchInput, Model model) {

		if (searchType.equals("userName")) {
			System.out.println("이름으로 검색 실행");
			List<NoticeBoard> nboardList = noticeBoardService.findBynoticeBoardWriterLike(searchInput);
			// model.addAttribute("NoticeBoard", userList);
			model.addAttribute("NoticeBoard", nboardList);
			// model.addAttribute("userList", userService.findByUserNameLike(searchInput));

		} else if (searchType.equals("nboardTitle")) {
			System.out.println("게시글 제목으로 검색 실행");
			List<NoticeBoard> nboardList = noticeBoardService.findBynoticeBoardTitleLike(searchInput);

			model.addAttribute("NoticeBoard", nboardList);
		}

		model.addAttribute("asidePage", "./board/board_aside.jsp");
		model.addAttribute("mainPage", "./board/board_getListNotice.jsp");
		System.out.println("세팅완료");

		return "index";
	}

}
