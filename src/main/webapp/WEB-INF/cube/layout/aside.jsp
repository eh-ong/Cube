<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.trash {
    display: none;
    opacity: 0;
    transition: opacity 0.7s ease;
}

.nav-item:hover .trash {
    display: inline-block;
    opacity: 1;
}

</style>
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
			<li class="nav-item active"><a class="nav-link" href="/index">
					<i class="fas fa-fw fa-home"></i> <span>홈</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading"><i class="fas fa-star"></i> 즐겨찾기</div>


			<c:if test = "${userBookmarkList ne null}">
			<c:forEach var="bm" items="${userBookmarkList}">
    <li class="nav-item">
        <div style="display: flex; align-items: center;">
            <a class="nav-link" href="${bm.bookmarkPath}">
                <i class="fa fa-star"></i>
                <span>${bm.bookmarkName}</span>
            </a>
            <i class="fas fa-trash-alt trash faa-vertical animated mr-3" style="color: white;"></i>
            <input type="hidden" class="" value="${bm.bookmarkId}">
        </div>
    </li>
</c:forEach>
			</c:if>



			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->
		</div>
<script>
$(document).ready(function() {
    $('.trash').on('click', function() {
        var bookmarkId = $(this).siblings('input[type="hidden"]').val();
        
        Swal.fire({
            title: "북마크 삭제",
            text: "이 북마크를 삭제하시겠습니까?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: '#007bff',
            cancelButtonColor: "#d33",
            confirmButtonText: "확인",
            cancelButtonText: "취소"
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'DELETE',
                    url: '/deleteBookmark/' + bookmarkId,
                    contentType: 'application/json;charset=UTF-8',
                    data: JSON.stringify(),
                }).done(function(response) {
                    Swal.fire({
                        text: "북마크를 삭제하였습니다.",
                        confirmButtonColor: '#007bff',
                        iconColor: '#007bff',
                        icon: "success"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            location.reload();
                        }
                    });
                }).fail(function(error) {
                    console.log(error);
                    alert('에러');
                });
            }
        });
    });
});
</script>
</body>
</html>