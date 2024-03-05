<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
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
.hovertr:hover{
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
					게시판<i class="fas fa-chevron-right mx-1"></i>${team.teamName}글목록
					<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<div class="justify-content-end">
						<table class="float-right">
							<tr>
								<td><select
									class="custom-select custom-select-sm form-control form-control-sm"
									name="searchType" id="searchType">
										<option value="userName">이름</option>
										<option value="boardTitle">제목</option>
								</select></td>
								<td>
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2" id="searchInput">
										<div class="input-group-append" id="btn-search">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</td>
							</tr>
						</table>
						<div class="text-center">
						<table class="table table-bordered" width="100%" cellspacing="0">
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
								<c:forEach var="Board" items="${getTeamBoardList}">
									<tr class="hovertr">
										<td>${Board.boardId}</td>
										<td><a href="/getBoard/${team.teamId}/${Board.boardId}">${Board.boardTitle}</a></td>
										<td>${Board.boardWriter.userName}</td>
										<td>${Board.boardCreated.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
										<td>${Board.boardUpdated.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="pagination  justify-content-center">
							<c:if test="${totalPages > 1}">
								<ul class="pagination justify-content-center">
									<li
										class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
										<a class="page-link" href="?page=${currentPage - 1}">&laquo;</a>
									</li>
									<c:forEach var="pageNumber" begin="1" end="${totalPages}">
										<li
											class="page-item <c:if test='${pageNumber == currentPage}'>active</c:if>'">
											<a class="page-link" href="?page=${pageNumber}">${pageNumber}</a>
										</li>
									</c:forEach>
									<li
										class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>'">
										<a class="page-link" href="?page=${currentPage + 1}">&raquo;</a>
									</li>
								</ul>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<div>
<c:choose>
    <c:when test="${team.teamId eq login_user.userTeamId.teamId}">
        <a href="/insertBoard/${team.teamId}" style="display: flex; justify-content: center; align-items: center; height: 100%; text-decoration: none;">
            <button class="btn btn-primary">
                <i class="fas fa-pen mr-2"></i>글등록
            </button>
        </a>
    </c:when>
</c:choose>
</div>
<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<script src="/js/tb.js"></script>
</body>
</html>
