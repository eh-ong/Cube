<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<style>
	.card {
	    width: 350px;
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

<title>CUBE : 회원정보 찾기</title>
</head>
<body class="bg-gradient-primary">

<div class="container">

<!-- Outer Row -->
<div class="row justify-content-center align-items-center" style="height: 100vh;">
<div class="card o-hidden border-0 shadow-lg my-5">
<div class="card-body p-0">
	<!-- Nested Row within Card Body -->
		<div class="p-5">
		<div class="text-center">
			<h1 class="h4 text-gray-900 mt-4 mb-5 font-weight-bold">비밀번호 변경</h1>
		</div>
				
				<!-- 비밀번호 -->
				<div class="form-group">
					<input type="password" class="form-control form-control-user"
						id="userPw" name="userPw" placeholder="비밀번호">
				</div>
				<small id="userPwError" class="text-danger-findIdPw"></small>
				<script>
					const userPwInput = document.getElementById('userPw');
					const userPwError = document.getElementById('userPwError');

					userPwInput.addEventListener('input',function(event) {
						// 정규표현식을 사용하여 비밀번호 유효성 검사
						const userPwRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])\S{8,}$/; // 8자 이상,영문자,숫자,특수문자 포함, 공백 허용 안함

						if (!userPwRegex
								.test(userPwInput.value)) {
							userPwError.textContent = '비밀번호는 8자 이상, 영문자, 숫자, 특수문자를 포함해야 합니다.';
						} else {
							userPwError.textContent = ''; // 에러 메시지 초기화
						}
					});
				</script>
				
				<!-- 비밀번호 확인 -->
				<div class="form-group">
					<input type="password" class="form-control form-control-user"
						id="checkPw" name="checkPw" placeholder="비밀번호 확인">					
				</div>
				<small id="checkPwError" class="text-danger-findIdPw"></small>
				<script>
					const userPwForCheckInput = document
							.getElementById('userPw'); //위 스크립트와 변수명을 다르게 해야 실행 됨
					const checkPwInput = document.getElementById('checkPw');
					const checkPwError = document
							.getElementById('checkPwError');

					checkPwInput.addEventListener('input', function(event) {
						if (userPwForCheckInput.value !== checkPwInput.value) {
							checkPwError.textContent = '비밀번호가 일치하지 않습니다.';
						} else {
							checkPwError.textContent = ''; // 에러 메시지 초기화
						}
					});
				</script>
				<br>
				<div class="form-group">
					<button id="btn-changePw" class="btn btn-primary btn-user btn-block">비밀번호 변경하기</button>
				</div>
				
				<hr>
				<br>		
				<div class="text-center">
					<a class="small" href="/login">로그인 화면으로</a>
				</div>

			</div>

		</div>
	</div>
<script src="/js/certification.js"></script>

<!-- Bootstrap core JavaScript-->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="js/sb-admin-2.min.js"></script>
</body>
</html>