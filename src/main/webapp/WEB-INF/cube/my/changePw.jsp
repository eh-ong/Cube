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
	
	<input type="hidden" id="userId" value="${user.userId }">	
	
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
				
				<div class="form-group row">
					<div class="col-sm-1 mr-5 mt-2">
						<label for="userPw" class="label"  style="width: 170%;">변경할 비밀번호</label>
					</div>
					<div class="col-lg-3 ml-4">
						<input type="password" id="userPw" class="form-control" required>
						<small id="userPwError" class="text-danger"></small>
                        <script>
                            const userPwInput = document.getElementById('userPw');
                            const userPwError = document.getElementById('userPwError');

                            userPwInput.addEventListener('input', function(event) {
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
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-1 mr-5 mt-2">
						<label for="checkPw" class="label"  style="width: 200%;">변경할 비밀번호 확인</label>
					</div>
					<div class="col-lg-3 ml-4">
						<input type="password" id="checkPw" class="form-control" required>
						<small id="checkPwError" class="text-danger"></small>
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
					</div>
				</div>
				<br>
				<div class="form-group" style="margin-left: 14.5%;">
					<button id="btn-changePw" class="btn btn-primary" style="width: 15%;" type="submit">변경하기</button>
				</div>
		</div>
	</div>
</div>
			
<script src="/js/my.js"></script>
</body>
</html>