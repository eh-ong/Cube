<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<!-- 주소찾기api -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="/js/addressapi.js"></script>
	
	<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>

</head>
<body>
<header class="index_header">
	<jsp:include page="../layout/header.jsp" />
</header>

<input type="hidden" id="userId" value="${user.userId }">
	
<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<a class="m-0 text-secondary" href="/my_main">마이페이지</a>
				<i class="fas fa-chevron-right mx-1"></i>
				<a  class="m-0 text-secondary" href="/my_profileCheckPw">내 정보</a>
			</div>
			<div class="card-body">
				<h2 class="h4 text-gray-900 font-weight-bold">내정보</h2>
				
<div class="form-group row justify-content-center">		
<div class="col-lg-4 d-flex justify-content-center">
	<div class="form-group">
		<div class="form-group">
			<img src="${user.userFilePath }" style="width: auto; height: 310px;" >
		</div>
		
		<br>
		<div class="form-group text-center">
			<h3 class="h4 text-gray-900 font-weight-bold">${user.userTeamId.teamName }팀 ${user.userName} ${user.userPosition }</h3>
		</div>
		<div class="form-group row">
			<div class="form-group">
				<input style="width: 70%" type="file" id="fileInput" name="file" accept="image/*" />
			</div>
			<div class="form-group">
				<button id="btn-uploadFile" class="btn btn-outline-primary btn-sm" style="margin-left: -100px;">사진 등록하기</button>			
			</div>
		</div>
	</div>
</div>

<div class="col-lg-6 mt-4">	
<div class="p-3">		

	<div class="form-group row d-flex align-items-center">
		<div class="col-lg-3">		
			<label for="userNum" class="label">사번</label>
		</div>
		<div class="col-lg-8">
			<input type="text" id="userNum" class="form-control" readOnly=readOnly value="${user.userNum }">
		</div>
	</div>
	<div class="form-group row d-flex align-items-center">
		<div class="col-lg-3">			
			<label for="userEmail" class="label">이메일</label>
		</div>
		<div class="col-lg-8">
			<input type="email" id="userEmail" class="form-control" readOnly=readOnly value="${user.userEmail }">
		</div>
	</div>
	
<!-- 주소 -->
	<div class="form-group row d-flex align-items-center">
		<div class="col-lg-3">					
			<label class="label">우편번호</label>
		</div>
		<div class="col-lg-6">
			<input class="form-control"
				placeholder="우편번호" name="userZipCode" id="userZipCode" type="text" readonly="readonly" value="${user.userZipCode }">
		</div>
		<div>
			<button type="button" class="btn btn-outline-secondary" onclick="execPostCode();">주소찾기</button>
		</div>			
			
		</div>	
	<div class="form-group row d-flex align-items-center">
		<div class="col-lg-3">					
			<label class="label">주소</label>
		</div>
		<div class="col-lg-8">
			<input class="form-control" placeholder="도로명 주소" name="userAddr" id="userAddr" type="text" readonly="readonly" value="${user.userAddr }">
		</div>
	</div>
	<div class="form-group row d-flex align-items-center">
		<div class="col-lg-3">						
			<label class="label">상세주소</label>	
		</div>
		<div class="col-lg-8">
			<input class="form-control" style="margin-bottom: 6px;"
				   placeholder="상세 주소" name="userAddrDetail" id="userAddrDetail" type="text" value="${user.userAddrDetail }">
			<small id="userAddrDetailError" class="text-danger"></small>
			<script>
				const userAddrDetailInput = document.getElementById('userAddrDetail');
				const userAddrDetailError = document.getElementById('userAddrDetailError');
		
				userAddrDetailInput.addEventListener('input', function(event) {
					// 정규표현식을 사용하여 휴대전화번호 유효성 검사
					const userAddrDetailRegex = /^\S.*$/; // 1글자 이상, 공백 허용, 공백만 입력은 불가
		
					if (!userAddrDetailRegex.test(userAddrDetailInput.value)) {
						userAddrDetailError.textContent = '상세주소를 입력해 주세요.';
					} else {
						userAddrDetailError.textContent = ''; // 에러 메시지 초기화
					}
				});
			</script>
		</div>
	</div>
	
<!-- 휴대전화 번호 -->
	<div class="form-group row" style="margin-bottom: -2px;">
		<div class="col-lg-3 mt-2">
			<label for="userMobile" class="label">휴대전화번호</label>
		</div>
		<div class="col-lg-6">
			<input type="text" id="userMobile" class="form-control" value="${user.userMobile }">
			<label id="mobileStatus" style="color: red; margin-top:10px; margin-bottom: -20px; font-size: 13px;"></label>
			<br>
			<!-- 에러 메시지를 표시할 small 요소 -->
			<small id="userMobileError" class="text-danger"></small>
			<script>
				const userMobileInput = document.getElementById('userMobile');
				const userMobileError = document.getElementById('userMobileError');
		
				userMobileInput.addEventListener('input', function(event) {
					// 정규표현식을 사용하여 휴대전화번호 유효성 검사
					const userMobileRegex = /^\d{11}$/; //11자리 숫자
		
					if (!userMobileRegex.test(userMobileInput.value)) {
						mobileStatus.textContent = '휴대전화 번호 중복확인 필요';
						userMobileError.textContent = '휴대전화 번호 11자리를 입력해 주세요.';
					} else {
						userMobileError.textContent = ''; // 에러 메시지 초기화
					}
				});
			</script>
		</div>
		<div>
			<button id="btn-checkMobile" class="btn btn-outline-secondary">중복확인</button>
		</div>
	</div>
	
<!-- 외부 이메일 -->
	<div class="form-group row">
		<div class="col-lg-3 mt-2">
			<label for="userEmailEx" class="label">외부 이메일</label>
		</div>
		<div class="col-lg-6">
			<input type="email" id="userEmailEx" class="form-control" value="${user.userEmailEx }">
			
			<label id="emailExStatus" style="color: red; margin-top:10px; margin-bottom: -20px; font-size: 13px;"></label>
			<br>
			<small id="userEmailExError" class="text-danger"></small>
			<script>
				const userEmailExInput = document.getElementById('userEmailEx');
				const userEmailExError = document.getElementById('userEmailExError');

				userEmailExInput.addEventListener('input', function(event) {
					//정규표현식을 사용하여 이메일 유효성 검사
					const userEmailExRegex = /^\S+@\S+\.\S+$/;

					if (!userEmailExRegex.test(userEmailExInput.value)) {
						emailExStatus.textContent = '외부 이메일 중복확인 필요';
						userEmailExError.textContent = '이메일 형식으로 입력해 주세요.';
					} else {
						userEmailExError.textContent = '';
					}
				});
			</script>
		</div>
		<div>
			<button id="btn-checkEmailEx" class="btn btn-outline-secondary">중복확인</button>
		</div>
	</div>	
</div>
</div>
</div>
<hr>
	<div class="form-group row justify-content-center">
		<button id="btn-updateProfile" class="btn btn-primary">수정완료</button>
	</div>
</div>
</div>
</div>
<script src="/js/certification.js"></script>
<script src="/js/my.js"></script>
</body>
</html>