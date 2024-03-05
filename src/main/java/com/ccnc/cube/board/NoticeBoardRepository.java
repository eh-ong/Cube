package com.ccnc.cube.board;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ccnc.cube.user.Users;

public interface NoticeBoardRepository  extends JpaRepository<NoticeBoard, Integer>{

	Optional<NoticeBoard> getNoticeBoardByNboardId(Integer nboardId);
	
	List<NoticeBoard> findByNboardTitleContaining(String nboardTitle);

	List<NoticeBoard> findByNboardWriter_UserNameContaining(String userName);
	
	

	
}
