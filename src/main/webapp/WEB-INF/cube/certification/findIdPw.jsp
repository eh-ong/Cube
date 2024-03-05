<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    background-size: cover; /* 이미지를 화면에 맞게 조절 */
    background-position: center; /* 이미지를 중앙에 정렬 */
    height: 500px;
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

<title>CUBE : 회원정보 찾기</title>
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
						<h1 class="h4 text-gray-900 mt-4 mb-4 font-weight-bold">회원정보 찾기</h1>
						</div>
						<br>
						<br>
						<br>
						<div class="form-group">
							<a href="/findId" class="btn btn-primary btn-user btn-block">아이디 찾기</a>		
						</div>
						<br>
						<div class="form-group">	
							<a href="/findPw" class="btn btn-primary btn-user btn-block">비밀번호 찾기</a>
						</div>
						</div>                              
						<div class="text-center">
							<a class="small" href="/login">로그인 화면으로</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
						    <a class="small" href="/signUp">회원가입</a>
						</div>
						</div>
						</div>  
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

</body>
</html>