package com.ccnc.cube.board;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

import org.hibernate.annotations.CreationTimestamp;

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
@Table(name = "COMMENT")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {

    @Id //댓글 번호
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "COMMENT_ID")
    private Integer commentId;

    @ManyToOne // 보드 번호
    @JoinColumn(name = "BOARD_ID" ,nullable = false)
    private Board boardId;

    @ManyToOne
    @JoinColumn(name = "COMMENT_WRITER", nullable = false)
    private Users commentWriter;
    
    @Column(name = "COMMENT_CONTENT", nullable = false, columnDefinition = "TEXT")
    private String commentContent;
    
    @Column(name = "COMMENT_CREATED", nullable = false)
    private LocalDateTime commentCreated = LocalDateTime.now();
}

