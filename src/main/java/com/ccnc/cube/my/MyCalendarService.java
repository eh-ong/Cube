package com.ccnc.cube.my;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
public class MyCalendarService {
	
	@Autowired
	MyCalendarRepository myCalendarRepository;
	
	@Transactional
	public void saveMyCalendar(MyCalendar myCalendar) {
		myCalendarRepository.save(myCalendar);
	}
	
	@Transactional
	public List<MyCalendar> getEventList() {
		return myCalendarRepository.findAll();
	}
}
