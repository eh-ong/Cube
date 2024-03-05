<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
	.card {
	    width: 700px;
	    min-height: 470px;
	    overflow: auto;
	}
</style>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

	<!-- Custom styles for this template-->
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/css/certification.css" />
	
	<!-- jquery -->
	<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
	<!-- alert -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<title>CUBE : 문의하기</title>
</head>
<body class="bg-gradient-primary">

<div class="container">

<!-- Outer Row -->
<div class="row justify-content-center align-items-center" style="height: 100vh;">
<div class="card o-hidden border-0 shadow-lg my-5">
<div class="card-body p-0">
	<!-- Nested Row within Card Body -->
	<div class="p-5">
		<h1 class="h4 text-gray-900 mt-1 mb-4 font-weight-bold">문의하기</h1>
		<hr class="border border-dark">

		<div class="form-group row mt-4">
			<div class="col-sm-2 mb-3 mb-sm-0" style="margin-right: 2%;">
				<p class="h8 text-gray-900">이메일</p>
			</div>
			<div style="width:45%;">	
				<input type="email" class="form-control form-control-user" id="qnaEmail" name="qnaEmail">
				<small id="qnaEmailError" class="text-danger"></small>
		        <script>
		            const qnaEmailInput = document.getElementById('qnaEmail');
		            const qnaEmailError = document.getElementById('qnaEmailError');
		
		            qnaEmailInput.addEventListener('input', function(event) {
		                //정규표현식을 사용하여 이메일 유효성 검사
		                const qnaEmailRegex = /^\S+@\S+\.\S+$/;
		
		                if (!qnaEmailInput.checkValidity()) {
		                	qnaEmailError.textContent = '이메일 형식으로 입력해주세요.';
		                } else {
		                	qnaEmailError.textContent = '';
		                }
		            });
		        </script>
	        </div>
		</div>
		
		<div class="form-group row mt-4">
			<div class="col-sm-2 mb-3 mb-sm-0">
				<p class="h8 text-gray-900">문의 제목</p>
			</div>
			<div class="col-sm-10 mb-3 mb-sm-0">
				<input type="text" class="form-control form-control-user" id="qnaTitle" name="qnaTitle">
			</div>
		</div>
		
		<div class="form-group row mt-4">
			<div class="col-sm-2 mb-3 mb-sm-0">
				<p class="h8 text-gray-900">문의 내용</p>
			</div>
			<div class="col-sm-10 mb-3 mb-sm-0">
				<textarea class="form-control form-control-user" id="qnaContent" name="qnaContent"></textarea>
			</div>
		</div>

		<div class="form-group mt-5 mb-4">
		<button id="btn-qna" class="btn btn-primary btn-user btn-block">문의하기</button>
									
		</div>
							
		<hr>
						
		<div class="text-center mt-4">
		<a class="small" href="/login">로그인 화면으로</a>
		</div>
</div>
</div>
</div>
</div>
</div>

<script src="/js/hr.js"></script>

<!-- Bootstrap core JavaScript-->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="js/sb-admin-2.min.js"></script>

</body>
</html>