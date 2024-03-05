<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>팀 게시글 입력</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">



<style>
.custom-input {
	width: 100%; /* 원하는 너비로 조정 */
	border-color: blue;
}

.form-group.row {
	display: flex; /* Flexbox 설정 */
	align-items: center; /* 수직으로 중앙 정렬 */
	border-color: blue;
}

.custom-content {
	width: 100%; /* 원하는 너비로 조정 */
	border-color: blue;
	resize: none;
}

input[readonly], textarea[readonly] {
	background-color: white !important; /* 배경색을 흰색으로 설정하고 우선순위를 높임 */
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
				팀 게시판<i class="fas fa-chevron-right mx-1"></i>팀 게시글 입력
			</h6>
		</div>
		<div class="card-body">
			


				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="boardTitle">제목</label>
					</div>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="boardTitle"
							placeholder="제목 입력하세요" name="boardTitle">
					</div>
				</div>
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="boardWriter">작성자</label>
					</div>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="boardWriter"
							name="boardWriter" value=${login_user.userName }
							readonly="readonly" />
					</div>
				</div>

				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="boardContent">내용</label>
					</div>
					<div class="col-sm-8">
					
						<textarea class="form-control summernote" id="boardContent"
							 name="boardContent" rows="15"></textarea>
						
						<input type="hidden" class="form-control" id="team"
							value="${team.teamId}">
						<div class="form-group" style="margin-left: 45%;">
						<td>
						</td>
						<button id="btn-insertBoard" class="btn btn-primary">글등록</button>
						</div>
						

	
					</div>
				</div>
			
		</div>
<div id="summernote"></div>
    <script>
      $('.summernote').summernote({
        placeholder: '내용을 입력하세요',
        tabsize: 2,
        height: 100
      });
</script>

	</div>
</div>



<script src="/js/tb.js"></script>
</body>
</html>