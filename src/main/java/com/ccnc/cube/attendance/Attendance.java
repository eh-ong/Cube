package com.ccnc.cube.attendance;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import com.ccnc.cube.common.CommonEnum.AIsWeekend;
import com.ccnc.cube.common.CommonEnum.AStatus;
import com.ccnc.cube.common.CommonEnum.AType;
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
@Table(name = "ATTENDANCE")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attendance {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ATT_ID")
	private int attId;

	@ManyToOne
	@JoinColumn(name = "USER_ID")
	private Users userId;

	@Column(name = "ATT_DATE")
	private LocalDate attDate = LocalDate.now();

	@Column(name = "ATT_START")
	private LocalTime attStart = LocalTime.now();

	@Column(name = "ATT_END")
	private LocalTime attEnd;

	@Enumerated(EnumType.STRING)
	@Column(name = "ATT_ISWEEKEND")
	private AIsWeekend attIsweekend = AIsWeekend.평일;

	@Column(name = "ATT_TYPE")
	@Enumerated(EnumType.STRING)
	private AType attType = AType.정상근무;

	@Column(name = "ATT_DES")
	private String attDes;

	@Column(name = "ATT_OT_START")
	private LocalTime attOtStart;

	@Column(name = "ATT_OT_END")
	private LocalTime attOtEnd;
	
	@Column(name = "ATT_OT_TIME")
	private String attOtTime;

	@Column(name = "ATT_OT_DES")
	private String attOtDes;

	@Column(name = "ATT_STATUS")
	@Enumerated(EnumType.STRING)
	private AStatus attStatus = AStatus.대기중;

	public String getformatattStart() {
		if (attStart != null) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH시 mm분 ss초");
			return attStart.format(formatter);
		} else {
			return null;
		}
	}

	public String getformatattEnd() {
		if (attEnd != null) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH시 mm분 ss초");
			return attEnd.format(formatter);
		} else {
			return null;
		}
	}
	
	public String getformatattOtStart() {
		if (attOtStart != null) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH시 mm분 ss초");
			return attOtStart.format(formatter);
		} else {
			return null;
		}
	}

	public String getformatattOtEnd() {
		if (attOtEnd != null) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH시 mm분 ss초");
			return attOtEnd.format(formatter);
		} else {
			return null;
		}
	}
}
