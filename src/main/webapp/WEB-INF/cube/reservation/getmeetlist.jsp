<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
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
					예약시스템<i class="fas fa-chevron-right mx-1"></i>회의실<i
						class="fas fa-chevron-right mx-1"></i>회의실예약목록
						<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<div id="calendar"></div>
				<table
					class="table table-bordered text-gray-900 border-bottom-primary"
					width="100%" cellspacing="0">
					<thead>
						<tr align="center">
							<th>예약자</th>
							<th>예약 날짜</th>
							<th>시작 시간</th>
							<th>종료 시간</th>
							<th>위치</th>
							<th>장소</th>
							<c:if test="${isAdmin}">
								<!-- 예약 변경 텍스트 -->
								<th>예약변경</th>
								<!-- 예약 삭제 텍스트 -->
								<th>예약취소</th>
							</c:if>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="reservation" items="${revList}">
							<tr align="center">
								<!-- 예약자 ID, 예약 항목, ... 등 각 열의 데이터를 출력합니다. -->
								<td>${reservation.userName.userName}</td>
								<td>${reservation.reDate}</td>
								<td>${reservation.reStart}</td>
								<td>${reservation.reEnd}</td>
								<td>${reservation.reNum.mrLocation }</td>
								<td>${reservation.reNum.mrName}</td>
								<!-- 예약 변경 및 취소 버튼 -->
								<c:if test="${isAdmin}">
									<td>
										<form action="/updateRev/${reservation.reId}" method="get">
											<button class="btn btn">
												<i class="fas fa-pen-to-square" style="color: blue;"></i>
											</button>
										</form>
									</td>
									<td>
										<form class="delete-form">
											<input type="hidden" class="reId" value="${reservation.reId}">
											<button class="btn btn btn-delete">
												<i class="fas fa-trash" style="color: red;"></i>
											</button>
										</form>
									</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<li class="page-item ${nowPage == 1 ? 'disabled' : ''}"><c:if
								test="${nowPage != 1}">
								<a class="page-link" href="/getrevlist?page=${nowPage - 1}"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a>
							</c:if></li>
						<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
							<li class="page-item ${pageNum == nowPage ? 'active' : ''}">
								<a class="page-link" href="/getrevlist?page=${pageNum}">${pageNum}</a>
							</li>
						</c:forEach>
						<li
							class="page-item ${nowPage == totalPages || totalPages < 10 ? 'disabled' : ''}">
							<c:if test="${nowPage != totalPages && totalPages >= 10}">
								<a class="page-link" href="/getrevlist?page=${nowPage + 1}"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a>
							</c:if>
						</li>
					</ul>
				</nav>




			</div>
		</div>
	</div>
	<script src="/js/revmeet.js"></script>
</body>
</html>
