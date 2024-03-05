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
            <h1 class="h4 text-gray-900 mt-4 mb-5 font-weight-bold">비밀번호 찾기</h1>           
        </div>
        
     	<!-- 아이디 -->
		<div class="form-group">
		    <input type="text" class="form-control form-control-user" id="userId" placeholder="아이디">
        </div>
			<small id="userIdError" class="text-danger-findIdPw"></small>
			<script>
				const userIdInput = document.getElementById('userId');
				const userIdError = document.getElementById('userIdError');
	
				userIdInput.addEventListener('input', function(event) {
					// 정규표현식을 사용하여 아이디 유효성 검사
					const userIdRegex = /^[a-zA-Z0-9]{5,}$/; // 5글자 이상, 공백 허용 안함, 한글 허용 안함
	
					if (!userIdRegex.test(userIdInput.value)) {
						userIdError.textContent = '아이디를 입력해 주세요.';
					} else {
						userIdError.textContent = ''; // 에러 메시지 초기화
					}
				});
			</script>
			

       <!-- 사번 -->
        <div class="form-group">
            <input type="text" class="form-control form-control-user" id="userNum" placeholder="사번 8자리">
        </div>
        <small id="userNumError" class="text-danger-findIdPw"></small>
		<script>
			const userNumInput = document.getElementById('userNum');
			const userNumError = document.getElementById('userNumError');

			userNumInput.addEventListener('input', function(event) {
				// 정규표현식을 사용하여 휴대전화번호 유효성 검사
				const userNumRegex = /^\d{8}$/; // 8자리 숫자

				if (!userNumRegex.test(userNumInput.value)) {
					userNumError.textContent = '지급받은 사번을 입력해 주세요.';
				} else {
					userNumError.textContent = ''; // 에러 메시지 초기화
				}
			});
		</script>
                                     
        <!-- 이름 -->
        <div class="form-group">
           <input type="text" class="form-control form-control-user" id="userName" placeholder="이름">
       	</div>
		<small id="userNameError" class="text-danger-findIdPw"></small>
		<script>
			const userNameInput = document.getElementById('userName');
			const userNameError = document.getElementById('userNameError');

			userNameInput.addEventListener('input', function(event) {
				// 정규표현식을 사용하여 이름 유효성 검사
				const userNameRegex = /^[가-힣a-zA-Z_]+$/; // 1글자 이상, 공백/특수문자/숫자 허용 안함, 한글 허용

				if (!userNameRegex.test(userNameInput.value)) {
					userNameError.textContent = '이름을 입력해 주세요.';
				} else {
					userNameError.textContent = ''; // 에러 메시지 초기화
				}
			});
		</script>

        <!-- 휴대전화번호 -->
	    <div class="form-group">
            <input type="text" class="form-control form-control-user" id="userMobile" placeholder="휴대전화 번호">
        </div>

		<small id="userMobileError" class="text-danger-findIdPw"></small>
		<script>
			const userMobileInput = document.getElementById('userMobile');
			const userMobileError = document.getElementById('userMobileError');

			userMobileInput.addEventListener('input', function(event) {
				// 정규표현식을 사용하여 휴대전화번호 유효성 검사
				const userMobileRegex = /^\d{11}$/; //11자리 숫자

				if (!userMobileRegex
						.test(userMobileInput.value)) {
					userMobileError.textContent = '휴대전화 번호 11자리를 입력해 주세요.';
				} else {
					userMobileError.textContent = ''; // 에러 메시지 초기화
				}
			});
		</script>
		
        <div class="form-group">
			<button id="btn-findPwCheckUser" class="btn btn-primary btn-user btn-block">비밀번호 찾기</button>
		</div>

		<hr>
                          
		<div class="text-center">
			<a class="small" href="/login">로그인 화면으로</a>
		</div>
</div>
</div>
</div>
</div>
</div>

<!-- Bootstrap core JavaScript-->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="js/sb-admin-2.min.js"></script>
<script src="/js/certification.js"></script>
</body>
</html>