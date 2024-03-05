package com.ccnc.cube.attendance;

import java.time.LocalDate;
import java.time.LocalTime;

import com.ccnc.cube.common.CommonEnum.ApIsWeekend;
import com.ccnc.cube.common.CommonEnum.ApStatus;
import com.ccnc.cube.common.CommonEnum.ApType;
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
@Table(name = "ATTENDANCEPLAN")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attendanceplan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AP_ID")
    private Integer apId;

    @ManyToOne
    @JoinColumn(name = "USER_ID", nullable = false)
    private Users userId;

    @Column(name = "AP_DATE")
    private LocalDate apDate;
    
    @Column(name = "AP_START")
    private LocalTime apStart = LocalTime.of(9, 0);
    
    @Column(name = "AP_END")
    private LocalTime apEnd = LocalTime.of(18, 0);

    @Column(name = "AP_ISWEEKEND")
    @Enumerated(EnumType.STRING)
    private ApIsWeekend apIsweekend = ApIsWeekend.평일;

    @Column(name = "AP_TYPE")
    @Enumerated(EnumType.STRING)
    private ApType apType = ApType.정상근무;

    @Column(name = "AP_STATUS")
    @Enumerated(EnumType.STRING)
    private ApStatus apStatus = ApStatus.미등록;
    
    @Column(name = "VACATION_APPROVE")
    private boolean vacationApprove = false;
    
}

