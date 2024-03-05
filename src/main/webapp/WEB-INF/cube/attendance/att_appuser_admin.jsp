<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
.hovertr {
	background-color: white;
	transition: background-color 0.3s;
}
.hovertr:hover{
	background-color: lightgrey;
}
</style>
</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-secondary">
					근태<i class="fas fa-chevron-right mx-1"></i>관리자<i class="fas fa-chevron-right mx-1"></i>근태 계획 승인<i class="fas fa-chevron-right mx-1"></i>${user.userName} ${inputMonth}월
				<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<table
					class="table table-bordered text-gray-900 border-bottom-primary"
					width="100%" cellspacing="0">
					<thead>
						<tr align="center">
							<th width = 10%>이름</th>
							<th width = 12%>날짜</th>
							<th width = 12%>요일 구분</th>
							<th width = 12%>근무 구분</th>
							<th width = 12%>휴가 신청</th>
							<th width = 12%>휴가 신청 상태</th>
							<th width = 30% colspan="4">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="attendanceplan" items="${apList}" varStatus="loop">
							<tr id="apTr" align="center" class="hovertr">
								<td>${attendanceplan.userId.userName}</td>
								<td>${attendanceplan.apDate}</td>
								<td>${attendanceplan.apIsweekend}</td>
								<td>${attendanceplan.apType}</td>
								<td>${vaTypeResult[loop.index].get(attendanceplan.apDate)[0] eq null ? "-" : vaTypeResult[loop.index].get(attendanceplan.apDate)[0]}</td>
								<td>${vaTypeResult[loop.index].get(attendanceplan.apDate)[1] eq null ? "-" : vaTypeResult[loop.index].get(attendanceplan.apDate)[1]}</td>
								<td>${attendanceplan.apStatus}<input
									type="hidden" id="apId" value="${attendanceplan.apId}" />
									<input
									type="hidden" id="apStatus" value="${attendanceplan.apStatus}" /></td>
									<c:if test="${attendanceplan.apStatus eq '대기중'}">
										<td style="vertical-align: middle"><div style="background-color: green; border-radius: 50%; border: none; width:20px; height: 20px;"></div></td>
									</c:if>
									<c:if test="${attendanceplan.apStatus eq '미등록'}">
										<td style="vertical-align: middle"><div style="background-color: orange; border-radius: 50%; border: none; width:20px; height: 20px;"></div></td>
									</c:if>
									<c:if test="${attendanceplan.apStatus eq '승인'}">
										<td style="vertical-align: middle"><div style="background-color: blue; border-radius: 50%; border: none; width:20px; height: 20px;"></div></td>
									</c:if>
									<c:if test="${attendanceplan.apStatus eq '반려'}">
										<td style="vertical-align: middle"><div style="background-color: red; border-radius: 50%; border: none; width:20px; height: 20px;"></div></td>
									</c:if>
									<c:set var="status" value="${attendanceplan.apStatus}" />
									<c:set var="vaStatus" value="${vaTypeResult[loop.index].get(attendanceplan.apDate)[1]}" />
									<c:set var="aptype" value="${attendanceplan.apType}" />
									<td><button class="btn btn-primary py-1 APappbtn" <c:if test="${(status eq '미등록') or ((vaStatus ne '승인') and (aptype ne '정상근무'))}">disabled</c:if>>승인</button></td>
									<td><button class="btn btn-danger py-1 APrejectbtn" <c:if test="${(status eq '미등록') or ((vaStatus ne '승인') and (aptype ne '정상근무'))}">disabled</c:if>>반려</button></td>
									
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class = "text-center">
				<button id="saveAll" class="btn btn-primary" <c:if test="${status == '미등록'}">disabled</c:if>><i class="fas fa-pen mr-1"></i>전체 승인</button>
				</div>
			</div>
		</div>
	</div>
	<script src="/js/att.js"></script>
</body>
</html>

