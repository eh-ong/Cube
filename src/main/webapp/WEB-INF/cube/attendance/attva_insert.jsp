<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
textarea {
	resize: none;
}
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
					근태<i class="fas fa-chevron-right mx-1"></i>휴가<i
						class="fas fa-chevron-right mx-1"></i>휴가 신청
						<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">

				<table
					class="table table-bordered text-gray-900 mb-2 border-bottom-primary"
					width="100%" cellspacing="0">
					<tr align=center>
						<th>휴가 시작일</th>
						<td><input type="date" id="startDate" required
							min="<%=LocalDate.now()%>" class="form-control"></td>
						<th>휴가 종료일</th>
						<td><input type="date" id="endDate" required
							class="form-control"></td>
					</tr>
					<tr align=center>
						<th>휴가 기간</th>
						<td id="calDate" colspan=3></td>
					</tr>

					<tr>
						<td colspan=4><div class="form-group">
								<textarea class="form-control" rows="5" cols="50" id="vaDes"
									placeholder="휴가 사유 작성" required></textarea></td>
					</tr>
				</table>
				<table class="table table-bordered text-gray-900 mb-2 border-left-info"
					width="100%" cellspacing="0">
				<tr id="dateTable">
					

				</tr>
				</table>
				<div class="text-center">
					<button id="insertVa" class="btn btn-primary">
						<i class="fas fa-pen mr-1"></i>휴가 신청
					</button>
				</div>
			</div>
		</div>
	</div>
	
	<script src="/js/att.js"></script>
</body>
</html>