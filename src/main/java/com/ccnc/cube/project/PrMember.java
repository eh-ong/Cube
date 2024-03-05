package com.ccnc.cube.project;

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
@Table(name = "PR_MEMBER")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PrMember {
		
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "PR_MEMBER_ID")
	private Integer prMemberId;
	
	@ManyToOne
    @JoinColumn(name = "PR_MEMBER_PROJECT", nullable = false)
    private Project prMemberProject;
	
	@ManyToOne
    @JoinColumn(name = "PR_MEMBER_USER", nullable = false)
    private Users prMemberUser;
	
}
