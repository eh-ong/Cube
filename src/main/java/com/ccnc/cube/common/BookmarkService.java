package com.ccnc.cube.common;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccnc.cube.user.Users;

import jakarta.transaction.Transactional;

@Service
public class BookmarkService {
	
	@Autowired
	private BookmarkRepository bookmarkRepository;

	@Transactional
	public List<Bookmark> getBookmarkList(Users user) {
		return bookmarkRepository.findByUserId(user);
	}
	
	@Transactional
	public void saveBookmark(Bookmark bookmark) {
		bookmarkRepository.save(bookmark);
	}
	
	@Transactional
	public void deleteBookmark(Integer bookmarkId) {
		bookmarkRepository.deleteById(bookmarkId);
	}
}
