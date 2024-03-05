<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-secondary">
					근태<i class="fas fa-chevron-right mx-1"></i>관리자<i class="fas fa-chevron-right mx-1"></i>팀 근태 조회<i class="fas fa-chevron-right mx-1"></i>${team.teamName}팀 사원 근태 조회
				<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
			<table class="table table-bordered text-gray-900 mb-2 border-bottom-primary">
			<tr align = center>
			<th width = 7%>성명</th>
			<th width = 12%>날짜</th>
			<th width = 12%>출근 시간</th>
			<th width = 12%>퇴근 시간</th>
			<th width = 8%>주말 구분</th>
			<th width = 8%>근무 구분</th>
			<th width = 12%>초과근무 시작</th>
			<th width = 12%>초과근무 종료</th>
			<th width = 17% colspan=3>상태</th>
			</tr>
			<tbody>
			<c:forEach var="att" items="${firstAttList}">
			<tr align = center>
			<td><a href = "/att_allfind_admin/${att.userId.userId}" style="text-decoration: none;">${att.userId.userName}</a><input type="hidden" id="attId" value = "${att.attId}"></td>
			<td>${att.attDate}</td>
			<td>${att.getformatattStart()}</td>
			<td>${att.getformatattEnd()}</td>
			<td>${att.attIsweekend}</td>
			<td>${att.attType}</td>
			<td>${att.getformatattOtStart()}</td>
			<td>${att.getformatattOtEnd()}</td>
			<td width = 7%>${att.attStatus}</td>
			<td width = 5%><button class="btn btn-primary text-xs px-1 mx-0 appbtn">승인</button></td>
			<td width = 5%><button class="btn btn-danger text-xs px-1 mx-0 rejectbtn">반려</button></td>
			</tr>
			</c:forEach>
			</tbody>
			</table>
			<c:if test="${not empty noAttList or not empty noAttPlanUser}" >
			<table class="table table-bordered text-gray-900 mb-2 border-bottom-danger">
			<tr align = center>
			<th width= 7%>성명</th>
			<th width= 12%>날짜</th>
			<th width= 12%>출근 시간</th>
			<th width= 12%>퇴근 시간</th>
			<th width= 8%>근무 구분</th>
			<th width= 8%>주말 구분</th>
			<th>근태 계획 상태</th>
			</tr>
			<c:forEach var="ap" items="${noAttList}">
			
			<tr align = center>
			<td><a href = "/att_allfind_admin/${ap.userId.userId}" style="text-decoration: none;">${ap.userId.userName}</a></td>
			<td>${ap.apDate}</td>
			<td>${ap.apStart}</td>
			<td>${ap.apEnd}</td>
			<td>${ap.apType}</td>
			<td>${ap.apIsweekend}</td>
			<td>${ap.apStatus}</td>
			</tr>
			
			</c:forEach>
			<c:forEach var="noap" items="${noAttPlanUser}">
			<tr align = center>
			<td><a href = "/att_allfind_admin/${noap.userId.userId}" style="text-decoration: none;">${noap.userId.userName}</a></td>
			<td>${noap.apDate}</td>
			<td colspan = 5 style="color:red">근태 계획 없음.</td>

			</tr>
			</c:forEach>
			</table>
			</c:if>
			
			</div>
			</div>
			</div>
			<script src="/js/att.js"></script>
</body>
</html>