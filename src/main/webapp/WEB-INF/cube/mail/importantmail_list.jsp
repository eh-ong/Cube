<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.format.DateTimeFormatter"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>ImportantMailList</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
</head>
<style>
.btn-center {
	display: flex;
	justify-content: center;
	align-items: center;
}
td {
   white-space: nowrap;
   overflow: hidden;
   text-overflow: ellipsis;
}

/* 추가된 스타일: 글이 화면을 넘어갈 때 줄임 처리 */
td {
   max-width: 200px; /* 적절한 너비로 조정 */
   overflow: hidden;
   text-overflow: ellipsis;
}
.hovertr {
   background-color: white;
   transition: background-color 0.1s;
}

.hovertr:hover {
   background-color: lightgrey;
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
					메일<i class="fas fa-chevron-right mx-1"></i>중요 메일함
					<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
</h6>
</div>
<div class="card-body">
<table class="table">
					<c:if test="${type eq 1}">				
							<thead>
								<tr>
									<th>메일 번호</th>
									<th>제목</th>
									<th>받는 사람</th>
									<th>받은 날짜</th>
									<th class="text-center">휴지통 이동</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="mail" items="${ImportantEmail.content}">
									<tr class="hovertr">
										<td>${mail.sendMailId}</td>
										<td><a href="/getSendMail/${mail.sendMailId}">${mail.sendMailTitle}</a></td>
										<td>${mail.sendMailReceiverUserName}</td>
										<td>${mail.sendMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
										<td><a href="/throwSendIsDelete/${mail.sendMailId}"
											class="btn-center"><i class="fas fa-trash"></i></a></td>
									</tr>
								</c:forEach>
							</tbody>
					</c:if>
					<c:if test="${type eq 2}">
							<thead>
						<tr>
							<th>메일 번호</th>
							<th>제목</th>
							<th>보낸 사람</th>
							<th>받은 날짜</th>
							<th>읽은 날짜</th>
							<th class="text-center">휴지통 이동</th>
						</tr>
					</thead>
							<tbody>
								<c:forEach var="mail" items="${ImportantEmail.content}">
									<tr class="hovertr">
								<td>${mail.receiveMailId}</td>
								<td><a href="/getReceiveMail/${mail.receiveMailId}"
									>${mail.receiveMailTitle}</a></td>
								<td>${mail.receiveMailSenderUserName}</td>
								<td>${mail.receiveMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
								<td>${mail.receiveMailReadDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
								<td><a href="/throwReceiveIsDelete/${mail.receiveMailId}"
									class="btn-center"><i class="fas fa-trash"></i></a></td>
							</tr>
								</c:forEach>
							</tbody>
							</c:if>
						</table>
					</div>
					</div>
					</div>
				

					<nav aria-label="Page navigation example">
						<ul class="pagination justify-content-center">
							<li
								class="page-item <c:if test='${CurrentPage == 1}'>disabled</c:if>">
								<a class="page-link"
								href='<c:url value="/importantmail_list"><c:param name="page" value="${CurrentPage - 1}"/></c:url>'>&laquo;</a>
							</li>
							<c:forEach var="pageNumber" begin="1" end="${TotalPage}">
								<li
									class="page-item <c:if test='${pageNumber == CurrentPage}'>active</c:if>">
									<a class="page-link"
									href='<c:url value="/importantmail_list"><c:param name="page" value="${pageNumber}"/></c:url>'>${pageNumber}</a>
								</li>
							</c:forEach>
							<li
								class="page-item <c:if test='${CurrentPage == TotalPage}'>disabled</c:if>">
								<a class="page-link"
								href='<c:url value="/importantmail_list"><c:param name="page" value="${CurrentPage + 1}"/></c:url>'>&raquo;</a>
							</li>
						</ul>
					</nav>
</body>
</html>
