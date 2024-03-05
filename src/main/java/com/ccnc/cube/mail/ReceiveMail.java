package com.ccnc.cube.mail;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.ccnc.cube.common.CommonEnum.MailImportant;
import com.ccnc.cube.common.CommonEnum.MailIsDelete;
import com.ccnc.cube.common.CommonEnum.MailReadStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "RECEIVEMAIL")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReceiveMail {

    @Id
    @Column(name = "RECEIVEMAIL_ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer receiveMailId;

    @Column(name = "RECEIVEMAIL_SENDER_EMAIL" , nullable = false)
    private String receiveMailSenderEmail;
    
    @Column(name = "RECEIVEMAIL_RECEIVER_EMAIL", nullable = false)
    private String receiveMailReceiverEmail;
    
    @Column(name = "RECEIVEMAIL_TITLE", nullable = false)
    private String receiveMailTitle;
    
    @Column(name = "RECEIVEMAIL_CONTENT", nullable = false)
    private String receiveMailContent;
    
    @Column(name = "RECEIVEMAIL_SENDERUSERNAME")
    private String receiveMailSenderUserName;
    
    @Column(name = "RECEIVEMAIL_RECEIVERUSERNAME")
    private String receiveMailReceiverUserName;
    
    @Lob
    @Column(name = "RECEIVEMAIL_FILE", nullable = true)
    private byte[] receiveMailFile;
    
	/*
	 * @Column(name = "RECEIVEMAIL_SENT_DATE", nullable = true) private
	 * LocalDateTime receiveMailSentDate = LocalDateTime.now();
	 */
    
    @Column(name = "RECEIVEMAIL_READ_DATE", nullable = true)
    private LocalDateTime receiveMailReadDate;
    
    @Column(name = "RECEIVEMAIL_RESERVATION_DATE")
    private LocalDateTime receiveMailReservationDate;
    
    @Column(name = "RECEIVEMAIL_ISDELETE")
    @Enumerated(EnumType.STRING)
    private MailIsDelete receiveMailIsDelete = MailIsDelete.존재;
    
    @Column(name = "RECEIVEMAIL_IMPORTANT")
    @Enumerated(EnumType.STRING)
    private MailImportant receiveMailImportant = MailImportant.기본;

    @Column(name = "RECEIVEMAIL_READ_STATUS")
    @Enumerated(EnumType.STRING)
    private MailReadStatus receiveMailReadStatus = MailReadStatus.읽지않음;
    
    	
	public ReceiveMail(SendMail sendMail) { 
		receiveMailSenderEmail = sendMail.getSendMailSenderEmail();
		receiveMailTitle = sendMail.getSendMailTitle();
	    receiveMailContent = sendMail.getSendMailContent();
	 }
	
	 public String getFormattedReadDate() {
	        if (receiveMailReadDate != null) {
	            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초");
	            return receiveMailReadDate.format(formatter);
	        } else {
	            return "아직 읽지 않음";
	        }
	    }
	 
	
}

