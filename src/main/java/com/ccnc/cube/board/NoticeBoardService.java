package com.ccnc.cube.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccnc.cube.user.Users;

@Service
public class NoticeBoardService {

	@Autowired
	private NoticeBoardRepository noticeBoardRepository;

	// 목록
	@Transactional
	public List<NoticeBoard> getListNoticeBoard() {
		return noticeBoardRepository.findAll();

	}

	// 조회
	@Transactional
	public NoticeBoard getNoticeBoard(Integer nboardId) {
		return noticeBoardRepository.findById(nboardId).orElse(null);

	}

	// 등록
	@Transactional
	public void insertNoticeBoard(NoticeBoard noticeBoard) {
		noticeBoardRepository.save(noticeBoard);

	}

	// 업데이트
	@Transactional
	public void updateNoticeBoard(NoticeBoard noticeBoard) {
		noticeBoardRepository.save(noticeBoard);

	}

	@Transactional
	public void deleteNoticeBoard(Integer nboardId) {
		noticeBoardRepository.deleteById(nboardId);
	}

	@Transactional
	public List<NoticeBoard> findBynoticeBoardTitleLike(String nboardTitle) {
		return noticeBoardRepository.findByNboardTitleContaining(nboardTitle);
	}
	@Transactional
	public Page<NoticeBoard> getListNoticeBoard(Pageable pageable) {
		return noticeBoardRepository.findAll(pageable);
	}

	public List<NoticeBoard> findBynoticeBoardWriterLike(String userName) {
		return noticeBoardRepository.findByNboardWriter_UserNameContaining(userName);
	}


}
