package com.ccnc.cube.reservation;

import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MeetingroomService {

	@Autowired
	private MeetingroomRepository meetingroomRepository;

	// 회의실 예약리스트 GetMettingList /예약조회 GetMetting /
	
//	@Transactional
//	public List<Meetingroom>getMeetingroomlist(){
//		List<Meetingroom>getMeetingroomlist = new ArrayList<Meetingroom>(meetingroomRepository.findAll());
//		
//		return getMeetingroomlist();
//	}
	
	//회의실 리스트 찾아주는 Transactional
	@Transactional
	public List<Meetingroom> getMeetingroomlist() {
	    List<Meetingroom> meetingroomList = meetingroomRepository.findAll();
	    return meetingroomList;
	}

	
	@Transactional(readOnly = true)
	public Meetingroom getMeetingroom(Integer mrId) {
		Meetingroom findMeetingroom = meetingroomRepository.findById(mrId).orElseGet(()->{
			return new Meetingroom();
		});
		
		return findMeetingroom;
	}
	
	@Transactional
	public void registerMeet(Meetingroom meetingroom) {
		meetingroomRepository.save(meetingroom);
	}

	
	
}
