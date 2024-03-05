<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.text.DecimalFormat"%>
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
					근태<i class="fas fa-chevron-right mx-1"></i>관리자<i
						class="fas fa-chevron-right mx-1"></i>팀 근태 조회
						<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<c:forEach var="team" items="${getAllUsers}" varStatus="loop">
				<a href ="/getAttTeam/${teamList[loop.index].teamId}" style="text-decoration: none;">
					<div class="col-xl-12 col-md-6 mb-1">
						<div class="card ${attUserList[loop.index].size() * 100 == 0 ? 'border-left-light' : attUserList[loop.index].size() * 100/team.size() == 100 ? 'border-left-primary' : attUserList[loop.index].size() * 100/team.size() >= 80 ? 'border-left-success' : attUserList[loop.index].size() * 100/team.size() >= 60 ? 'border-left-warning' : 'border-left-danger'}
 shadow h-100 py-2">
							<div class="card-body">
								<div class="align-items-center">
									<div class="col mr-2">
										<div class="text-s font-weight-bold text-primary mb-2">
											${teamList[loop.index].teamName}팀</div>
										<h4 class="small font-weight-bold">
											${attUserList[loop.index].size() != 0 ? attUserList[loop.index].size() * 100 / team.size():0}%<span class="float-right">${team.size()}</span>
										</h4>
										<div class="progress">
											<div class="progress-bar ${attUserList[loop.index].size() * 100 == 0 ? 'bg-light' : attUserList[loop.index].size() * 100/team.size() == 100 ? 'bg-primary' : attUserList[loop.index].size() * 100/team.size() >= 80 ? 'bg-success' : attUserList[loop.index].size() * 100/team.size() >= 60 ? 'bg-warning' : 'bg-danger'}" role="progressbar"
												style="width: ${attUserList[loop.index].size() * 100 / team.size()}%;"
												aria-valuenow="${attUserList[loop.index].size()}"
												aria-valuemin="0" aria-valuemax="${team.size()}">${attUserList[loop.index].size()}</div>
										</div>
									</div>
								</div>
								
							</div>
						</div>
					</div>
					</a>
				</c:forEach>














			</div>
		</div>
	</div>
</body>
</html>