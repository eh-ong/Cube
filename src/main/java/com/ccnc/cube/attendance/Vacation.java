package com.ccnc.cube.attendance;

import java.time.LocalDate;

import com.ccnc.cube.common.CommonEnum.VaStatus;
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
@Table(name = "VACATION")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Vacation {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "VA_ID")
	private int vaId;

	@ManyToOne
	@JoinColumn(name = "USER_ID")
	private Users userId;

	@Column(name = "VA_STARTDATE")
	private LocalDate vaStartDate;

	@Column(name = "VA_ENDDATE")
	private LocalDate vaEndDate;

	@Enumerated(EnumType.STRING)
	@Column(name = "VA_STATUS")
	private VaStatus vaStatus = VaStatus.대기중;
	
	@Column(name = "VA_DES")
	private String vaDes;
	
	@Column(name = "VA_TYPE")
	private String vaType;
}
