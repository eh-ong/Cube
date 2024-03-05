package com.ccnc.cube.common;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.user.Users;


@Repository
public interface BookmarkRepository extends JpaRepository<Bookmark, Integer>{
	List<Bookmark> findByUserId(Users user);
}
