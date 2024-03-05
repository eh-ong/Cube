<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">

    <!-- 주소찾기api -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="/js/addressapi.js"></script>
	
	<!-- jquery -->
	<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
	<!-- alert -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <link href="css/certification.css" rel="stylesheet">
    
    <title>CUBE : 회원가입</title>

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
                                <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
                            </div>
                            <div class="user">
                                <!-- 아이디 -->
                                <div class="form-group row">
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control form-control-user" id="userId"
                                            placeholder="아이디">
		                                <label id="idStatus" style="color: red; margin-left: 2%; margin-top: 5%; margin-bottom: 0; font-size: 12px;">아이디 중복확인 필요</label>
		                                <small id="userIdError" class="text-danger"></small>
		                                <script>
		                                    const userIdInput = document.getElementById('userId');
		                                    const userIdError = document.getElementById('userIdError');
		
		                                    userIdInput.addEventListener('input', function(event) {
		                                        // 정규표현식을 사용하여 아이디 유효성 검사
		                                        const userIdRegex = /^[a-zA-Z0-9]{5,}$/; // 5글자 이상, 공백 허용 안함, 한글 허용 안함
		
		                                        if (!userIdRegex.test(userIdInput.value)) {
		                                            userIdError.textContent = '아이디는 5자 이상 입력해주세요.';
		                                        } else {
		                                            userIdError.textContent = ''; // 에러 메시지 초기화
		                                        }
		                                    });
		                                </script>
                                    </div>
                                    <div class="col-sm-4">
                                        <button id="btn-checkId" class="btn btn-secondary btn-user btn-block">중복확인</button>
                                    </div>                                
                                </div>
                                
                                <!-- 비밀번호 -->
                                <div class="form-group">
                                    <input type="password" class="form-control form-control-user"
                                        id="userPw" placeholder="비밀번호">
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
                                <!-- 비밀번호확인 -->
                                <div class="form-group">
                                    <input type="password" class="form-control form-control-user"
                                        id="checkPw" placeholder="비밀번호 확인">
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
                                <!-- 사번 -->
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" id="userNum"
                                       placeholder="사번 8자리">
                                    <small id="userNumError" class="text-danger"></small>
                                    <script>
                                        const userNumInput = document.getElementById('userNum');
                                        const userNumError = document.getElementById('userNumError');

                                        userNumInput.addEventListener('input', function(event) {
                                            // 정규표현식을 사용하여 휴대전화번호 유효성 검사
                                            const userNumRegex = /^\d{8}$/; // 8자리 숫자

                                            if (!userNumRegex
                                                    .test(userNumInput.value)) {
                                                userNumError.textContent = '지급받은 사번을 입력해주세요(숫자 8자리).';
                                            } else {
                                                userNumError.textContent = ''; // 에러 메시지 초기화
                                            }
                                        });
                                    </script>
                                </div>    
                                    
                                <!-- 이름 -->
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" id="userName"
                                        placeholder="이름">
	                                <small id="userNameError" class="text-danger"></small>
	                                <script>
	                                    const userNameInput = document.getElementById('userName');
	                                    const userNameError = document
	                                            .getElementById('userNameError');
	
	                                    userNameInput.addEventListener('input', function(event) {
	                                        // 정규표현식을 사용하여 이름 유효성 검사
	                                        const userNameRegex = /^[가-힣a-zA-Z_]+$/; // 1글자 이상, 공백/특수문자/숫자 허용 안함, 한글 허용
	
	                                        if (!userNameRegex.test(userNameInput.value)) {
	                                            userNameError.textContent = '이름을 입력해주세요.';
	                                        } else {
	                                            userNameError.textContent = ''; // 에러 메시지 초기화
	                                        }
	                                    });
	                                </script>
                                </div>

                                <!-- 성별 -->
                                <label for="userGender" class="label1">성별</label>
                                <div class="form-group">

                                    <ul class="gender_list" id="userGender" style="width: 100%;">
                                        <li class="radio_item"><input type="radio" id="gender1" name="gender" value="남" class="blind"> <label
                                            for="gender1">남자</label></li>
                                        <li class="radio_item"><input type="radio" id="gender2" name="gender" value="여" class="blind"> <label
                                            for="gender2">여자</label></li>
                                    </ul>
	                                <small id="userGenderError" class="text-danger"></small>
                                </div>

                                <!-- 주소 -->
                                <div class="form-group row">
                                    <div class="col-sm-8 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" id="userZipCode" name="userZipCode"
                                            placeholder="우편번호" readonly="readonly">
                                    </div>
                                    <div class="col-sm-4">
                                        <button type="button" class="btn btn-secondary btn-user btn-block" onclick="execPostCode();">
                                            <i class="fa fa-search"></i>주소찾기
                                        </button>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" id="userAddr" name="userAddr"
                                        placeholder="도로명 주소" readonly="readonly">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" id="userAddrDetail"
                                        placeholder="상세 주소">
                                
	                                <small id="userAddrDetailError" class="text-danger"></small>
	                                <script>
	                                    const userAddrDetailInput = document.getElementById('userAddrDetail');
	                                    const userAddrDetailError = document.getElementById('userAddrDetailError');
	
	                                    userAddrDetailInput.addEventListener('input', function(event) {
	                                        // 정규표현식을 사용하여 휴대전화번호 유효성 검사
	                                        const userAddrDetailRegex = /^\S.*$/; // 1글자 이상, 공백 허용, 공백만 입력은 불가
	
	                                        if (!userAddrDetailRegex
	                                                .test(userAddrDetailInput.value)) {
	                                            userAddrDetailError.textContent = '상세주소를 입력해주세요.';
	                                        } else {
	                                            userAddrDetailError.textContent = ''; // 에러 메시지 초기화
	                                        }
	                                    });
	                                </script>
                                </div>

                                <!-- 휴대전화번호 -->
                                <div class="form-group row">
                                    <div class="col-sm-8 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" id="userMobile"
                                            placeholder="휴대전화번호">
		                                <label id="mobileStatus" style="color: red; margin-left: 2%; margin-top: 5%; margin-bottom: 0; font-size: 12px;">휴대전화번호 중복확인 필요</label>
		                                <!-- 에러 메시지를 표시할 small 요소 -->
		                                <small id="userMobileError" class="text-danger"></small>
		                                <script>
		                                    const userMobileInput = document.getElementById('userMobile');
		                                    const userMobileError = document.getElementById('userMobileError');
		
		                                    userMobileInput.addEventListener('input', function(event) {
		                                        // 정규표현식을 사용하여 휴대전화번호 유효성 검사
		                                        const userMobileRegex = /^\d{11}$/; //11자리 숫자
		
		                                        if (!userMobileRegex
		                                                .test(userMobileInput.value)) {
		                                            userMobileError.textContent = '휴대전화번호 11자리를 입력해주세요.';
		                                        } else {
		                                            userMobileError.textContent = ''; // 에러 메시지 초기화
		                                        }
		                                    });
		                                </script>
                                    </div>
                                    <div class="col-sm-4">
                                        <button id="btn-checkMobile" class="btn btn-secondary btn-user btn-block">중복확인</button>
                                    </div>
                                </div>

                                <!-- 외부 이메일 -->
                                <div class="form-group row">
                                    <div class="col-sm-8 mb-3 mb-sm-0">
                                        <input type="email" class="form-control form-control-user" id="userEmailEx"
                                            placeholder="외부 이메일">
		                                <label id="emailExStatus" style="color: red; margin-left: 2%; margin-top: 5%; margin-bottom: 0; font-size: 12px;">외부 이메일 중복확인 필요</label>
		                                <small id="userEmailExError" class="text-danger"></small>
		                                <script>
		                                    const userEmailExInput = document.getElementById('userEmailEx');
		                                    const userEmailExError = document.getElementById('userEmailExError');
		
		                                    userEmailExInput.addEventListener('input', function(event) {
		                                        //정규표현식을 사용하여 이메일 유효성 검사
		                                        const userEmailExRegex = /^\S+@\S+\.\S+$/;
		
		                                        if (!userEmailExInput.checkValidity()) {
		                                            userEmailExError.textContent = '이메일 형식으로 입력해주세요.';
		                                        } else {
		                                            userEmailExError.textContent = '';
		                                        }
		                                    });
		                                </script>
                                    </div>
                                    <div class="col-sm-4">
                                        <button id="btn-checkEmailEx" class="btn btn-secondary btn-user btn-block">중복확인</button>
                                    </div>
                                </div>


                                <button id="btn-signUp" class="btn btn-primary btn-user btn-block">회원가입 신청</button>
                                
                            </div>
                            <br>
                            <hr>
                            <br>
                            <div class="text-center">
                                <a class="small" href="/login">로그인하기</a>&nbsp&nbsp&nbsp&nbsp
                                <a class="small" href="/findIdPw">아이디 | 비밀번호찾기</a>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
        </div>

    </div>
    
    <script src="/js/certification.js"></script>

    <!-- Bootstrap core JavaScript-->
    <script src="/js/templet/jquery.min.js"></script>
    <script src="/js/templet/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/js/templet/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/js/templet/sb-admin-2.min.js"></script>

</body>

</html>