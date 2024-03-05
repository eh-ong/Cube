package com.ccnc.cube.board;

import java.time.LocalDateTime;
import java.util.List;

import com.ccnc.cube.user.Users;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "NOTICEBOARD")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeBoard {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "N_BOARD_ID")
	private Integer nboardId;

	@Column(name = "N_BOARD_TITLE", nullable = false)
	private String nboardTitle;

	@ManyToOne
	@JoinColumn(name = "N_BOARD_WRITER", nullable = false)
	private Users nboardWriter;

	@Column(name = "N_BOARD_CONTENT", nullable = false, columnDefinition = "TEXT")
	private String nboardContent;

	@Column(name = "N_BOARD_CREATED", nullable = false)
	private LocalDateTime nboardCreated = LocalDateTime.now();

	@Column(name = "N_BOARD_UPDATED")
	private LocalDateTime nboardUpdated;

	@Lob
	@Column(name = "N_BOARD_FILE")
	private byte[] nboardFile;

}
