<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<meta charset="UTF-8">
<title>예약 목록</title>
</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-secondary">
					예약시스템<i class="fas fa-chevron-right mx-1"></i>예약검색
					<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<div id="calendar"></div>
				<div class="table-responsive">
					<form action="/myRevpage" method="GET">
						<label for="reservationDate">예약 날짜 선택:</label> <input type="date"
							id="reservationDate" name="reservationDate"
							min="<%=java.time.LocalDate.now()%>">
						<button type="submit">조회</button>
					</form>
					<table
						class="table table-bordered text-gray-900 border-bottom-primary"
						width="100%" cellspacing="0">
						<thead>
							<tr align="center">
								<th>예약자</th>
								<th>예약 항목</th>
								<th>예약 날짜</th>
								<th>시작 시간</th>
								<th>종료 시간</th>
								<th>장소</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="reservation" items="${revList}">
								<tr align="center">
									<td>${reservation.userName.userName}</td>
									<td>${reservation.reItem}</td>
									<td>${reservation.reDate}</td>
									<td>${reservation.reStart}</td>
									<td>${reservation.reEnd}</td>
									<td>${reservation.reNum.mrName}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<nav aria-label="Page navigation example">
						<ul class="pagination justify-content-center">
							<li class="page-item ${nowPage == 1 ? 'disabled' : ''}"><c:if
									test="${nowPage != 1}">
									<a class="page-link" href="/myRevpage?page=${nowPage - 1}"
										aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									</a>
								</c:if></li>
							<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
								<li class="page-item ${pageNum == nowPage ? 'active' : ''}">
									<a class="page-link" href="/myRevpage?page=${pageNum}">${pageNum}</a>
								</li>
							</c:forEach>
							<li
								class="page-item ${nowPage == totalPages || totalPages < 10 ? 'disabled' : ''}">
								<c:if test="${nowPage != totalPages && totalPages >= 10}">
									<a class="page-link" href="/myRevpage?page=${nowPage + 1}"
										aria-label="Next"> <span aria-hidden="true">&raquo;</span>
									</a>
								</c:if>
							</li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
