package com.ccnc.cube.mail;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.common.CommonEnum.MailImportant;
import com.ccnc.cube.common.CommonEnum.MailIsDelete;

@Repository
public interface ReceiveMailRepository extends JpaRepository<ReceiveMail, Integer> {

	//List<ReceiveMail> findByReceiveMailReceiverEmail(String receiveMailReceiverEmail);
	//로그인한 유저의 getUserEmail이 receiveMailReceiverEmail과 같으면서 receiveMailIsDelete가 '존재'이고 receiveMailImportant가 '기본'인 구문:
	Page<ReceiveMail> findByReceiveMailReceiverEmailAndReceiveMailIsDeleteAndReceiveMailImportant(String userEmail, MailIsDelete isDelete, MailImportant important, Pageable pageable);
	List<ReceiveMail> findByReceiveMailReceiverEmailAndReceiveMailIsDeleteAndReceiveMailImportant(String userEmail, MailIsDelete isDelete, MailImportant important);
	//List<ReceiveMail> findByReceiveMailTitleContaining(String receiveMailTitle);
	
	List<ReceiveMail> findByReceiveMailTitleContainingAndReceiveMailReceiverEmail(String receiveMailTitle, String receiveMailReceiverEmail);
	   
	List<ReceiveMail> findByReceiveMailReceiverUserNameContainingAndReceiveMailReceiverEmail(String receiveMailReceiverUserName, String receiveMailReceiverEmail);
	
	List<ReceiveMail> findByReceiveMailContentContainingAndReceiveMailReceiverEmail(String receiveMailContent, String receiveMailReceiverEmail);

	
  
	}
