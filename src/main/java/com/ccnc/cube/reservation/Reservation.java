package com.ccnc.cube.reservation;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import com.ccnc.cube.common.CommonEnum.MrStatus;
import com.ccnc.cube.common.CommonEnum.ReservationItem;
import com.ccnc.cube.user.Users;

import jakarta.persistence.CascadeType;
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
@Table(name = "RESERVATION")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RE_ID")
    private Integer reId;

    @Column(name = "RE_ITEM", nullable = false)
    @Enumerated(EnumType.STRING)
    private ReservationItem reItem;
    
    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "RE_NUM")
    private Meetingroom reNum;
    
    @Column(name = "RE_COUNT")
    private Integer reCount;
    
    @ManyToOne
    @JoinColumn(name = "USER_ID",nullable = false)
    private Users userId;
       
    @ManyToOne
    @JoinColumn(name = "USER_NAME",nullable = false)
    private Users userName;
    
    @Column(name = "RE_CREATED" , nullable = false)
    private LocalDateTime reCreated = LocalDateTime.now();
    
    @Column(name = "RE_DATE")
    private LocalDate reDate;
    
    @Column(name = "RE_START")
    private LocalTime reStart;

    @Column(name = "RE_END")
    private LocalTime reEnd;
    
    
}
