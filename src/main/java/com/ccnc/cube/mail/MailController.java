package com.ccnc.cube.mail;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
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

import com.ccnc.cube.common.CommonEnum.MailImportant;
import com.ccnc.cube.common.CommonEnum.MailIsDelete;
import com.ccnc.cube.common.CommonEnum.MailReadStatus;
import com.ccnc.cube.common.ResponseDTO;
import com.ccnc.cube.common.TeamService;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;


@Controller
public class MailController {

	@Autowired
	private MailService mailService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private TeamService teamService;

	
//====================================================================================	       메일 메인 화면(완)
	
	@GetMapping("/mailPage")
	public String mailPage(Model model) {
		model.addAttribute("asidePage", "./mail/mail_aside.jsp");
		model.addAttribute("mainPage", "./mail/mail_main.jsp");
		return "index";
	}

//====================================================================================	       보낸 메일 내용 보기 화면(완)
	
	@GetMapping("/getSendMail/{sendMailId}")
	public String getSendMail(@PathVariable Integer sendMailId, Model model) {
		SendMail SendMail = mailService.getSendMail(sendMailId);
		model.addAttribute("SendMail", SendMail);
		model.addAttribute("asidePage", "./mail/mail_aside.jsp");
		model.addAttribute("mainPage", "./mail/sendmail_content.jsp");
		return "index";
	}
	
//====================================================================================	       받은 메일 내용 보기 화면(완)
	
	@GetMapping("/getReceiveMail/{receiveMailId}")
	public String getReceiveMail(@PathVariable Integer receiveMailId, Model model) {
		ReceiveMail receiveMail = mailService.getReceiveMail(receiveMailId);
		if(receiveMail.getReceiveMailReadDate() == null ) {
		receiveMail.setReceiveMailReadDate(LocalDateTime.now());
		receiveMail.setReceiveMailReadStatus(MailReadStatus.읽음);
		}
		mailService.saveReceiveMail(receiveMail);
		model.addAttribute("ReceiveMail", receiveMail);
		model.addAttribute("asidePage", "./mail/mail_aside.jsp");
		model.addAttribute("mainPage", "./mail/receivemail_content.jsp");
		return "index";
	}
	
	
//====================================================================================	       메일 보내기 화면(완)	

	@GetMapping("/mail_send")
	public String mailSend(Model model) {
		model.addAttribute("teamList", teamService.getTeamList());
		model.addAttribute("asidePage", "./mail/mail_aside.jsp");
		model.addAttribute("mainPage", "./mail/mail_send.jsp");
		return "index";
	}
//====================================================================================	       보낸 메일함(완)  
	
	@GetMapping("/sendmail_list")
	public String sendMailList(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size) {
		System.out.println("보낸 메일 리스트 요청됨");
		Users users = (Users)session.getAttribute("login_user");
		String usersMail = users.getUserEmail();
		
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "sendMailId"));
		if (page < 1) {
	        page = 1;
	    }
		//List<SendMail> SendMailList = mailService.sentMailBoxList(usersMail, MailIsDelete.존재, MailImportant.기본);
		Page<SendMail> SendMailPage = mailService.sentMailBoxPage(usersMail, MailIsDelete.존재, MailImportant.기본, pageable);

		
		model.addAttribute("sendMailPage", SendMailPage);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", SendMailPage.getTotalPages());
		model.addAttribute("asidePage", "./mail/mail_aside.jsp");
		model.addAttribute("mainPage", "./mail/sendmail_list.jsp");
		return "index";
	}
	
//====================================================================================	       받은 메일함(완)
		
	@GetMapping("/receivemail_list")
	public String receiveMailList(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size) {
	    System.out.println("받은 메일 리스트 요청됨");
	    Users users = (Users) session.getAttribute("login_user");
	    String usersEmail = users.getUserEmail();
	    
	    Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "receiveMailId"));
	    
	    // 받은 메일 데이터를 가져온다.
	    //List<ReceiveMail> receivedMailList = mailService.receivedMailBoxList(usersEmail, MailIsDelete.존재, MailImportant.기본);
	    Page<ReceiveMail> receiveMailPage = mailService.receivedMailBoxPage(usersEmail, MailIsDelete.존재, MailImportant.기본, pageable);

	    List<ReceiveMail> filteredMailList = new ArrayList<>();
	    for (ReceiveMail mail : receiveMailPage) {
	        if (mail.getReceiveMailReservationDate() == null ||
	                LocalDateTime.now().isAfter(mail.getReceiveMailReservationDate()) ||
	                LocalDateTime.now().isEqual(mail.getReceiveMailReservationDate())) {
	            filteredMailList.add(mail);
	        }
	    }

	    // 새로운 Page 객체 생성
	    int start = (int) pageable.getOffset();
	    int end = Math.min((start + pageable.getPageSize()), filteredMailList.size());
	    Page<ReceiveMail> filteredPage = new PageImpl<>(filteredMailList.subList(start, end), pageable, filteredMailList.size());
	    
	    if (page < 1) {
	        page = 1;
	    }
	    System.out.println("Requested Page: " + page); // 로그 추가
	    // Pageable pageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "receiveMailId"));

	   

	    model.addAttribute("receiveMailPage", filteredPage);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPage", receiveMailPage.getTotalPages());
	    model.addAttribute("asidePage", "./mail/mail_aside.jsp");
	    model.addAttribute("mainPage", "./mail/receivemail_list.jsp");
	    return "index";
	}


	
//====================================================================================	       삭제 메일함(완)
		
	@GetMapping("/isdeletemail_list/{type}")
	public String sendIsdeleteMailList(Model model,HttpSession session,@PathVariable int type, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size) {
		System.out.println("메일 휴지통 리스트 요청됨");
		Users users = (Users)session.getAttribute("login_user");
		String UsersEmail = users.getUserEmail(); 
		
		if(type == 1) {
			Pageable sendPageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "sendMailId"));
			if (page < 1) {
		        page = 1;
		    }
			Page<SendMail> sendMailPage = mailService.sentMailBoxPage(UsersEmail, MailIsDelete.삭제, MailImportant.기본, sendPageable);
			model.addAttribute("IsDeleteEmail", sendMailPage);
			model.addAttribute("TotalPage", sendMailPage.getTotalPages());
			model.addAttribute("CurrentPage", page);
							
		}else {
			Pageable receivePageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "receiveMailId"));
			if (page < 1) {
		        page = 1;
		    }
			Page<ReceiveMail> receiveMailPage = mailService.receivedMailBoxPage(UsersEmail, MailIsDelete.삭제, MailImportant.기본, receivePageable);
			model.addAttribute("IsDeleteEmail", receiveMailPage);
			model.addAttribute("TotalPage", receiveMailPage.getTotalPages());
			model.addAttribute("CurrentPage", page);
						
		}
		model.addAttribute("type",type);
		model.addAttribute("asidePage", "./mail/mail_aside.jsp");
		model.addAttribute("mainPage", "./mail/isdeletemail_list.jsp");
		return "index"; 
	}
	
	//----------------------------------------------------------------
	
//	@GetMapping("/receiveisdeletemail_list")
//	public String receiveIsdeleteMailList(Model model,HttpSession session) {
//		System.out.println("메일 휴지통 리스트 요청됨");
//		Users users = (Users)session.getAttribute("login_user");
//		String UsersEmail = users.getUserEmail(); 
//		model.addAttribute("sendIsDeleteEmail",mailService.sentMailbox(UsersEmail, MailIsDelete.삭제, MailImportant.기본));
//		model.addAttribute("receivedIsDeleteEmail",mailService.receivedMailBox(UsersEmail, MailIsDelete.삭제, MailImportant.기본));
//		model.addAttribute("asidePage", "./mail/mail_aside.jsp");
//		model.addAttribute("mainPage", "./mail/receiveisdeletemail_list.jsp");
//		return "index"; 
//	}
	
//====================================================================================	     받은  중요 메일함(완)
		
	@GetMapping("/importantmail_list/{type}")//보낸 받은 나눔
	public String receiveImportantMailList(Model model, HttpSession session,@PathVariable int type, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size) {
		System.out.println("중요 메일 리스트 요청됨");
		Users users = (Users)session.getAttribute("login_user");
		String UsersEmail = users.getUserEmail();
		
		if(type == 1) {
			Pageable sendPageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "sendMailId"));	
			Page<SendMail> sendMailPage = mailService.sentMailBoxPage(UsersEmail, MailIsDelete.존재, MailImportant.중요, sendPageable);
			if (page < 1) {
		        page = 1;
		    }
			model.addAttribute("ImportantEmail", sendMailPage);
			model.addAttribute("TotalPage", sendMailPage.getTotalPages());
			model.addAttribute("CurrentPage", page);
				
		}else {
			Pageable receivePageable = PageRequest.of(page - 1, size, Sort.by(Sort.Direction.DESC, "receiveMailId"));
			Page<ReceiveMail> receiveMailPage = mailService.receivedMailBoxPage(UsersEmail, MailIsDelete.존재, MailImportant.중요, receivePageable);
			if (page < 1) {
		        page = 1;
		    }
			model.addAttribute("ImportantEmail", receiveMailPage);
			model.addAttribute("TotalPage", receiveMailPage.getTotalPages());
			model.addAttribute("CurrentPage", page);
					
		}
		
		
		
		
		
		model.addAttribute("type",type);
		model.addAttribute("asidePage", "./mail/mail_aside.jsp");
		model.addAttribute("mainPage", "./mail/importantmail_list.jsp");
		return "index";
	}
	
	//-------------------------------------------------------------   보낸 중요메일함
	
//	@GetMapping("/sendimportantmail_list")//보낸 받은 나눔
//	public String sendImportantMailList(Model model, HttpSession session) {
//		System.out.println("중요 메일 리스트 요청됨");
//		Users users = (Users)session.getAttribute("login_user");
//		String UsersEmail = users.getUserEmail();
//		model.addAttribute("sendImportantEmail",mailService.sentMailbox(UsersEmail, MailIsDelete.존재, MailImportant.중요));
//		model.addAttribute("receivedImportantEmail",mailService.receivedMailBox(UsersEmail, MailIsDelete.존재, MailImportant.중요));
//		model.addAttribute("asidePage", "./mail/mail_aside.jsp");
//		model.addAttribute("mainPage", "./mail/sendimportantmail_list.jsp");
//		return "index";
//	}

//====================================================================================	       메일 보내기 기능(완)

	  @ResponseBody
	  @PostMapping("/mail_send")
	  public ResponseDTO<?> mailSend(@RequestBody SendMail sendMail, HttpSession session) {
	  Users users = (Users)session.getAttribute("login_user");
	  sendMail.setSendMailSenderUserName(users.getUserName());
	  String sendMailReceiverUserName = "";
	  
	  String[] receiverArray = sendMail.getSendMailReceiverEmail().split(";");
	  for (String receiver : receiverArray) { //이메일
		  ReceiveMail receiveMail = new ReceiveMail();
		  receiveMail.setReceiveMailContent(sendMail.getSendMailContent());
		  receiveMail.setReceiveMailTitle(sendMail.getSendMailTitle());
		  receiveMail.setReceiveMailReservationDate(sendMail.getSendMailReservationDate());
		  receiveMail.setReceiveMailSenderUserName(sendMail.getSendMailSenderUserName());
		  receiveMail.setReceiveMailSenderEmail(sendMail.getSendMailSenderEmail());
		  receiveMail.setReceiveMailReceiverEmail(receiver); // 이메일 삽입
		
	      String receiverUserName = userService.findByUserEmail(receiver).getUserName() + ";";
	      sendMailReceiverUserName += receiverUserName;
	      
	      receiveMail.setReceiveMailReceiverUserName(receiverUserName); // 받는 사람의 메일에 받는사람 저장
	      mailService.saveReceiveMail(receiveMail);
	      
	  }
	  
	  sendMail.setSendMailReceiverUserName(sendMailReceiverUserName);
	  mailService.saveSendMail(sendMail); // 보내는 메일 저장
	  

	  
	  return new ResponseDTO<>(HttpStatus.OK.value(), "메일 보내기 성공"); 
	}
	 
//====================================================================================	       보낸 메일 휴지통 보내기 기능(완) 
	  
	  
	  @GetMapping("/changeSendIsDelete/{sendMailId}")
	  public String sendMailChangeisdelete(@PathVariable Integer sendMailId) {
	  System.out.println("보낸메일 휴지통 보내기");
	  SendMail findSendMail = mailService.getSendMail(sendMailId);
	  findSendMail.setSendMailIsDelete(MailIsDelete.삭제);
	  mailService.saveSendMail(findSendMail);
	  return "redirect:/sendmail_list"; 
	}
	  
//====================================================================================	       보낸 메일 중요메일함 보내기 기능(완)
	  
	  @GetMapping("/changeSendImportant/{sendMailId}")
	  public String sendMailChangeImportant(@PathVariable Integer sendMailId) {
	  System.out.println("보낸메일 중요메일함 보내기");
	  SendMail findSendMail = mailService.getSendMail(sendMailId);
	  findSendMail.setSendMailImportant(MailImportant.중요);
	  mailService.saveSendMail(findSendMail);
	  return "redirect:/sendmail_list"; 
	}
//====================================================================================	       받은 메일 휴지통 보내기 기능(완)
	  
	  @GetMapping("/changeReceiveIsDelete/{receiveMailId}")
	  public String receiveMailChangeisdelete(@PathVariable Integer receiveMailId) {
	  System.out.println("보낸메일 휴지통 보내기");
	  ReceiveMail findReceiveMail = mailService.getReceiveMail(receiveMailId);
	  findReceiveMail.setReceiveMailIsDelete(MailIsDelete.삭제);
	  mailService.saveReceiveMail(findReceiveMail);
	  return "redirect:/receivemail_list"; }
	  
//====================================================================================	       받은 메일 중요메일함 보내기 기능(완)
	  
	  @GetMapping("/changeReceiveImportant/{receiveMailId}")
	  public String receiveMailChangeImportant(@PathVariable Integer receiveMailId) {
	  System.out.println("보낸메일 중요메일함 보내기");
	  ReceiveMail findReceiveMail = mailService.getReceiveMail(receiveMailId);
	  findReceiveMail.setReceiveMailImportant(MailImportant.중요);
	  mailService.saveReceiveMail(findReceiveMail);
	  return "redirect:/receivemail_list"; }
	
//====================================================================================	       휴지통에서 보낸 메일 완전 삭제 기능
	  
	  @GetMapping("/sendMailIsDelete/{sendMailId}")
      public String sendMailIsDelete(@PathVariable Integer sendMailId) {
	  System.out.println("보낸 메일 완전삭제 요청");
	  mailService.isDeleteSendMail(sendMailId);
	  return "redirect:/isdeletemail_list/1"; }
//====================================================================================	       휴지통에서 받은 메일 완전 삭제 기능
	  
	  @GetMapping("/receiveMailIsDelete/{receiveMailId}")
      public String receiveMailIsDelete(@PathVariable Integer receiveMailId) {
	  mailService.isDeleteReceiveMail(receiveMailId);
	  return "redirect:/isdeletemail_list/2"; }
//====================================================================================	       휴지통에서 보낸 메일 다시 보낸 메일함 보낵기 기능(완)
	  
	  @GetMapping("/recoverySendIsDelete/{sendMailId}")
	  public String sendMailRecoveryisdelete(@PathVariable Integer sendMailId) {
	  System.out.println("휴지통에 있던거 다시 보낸메일함으로 보내기");
	  SendMail findSendMail = mailService.getSendMail(sendMailId);
	  findSendMail.setSendMailIsDelete(MailIsDelete.존재);
	  mailService.saveSendMail(findSendMail);
	  return "redirect:/sendmail_list"; 
	}
	  
//====================================================================================	       휴지통에서 벋은 메일 다시 받은 메일함 보내기 기능(완)
	 
	  @GetMapping("/recoveryReceiveIsDelete/{receiveMailId}")
	  public String receiveMailRecoveryisdelete(@PathVariable Integer receiveMailId) {
	  System.out.println("휴지통에 있던거 다시 받은메일함으로 보내기");
	  ReceiveMail findReceiveMail = mailService.getReceiveMail(receiveMailId);
	  findReceiveMail.setReceiveMailIsDelete(MailIsDelete.존재);
	  mailService.saveReceiveMail(findReceiveMail);
	  return "redirect:/receivemail_list"; }
	  
//====================================================================================	       중요 메일함에서 보낸 메일 다시 보낸 메일함 보내기 기능(완)
	 
	  @GetMapping("/recoverySendImportant/{sendMailId}")
	  public String sendMailRecoveryImportant(@PathVariable Integer sendMailId) {
	  System.out.println("중요에 있던거 다시 보낸메일함으로 보내기");
	  SendMail findSendMail = mailService.getSendMail(sendMailId);
	  findSendMail.setSendMailImportant(MailImportant.기본);
	  mailService.saveSendMail(findSendMail);
	  return "redirect:/sendmail_list"; 
	}
//====================================================================================	       중요 메일함에서 받은 메일 다시 받은 메일함 보내기  기능(완)
	  
	  @GetMapping("/recoveryReceiveImportant/{receiveMailId}")
	  public String receiveMailRecoveryImportant(@PathVariable Integer receiveMailId) {
	  System.out.println("중요에 있던거 다시 받은메일함으로 보내기");
	  ReceiveMail findReceiveMail = mailService.getReceiveMail(receiveMailId);
	  findReceiveMail.setReceiveMailImportant(MailImportant.기본);
	  mailService.saveReceiveMail(findReceiveMail);
	  return "redirect:/receivemail_list"; }
//====================================================================================	       중요 메일함에 있는 받은 메일 휴지통 보내기(완)
	  
	  @GetMapping("/throwReceiveIsDelete/{receiveMailId}")
	  public String importantReceiveMailThrowisdelete(@PathVariable Integer receiveMailId) {
	  System.out.println("중요한 받은 메일 휴지통 보내기");
	  ReceiveMail findReceiveMail = mailService.getReceiveMail(receiveMailId);
	  findReceiveMail.setReceiveMailIsDelete(MailIsDelete.삭제);
	  mailService.saveReceiveMail(findReceiveMail);
	  return "redirect:/importantmail_list"; }
	  
//====================================================================================	       중요 메일함에 있는 보낸 메일 휴지통 보내기(완)
	  
	  @GetMapping("/throwSendIsDelete/{sendMailId}")
	  public String importantSendMailThrowisdelete(@PathVariable Integer sendMailId) {
	  System.out.println("중요한 받은 메일 휴지통 보내기");
	  SendMail findSendMail = mailService.getSendMail(sendMailId);
	  findSendMail.setSendMailIsDelete(MailIsDelete.삭제);
	  mailService.saveSendMail(findSendMail);
	  return "redirect:/importantmail_list"; 
	}
	 
//====================================================================================	       메일 검색(완)
	  
	   @GetMapping("/mail_main/{mailType}/{searchType}/{searchInput}")
	   public String searchSendMail(@PathVariable String mailType, @PathVariable String searchType,
	         @PathVariable String searchInput, Model model, HttpSession session,@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size) {

		   Users users = (Users)session.getAttribute("login_user");
	      //List<SendMail> sendMailList = new ArrayList<>();
		   String UsersEmail = users.getUserEmail();
	      if(mailType.equals("sendMail")) {
	         if (searchType.equals("UserName")) {
	              System.out.println("이름으로 검색 실행");
	              List<SendMail> mailList = mailService.searchBySendMailSenderUserName(searchInput, UsersEmail);
	              model.addAttribute("mailList", mailList);
	         } else if(searchType.equals("MailTitle")) {
	              System.out.println("제목으로 검색 실행");
	              List<SendMail> mailList = mailService.searchBySendMailTitle(searchInput, UsersEmail);
	              model.addAttribute("mailList", mailList);
	         } else if(searchType.equals("MailContent")) {
	              System.out.println("내용으로 검색 실행");
		          List<SendMail> mailList = mailService.searchBySendMailContent(searchInput, UsersEmail);
		          model.addAttribute("mailList", mailList);		         	 
	         }
	         
	      }else if(mailType.equals("receiveMail")) {
	    	  if (searchType.equals("UserName")) {
	              System.out.println("이름으로 검색 실행");
	              List<ReceiveMail> mailList = mailService.searchByReceiveMailReceiverUserName(searchInput, UsersEmail);
	              model.addAttribute("mailList", mailList);
	         } else if(searchType.equals("MailTitle")) {
	              System.out.println("제목으로 검색 실행");
	              List<ReceiveMail> mailList = mailService.searchByReceiveMailTitle(searchInput, UsersEmail);
	              model.addAttribute("mailList", mailList);
	         } else if(searchType.equals("MailContent")) {
	              System.out.println("내용으로 검색 실행");
		          List<ReceiveMail> mailList = mailService.searchByReceiveMailContent(searchInput, UsersEmail);
		          model.addAttribute("mailList", mailList);		         	 
	         }
	          
	      }
	      model.addAttribute("searchMailType", mailType);
	      model.addAttribute("asidePage", "./mail/mail_aside.jsp");
		  model.addAttribute("mainPage", "./mail/mail_main.jsp");
	      return "index";
	   }
	   
	   
//====================================================================================	       자동완성 기능
		/*
		 * @Controller public class AutoComController {
		 * 
		 * @Autowired AutoComService service;
		 * 
		 * @GetMapping("/ajax/autocomplete.do") public @ResponseBody Map<String, Object>
		 * autocomplete(@RequestParam("keyword") String keyword) throws Exception {
		 * 
		 * List<Map<String, Object>> resultList = service.autocomplete(keyword);
		 * Map<String, Object> resultMap = new HashMap<>(); resultMap.put("resultList",
		 * resultList);
		 * 
		 * return resultMap; } }
		 */
	   
//====================================================================================	       답신 보내기 화면(완)
	   
	   @GetMapping("/getReMailSend/{receiveMailId}")
		public String reMailSendContent(@PathVariable Integer receiveMailId, Model model) {
			ReceiveMail receiveMail = mailService.getReceiveMail(receiveMailId);
			model.addAttribute("getReMailSend", receiveMail);
			model.addAttribute("asidePage", "./mail/mail_aside.jsp");
			model.addAttribute("mainPage", "./mail/remail_send.jsp");
			return "index";
		}
	   
//====================================================================================	       답신 보내기 기능
	   
	   @ResponseBody
		  @PostMapping("/mail_resend")
		  public ResponseDTO<?> mailReSend(@RequestBody SendMail sendMail, HttpSession session) {
		  Users users = (Users)session.getAttribute("login_user");
		  sendMail.setSendMailSenderUserName(users.getUserName());
		  String sendMailReceiverUserName = "";
		  
		  String[] receiverArray = sendMail.getSendMailReceiverEmail().split(";");
		  for (String receiver : receiverArray) { //이메일
			  ReceiveMail receiveMail = new ReceiveMail();
			  receiveMail.setReceiveMailContent(sendMail.getSendMailContent());
			  receiveMail.setReceiveMailTitle(sendMail.getSendMailTitle());
			  receiveMail.setReceiveMailReservationDate(sendMail.getSendMailReservationDate());
			  receiveMail.setReceiveMailSenderUserName(sendMail.getSendMailSenderUserName());
			  receiveMail.setReceiveMailSenderEmail(sendMail.getSendMailSenderEmail());
			  receiveMail.setReceiveMailReceiverEmail(receiver); // 이메일 삽입
			
		      String receiverUserName = userService.findByUserEmail(receiver).getUserName() + ";";
		      sendMailReceiverUserName += receiverUserName;
		      
		      receiveMail.setReceiveMailReceiverUserName(receiverUserName); // 받는 사람의 메일에 받는사람 저장
		      mailService.saveReceiveMail(receiveMail);
		      
		  }
		  
		  sendMail.setSendMailReceiverUserName(sendMailReceiverUserName);
		  mailService.saveSendMail(sendMail); // 보내는 메일 저장
		  

		  
		  return new ResponseDTO<>(HttpStatus.OK.value(), "메일 보내기 성공"); 
		}
//---------------------------------------------------------------------
	}
