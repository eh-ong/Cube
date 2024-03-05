<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
						class="fas fa-chevron-right mx-1"></i>휴가 승인
						<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<div id="calendar"></div>

				<script>
					document.addEventListener('DOMContentLoaded', function() {
						var calendarEl = document.getElementById('calendar');
						var calendar = new FullCalendar.Calendar(calendarEl, {
							locale: 'ko',
							allDayDefault: false,
							headerToolbar: {
								left: '',
								center: 'title'
							},
							height: 600,
							initialView: 'dayGridMonth',
							eventMouseEnter: function(info) {
					            info.el.style.cursor = 'pointer';
					        },
					        eventMouseLeave: function(info) {
					            info.el.style.cursor = '';
					        },
							eventClick: function(info) {
								var endDate = new Date(info.event.end);
								endDate.setDate(endDate.getDate() - 1);
								var newEndDate = endDate.toLocaleDateString();
					            Swal.fire({
					                title: info.event.title,
					                confirmButtonColor: '#007bff',
					                cancelButtonColor: 'red',
					                html: info.event.start.toLocaleDateString() + "~ "+ newEndDate+"<br>"+info.event.constraint,
					                icon: 'info',
					                
					                showCancelButton: true,
					                confirmButtonText: '승인',
					                cancelButtonText: '반려' 
					            }).then((result) => {
					            	if (result.isConfirmed) {
					    				$.ajax({
					    					type: 'PUT',
					    					url: '/approveVa?vaId=' + info.event.id,
					    					contentType: 'application/json;charset=UTF-8',
					    					data: JSON.stringify(),
					    				}).done(function(response) {
					    					Swal.fire({
					    						text: "휴가를 승인하였습니다.",
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
					    			} else if (result.dismiss === Swal.DismissReason.cancel) {
					    				$.ajax({
					    			        type: 'PUT',
					    			        url: '/rejectVa?vaId=' + info.event.id,
					    			        contentType: 'application/json;charset=UTF-8',
					    			        data: JSON.stringify(),
					    			    }).done(function(response) {
					    			        Swal.fire({
					    			            text: "휴가를 반려하였습니다.",
					    			            confirmButtonColor: '#007bff',
					    			            iconColor: 'red',
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
					        },
							events: [
								<c:forEach items="${vaEventsList}" var="event">
									{
										id: '${event.vaId.vaId}',
										title: '${event.vaId.userId.userName}',
										start: '${event.startDate}',
										end: '${event.endDate}',
										backgroundColor: '${event.bgcolor}',
										constraint: '${event.vaId.vaDes}'
									},
								</c:forEach>
							]
						});
						calendar.render();
					});
				</script>
			</div>
		</div>
	</div>
</body>
</html>