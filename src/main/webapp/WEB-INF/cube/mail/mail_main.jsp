<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>SendMailList</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/css/mailList.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<style>
    .btn-center {
        display: flex;
        justify-content: center;
        align-items: center;
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
					메일<i class="fas fa-chevron-right mx-1"></i>메인 검색
					<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">



              <h3>보낸 메일 검색</h3>
				<table class="table">
							<tr>
								<td><select
									class="custom-select custom-select-sm form-control form-control-sm"
									name="mailType" id="mailType">
										<option value="sendMail">보낸 메일</option>
										<option value="receiveMail">받은 메일</option>
								</select></td>
								<td><select
									class="custom-select custom-select-sm form-control form-control-sm"
									name="searchType" id="searchType">
										<option value="UserName">이름</option>
										<option value="MailTitle">제목</option>
										<option value="MailContent">내용</option>
								</select></td>
								<td>
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="검색할 단어를 입력하세요" aria-label="Search"
											aria-describedby="basic-addon2" id="searchInput">
										<div class="input-group-append">
											<button id="btn-search" class="btn btn-primary">
												<i class="fas fa-search fa-sm"></i>
											</button>
																								
										</div>
									</div>
									<input id="sendMailId" type=hidden value="${SendMail.sendMailId}">
						    <input id="receiveMailId" type=hidden value="${ReceiveMail.receiveMailId}">
								</td>
							</tr>
								
						</table>
						<c:if test="${searchMailType eq 'sendMail'}">
							<h3>보낸 메일</h3>
							<table class="table">
					<thead>
						<tr>
							<th>메일 번호</th>
							<th>제목</th>
							<th>받는 사람</th>
							<th>보낸 날짜</th>
							<th class="text-center">휴지통 이동</th>
							<th class="text-center">중요메일함 이동</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="mail" items="${mailList}">
							<tr>
								<td>${mail.sendMailId}<input type="hidden"
									value="${mail.sendMailId}" id="sendMailId"></td>
								<td><a href="/getSendMail/${mail.sendMailId}"
									>${mail.sendMailTitle}</a></td>
								<td>${mail.sendMailReceiverEmail}</td>
								<td>${mail.sendMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
								<td><a href="/changeSendIsDelete/${mail.sendMailId}"
									class="btn-center"> <i class="fas fa-trash"></i></a></td>
								<td><a href="/changeSendImportant/${mail.sendMailId}"
									class="btn-center"><i class="fas  fa-star"></i></a></td>

							</tr>
						</c:forEach>
					</tbody>
				</table>
						</c:if>
						<c:if test="${searchMailType eq 'receiveMail'}">
						<table class="table">
					<thead>
						<tr>
							<th>메일 번호</th>
							<th>제목</th>
							<th>보낸 사람</th>
							<th>받은시간</th>
							<th>읽음 여부</th>
							<th>읽은 날짜</th>
							<th class="text-center">휴지통 이동</th>
							<th class="text-center">중요메일함 이동</th>



						</tr>
					</thead>
					<tbody>
						<c:forEach var="mail" items="${mailList}">

							<tr>
								<!-- 메일 순번  -->
								<td>${mail.receiveMailId}<input type="hidden"
									value="${mail.receiveMailId}" id="receiveMailId"></td>
								<!-- 제   목  -->
								<td><a href="/getReceiveMail/${mail.receiveMailId}"> ${mail.receiveMailTitle}</a></td>
								<!-- 보낸 사람  -->
								<td>${mail.receiveMailSenderEmail}</td>
								<!-- 받은 시간  -->
								<td>${mail.receiveMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
								<!-- 읽음 여부  -->
								<td>${mail.receiveMailReadStatus}</td>
								<!-- 읽은 날짜  -->
								<td>${mail.receiveMailReadDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
								<!-- 휴지통 이동 -->
								<td><a href="/changeReceiveIsDelete/${mail.receiveMailId}"
									class="btn-center"> <i class="fas fa-trash"></i></a></td>
								<!-- 중요함 이동 -->
								<td><a href="/changeReceiveImportant/${mail.receiveMailId}"
									class="btn-center"><i class="fas  fa-star"></i></a></td>

							</tr>

						</c:forEach>
					</tbody>
				</table>
						</c:if>
</div>
</div>
</div>
<script src="/js/mailSearch.js"></script>


</body>
</html>