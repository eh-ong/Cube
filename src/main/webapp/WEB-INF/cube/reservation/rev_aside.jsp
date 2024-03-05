<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ccnc.cube.common.CommonEnum.UserRole"%>
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
			<a class="sidebar-brand d-flex align-items-center justify-content-center mx-2" href="/index"> <img src="/image/logo_3.svg" alt="CUBE_icon"
				style="width: auto; height: 30px;">

				<div class="sidebar-brand-text mx-2">CUBE</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link" href="/myRevpage">
					<i class="fas fa-fw fa-home"></i> <span>예약페이지</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">예약</div>

			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseMeetings"
				aria-expanded="true" aria-controls="collapseMeetings"> <i
					class="fas fa-handshake mr-2"></i><span>회의실</span>
			</a>
				<div id="collapseMeetings" class="collapse"
					aria-labelledby="headingMeetings" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="/getrevlist">회의실 예약 목록</a> <a
							class="collapse-item" href="/insertRev">회의실 예약</a>
					</div>
				</div></li>

			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseCars"
				aria-expanded="true" aria-controls="collapseCars"> <i
					class="fas fa-car mr-2"></i><span>차량</span>
			</a>
				<div id="collapseCars" class="collapse"
					aria-labelledby="headingCars" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="/getcarlist">차량 예약 목록</a> <a
							class="collapse-item" href="/insertCar">차량 예약</a>
					</div>
				</div></li>


			<!-- Divider -->
			<hr class="sidebar-divider">
			<!-- Heading -->
			<div class="sidebar-heading">나의 예약</div>
			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseTwo"
				aria-expanded="true" aria-controls="collapseTwo"> <i class="fas fa-user-edit mr-2"></i><span>나의 예약내역</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">나의 예약내역</h6>
						<a class="collapse-item" href="/meetinglist">회의실 내역</a> <a
							class="collapse-item" href="/carlist">차량 내역</a>
					</div>
				</div></li>
						
			<c:if test="${login_user.userTeamId.teamName == '총무'}">
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
							<a class="collapse-item" href=/meetRegister>회의실 등록</a>	
							<a class="collapse-item" href=/carRegister>신규차량 등록</a>				
					</div>
				</div></li>
				</c:if>



			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->
		</div>
</body>
</html>