<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>공지사항 글 수정</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
					공지사항<i class="fas fa-chevron-right mx-1"></i>게시글 수정
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
								name="nboardTitle" value="${NoticeBoard.nboardTitle}">
						</div>
					</div>
					<hr>
					<div class="form-group row">
						<div class="col-sm-2 text-center">
							<label for="nboardWriter">작성자</nboardWriter>
						</div>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="nboardWriter"
								name="nboardWriter" value=${login_user.userName
							}
								readonly="readonly" />
						</div>
					</div>

					<hr>
					<div class="form-group row">
						<div class="col-sm-2 text-center">
							<label for="nboardContent">내용</label>
						</div>
						<div class="col-sm-10">

							<textarea class="form-control summernote" id="nboardContent"
								name="nboardContent" rows="15" style="display: none">${NoticeBoard.nboardContent}</textarea>


							<input type="hidden" id="nboardId"
								value="${NoticeBoard.nboardId}">
						</div>
							<script>
						$('.summernote').summernote({
							
							minHeight : 300,
							maxHeight : 600,
							placeholder : '내용을 입력하세요',
							tabsize : 10,
							height : 400

						});
					</script>
					</div>
					<div class="col text-center">
						<button id="btn-updateNotice" class="btn btn-primary">글
							수정</button>
					</div>
				
					<script src="/js/nb.js"></script>





					</div>
</body>
</html>