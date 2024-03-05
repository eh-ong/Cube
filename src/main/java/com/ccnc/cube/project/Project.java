package com.ccnc.cube.project;

import java.time.LocalDateTime;
import java.util.Date;

import com.ccnc.cube.common.CommonEnum.PrStatus;
import com.ccnc.cube.user.Users;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
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
@Table(name = "PROJECT")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Project {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "PROJECT_ID")
	private Integer projectId;
	
	@ManyToOne
    @JoinColumn(name = "PROJECT_WRITER", nullable = false)
    private Users projectWriter;
	
	@Column(name = "PROJECT_TITLE", nullable = false)
    private String projectTitle;
	
	@Column(name = "PROJECT_CONTENT", nullable = false, columnDefinition = "TEXT")
	private String projectContent;
	
	@Column(name = "PROJECT_COST")
	private Integer projectCost;
	
	@Column(name = "PROJECT_START_DATE", nullable = false)
	private Date projectStartDate;
	
	@Column(name = "PROJECT_END_DATE")
	private Date projectEndDate;
	
	@Column(name = "PROJECT_CREATED", nullable = false)
    private LocalDateTime projectCreated = LocalDateTime.now();
    
    @Column(name = "PROJECT_UPDATED")
    private LocalDateTime projectUpdated;
    
    @Column(name = "PROJECT_STATUS", nullable = false)
    private PrStatus projectStatus = PrStatus.진행중;
    
    /*
    @Column(name = "PROJECT_FILE_NAME")
    private String projectFileName;  //프로필 사진 파일 이름
    
    @Column(name = "PROJECT_FILE_PATH")
    private String projectFilePath;// 파일 저장 경로
    */
    
    /*
    @Lob
    @Column(name = "PROJECT_FILE")
    private byte[] projectFile;
    */

}
