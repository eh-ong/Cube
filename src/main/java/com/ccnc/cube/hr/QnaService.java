package com.ccnc.cube.hr;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
public class QnaService {
	
	@Autowired
	QnaRepository qnaRepository;
	
	@Transactional
	public void saveQna(Qna qna) {
		qnaRepository.save(qna);
	}
	
	@Transactional
	public List<Qna> getQnaList() {
		return qnaRepository.findAll();
	}
	
	@Transactional
	public Page<Qna> getQnaListPage(Pageable pageable) {
		return qnaRepository.findAll(pageable);
	}
	
	@Transactional
	public Qna getQna(Integer qnaId) {
		return qnaRepository.findById(qnaId).orElse(null);
	}

}
