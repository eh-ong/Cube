<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%
java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
String currentDateTime = java.time.LocalDateTime.now().format(formatter);
%>

<html lang="en">
<head>
<title>게시글 입력</title>
<meta charset="utf-8">
<style>
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
	transition: background-color 0.3s;
}

.hovertr:hover {
	background-color: lightgrey;
}
</style>
</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-gray-600">
					게시판<i class="fas fa-chevron-right mx-1"></i>공지사항
					<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<div class="justify-content-end">
						<table class="float-right">
							<tr>
								<td><select
									class="custom-select custom-select-sm form-control form-control-sm "
									name="searchType" id="searchType">
										<option value="userName">이름</option>
										<option value="nboardTitle">제목</option>
								</select></td>
								<td>
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2" id="searchInput">
										<div class="input-group-append" id="btn-nboardsearch">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</td>

							</tr>

							<input id="nboardId" type=hidden value="${Board.nboardId}">
						</table>
					</div>
					<div class="text-center">
						<table class="table table-bordered mx-auto" width="100%"
							cellspacing="0">
							<thead>

								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>생성일</th>
									<th>수정 시간</th>


								</tr>
							</thead>
							<tbody>
								<c:forEach var="Board" items="${NoticeBoard}">
									<tr class="hovertr">
										<td>${Board.nboardId}</td>
										<td><a href="getNotice/${Board.nboardId}">${Board.nboardTitle}</a></td>
										<td>${Board.nboardWriter.userName}</td>
										<td>${Board.nboardCreated.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
										<td>${Board.nboardUpdated.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>


									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- 페이징 -->
						<nav aria-label="Page navigation example">
							<ul class="pagination justify-content-center">
								<!--가운데 -->
								<li
									class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
									<a class="page-link"
									href='<c:url value="/listNotice"><c:param name="page" value="${currentPage}"/></c:url>'>&laquo;</a>
								</li>
								<c:forEach var="pageNumber" begin="1" end="${totalPages}">
									<li
										class="page-item <c:if test='${pageNumber == currentPage}'>active</c:if>'">
										<a class="page-link"
										href='<c:url value="/listNotice"><c:param name="page" value="${pageNumber}"/></c:url>'>${pageNumber}</a>
									</li>
								</c:forEach>
								<li
									class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>'">
									<a class="page-link"
									href='<c:url value="/listNotice"><c:param name="page" value="${currentPage + 1}"/></c:url>'>&raquo;</a>
								</li>
							</ul>
						</nav>
					</div>
				</div>

			</div>
		</div>
	</div>
	<c:if test="${sessionScope.login_user.userRole eq 'ADMIN'}">
		<div class="text-center">
		
			<a href="/insertNotice"><button class="btn btn-primary">
					<i class="fas fa-pen mr-2"></i>글등록
				</button></a>
		</div>
	</c:if>



	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<script src="/js/nb.js"></script>


</body>
</html>
