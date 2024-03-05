package com.ccnc.cube.mail;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.ccnc.cube.common.CommonEnum.MailImportant;
import com.ccnc.cube.common.CommonEnum.MailIsDelete;

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
@Table(name = "SENDMAIL")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SendMail {

    @Id
    @Column(name = "SENDMAIL_ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer sendMailId;

    @Column(name = "SENDMAIL_SENDER_EMAIL" , nullable = false)
    private String sendMailSenderEmail;
    
    @Column(name = "SENDMAIL_RECEIVER_EMAIL", nullable = false)
    private String sendMailReceiverEmail;
    
    @Column(name = "SENDMAIL_TITLE", nullable = false)
    private String sendMailTitle;
    
    @Column(name = "SENDMAIL_CONTENT", nullable = false)
    private String sendMailContent;
    
    @Column(name = "SENDMAIL_SENDERUSERNAME")
    private String sendMailSenderUserName;
    
    @Column(name = "SENDMAIL_RECEIVERUSERNAME")
    private String sendMailReceiverUserName;
    
    @Lob
    @Column(name = "SENDMAIL_FILE")
    private byte[] sendMailFile;
    
	/*
	 * @Column(name = "SENDMAIL_SENT_DATE") private LocalDateTime sendMailSentDate =
	 * LocalDateTime.now();
	 */
    
    @Column(name = "SENDMAIL_RESERVATION_DATE")
    private LocalDateTime sendMailReservationDate;
    
	
	 @Column(name = "MAIL_READ_DATE")
	 private LocalDateTime mailReadDate;
	 
    
    @Column(name = "SENDMAIL_ISDELETE")
    @Enumerated(EnumType.STRING)
    private MailIsDelete sendMailIsDelete = MailIsDelete.존재;
    
    @Column(name = "SENDMAIL_IMPORTANT")
    @Enumerated(EnumType.STRING)
    private MailImportant sendMailImportant = MailImportant.기본;

	/*
	 * @Column(name = "MAIL_READ_STATUS")
	 * 
	 * @Enumerated(EnumType.STRING) private MailReadStatus mailReadStatus =
	 * MailReadStatus.읽지않음;
	 */
    public String getFormattedSendMailSentDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초");
        return sendMailReservationDate.format(formatter);
    }
    
  

}

