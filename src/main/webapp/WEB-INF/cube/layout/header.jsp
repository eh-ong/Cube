<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.user-image{
	width: 250px;
	height: 300px;
}
.user-email-ex, .user-email {
        color: blue;
        cursor: pointer;
    }

.nav-link:hover{

} 

</style>
</head>
<body>

	<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

		<div class="navbar-nav">
			<a class="nav-link mx-3 text-gray-900 font-weight-bold" href="/att_FindPage">근태</a> <a
				class="nav-link mx-3 text-gray-900 font-weight-bold" href="/mailPage">메일</a> <a
				class="nav-link mx-3 text-gray-900 font-weight-bold" href="/listNotice">게시판</a> <a
				class="nav-link mx-3 text-gray-900 font-weight-bold" href="/myRevpage">예약시스템</a>
				<a class="nav-link mx-3 text-gray-900 font-weight-bold" href="/pr_inProgressList">프로젝트</a>
			<c:if test="${sessionScope.login_user.userTeamId.teamId eq 1}">
				<a class="nav-link mx-3 mr-5 text-gray-900 font-weight-bold" href="/hr_employeePage">HR</a>
			</c:if>
		</div>

		<ul class="navbar-nav ml-auto">

			<li class="nav-item no-arrow"><a class="nav-link"
				id="openModalBtn" href="#"><span class="text-gray-600">조직도</span></a></li>

			<div class="topbar-divider d-none d-sm-block"></div>

			<!-- Nav Item - User Information -->
			<li class="nav-item no-arrow"><a class="nav-link"
				href="/my_profileCheckPw"><span
					class="mr-2 d-none d-lg-inline text-gray-900 lg"><i
						class="fas fa-user fa-lg mr-1"></i>${login_user.userName}</span> </a></li>
		</ul>

		<div class="navbar-nav">
			<a href="/logout" class="ml-3 d-none d-lg-inline small"><i
				class="fas fa-sign-out-alt"></i>로그아웃</a>
		</div>
	</nav>
	<div class="modal fade" id="orgModal">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div id="orgModalContent"></div>
			</div>
		</div>
	</div>
	<script>
	
	
		$(document).ready(function() {
			var currentUrl = window.location.href;
			let bookmarkPath = currentUrl;
			$('#star').click(function() {
				var isBookmarked = false;

				$.ajax({
					type: 'GET',
					url: '/bookmarkList?bookmarkPath=' + bookmarkPath,
					contentType: 'application/json;charset=UTF-8',
				}).done(function(response) {
					if (response.status === 200) {
						Swal.fire({
				            title: '북마크 등록',
				            input: 'text',
				            inputPlaceholder: '북마크 이름 설정',
				            showCancelButton: false,
				            confirmButtonText: '확인',
				            confirmButtonColor: '#007bff',
				            preConfirm: (inputValue) => {
				                if (!inputValue) {
				                    Swal.showValidationMessage('텍스트를 입력해주세요!');
				                }
				                return inputValue;
				            }
				        	}).then((result) => {
				            if (result.isConfirmed) {
				               	bookmarkName = result.value;
				               	let bookmark = {
										bookmarkName: bookmarkName,
										bookmarkPath: currentUrl,
									}
								$.ajax({
									type: 'POST',
									url: '/bookmark',
									contentType: 'application/json;charset=UTF-8',
									data: JSON.stringify(bookmark),
								}).done(function(response) {
									Swal.fire({
										icon: "success",
										iconColor: '#007bff',
										confirmButtonColor: '#007bff',
										text: '즐겨찾기 등록 완료.',
										showCloseButton: true
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
					} else {
						Swal.fire({
							icon: "error",
							iconColor: 'orange',
							confirmButtonColor: '#007bff',
							text: '이미 즐겨찾기에 등록되어 있습니다.',
							showCloseButton: true
						}).then((result) => {
							if (result.isConfirmed) {
								location.reload();
							}
						});
					}
				}).fail(function(error) {
					console.log(error);
					alert('에러');
				});
				
			    
			    
			
			});

			
					$("#openModalBtn").click(function() {
						loadModalContent();
					});

					function loadModalContent() {
						$.get("/orgPage", function(data) {
							$("#orgModal #orgModalContent").html(data);
							$("#orgModal").modal("show");

							$("#orgModalContent").on(
									"click",
									"a",
									function(event) {
										event.preventDefault();

										var linkUrl = $(this).attr("href");

										$("#userImage").html("");
										$("#userDetails").html("");
										$.get(linkUrl, function(data) {

										    var htmlContent = "<table class='table text-gray-900'>";

										    if (data.length === 0) {
										        htmlContent += "<tr><td colspan='2'>팀 구성원 없음</td></tr>";
										    } else {
										        data.forEach(function(member) {
										            htmlContent += "<tr>";
										            htmlContent += "<td><a href='#' class='member-link' data-user-id='" + member.userId + "'>" + member.userName + "</a></td>";
										            htmlContent += "<td>" + member.userPosition + "</td>";
										            htmlContent += "</tr>";
										        });
										    }

										    htmlContent += "</table>";

										    $("#teamMembersList").html(htmlContent);
										    
										    $(".member-link").click(function(event) {
										        event.preventDefault();

										        var userId = $(this).data("user-id");

										        $.get("/userInfo/" + userId, function(userData) {
										            var userImage = $("<img src='" + userData.userFilePath + "' alt='사진 미등록' class='user-image'>");
										            $("#userImage").html(userImage);
										            var userDetailsHtml = "<table class='table text-gray-900'>";
										            userDetailsHtml += "<tr><td>성명</td><td>" + userData.userName + "</td></tr>";
										            userDetailsHtml += "<tr><td>사번</td><td>" + userData.userNum + "</td></tr>";
										            userDetailsHtml += "<tr><td>핸드폰 번호</td><td>" + userData.userMobile + "</td></tr>";
										            userDetailsHtml += "<tr><td>이메일</td><td><span class='user-email'>" + userData.userEmail + "</span></td></tr>";
										            userDetailsHtml += "<tr><td>사외 이메일</td><td><span class='user-email-ex'>" + userData.userEmailEx + "</span></td></tr>";
										            userDetailsHtml += "<tr><td>직책</td><td>" + userData.userPosition + "</td></tr>";
										            userDetailsHtml += "<tr><td>입사일</td><td>" + userData.userHireDate + "</td></tr>";
										            userDetailsHtml += "</table>";
										            $("#userDetails").html(userDetailsHtml);
										            
										            $(".user-email-ex").click(function() {
										                var emailEx = $(this).text();
										                window.location.href = "mailto:" + emailEx;
										            });
										            $(".user-email").click(function() {
										                var email = $(this).text();
										                location= "/mail_send/"+ email;
										            });
										        });
										    });
										});
									});
						});
					}
					$("#orgModal").on("click", function(event) {
						event.stopPropagation();
					});
				});
	</script>
</body>
</html>