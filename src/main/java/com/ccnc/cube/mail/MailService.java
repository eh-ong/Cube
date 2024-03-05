package com.ccnc.cube.mail;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccnc.cube.board.NoticeBoard;
import com.ccnc.cube.common.CommonEnum.MailImportant;
import com.ccnc.cube.common.CommonEnum.MailIsDelete;

@Service
public class MailService {
	
	
	
	@Autowired
	private ReceiveMailRepository receiveMailRepository;
	
	@Autowired
	private SendMailRepository sendMailRepository;
/*	
	@Transactional
	public void sendMail(SendMail sendMail) {
		sendMailRepository.save(sendMail);
	}
*/	
	@Transactional
	public void saveSendMail(SendMail sendMail) {
		sendMailRepository.save(sendMail);
	}
	
	@Transactional
	public void saveReceiveMail(ReceiveMail receiveMail) {
		receiveMailRepository.save(receiveMail);
	}

	public void isDeleteSendMail(Integer sendMailId) {
		sendMailRepository.deleteById(sendMailId);
	}
	
	public void isDeleteReceiveMail(Integer receiveMailId) {
		receiveMailRepository.deleteById(receiveMailId);
	}

//======================================================================================	
	@Transactional
	public List<SendMail> sendMailList(){
		return sendMailRepository.findAll(); 
	}
//======================================================================================	
	@Transactional
	public List<ReceiveMail> receiveMailList(){
		return receiveMailRepository.findAll();
	}
//======================================================================================   	보낸 메일함	

	@Transactional
	public List<SendMail> sentMailBoxList(String userEmail, MailIsDelete isDelete, MailImportant important){
		return sendMailRepository.findBySendMailSenderEmailAndSendMailIsDeleteAndSendMailImportant(userEmail,isDelete,important);
	};
	
	public Page<SendMail> sentMailBoxPage(String userEmail, MailIsDelete isDelete, MailImportant important, Pageable pageable){
		return sendMailRepository.findBySendMailSenderEmailAndSendMailIsDeleteAndSendMailImportant(userEmail,isDelete,important, pageable);
	};
	
	
//======================================================================================   받은 메일함	
	
	@Transactional
	public Page<ReceiveMail> receivedMailBoxPage(String userEmail, MailIsDelete isDelete, MailImportant important, Pageable pageable){
		return receiveMailRepository.findByReceiveMailReceiverEmailAndReceiveMailIsDeleteAndReceiveMailImportant(userEmail,isDelete,important,pageable);
	};
	
	@Transactional
	public List<ReceiveMail> receivedMailBoxList(String userEmail, MailIsDelete isDelete, MailImportant important){
		return receiveMailRepository.findByReceiveMailReceiverEmailAndReceiveMailIsDeleteAndReceiveMailImportant(userEmail,isDelete,important);
	};
	
//====================================================================================== 
		
	@Transactional(readOnly = true)
	public SendMail getSendMail(Integer sendMailId){
	 SendMail findSendMail = sendMailRepository.findById(sendMailId).orElseGet(()->{
			return new SendMail();
		});
	 return findSendMail;
	}
	
	@Transactional(readOnly = true)
	public ReceiveMail getReceiveMail(Integer receiveMailId){
	 ReceiveMail findReceiveMail = receiveMailRepository.findById(receiveMailId).orElseGet(()->{
			return new ReceiveMail();
		});
	 return findReceiveMail;
	}

//============================================================================================ 보낸 메일 검색
	
	@Transactional
	public List<SendMail> searchBySendMailTitle(String sendMailTitle, String sendMailSenderEmail) {
        return sendMailRepository.findBySendMailTitleContainingAndSendMailSenderEmail(sendMailTitle, sendMailSenderEmail);
    }

	@Transactional
    public List<SendMail> searchBySendMailSenderUserName(String sendMailSenderUserName, String sendMailSenderEmail) {
        return sendMailRepository.findBySendMailSenderUserNameContainingAndSendMailSenderEmail(sendMailSenderUserName, sendMailSenderEmail);
    }
	
	@Transactional
	public List<SendMail> searchBySendMailContent(String sendMailContent, String sendMailSenderEmail){
		return sendMailRepository.findBysendMailContentContainingAndSendMailSenderEmail(sendMailContent, sendMailSenderEmail);
	}
//============================================================================================ 받은 메일 검색
	
	@Transactional
	public List<ReceiveMail> searchByReceiveMailTitle(String receiveMailTitle, String sendMailSenderEmail) {
		return receiveMailRepository.findByReceiveMailTitleContainingAndReceiveMailReceiverEmail(receiveMailTitle, sendMailSenderEmail);
	}

	@Transactional
	public List<ReceiveMail> searchByReceiveMailReceiverUserName(String receiveMailReceiverUserName, String sendMailSenderEmail) {
	    return receiveMailRepository.findByReceiveMailReceiverUserNameContainingAndReceiveMailReceiverEmail(receiveMailReceiverUserName, sendMailSenderEmail);
	}
		
    @Transactional
	public List<ReceiveMail> searchByReceiveMailContent(String receiveMailContent, String sendMailSenderEmail){
	    return receiveMailRepository.findByReceiveMailContentContainingAndReceiveMailReceiverEmail(receiveMailContent, sendMailSenderEmail);
	}

 //============================================================================================ 메일아이디로 유저네임 찾기	

    public List<SendMail> findSendMailsByUserEmail(String userEmails) {
        return sendMailRepository.findBySendMailReceiverEmail(userEmails);
    }
   
 //--------------------------------------------------------------------------------------------페이징
    
    @Transactional
	public Page<SendMail> getListSendMailList(Pageable pageable) {
		return sendMailRepository.findAll(pageable);
	}
    
    @Transactional
	public Page<ReceiveMail> getListReceiveMailList(Pageable pageable) {
		return receiveMailRepository.findAll(pageable);
	}
	
	
	
	
	
}