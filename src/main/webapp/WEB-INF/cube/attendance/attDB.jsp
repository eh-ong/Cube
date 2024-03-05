<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-secondary">
					근태 데이터베이스
				</h6>
			</div>
			<div class="card-body">
				<select name="userSelect" class = "form-select" id= "userSelect">
    				<c:forEach var="user" items="${userList}">
        				<option value="${user.userId}">${user.userName}</option>
   					</c:forEach>
				</select>
				<hr>
				<select name="monthSelect" class = "form-select" id="monthSelect">
        				<option value= 1 >1</option>
        				<option value= 2 >2</option>
        				<option value= 3 >3</option>
        				<option value= 4 >4</option>
				</select>
				<br>
				<select name="statusSelect" class = "form-select" id= "statusSelect">
    				<option value= "대기중" >대기중</option>
    				<option value= "승인" >승인</option>
				</select>
				<br>
				<button id = "addAP">근태계획생성</button>
				
				
				<br>
				<hr>
				날짜: <input type="date" id="daySelect"><br>
				출근: <input type="time" id="startSelect" value="09:00"><br>
				초과근무시작: <input type="time" id="ottime" min="18:00" max="23:59"><br>
				초과근무종료: <input type="time" id="otendtime" min="18:00" max="23:59"><br>
				
				<button id = "addAtt">근태 생성</button>
				
				<hr>
				근태 1개월 생성
				<button id = "createAtt">근태 생성</button>
			</div>
		</div>
	</div>
	
	
	<script>
	$("#addAP").on("click", () => { 
	    let userId = $("#userSelect").val();
	    let month = $("#monthSelect").val();
	    let status = $("#statusSelect").val();
	    
	    $.ajax({
	        type: "POST",
	        url: "/addAP",
	        data: {
	            userId: userId,
	            month: month,
	            status: status
	        }
	    }).done(function(response){
	        console.log(response);
	        alert("완료");
	        location.reload();
	    }).fail(function(error){
	        console.log(error);
	        alert("에러 발생: " + error);
	    });
	});
	
	$("#addAtt").on("click", () => { 
	    let userId = $("#userSelect").val();
	    let day = $("#daySelect").val();
	    let start = $("#startSelect").val();
	    let ottime = $("#ottime").val();
	    let otendtime = $("#otendtime").val();
	    
	    $.ajax({
	        type: "POST",
	        url: "/addAtt",
	        data: {
	            userId: userId,
	            day: day,
	            start: start,
	    		ottime: ottime,
	    		ottimeend:otendtime
	        }
	    }).done(function(response){
	        console.log(response);
	        alert("완료");
	        location.reload();
	    }).fail(function(error){
	        console.log(error);
	        alert("에러 발생: " + error);
	    });
	});
	
	$("#createAtt").on("click", () => { 
	    let userId = $("#userSelect").val();
	    let month = $("#monthSelect").val();
	    
	    $.ajax({
	        type: "POST",
	        url: "/createAtt",
	        data: {
	            userId: userId,
	            month: month,

	        }
	    }).done(function(response){
	        console.log(response);
	        alert("완료");
	        location.reload();
	    }).fail(function(error){
	        console.log(error);
	        alert("에러 발생: " + error);
	    });
	});
	</script>
</body>
</html>
