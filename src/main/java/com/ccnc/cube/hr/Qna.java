package com.ccnc.cube.hr;

import java.time.LocalDateTime;

import com.ccnc.cube.common.CommonEnum.QnaStatus;
import com.ccnc.cube.user.Users;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "QNA")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Qna {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "QNA_ID")
    private Integer qnaId;
	
	@Column(name = "QNA_EMAIL", nullable = false)
    private String qnaEmail;

	@Column(name = "QNA_TITLE", nullable = false)
    private String qnaTitle;
	
	@Column(name = "QNA_CONTENT", nullable = false, columnDefinition = "TEXT")
    private String qnaContent;
		
	@Column(name = "QNA_STATUS", nullable = false)
	@Enumerated(EnumType.STRING)
    private QnaStatus qnaStatus = QnaStatus.대기중;
	
	@ManyToOne
	@JoinColumn(name = "QNA_REWRITER")
	private Users qnaReWriter;
	
	@Column(name = "QNA_REPLY", columnDefinition = "TEXT")
	private String qnaReply;
	
	@Column(name = "QNA_CREATED", nullable = false)
    private LocalDateTime qnaCreated = LocalDateTime.now();
    
    @Column(name = "QNA_UPDATED")
    private LocalDateTime qnaReplyed;
}

