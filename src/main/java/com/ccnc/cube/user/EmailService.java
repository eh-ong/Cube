package com.ccnc.cube.user;

import java.io.IOException;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.ccnc.cube.hr.Qna;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {
	
	@Autowired
	private JavaMailSender javaMailSender;

/*	
	//이메일 전송 방법1
	public String sendEmail(EmailMessage emailMessage) {
		String code = createCode();
		
		MimeMessage mimeMessage = javaMailSender.createMimeMessage();
		
		try {
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");
			mimeMessageHelper.setTo(emailMessage.getTo());  //메일 수신자
			mimeMessageHelper.setSubject(emailMessage.getSubject());  //메일 제목
			mimeMessageHelper.setText(authNum, false);  //메일 본문 내용, HTML 여부
			javaMailSender.send(mimeMessage);
			
			return code;
			
		} catch(MessagingException e) {
			System.out.println(e);
			throw new RuntimeException(e);
		}
	}
*/	
	
	public String sendEmailCheckCode(EmailMessage emailMessage) throws MessagingException, IOException {
		String code = createCode();
		
		String html = checkCodeHtml(code);
		
		MimeMessage mimeMessage = javaMailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "UTF-8");
		
		helper.setTo(emailMessage.getTo());
		helper.setSubject(emailMessage.getSubject());
		helper.setText(html, true);
		
		javaMailSender.send(mimeMessage);
		
		return code;
	}
	
	//인증번호 및 임시 비밀번호 생성 메소드
	public String createCode() {
		Random random = new Random();
		StringBuffer key = new StringBuffer();
		
		for(int i = 0 ; i < 8 ; i++) {
			int index = random.nextInt(4);
			
			switch (index) {
			case 0: key.append((char) ((int) random.nextInt(26) + 97)); break;
			case 1: key.append((char) ((int) random.nextInt(26) + 65)); break;
			default: key.append(random.nextInt(9));
			}
		}
		return key.toString();
	}
	
	//html 적용
	public String checkCodeHtml(String code) {
		//HTML 문자열을 동적으로 생성
		String html = "<!DOCTYPE html>\n" +
                "<html>\n" +
                "<body>\n" +
                "<div style=\"margin:100px;\">\n" +
                "    <h1> 안녕하세요. </h1>\n" +
                "    <h1> 그룹웨어 CUBE 에서 인증번호 안내드립니다. </h1>\n" +
                "	 <br>\n" +
                "    <p>아래 발급된 인증번호를 입력해주세요.</p>\n" +
                "	 <br>\n" +
                "	 <div align=\"center\" style=\"border:1px solid black;\">\n" +
                "    	<h3>" + code + "</h3>\n" +
                "	 </div>\n" +
                "</div>\n" +
                "</body>\n" +
                "</html>";
		return html;
	}
	
	
	public void sendEmailQnaReply(EmailMessage emailMessage, Qna qna) throws MessagingException, IOException {
		String html = qnaReplyHtml(qna.getQnaTitle(), qna.getQnaContent(), qna.getQnaReply());
		
		MimeMessage mimeMessage = javaMailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "UTF-8");
		
		helper.setTo(emailMessage.getTo());
		helper.setSubject(emailMessage.getSubject());
		helper.setText(html, true);
		
		javaMailSender.send(mimeMessage);
		
	}
	
	//html 적용
	public String qnaReplyHtml(String qnaTitle, String qnaContent, String qnaReply) {
		//HTML 문자열을 동적으로 생성
		String html = "<!DOCTYPE html>\n" +
                "<html>\n" +
                "<body>\n" +
                "<div style=\"margin:100px;\">\n" +
                "    <h1> 안녕하세요. </h1>\n" +
                "    <h1> 그룹웨어 CUBE 에서 문의하신 내용에 대해 답변 드립니다. </h1>\n" +
                "	 <br>\n" +
                "    <p>ㆍ문의 제목: " + qnaTitle + "</p>\n" +
                "    <p>ㆍ문의 내용: " + qnaContent + "</p>\n" +
                "	 <br>\n" +
                "	 <div align=\"center\" style=\"border:1px solid black;\">\n" +
                "    	<h3>" + qnaReply + "</h3>\n" +
                "	 </div>\n" +
                "</div>\n" +
                "</body>\n" +
                "</html>";
		return html;
	}

}
