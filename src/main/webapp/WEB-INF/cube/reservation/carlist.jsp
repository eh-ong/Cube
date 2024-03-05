<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<meta charset="UTF-8">
<title>차량 예약 목록</title>
</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-secondary">
					예약시스템<i class="fas fa-chevron-right mx-1"></i>나의 예약현황<i
						class="fas fa-chevron-right mx-1"></i>차량 내역
						<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table
						class="table table-bordered text-gray-900 border-bottom-primary"
						width="100%" cellspacing="0">
						<thead>
							<tr align="center">
								<th>예약자</th>
								<th>예약 날짜</th>
								<th>시작 시간</th>
								<th>종료 시간</th>
								<th>차량</th>
								<th>예약 변경</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="carreservation" items="${carList}">
								<tr align="center">
									<td>${carreservation.userName.userName}</td>
									<td>${carreservation.creDate}</td>
									<td>${carreservation.creStart}</td>
									<td>${carreservation.creEnd}</td>
									<td>${carreservation.creNum.carName}</td>
									<td><a href="/updateCar/${carreservation.creId}"
										class="btn btn"><i class="fas fa-pen-to-square"
											style="color: blue;"></i></a></td>
									<td>
										<form class="delete-form">
											<input type="hidden" class="creId"
												value="${carreservation.creId}">
											<button class="btn btn btn-delete">
												<i class="fas fa-trash" style="color: red;"></i>
											</button>
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<nav aria-label="Page navigation example">
						<ul class="pagination justify-content-center">
							<li class="page-item ${nowPage == 1 ? 'disabled' : ''}"><c:if
									test="${nowPage != 1}">
									<a class="page-link" href="/meetinglist?page=${nowPage - 1}"
										aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									</a>
								</c:if></li>
							<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
								<li class="page-item ${pageNum == nowPage ? 'active' : ''}">
									<a class="page-link" href="/meetinglist?page=${pageNum}">${pageNum}</a>
								</li>
							</c:forEach>
							<li
								class="page-item ${nowPage == List.totalPages || List.totalPages < 10 ? 'disabled' : ''}">
								<c:if
									test="${nowPage != List.totalPages && List.totalPages >= 10}">
									<a class="page-link" href="/meetinglist?page=${nowPage + 1}"
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
	<script src="/js/revcar.js"></script>
</body>
</html>
