package com.ccnc.cube.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmailMessage {
	
	private String to;  //수신자
	private String subject;  //메일 제목
	private String message;  //메일 내용

}
