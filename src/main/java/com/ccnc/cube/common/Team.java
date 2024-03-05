package com.ccnc.cube.common;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "TEAM")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Team {

    @Id
    @Column(name = "TEAM_ID")
    private Integer teamId;

    @Column(name = "TEAM_NAME", length = 20 , nullable = false)
    private String teamName;
}
