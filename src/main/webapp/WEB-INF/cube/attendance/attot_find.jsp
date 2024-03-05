<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.noDataMessage {
	font-size: 20px;
	margin-top: 50px;
	text-align: center;
	color: red;
	display: none;
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
						class="fas fa-chevron-right mx-1"></i>초과근무 신청 내역
						<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<div class="float-right">
					<div class=monthSelectBox>
						<select id="monthSelect"
							class="custom-select custom-select-sm form-control form-control-sm mb-3 border border-primary"
							style="width: 100px" onchange="filterByMonth()">
							<option value="all">전체</option>
							<option value="01">1월</option>
							<option value="02">2월</option>
							<option value="03">3월</option>
							<option value="04">4월</option>
							<option value="05">5월</option>
							<option value="06">6월</option>
							<option value="07">7월</option>
							<option value="08">8월</option>
							<option value="09">9월</option>
							<option value="10">10월</option>
							<option value="11">11월</option>
							<option value="12">12월</option>
						</select>
					</div>
				</div>
				<table
					class="table table-bordered text-gray-900 border-bottom-primary"
					width="100%" cellspacing="0">
					<thead>
						<tr align="center">
							<th width=12.5%>이름</th>
							<th width=12.5%>날짜</th>
							<th width=12.5%>평일 구분</th>
							<th width=12.5%>초과근무 시작</th>
							<th width=12.5%>초과근무 종료</th>
							<th width=12.5%>초과근무 시간</th>
							<th width=12.5%>초과근무 사유</th>
							<th width=12.5% colspan = 2>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="att" items="${attotList}">
							<tr align="center">
								<td>${att.userId.userName}</td>
								<td>${att.attDate}</td>
								<td>${att.attIsweekend}</td>
								<td>${att.getformatattOtStart()}</td>
								<td>${att.getformatattOtEnd()}</td>
								<td>${att.attOtTime}</td>
								<td><button class="btn btn-outline-primary"
										data-bs-toggle="modal"
										data-bs-target="#exampleModal-${att.attId}">상세보기</button></td>
								<td>${att.attStatus}</td>
								<c:if test="${att.attStatus eq '대기중'}">
										<td style="vertical-align: middle"><div style="background-color: green; border-radius: 50%; border: none; width:20px; height: 20px;"></div></td>
									</c:if>
									<c:if test="${att.attStatus eq '승인'}">
										<td style="vertical-align: middle"><div style="background-color: blue; border-radius: 50%; border: none; width:20px; height: 20px;"></div></td>
									</c:if>
									<c:if test="${att.attStatus eq '반려'}">
										<td style="vertical-align: middle"><div style="background-color: red; border-radius: 50%; border: none; width:20px; height: 20px;"></div></td>
									</c:if>
							</tr>
							<div class="modal fade" id="exampleModal-${att.attId}"
								tabindex="-1" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">초과근무 사유</h5>
										</div>
										<div class="modal-body text-gray-900">${att.attOtDes}</div>
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
				<p id="noDataMessage" class="noDataMessage">선택한 월에 대한 초과근무내역이
					없습니다.</p>
			</div>
		</div>
	</div>


	<script>
		function filterByMonth() {
			var selectedMonth = document.getElementById("monthSelect").value;
			var rows = document.querySelectorAll("tbody tr");

			var hasData = false;

			rows.forEach(function(row) {
				var date = row.children[1].innerText;
				var month = date.split("-")[1];

				if (selectedMonth === "all" || month === selectedMonth) {
					row.style.display = "";
					hasData = true;
				} else {
					row.style.display = "none";
				}
			});

			var noDataMessage = document.getElementById("noDataMessage");
			noDataMessage.style.display = hasData ? "none" : "block";
		}
	</script>
</body>
</html>