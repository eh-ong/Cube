package com.ccnc.cube.reservation;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.hibernate.annotations.CreationTimestamp;

import com.ccnc.cube.common.CommonEnum.ReservationItem;
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
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "CARRESERVATION")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CarReservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CRE_ID")
    private Integer creId;

    @Column(name = "CRE_ITEM", nullable = false)
    @Enumerated(EnumType.STRING)
    private ReservationItem creItem = ReservationItem.차량;
    
    @ManyToOne
    @JoinColumn(name = "CRE_NUM")
    private Car creNum;
    
     
    @Column(name = "CRE_COUNT")
    private Integer creCount;

    @ManyToOne
    @JoinColumn(name = "USER_ID",nullable = false)
    private Users userId;
    
    @ManyToOne
    @JoinColumn(name = "USER_NAME",nullable = false)
    private Users userName;
    
    @Column(name = "CRE_CREATED" , nullable = false)
    private LocalDateTime creCreated = LocalDateTime.now();
    
    @Column(name = "CRE_DATE")
    private LocalDate creDate;
    
    @Column(name = "CRE_START")
    private LocalTime creStart;

    @Column(name = "CRE_END")
    private LocalTime creEnd;
    
    
}
