<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<style>
.card {
    width: 800px;
    height: 470px;
    overflow: auto;
}
.bg-image-a {
    background-image: url('/image/login_cubeCat.gif');
    background-size: cover;
    background-position: center;
    height: 470px;
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

<title>CUBE : 로그인</title>
</head>
<body class="bg-gradient-primary">       

<div class="container">

<!-- Outer Row -->
<div class="row justify-content-center align-items-center" style="height: 100vh;">
<!-- <div class="col-xl-10 col-lg-12 col-md-9"> -->
<div class="card o-hidden border-0 shadow-lg my-5">
<div class="card-body p-0">
<!-- Nested Row within Card Body -->
<div class="row">
<div class="col-lg-6 d-none d-lg-block bg-image-a"></div>
<div class="col-lg-6">
<div class="p-5">
    <div class="text-center">
        <h1 class="h2 text-gray-900 mt-3 mb-5 font-weight-bold">Login</h1>
    </div>
	<div class="form-group">
	    <input type="text" class="form-control form-control-user" id="userId" aria-describedby="emailHelp" placeholder="아이디">
	</div>
	<div class="form-group">
	    <input type="password" class="form-control form-control-user" id="userPw" placeholder="비밀번호">
	</div>
	<br>
	<div class="form-group">	
		<button id="btn-login" class="btn btn-primary btn-user btn-block">로그인</button>
	</div>
	<hr>
	<div class="text-center">
	    <a class="small" href="/findIdPw">아이디 | 비밀번호 찾기</a>
	    <a class="small" href="/signUp">회원가입</a>
    </div>
    <br>
   	<div class="text-center">	    
	    <a class="small" href="/hr_qna">문의하기</a>
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
<script src="/js/templet/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/js/templet/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/templet/sb-admin-2.min.js"></script>
    
</body>
</html>