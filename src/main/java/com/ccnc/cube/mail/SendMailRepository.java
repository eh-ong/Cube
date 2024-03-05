package com.ccnc.cube.mail;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.common.CommonEnum.MailImportant;
import com.ccnc.cube.common.CommonEnum.MailIsDelete;

@Repository
public interface SendMailRepository extends JpaRepository<SendMail, Integer> {

	//List<SendMail> findAllBySendMailSenderEmail(String sendMailSenderEmail);
	
	
	List<SendMail> findBySendMailSenderEmailAndSendMailIsDeleteAndSendMailImportant(String userEmail, MailIsDelete isDelete, MailImportant important);
	Page<SendMail> findBySendMailSenderEmailAndSendMailIsDeleteAndSendMailImportant(String userEmail, MailIsDelete isDelete, MailImportant important, Pageable pageable);
	//List<SendMail> findByTeamId(Team team);
	
	List<SendMail> findBySendMailTitleContainingAndSendMailSenderEmail(String sendMailTitle, String sendMailSenderEmail);
	   
	List<SendMail> findBySendMailSenderUserNameContainingAndSendMailSenderEmail(String sendMailSenderUserName, String sendMailSenderEmail);
	
	List<SendMail> findBysendMailContentContainingAndSendMailSenderEmail(String sendMailContent, String sendMailSenderEmail);
	
	List<SendMail> findBySendMailReceiverEmail(String userEmails); // 샌더의 이메일로 유저스 엔티티에 같은 이메일이 있는지 찾는 구문
	
	Optional<SendMail> getSendMailBysendMailId(Integer sendMailId);
}
