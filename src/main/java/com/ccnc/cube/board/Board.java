package com.ccnc.cube.board;

import java.time.LocalDateTime;
import java.util.List;

import com.ccnc.cube.common.Team;
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
@Table(name = "BOARD")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "BOARD_ID")
    private Integer boardId;

    @ManyToOne
    @JoinColumn(name = "TEAM_ID")
    private Team teamId;

    @Column(name = "BOARD_TITLE", nullable = false)
    private String boardTitle;
    
    @ManyToOne
    @JoinColumn(name = "BOARD_WRITER", nullable = false)
    private Users boardWriter;
    
    @Column(name = "BOARD_CONTENT", nullable = false, columnDefinition = "TEXT")
    private String boardContent;
    
    @Column(name = "BOARD_CREATED", nullable = false)
    private LocalDateTime boardCreated = LocalDateTime.now();
    
    @Column(name = "BOARD_UPDATED")
    private LocalDateTime boardUpdated;
    
    @Lob
    @Column(name = "BOARD_FILE")
    private byte[] boardFile;
    
    @OneToMany(mappedBy = "boardId", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private List<Comment> comments;
}

