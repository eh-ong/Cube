package com.ccnc.cube.my;

import java.sql.Time;
import java.util.Date;

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
@Table(name = "MY_CALENDAR")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MyCalendar {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "MY_C_ID")
	private Integer myCId;
	
	@ManyToOne
	@JoinColumn(name = "USER_ID", nullable = false)
	private Users user;
	
	@Column(name = "MY_C_START_DATE", nullable = false)
	private Date myCStartDate;
	
	@Column(name = "MY_C_START_TIME")
	private Time myCStartTime;
	
	@Column(name = "MY_C_END_DATE", nullable = false)
	private Date myCEndDate;
	
	@Column(name = "MY_C_END_TIME")
	private Time myCEndTime;
	
	@Column(name = "MY_C_TITLE", nullable = false)
	private String myCTitle;
	
	@Column(name = "MY_C_MEMO")
	private String myCMemo;
	

}

