package com.ccnc.cube.project;

import java.time.LocalDateTime;

import com.ccnc.cube.user.Users;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "PR_PROGRESS")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PrProgress {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "PR_PROGRESS_ID")
	private Integer prProgressId;
	
	@ManyToOne
    @JoinColumn(name = "PR_PROGRESS_PROJECT", nullable = false)
    private Project prProgressProject;
	
	@ManyToOne
    @JoinColumn(name = "PR_PROGRESS_WRITER", nullable = false)
    private Users prProgressWriter;
		
	@Column(name = "PR_PROGRESS_CONTENT", nullable = false, columnDefinition = "TEXT")
	private String prProgressContent;
		
	@Column(name = "PR_PROGRESS_CREATED", nullable = false)
    private LocalDateTime prProgressCreated = LocalDateTime.now();
    
    @Column(name = "PR_PROGRESS_UPDATED")
    private LocalDateTime prProgressUpdated;

    
/*    
    @Lob
    @Column(name = "PR_PROGRESS_FILE")
    private byte[] prProgressFile;
*/
    
}
