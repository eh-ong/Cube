<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<style>
.column {
	min-height: 400px;
	max-height: 400px;
	overflow-y: auto;
	scrollbar-width: none;
	max-height: 400px;
}
.column::-webkit-scrollbar {
	display: none;
}
</style>
</head>
<body>
	<div class="container-fluid">
				<div class="row mt-3">
					<div class="col-md-2">
						<div class="column text-center">
							<h2>
							</h2>
							<table class="table mt-3">
								<c:forEach var="team" items="${getAllUsers}" varStatus="loop">
									<tr align="center">
										<th><a href="/orgUsers/${teamList[loop.index].teamId}">
												${teamList[loop.index].teamName}팀</a></th>
										
									</tr>
								</c:forEach>
							</table>

						</div>
					</div>
					<div class="col-md-2">
						<div class="column text-center">
								<div class = "mt-3" id="teamMembersList"></div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="fixed-column text-center">
							<div class = "mt-3" id="userImage"></div>
						</div>
					</div>
					<div class="col-md-5">
						<div class="fixed-column text-center">
							<div class = "mt-3" id="userDetails"></div>
						</div>
					</div>
				</div>
			</div>

</body>
</html>
