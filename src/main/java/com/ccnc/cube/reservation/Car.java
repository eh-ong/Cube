package com.ccnc.cube.reservation;

import com.ccnc.cube.common.CommonEnum;
import com.ccnc.cube.common.CommonEnum.CarStatus;
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
@Table(name = "CAR")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Car {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CAR_ID")
    private Integer carId;
    
    @Column(name = "CAR_NUM")
    private String carNum;
    
    @Column(name = "CAR_NAME")
    private String carName;
        
    @Column(name = "CAR_CAPACITY")
    private Integer carCapacity;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "CAR_STATUS")
    private CarStatus carStatus;

}

