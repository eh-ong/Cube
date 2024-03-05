<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회의실 예약</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/css/insertrev.css" />
</head>
<body id="page-top">
    <header class="index_header">
        <jsp:include page="../layout/header.jsp" />
    </header>
    <div class="container-fluid">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 text-secondary">
                    예약시스템<i class="fas fa-chevron-right mx-1"></i>관리자<i
                        class="fas fa-chevron-right mx-1"></i>회의실 등록
                        <i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
                </h6>
            </div>
            <div class="card-body">
                <div id="calendar"></div>
                <!-- General Form Elements -->
                <!-- 회의실 이름 -->
                <div class="form-group">
                    <label for="mrName">회의실 이름</label>
                    <input type="text" id="mrName" name="mrName" class="form-control" style="width: 50%;" required>
                </div>
                
                <!-- 회의실 위치 -->
                <div class="form-group">
                    <label for="mrLocation">회의실 위치</label>
                    <input type="text" id="mrLocation" name="mrLocation" class="form-control" style="width: 50%;" required>
                </div>
                
                                <!-- 회의실 인원수 -->
                <div class="form-group">
                    <label for="mrCapacity">회의실 인원수</label>
                    <input type="text" id="mrCapacity" name="mrCapacity" class="form-control" style="width: 50%;" required>
                </div>

                <!-- 예약자 -->
                <div class="form-group">
                    <label for="userId">등록자</label> 
                    <input value="${login_user.userName}" id="userId" name="userId" readonly="readonly" class="form-control" style="width: 50%;">
                </div>

                <!-- 버튼 -->
                <div class="text-center mt-4">
                    <button id="btn-insert" class="btn btn-primary">회의실 등록</button>
                </div>
            </div>
        </div>
    </div>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<script src="/js/revRegister.js"></script>
</body>
</html>
