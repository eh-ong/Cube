<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>

</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
		
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<a class="m-0 text-secondary" href="/my_main">마이페이지</a>
				<i class="fas fa-chevron-right mx-1"></i>
				<a  class="m-0 text-secondary" href="/my_changePwCheckPw">비밀번호 변경</a>
			</div>
			<div class="card-body">
				<h2 class="h4 text-gray-900 font-weight-bold">비밀번호 변경</h2>
				
				<br>
				<br>
				
				<div class="form-group row" style="align-items: center;">
				<div class="col-sm-1 mr-3">
					<label for="userPw" class="label"  style="width: 110px;">비밀번호 확인</label>
				</div>
				<div class="col-sm-2">
					<input type="password" id="userPw" class="form-control" required>									
				</div>
				<button id="btn-changePwcheckPw" class="btn btn-primary" style="width: 7%;" type="submit">확인</button>
			</div>
		</div>
	</div>
</div>
			
<script src="/js/my.js"></script>
</body>
</html>