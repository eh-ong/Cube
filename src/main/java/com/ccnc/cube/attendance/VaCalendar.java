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

@Data
public class VaCalendar {

	private Integer vcId;

	private Vacation vaId;

	private LocalDate startDate;

	private LocalDate endDate;

	private String Bgcolor;
		
	private String color;
	
}
