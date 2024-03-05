<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>차량 예약</title>
<link rel="stylesheet" type="text/css" href="/css/insertrev.css" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css">
</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-secondary">
					예약시스템<i class="fas fa-chevron-right mx-1"></i>차량<i
						class="fas fa-chevron-right mx-1"></i>차량예약
						<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<div id="calendar"></div>
  

				<!-- General Form Elements -->
				<!-- 날짜 선택 -->
		<div class="form-group">
			<label for="creDate">날짜 선택:</label> <input type="date" id="creDate"
				class="form-control" style="width: 50%;" name="creDate" min="<%=LocalDate.now()%>"
				required>
		</div>

				<div class="form-group">
					<label for="creStart">시작 시간:</label> <select id="creStart"
						name="creStart" class="form-control" style="width: 50%;" required>
						<option value="">시간을 선택하세요</option>
						<!-- 오전 9시부터 오후 6시까지의 옵션 생성 -->
						<c:forEach begin="9" end="18" var="hour">
							<c:set var="hour" value="${hour < 10 ? '09' : hour}" />
							<c:set var="amPm" value="${hour >= 12 ? '오후' : '오전'}" />
							<c:set var="hour12" value="${hour > 12 ? hour - 12 : hour}" />
							<option value="<c:out value='${hour}'/>:00">${amPm}
								<c:out value='${hour12}' />:00
							</option>
							<option value="<c:out value='${hour}'/>:30">${amPm}
								<c:out value='${hour12}' />:30
							</option>
						</c:forEach>
					</select>
				</div>

				<div class="form-group">
					<label for="creEnd">종료 시간:</label> <select id="creEnd"
						name="creEnd" class="form-control" style="width: 50%;" required>
						<option value="">시간을 선택하세요</option>
						<!-- 오전 9시부터 오후 6시까지의 옵션 생성 -->
						<c:forEach begin="9" end="18" var="hour">
							<c:set var="hour" value="${hour < 10 ? '09' : hour}" />
							<c:set var="amPm" value="${hour >= 12 ? '오후' : '오전'}" />
							<c:set var="hour12" value="${hour > 12 ? hour - 12 : hour}" />
							<option value="<c:out value='${hour}'/>:00">${amPm}
								<c:out value='${hour12}' />:00
							</option>
							<option value="<c:out value='${hour}'/>:30">${amPm}
								<c:out value='${hour12}' />:30
							</option>
						</c:forEach>
					</select>
				</div>

				<div class="form-group">
					<label for="creNum">차량 선택:</label> <select id="creNum"
						name="creNum" class="form-control" style="width: 50%;" required>
						<option value="">차량을 선택하세요</option>
						<!-- carList에서 각 아이템을 반복하며 셀렉트 박스 옵션 생성 -->
						<c:forEach var="car" items="${carList}">
							<option value="${car.carId}">${car.carName}</option>
						</c:forEach>
					</select>
				</div>
				
				 <!-- 회의실 인원수 -->
                <div class="form-group">
                    <label for="creCount">탑승 인원</label>
                    <input type="text" id="creCount" name="creCount" class="form-control" style="width: 50%;" required>
                </div>


				<!-- 예약자 -->
				<div class="form-group">
					<label for="userId">예약자:</label> <input
						value="${login_user.userName}" id="userId" name="userId"
						readonly="readonly" class="form-control" style="width: 50%;">

				</div>


				<!-- 버튼 -->
				<div class="text-center mt-4">
					<button id="btn-insert" class="btn btn-primary">예약등록</button>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="/js/revcar.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>
