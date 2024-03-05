<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

	<!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

	<!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    
    <!-- jquery -->
	<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>

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
                                    <h1 class="h4 text-gray-900 mt-4 mb-5 font-weight-bold">회원정보 찾기</h1>
                                </div>
                                <br>
                                <br>
                                <div class="form-group">
                                    <label for="userId" class="label">찾은 아이디</label>
                                    <input type="text" class="form-control form-control-user"
                                        id="userId" readOnly="readOnly" value="${findUser.userId }">
                                </div>
                                <br>                                    
                                <br>                                    
                                <br>                                    
                                <hr>
                                <div class="text-center">
                                    <a class="small" href="/login">로그인 화면으로</a>
                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp                            
                                    <a class="small" href="/findPw">비밀번호 찾기</a>
                                </div>
                            </div>
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