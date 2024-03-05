package com.ccnc.cube.user;

import java.time.LocalDate;

import com.ccnc.cube.common.CommonEnum;
import com.ccnc.cube.common.Team;
import com.ccnc.cube.common.CommonEnum.UserGender;
import com.ccnc.cube.common.CommonEnum.UserPosition;
import com.ccnc.cube.common.CommonEnum.UserRole;
import com.ccnc.cube.common.CommonEnum.UserStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "USERS")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Users {

    @Id
    @Column(name = "USER_ID", length = 20)
    private String userId;

    @Column(name = "USER_PW", nullable = false, length = 20)
    private String userPw;

    @Column(name = "USER_NUM", unique = true, nullable = false, length = 8)
    private String userNum;

    @Column(name = "USER_NAME", nullable = false, length = 20)
    private String userName;

    @Column(name = "USER_GENDER", nullable = false)
    @Enumerated(EnumType.STRING)
    private UserGender userGender;

    @Column(name = "USER_ZIPCODE", nullable = false, length = 5)
    private String userZipCode;
    
    @Column(name = "USER_ADDR", nullable = false, length = 100)
    private String userAddr;
    
    @Column(name = "USER_ADDRDETAIL", nullable = false, length = 30)
    private String userAddrDetail;

    @Column(name = "USER_MOBILE", unique = true, nullable = false, length = 11)
    private String userMobile;

    @Column(name = "USER_EMAIL", unique = true, nullable = false, length = 30)
    private String userEmail;
    
    @Column(name = "USER_EMAIL_EX", unique = true, nullable = false, length = 30)
    private String userEmailEx;

    @ManyToOne
    @JoinColumn(name = "USER_TEAM_ID")
    private Team userTeamId;

    @Column(name = "USER_STATUS", nullable = false)
    @Enumerated(EnumType.STRING)
    private UserStatus userStatus = UserStatus.비활성화;

    @Column(name = "USER_ROLE", nullable = false)
    @Enumerated(EnumType.STRING)
    private UserRole userRole = UserRole.USER;

    @Column(name = "USER_POSITION", nullable = false)
    @Enumerated(EnumType.STRING)
    private UserPosition userPosition = UserPosition.팀원;

    @Column(name = "USER_HIRE_DATE", nullable = false)
    private LocalDate userHireDate = LocalDate.now();
    
    @Column(name = "USER_FILE_NAME")
    private String userFileName;  //프로필 사진 파일 이름
    
    @Column(name = "USER_FILE_PATH")
    private String userFilePath;// 파일 저장 경로
    
    @Column(name = "USER_VACATION_DAY")
    private Integer userVacationDay;//휴가 일수
    
    @Column(name = "USER_REMAIN_VACATION")
    private Double userRemainVacation;//남은 휴가 일수
    
    @Override
	public String toString() {
		return userName + "(" + userNum + ")";
	}
}

