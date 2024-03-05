<%@ page import="java.util.List"%>
<%@ page import="com.ccnc.cube.attendance.Vacation"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-secondary">
					근태<i class="fas fa-chevron-right mx-1"></i>휴가<i
						class="fas fa-chevron-right mx-1"></i>휴가 신청 내역
						<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">

				<table
					class="table table-bordered text-gray-900 border-bottom-primary"
					width="100%" cellspacing="0">
					<thead>
						<tr align="center">
							<th width=12.5%>이름</th>
							<th width=25%>휴가 시작</th>
							<th width=25%>휴가 종료</th>
							<th width=12.5%>상세보기</th>
							<th width=15% colspan=2>상태</th>
							<th width=10%>취소</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach var="va" items="${vaList}">
							<tr align="center">
								<td>${va.userId.userName}</td>
								<td>${va.vaStartDate}</td>
								<td>${va.vaEndDate}</td>
								<td><button class="btn btn-outline-primary"
										data-bs-toggle="modal"
										data-bs-target="#exampleModal-${va.vaId}">상세보기</button></td>
								<td>${va.vaStatus}</td>
								<c:if test="${va.vaStatus eq '대기중'}">
									<td style="vertical-align: middle"><div
											style="background-color: green; border-radius: 50%; border: none; width: 20px; height: 20px;"></div></td>
								</c:if>
								<c:if test="${va.vaStatus eq '승인'}">
									<td style="vertical-align: middle"><div
											style="background-color: blue; border-radius: 50%; border: none; width: 20px; height: 20px;"></div></td>
								</c:if>
								<c:if test="${va.vaStatus eq '반려'}">
									<td style="vertical-align: middle"><div
											style="background-color: red; border-radius: 50%; border: none; width: 20px; height: 20px;"></div></td>
								</c:if>
								<td><button class="btn btn-danger vaCancle" >
										<i class="fas fa-times mr-1"> </i>취소
									</button><input type = hidden id="vaId" value="${va.vaId}"><input type = hidden id="vaStatus" value="${va.vaStatus}"></td>
							</tr>
							
							<div class="modal fade" id="exampleModal-${va.vaId}"
								tabindex="-1" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
									
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">휴가 상세보기</h5>
										</div>
										
										
										<div class="modal-body text-gray-900">${va.vaDes}</div>
										
										<div class="modal-footer">
											<button type="button" class="btn btn-primary"
												data-bs-dismiss="modal">확인</button>
										</div>
										
									</div>
								</div>
							</div>
							
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script src="/js/att.js"></script>
</body>
</html>
