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
			<a class="sidebar-brand d-flex align-items-center justify-content-center mx-2" href="/index"> <img src="/image/logo_3.svg" alt="CUBE_icon"
				style="width: auto; height: 30px;">

				<div class="sidebar-brand-text mx-2">CUBE</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link" href="/mailPage">
					<i class="fas fa-fw fa-home"></i> <span>메일</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">메일 보내기</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link" href="/mail_send">
					<i class="fas fa-paper-plane mr-2"></i> <span>메일 보내기</span>
			</a></li>
			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">메일함</div>
			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item"><a class="nav-link" href="/sendmail_list">
					<i class="fas fa-envelope mr-2"></i> <span>보낸 메일함</span>
			</a></li>
			
			<li class="nav-item"><a class="nav-link" href="/receivemail_list">
					<i class="fas fa-inbox mr-2"></i> <span>받은 메일함</span>
			</a></li>
			
			<!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
                    aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="fas fa-star mr-2"></i>
                    <span>중요 메일함</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">중요 메일함</h6>
                        <a class="collapse-item" href="/importantmail_list/1">보낸 중요 메일함</a>
                        <a class="collapse-item" href="/importantmail_list/2">받은 중요 메일함</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-trash-alt mr-2"></i>
                    <span>삭제 메일함</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">삭제 메일함</h6>
                        <a class="collapse-item" href="/isdeletemail_list/1">보낸 삭제 메일함</a>
                        <a class="collapse-item" href="/isdeletemail_list/2">받은 삭제 메일함</a>
                    </div>
                </div>
            </li>





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