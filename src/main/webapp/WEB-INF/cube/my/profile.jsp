<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>

</head>
<body>
<header class="index_header">
	<jsp:include page="../layout/header.jsp" />
</header>
<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<a class="m-0 text-secondary" href="/my_main">마이페이지</a>
				<i class="fas fa-chevron-right mx-1"></i>
				<a class="m-0 text-secondary" href="/my_profileCheckPw">내 정보</a>
			</div>
			<div class="card-body">
				<h2 class="h4 text-gray-900 font-weight-bold">내 정보</h2>
						
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
	</div>
</div>

<div class="col-lg-6 mt-4">	
<div class="p-3">		

	<div class="form-group row">
		<div class="col-lg-3">		
			<label for="userNum" class="label">사번</label>
		</div>
		<div class="col-lg-8">
			<label for="userNum" class="label">${user.userNum }</label>
			<%-- <input type="text" id="userNum" class="form-control" readOnly=readOnly value="${user.userNum }"> --%>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-lg-3">			
			<label for="userEmail" class="label">이메일</label>
		</div>
		<div class="col-lg-8">
			<label for="userEmail" class="label">${user.userEmail }</label>
			<%-- <input type="email" id="userEmail" class="form-control" readOnly=readOnly value="${user.userEmail }"> --%>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-lg-3">					
			<label class="label">우편번호</label>
		</div>
		<div class="col-lg-8">
			<label for="userZipCode" class="label">${user.userZipCode }</label>	
			<%-- <input class="form-control"
				placeholder="우편번호" name="userZipCode" id="userZipCode" type="text" readonly="readonly" value="${user.userZipCode }"> --%>
			<!-- <button type="button" class="btn-findAddr" onclick="execPostCode();">
				<i class="fa fa-search"></i>주소찾기
			</button> -->
		</div>	
	</div>
	<div class="form-group row">
		<div class="col-lg-3">					
			<label class="label">주소</label>
		</div>
		<div class="col-lg-8">
			<label for="userAddr" class="label">${user.userAddr }</label>	
			<%-- <input class="form-control" placeholder="도로명 주소" name="userAddr" id="userAddr" type="text" readonly="readonly" value="${user.userAddr }"> --%>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-lg-3">						
			<label class="label">상세주소</label>	
		</div>
		<div class="col-lg-8">
			<label for="userAddrDetail" class="label">${user.userAddrDetail }</label>
			<%-- <input class="form-control" placeholder="상세 주소" name="userAddrDetail" id="userAddrDetail" type="text" readonly="readonly" value="${user.userAddrDetail }"> --%>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-lg-3">
			<label for="userMobile" class="label">휴대전화번호</label>
		</div>
		<div class="col-lg-8">
			<label for="userMobile" class="label">${user.userMobile }</label>
			<%-- <input type="text" id="userMobile" class="form-control" readOnly=readOnly value="${user.userMobile }"> --%>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-lg-3">
			<label for="userEmailEx" class="label">외부 이메일</label>
		</div>
		<div class="col-lg-8">
			<label for="userEmailEx" class="label">${user.userEmailEx }</label>
			<%-- <input type="email" id="userEmailEx" class="form-control" readOnly=readOnly value="${user.userEmailEx }"> --%>
		</div>
	</div>
					
</div>
</div>
</div>
<hr>
	<div class="form-group row justify-content-center">
		<a href="/my_updateProfile" class="btn btn-outline-primary">수정하기</a>
	</div>
</div>
</div>
</div>
<script src="/js/my.js"></script>
</body>
</html>