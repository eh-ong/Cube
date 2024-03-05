package com.ccnc.cube.board;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Integer>{
	
	
	List<Comment> findByBoardId_boardId(Integer boardId);
	
	

}
