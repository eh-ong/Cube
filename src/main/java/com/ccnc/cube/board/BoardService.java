package com.ccnc.cube.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccnc.cube.common.Team;

@Service
public class BoardService {

	@Autowired
	private BoardRepository boardRepository;

	// 목록
	@Transactional
	public List<Board> getListBoard() {
		return boardRepository.findAll();

	}

	// 조회
	@Transactional
	public Board getBoard(Integer boardId) {
		return boardRepository.findById(boardId).orElse(null);

	}

	// 등록
	@Transactional
	public void insertBoard(Board board) {
		boardRepository.save(board);

	}

	// 업데이트
	@Transactional
	public void updateBoard(Board board) {
		boardRepository.save(board);

	}

	@Transactional
	public void deleteBoard(Integer boardId) {
		boardRepository.deleteById(boardId);
	}

	@Transactional
	public List<Board> findByTeamId(Team team) {
		return boardRepository.findByTeamId(team);
	}

	// 찾기
	@Transactional
	public List<Board> findByBoardTitleLike(String boardTitle) {
		return boardRepository.findByBoardTitleContaining(boardTitle);
	}
	
	@Transactional
	public List<Board> findByBoardWriterLike(String userName) {
		return boardRepository.findByBoardWriter_UserNameContaining(userName);
	}
	@Transactional
	public Page<Board> findByTeamIdPaged(Team team, Pageable pageable) {
	    return boardRepository.findByTeamId(team, pageable);
	}
}
