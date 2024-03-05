<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="java.time.format.DateTimeFormatter"%>
<style type="text/css">
textarea{
	resize: none;
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
					근태<i class="fas fa-chevron-right mx-1"></i>초과근무<i
						class="fas fa-chevron-right mx-1"></i>초과근무 신청
						<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<table
					class="table table-bordered text-gray-900 mb-2 border-bottom-primary"
					width="100%" cellspacing="0">
					<tr align = "center">
						<th width=150>성명</th>
						<td width=200>${att.userId.userName}</td>

						<th width=150>날짜</th>
						<td width=200>${att.attDate}</td>

						<th width=150>평일 구분</th>
						<td width=200>${att.attIsweekend}</td>
					</tr>
					<tr align = "center">
						<th width=150>초과근무 시작시간</th>
						<td width=200>${att.attOtStart.format(DateTimeFormatter.ofPattern("HH시 mm분 ss초"))}</td>

						<th width=150>초과근무 종료시간</th>
						<td width=200>${att.attOtEnd.format(DateTimeFormatter.ofPattern("HH시 mm분 ss초"))}</td>

						<th width=150>초과근무 시간</th>
						<td width=200>${time}</td>
					</tr>
					<tr align = "center">
						<td colspan=6>
							<div class="form-group">
								<textarea class="form-control" rows="5" id="otDes"
									placeholder="초과근무 사유 작성" required>${att.attOtDes}</textarea>
							</div> <input type=hidden id=otstart value="${att.attOtStart}" /> <input
							type=hidden id=otend value="${att.attOtEnd}" />
						</td>
					</tr>
				</table>
				<div class = "text-right">
				<button id="ot_insert" class = "btn btn-primary">초과근무 시작</button>
				<button id="ot_end" class = "btn btn-primary">초과근무 종료</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			var otStart = "${att.attOtStart}";
			var otEnd = "${att.attOtEnd}";

			if (!otStart && !otEnd) {
				$("#ot_insert").prop("disabled", false);
				$("#ot_end").prop("disabled", true);
			} else if (otStart && !otEnd) {
				$("#ot_insert").prop("disabled", true);
				$("#ot_end").prop("disabled", false);
			} else {
				$("#ot_insert, #ot_end").prop("disabled", true);
			}
		});
	</script>
	<script src="/js/att.js"></script>
</body>


</html>
