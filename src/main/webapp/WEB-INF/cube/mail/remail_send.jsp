<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ccnc.cube.user.Users"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% Users login_user = (Users)session.getAttribute("login_user"); %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>reMailSend</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<style>
    .custom-input {
        width: 100%; /* 원하는 너비로 조정 */
        border-color: blue;
       
    }
     .form-group.row {
        display: flex; /* Flexbox 설정 */
        align-items: center; /* 수직으로 중앙 정렬 */
        border-color: blue;
        width: 60%
        
    }
     .custom-content {
        width: 100%; /* 원하는 너비로 조정 */
        border-color: blue;
        resize: none;
       
    }
     .center {
    text-align: center;
}
</style>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-gray-600">
					메일<i class="fas fa-chevron-right mx-1"></i>답변 보내기
					<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">

               <table border="2">
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="mailSenderEmail" >보내는 사람 </label>
					</div>
					<div class="col-sm-10">
					<input id="mailSenderEmail" class="form-control" type="text" readOnly="readOnly"  value="<%=login_user.getUserEmail()%>" />
					</div>			
				</div>
				
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="mailReceiverEmail" >받는 사람</label>
					</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="mailReceiverEmail" readOnly="readOnly" name="mailReceiverEmail" value="${getReMailSend.receiveMailSenderEmail}">
					</div>
				</div>
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="mailTitle" >제    목</label>
					</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="mailTitle" placeholder="제목을 입력하세요" name="mailTitle" value="[답신]${getReMailSend.receiveMailTitle}" readonly>
					</div>
				</div>
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="mailContent" >내    용</label>
					</div>
					<div class="col-sm-10">
						<textarea class="form-control" id="mailContent" placeholder="내용을 입력하세요" name="mailContent" rows="15" ></textarea>
					</div>
				</div>
				
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
				<label for="sendMailReservationDate">날짜와 시간</label>
			</div>
			<div  class="col-sm-10">
				<%
  java.time.LocalDateTime now = java.time.LocalDateTime.now();
  java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
  String currentDateTime = now.format(formatter);
%>
				<input type="datetime-local" class="form-control" id="sendMailReservationDate" max="2100-06-20T23:59" min="<%= currentDateTime %>"value="<%= currentDateTime %>">
				</div>
</table>                
                <hr>
				<div class="form-group" style="margin-left: 30%;">
				 <button id="btn-mailSend" class="btn btn-primary">메일보내기</button>
                 </div>
               

				<script src="/js/mailReSend.js"></script>
			</div>
		</div>
	</div>
</body>
</html>

