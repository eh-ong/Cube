<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ccnc.cube.common.CommonEnum.UserRole" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>

<body>

	<div id="wrapper">
		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center mx-2"
				href="/index"> <img src="/image/logo_3.svg" alt="CUBE_icon"
				style="width: auto; height: 30px;">

				<div class="sidebar-brand-text mx-2">CUBE</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link" href="/att_FindPage">
					<i class="fas fa-fw fa-home"></i> <span>근태</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">근태</div>
			
			<li class="nav-item"><a class="nav-link" href="/att_FindPage">
					<i class="fas fa-calendar-alt mr-2"></i> <span>근태 조회</span>
			</a></li>
			
			<li class="nav-item"><a class="nav-link" href="/attplan_InsertPage">
					<i class="fas fa-calendar-check mr-2"></i> <span>근태 계획 등록</span>
			</a></li>
			<!-- Divider -->
			<hr class="sidebar-divider">
			<!-- Heading -->
			<div class="sidebar-heading">초과근무</div>
			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseTwo"
				aria-expanded="true" aria-controls="collapseTwo"> <i class="fas fa-stopwatch mr-2"></i><span>초과근무</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">초과근무</h6>
						<a class="collapse-item" href="/att_Ot_InsertPage">초과근무 신청</a> <a
							class="collapse-item" href="/att_Ot_FindPage">초과근무 신청 내역</a>
					</div>
				</div></li>
				
			<!-- Divider -->
			<hr class="sidebar-divider">
			<!-- Heading -->
			<div class="sidebar-heading">휴가</div>
			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseUtilities"
				aria-expanded="true" aria-controls="collapseUtilities"> <i class="fas fa-stamp mr-2"></i> <span>휴가</span>
			</a>
				<div id="collapseUtilities" class="collapse"
					aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">휴가 신청</h6>
						<a class="collapse-item" href="/att_Va_InsertPage">휴가 신청</a> <a
							class="collapse-item" href="/att_Va_FindPage">휴가 신청 내역</a>
					</div>
				</div></li>

			<!-- Divider -->
			<hr class="sidebar-divider">
			<!-- Heading -->
			<div class="sidebar-heading">통계</div>
			
						<li class="nav-item"><a class="nav-link" href="/att_StatisticsPage">
					<i class="fas fa-chart-pie mr-2"></i> <span>근태 통계</span>
			</a></li>
			
			<c:if test="${login_user.userTeamId.teamName == '인사'}">
			<!-- Divider 관리자페이지-->
			<hr class="sidebar-divider">
			<!-- Heading -->
			<div class="sidebar-heading">관리자</div>
			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseadmin"
				aria-expanded="true" aria-controls="collapseadmin"> <i class="fas fa-user-cog"></i> <span>관리자</span>
			</a>
				<div id="collapseadmin" class="collapse"
					aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">관리자</h6>
						<a class="collapse-item" href="/att_find_admin">근태 승인</a>
						<a class="collapse-item" href="/att_app_admin">근태 계획 승인</a>
						<a class="collapse-item" href="/att_va_admin">휴가 승인</a>
					</div>
				</div></li>
				</c:if>
			<!-- Divider -->
			<hr class="sidebar-divider">
			<!--<a class="collapse-item" href="/attDB">근태 데이터베이스</a>  -->
			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->
		</div>
</body>
</html>