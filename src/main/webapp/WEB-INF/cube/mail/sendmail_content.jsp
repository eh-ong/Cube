<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ccnc.cube.user.Users"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>SendMailContent</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>

</head>
<style>
 .custom-input {
   width: 80%; /* 원하는 너비로 조정 */
   border-color: blue;
}

.form-group.row {
   display: flex; /* Flexbox 설정 */
   align-items: center; /* 수직으로 중앙 정렬 */
   width: 80%; /* 원하는 너비로 조정 */
   border-color: blue;
}

.custom-content {
   width: 80%; /* 원하는 너비로 조정 */
   border-color: blue;
   resize: none;
}

.card-body {
   width: 75%;
   border-color: white;
}

textarea {
   resize: none;
}
input[readonly],
    textarea[readonly] {
        background-color: white !important; /* 배경색을 흰색으로 설정하고 우선순위를 높임 */
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
					메일<i class="fas fa-chevron-right mx-1"></i>보낸 메일함<i
						class="fas fa-chevron-right mx-1"></i>보낸 메일 상세보기
				</h6>
			</div>
			<div class="card-body">


				<table border="1">
				
				
				
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="sendMailTitle" >제    목</label>
					</div>
					<div class="col-sm-10">
                        <input type="text" class="form-control" id="sendMailTitle" name="sendMailTitle" value="${SendMail.sendMailTitle}" readonly>
						
					</div>
				</div>
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="sendMailReceiverEmail" >받는 사람</label>
					</div>
					<div class="col-sm-10">
                        <input type="text" class="form-control" id="sendMailReceiverEmail" name="sendMailReceiverEmail" value="${SendMail.sendMailReceiverUserName}" readonly>
						
					</div>
				</div>
				
				
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="sendMailReservationDate" >보낸 날짜 </label>
					</div>
					<div class="col-sm-10">
					 <input type="text" class="form-control" id="sendMailReservationDate" name="sendMailReservationDate" value="${SendMail.sendMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}" readonly>
						
					</div>			
				</div>
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="sendMailContent" >내    용</label>
					</div>
					<div class="col-sm-10">
						<textarea class="form-control" rows="15" style="width: 100%; border-color: blue; resize: none;"
						id="sendMailContent" name="sendMailContent" readonly>${SendMail.sendMailContent}</textarea>
					</div>
				</div>
				
				
				
				</table>
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				<!--  	<thead>
						<tr>
							<th>메일 번호</th>
							<th>제목</th>
							<th>보낸 사람</th>
							<th>받은 날짜</th>
							<th>내용</th>
						</tr>
						<tr>
							<td>${ReceiveMail.receiveMailId}</td>
							<td>${ReceiveMail.receiveMailTitle}</td>
							<td>${ReceiveMail.receiveMailSenderEmail}</td>
							<td>${ReceiveMail.receiveMailReservationDate}</td>
							<td>${ReceiveMail.receiveMailContent}</td>
						</tr>
					</thead>-->
				</table>
			</div>
		</div>
	</div>
</body>
</html>
