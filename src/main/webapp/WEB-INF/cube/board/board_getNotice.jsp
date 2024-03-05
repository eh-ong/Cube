<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>공지사항 글 상세보기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
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


<div class="container-fluid">
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 text-gray-600">
				공지사항<i class="fas fa-chevron-right mx-1"></i>게시글 상세보기
			</h6>
		</div>
		<div class="card-body">
			<table border="1">
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="nboardTitle">제목</label>
					</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="nboardTitle"
							name="nboardTitle" value="${NoticeBoard.nboardTitle}" readonly>
					</div>
				</div>
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="nboardWriter">작성자</label>
					</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="nboardWriter"
							name="nboardWriter" value="${login_user.userName}" readonly>
					</div>
				</div>
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="nboardContent">내용</label>
					</div>
					<div class="col-sm-10">
						
							<label id="nboardContent" name="nboardContent" >${NoticeBoard.nboardContent}</label>
								 
						<input type="hidden" id="nboardId" value="${NoticeBoard.nboardId}">
					</div>
					</div>
					
					<c:if test="${sessionScope.login_user.userRole eq 'ADMIN'}">
					<div class= "col text-center mt-3">
						<a href="/updateNotice/${nboardId}" style="text-decoration: none;">
							<button class="btn btn-primary">
								<i class="fas fa-pen mr-2"></i>글수정
							</button>
						</a>
						<button id="btn-deleteNotice" class="btn btn-primary"
							style="margin-left: 10px;">글 삭제</button>
					</div>
					
					</c:if>
			</table>
		</div>
		
	</div>
</div>

<script src="/js/nb.js"></script>
</body>
</html>