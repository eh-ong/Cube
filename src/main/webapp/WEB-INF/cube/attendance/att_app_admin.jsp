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
.hovertd {
	background-color: white;
	transition: background-color 0.3s;
}

.hovertd:hover {
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
					관리자<i class="fas fa-chevron-right mx-1"></i>근태계획 승인
					<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<div class="justify-content-end">
					<table class="float-left ml-1">
						<tr>
							<td>비활성</td>
							<td><div class="mr-3"
									style="background-color: grey; border-radius: 50%; border: none; width: 10px; height: 10px;"></div></td>
							<td>미등록</td>
							<td><div class="mr-3"
									style="background-color: red; border-radius: 50%; border: none; width: 10px; height: 10px;"></div></td>
							<td>대기중</td>
							<td><div class="mr-3"
									style="background-color: green; border-radius: 50%; border: none; width: 10px; height: 10px;"></div></td>
							<td>확인</td>
							<td><div class="mr-3"
									style="background-color: blue; border-radius: 50%; border: none; width: 10px; height: 10px;"></div></td>
							<td>부분확인</td>
							<td><div
									style="background-color: turquoise; border-radius: 50%; border: none; width: 10px; height: 10px;"></div></td>
						</tr>
					</table>
					<table class="float-right">
						<tr>
							<td><select
								class="custom-select custom-select-sm form-control form-control-sm mb-3 mr-1"
								style="height: 36px; width: 90px;" name="searchType"
								id="searchType">
									<option value="userName">이름</option>
									<option value="userTeamId">팀</option>
							</select></td>
							<td>
								<div class="input-group mb-3">
									<input type="text" class="form-control bg-light border-1"
										style="width: 300px" placeholder="검색" aria-label="Search"
										aria-describedby="basic-addon2" id="searchInput">
									<div class="input-group-append" id="btn-search">
										<button class="btn btn-primary" type="button">
											<i class="fas fa-search fa-sm"></i>
										</button>
									</div>
								</div>
							</td>
						</tr>
					</table>

				</div>

				<table
					class="table table-bordered text-gray-900 border-bottom-primary"
					style="width: 100%; cellspacing: 0">
					<thead>
						<tr align=center>
							<th width=10%>사번</th>
							<th width=8%>이름</th>
							<th width=6%>팀</th>
							<th width=6%>직책</th>
							<th width=10%>상태</th>
							<td>1</td>
							<td>2</td>
							<td>3</td>
							<td>4</td>
							<td>5</td>
							<td>6</td>
							<td>7</td>
							<td>8</td>
							<td>9</td>
							<td>10</td>
							<td>11</td>
							<td>12</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${userList}" varStatus="loop">
							<input type="hidden" id="userId" value="${user.userId}">
							<tr align=center>
								<td>${user.userNum}</td>
								<td>${user.userName}</td>
								<td>${user.userTeamId.teamName}</td>
								<td>${user.userPosition}</td>
								<td>${user.userStatus}</td>

								<c:forEach var="color" items="${apList[loop.index]}"
									varStatus="loop2">
									<c:choose>
										<c:when test="${color eq 'grey'}">
											<td><div
													style="background-color: ${color eq 'grey' ? 'grey' : (color eq 'green' ? 'green' : (color eq 'blue' ? 'blue' :(color eq 'teal' ? 'turquoise' : 'red')))}; border-radius: 50%; border: none; width:20px; height: 20px;"></div>
											</td>
										</c:when>
										<c:otherwise>
											<td class="hovertd"><a
												href="/att_appuser_admin/${user.userId}/${loop2.index+1}"><div
														style="background-color: ${color eq 'grey' ? 'grey' : (color eq 'green' ? 'green' : (color eq 'blue' ? 'blue' :(color eq 'teal' ? 'turquoise' : 'red')))}; border-radius: 50%; border: none; width:20px; height: 20px;"></div>
											</a></td>
										</c:otherwise>
									</c:choose>
								</c:forEach>

							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script>
	$("#btn-search").on("click", ()=>{
		let searchType = $("#searchType").val()
		let searchInput = $("#searchInput").val()
		$.ajax({
			type: "GET",
			url: "/userSearch/" + searchType + "/" + searchInput,
		}).done(function(response){
			console.log(response);
			location = "/userSearch/" + searchType + "/" + searchInput;
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	});
	</script>
</body>
</html>

