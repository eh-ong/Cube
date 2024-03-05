package com.ccnc.cube.my;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MyCalendarController {
	
	@Autowired
	MyCalendarService myCalendarService;
	
	@GetMapping("/event")  //ajax 데이터 전송 URL
	public @ResponseBody List<MyCalendar> getEvent() {
		return myCalendarService.getEventList();
	}
}
