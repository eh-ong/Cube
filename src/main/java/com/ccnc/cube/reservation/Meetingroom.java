package com.ccnc.cube.reservation;

import com.ccnc.cube.common.CommonEnum.MrStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "MEETINGROOM")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Meetingroom {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "MR_ID")
	private Integer mrId;

	@Column(name = "MR_NAME")
	private String mrName;

	@Column(name = "MR_LOCATION")
	private String mrLocation;
	
	@Column(name = "MR_CAPACITY")
	private Integer mrCapacity;

	@Enumerated(EnumType.STRING)
	@Column(name = "MR_STATUS")
	private MrStatus mrStatus;
}
