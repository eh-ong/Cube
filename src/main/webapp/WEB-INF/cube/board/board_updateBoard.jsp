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
				팀게시판<i class="fas fa-chevron-right mx-1"></i>게시글 수정
			</h6>
		</div>
		<div class="card-body">
			<table border="1">


				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="boardTitle">제목</label>
					</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="boardTitle"
							name="boardTitle" value="${Board.boardTitle}">
					</div>
				</div>
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="boardWriter">작성자</nboardWriter>
					</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="boardWriter"
							name="boardWriter" value=${login_user.userName
							}
							readonly="readonly" />
					</div>
				</div>

				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="boardContent">내용</label>
					</div>
					<div class="col-sm-10">
						<textarea class="form-control summernote" id="boardContent"
							name="boardContent" rows="15">
            ${Board.boardContent}
        </textarea>
						<input type="hidden" id="boardId" value="${Board.boardId}">
						<input type="hidden" id="teamId" value="${teamId}">
					</div>
				</div>
							<script>
						$('.summernote').summernote({
							
							minHeight : 300,
							maxHeight : 600,
							placeholder : '내용을 입력하세요',
							tabsize : 10,
							height : 100

						});
					</script>


				<div class="text-center">
					<button id="btn-updateBoard" class="btn btn-primary">글 수정</button>


				</div>

				<script src="/js/tb.js"></script>





				</div>


				


				</body>
				</html>