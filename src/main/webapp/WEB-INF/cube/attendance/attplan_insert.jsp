<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    $(document).ready(function () {
        
        $('select#attApType').change(function () {
            updateTimings();
        });
        
        $('td.attApStatus').each(function () {
            var apStatus = $(this).text().trim();
            var apTypeSelect = $(this).closest('tr').find('select#attApType');
            if (apStatus === '승인') {
                apTypeSelect.prop('disabled', true);
            } else {
                apTypeSelect.prop('disabled', false);
            }
        });
        
        if (${login_user.userRemainVacation} <= 0) {
            $('select#attApType option[value="연차"]').prop('disabled', true);
            $('select#attApType option[value="오전반차"]').prop('disabled', true);
            $('select#attApType option[value="오후반차"]').prop('disabled', true);
        }
        
        function updateTimings() {
            $('select#attApType').each(function () {
                var apType = $(this).val();
                var startTime = $(this).closest('tr').find('td.attStartTime');
                var endTime = $(this).closest('tr').find('td.attEndTime');
                if (apType === '공가') {
                    startTime.text('-');
                    endTime.text('-');
                } else if (apType === '오전반차') {
                    startTime.text('14:00');
                    endTime.text('18:00');
                } else if (apType === '오후반차') {
                    startTime.text('09:00');
                    endTime.text('13:00');
                } else if (apType === '연차') {
                    startTime.text('-');
                    endTime.text('-');
                } else if (apType === '정상근무') {
                    startTime.text('09:00');
                    endTime.text('18:00');
                }
            });
        }
      
        updateTimings();
    });
</script>
</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-secondary">
					근태<i class="fas fa-chevron-right mx-1"></i>근태계획 등록
					<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">
				<table
					class="table table-bordered text-gray-900 mb-2 border-bottom-primary"
					width="100%" cellspacing="0">
					<tr align=center>
						<th width=12.5%>사용자</th>
						<td width=12.5%>${login_user.userName}</td>
						<th width=12.5%>현재 날짜</th>
						<td width=12.5%><%=LocalDate.now()%></td>
						<th width=12.5%>전체 연차</th>
						<td width=12.5%>${login_user.userVacationDay}</td>
						<th width=12.5%>사용한 연차</th>
						<td width=12.5%>${vacationArr[0]}</td>
					</tr>
					<tr align=center>

						<th>사용가능 연차</th>
						<td colspan=3>${login_user.userRemainVacation}</td>
						<th>승인</th>
						<td>${vacationArr[1]}</td>
						<th>대기중</th>
						<td>${vacationArr[2]}</td>
					</tr>
				</table>
				<table
					class="table table-bordered text-gray-900 border-bottom-primary"
					width="100%" cellspacing="0">
					<thead>
						<tr align="center">
							<th width=20%;>날짜</th>
							<th width=15%;>출근 시간</th>
							<th width=15%;>퇴근 시간</th>
							<th width=15%;>요일 구분</th>
							<th width=15%;>근무 구분</th>
							<th width=20%; colspan="2">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="attendanceplan" items="${attplanList}">
							<tr id="attTr" align="center">
								<td>${attendanceplan.apDate}</td>
								<td class="attStartTime">${attendanceplan.apStart}</td>
								<td class="attEndTime">${attendanceplan.apEnd}</td>
								<td>${attendanceplan.apIsweekend}</td>
								<td><select id="attApType" name="apType"
									class="custom-select custom-select-sm form-control form-control-sm border border-primary">
										<option value="연차"
											${attendanceplan.apType eq '연차' ? 'selected' : ''}>연차</option>
										<option value="공가"
											${attendanceplan.apType eq '공가' ? 'selected' : ''}>공가</option>
										<option value="오후반차"
											${attendanceplan.apType eq '오후반차' ? 'selected' : ''}>오후반차</option>
										<option value="오전반차"
											${attendanceplan.apType eq '오전반차' ? 'selected' : ''}>오전반차</option>
										<option value="정상근무"
											${attendanceplan.apType eq '정상근무' ? 'selected' : ''}>정상근무</option>
								</select></td>
								<td class="attApStatus">${attendanceplan.apStatus}<input
									type="hidden" id="apId" value="${attendanceplan.apId}" /></td>
									<c:if test="${attendanceplan.apStatus eq '대기중'}">
										<td style="vertical-align: middle"><div style="background-color: green; border-radius: 50%; border: none; width:20px; height: 20px;"></div></td>
									</c:if>
									<c:if test="${attendanceplan.apStatus eq '미등록'}">
										<td style="vertical-align: middle"><div style="background-color: orange; border-radius: 50%; border: none; width:20px; height: 20px;"></div></td>
									</c:if>
									<c:if test="${attendanceplan.apStatus eq '승인'}">
										<td style="vertical-align: middle"><div style="background-color: blue; border-radius: 50%; border: none; width:20px; height: 20px;"></div></td>
									</c:if>
									<c:if test="${attendanceplan.apStatus eq '반려'}">
										<td style="vertical-align: middle"><div style="background-color: red; border-radius: 50%; border: none; width:20px; height: 20px;"></div></td>
									</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class = "text-center">
				<button id="save" class = "btn btn-primary"><i class="fas fa-pen mr-1"></i>등록하기</button>
				</div>
			</div>
		</div>
	</div>
	<script src="/js/att.js"></script>
</body>
</html>
