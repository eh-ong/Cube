package com.ccnc.cube.common;

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
@Table(name = "BOOKMARK")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Bookmark {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "BOOKMARK_ID")
    private Integer bookmarkId;

    @ManyToOne
    @JoinColumn(name = "USER_ID")
    private Users userId;
    
    @Column(name = "BOOKMARK_NAME")
    private String bookmarkName;
    
    @Column(name = "BOOKMARK_PATH")
    private String bookmarkPath;
}
