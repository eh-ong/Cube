<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			<li class="nav-item active"><a class="nav-link" href="#">
					<i class="fas fa-fw fa-home"></i> <span>프로젝트</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">프로젝트</div>
			
			<li class="nav-item"><a class="nav-link" href="/pr_new">
					<i class="far fa-clipboard"></i> <span>새 프로젝트</span>
			</a></li>
			
			<li class="nav-item"><a class="nav-link" href="/pr_inProgressList">
					<i class="fas fa-clipboard"></i> <span>진행함</span>
			</a></li>
			
			<li class="nav-item"><a class="nav-link" href="/pr_completedList">
					<i class="fas fa-check"></i> <span>완료함</span>
			</a></li>
			
			<li class="nav-item"><a class="nav-link" href="/pr_terminatedList">
					<i class="fas fa-stop"></i> <span>중단함</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->
		</div>
</body>
</html>