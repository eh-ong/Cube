<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ccnc.cube.user.Users"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% Users login_user = (Users)session.getAttribute("login_user"); %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Mail</title>
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
					메일<i class="fas fa-chevron-right mx-1"></i>메일 보내기
					
					<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
					
				</h6>
			</div>
			<div class="card-body">

               
               				
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="mailSenderEmail" >보내는 사람 </label>
					</div>
					<div class="col-sm-10">
					<input id="mailSenderEmail" class="form-control custom-input" type="text" readOnly="readOnly"  value="<%=login_user.getUserEmail()%>" />
					</div>			
				</div>
				
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="mailSenderEmail" >받는 사람</label>
					</div>
					<div class="col-sm-10">
						<input type="text" class="form-control custom-input" id="mailReceiverEmail" placeholder="받는사람을 입력하세요" name="mailReceiverEmail" value="${receiverEmail}">
						</div>
				</div>
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="mailTitle" >제    목</label>
					</div>
					<div class="col-sm-10">
						<input type="text" class="form-control custom-input" id="mailTitle" placeholder="제목을 입력하세요" name="mailTitle">
					</div>
				</div>
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="mailContent" >내    용</label>
					</div>
					<div class="col-sm-10">
						<textarea class="form-control custom-content" id="mailContent" placeholder="내용을 입력하세요" name="mailContent" rows="15"></textarea>
					</div>
				</div>
				
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
				<label for="sendMailReservationDate"">날짜와 시간</label>
			</div>
			<div  class="col-sm-10">
				<%
  java.time.LocalDateTime now = java.time.LocalDateTime.now();
  java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
  String currentDateTime = now.format(formatter);
%>
				<input type="datetime-local" class="form-control custom-input" id="sendMailReservationDate" max="2100-06-20T23:59" min="<%= currentDateTime %>"value="<%= currentDateTime %>">
				</div>  
                <hr>
				<div class="form-group" style="margin-left: 50%;">
				 <button id="btn-mailSend" class="btn btn-primary mt-3">메일보내기</button>
                 </div>
               

				
			</div>
		</div>
	</div>

		<div class="modal fade" id="mailmodal" tabindex="-1" aria-labelledby="mailmodalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="mailmodalcontent">
            </div>
            <div class="col-md-12">
                <div class="column text-center">
                    <div class="mt-3" id="mailmodalpage"></div>
                </div>
            </div>
        </div>
    </div>
</div>

	<script src="/js/mailSend.js"></script>
</body>
</html>

