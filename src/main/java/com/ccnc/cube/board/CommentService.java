package com.ccnc.cube.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CommentService {

	@Autowired
	private CommentRepository commentRepository;

	@Autowired
	private BoardRepository boardRepository;

	@Transactional
	public Comment insertComment(Comment comment) {
		return commentRepository.save(comment);
	}

	@Transactional(readOnly = true)
	public List<Comment> commentList(Integer boardId) {
		return commentRepository.findByBoardId_boardId(boardId); // 게시글 속한 댓글 다 가져와라
	}

	@Transactional
	public void deleteComment(Integer commentId) {
		commentRepository.deleteById(commentId);
	}
}
