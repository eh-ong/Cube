<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
					근태<i class="fas fa-chevron-right mx-1"></i>통계
					<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
				</h6>
			</div>
			<div class="card-body">

				<div class="row">
					<!-- 여기부터 -->
					<div class="col-xl-6 col-md-6 mb-4">
						<div class="card border-left-primary shadow h-100 py-2">
							<div class="card-body">
								<div class="row no-gutters align-items-center">
									<div class="col mr-2">
										<div class="text-s font-weight-bold text-primary mb-1">
											이번 달 출근</div>
										<h4 class="small font-weight-bold">
											${String.format("%.0f", (attList.size()/workDay)*100)}% <span
												class="float-right">${workDay}일</span>
										</h4>
										<div class="progress">
											<div class="progress-bar bg-primary" role="progressbar"
												style="width: ${attList.size()*100/workDay}%"
												aria-valuenow="${workDay}" aria-valuemin="0"
												aria-valuemax="${workDay}">${attList.size()}일</div>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>

					<!--여기부터 -->
					<div class="col-xl-6 col-md-6 mb-4">
						<div class="card border-left-success shadow h-100 py-2">
							<div class="card-body">
								<div class="row no-gutters align-items-center">
									<div class="col mr-2">
										<div class="text-s font-weight-bold text-primary mb-1">
											이번 주 초과근무</div>
										<h4 class="small font-weight-bold">
											${String.format("%.1f", ((otHour*60)+otMinute)*100/720)}%<span
												class="float-right">12시간</span>
										</h4>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar"
												style="width: ${((otHour*60)+otMinute)*100/720}%"
												aria-valuenow="${((otHour*60)+otMinute)}%" aria-valuemin="0"
												aria-valuemax="720">${otHour}시간${otMinute}분</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xl-12 col-md-12 mb-4">
						<div class="card border-left-warning shadow h-100 py-2">
							<div class="card-body">
							<div class="row no-gutters align-items-center">
								<div class="col mr-2">
									<div class="text-s font-weight-bold text-primary mb-1">
										이번 달 휴가신청</div>
									<h4 class="small font-weight-bold">
										<table
											class="table table-bordered text-gray-900 py-0 my-0"
											width="100%" cellspacing="0">
											<thead>
												<tr align="center">
													<th width=25%>휴가 시작</th>
													<th width=25%>휴가 종료</th>
													<th width=20%>상세보기</th>
													<th width=15%>상태</th>
													<th width=15%>취소</th>

												</tr>
											</thead>
											<tbody>
												<c:forEach var="va" items="${vaList}">
													<tr align="center">
														<td style="vertical-align: middle">${va.vaStartDate}</td>
														<td style="vertical-align: middle">${va.vaEndDate}</td>
														<td style="vertical-align: middle"><button class="btn btn-outline-primary text-xs py-1 px-2"
																data-bs-toggle="modal"
																data-bs-target="#exampleModal-${va.vaId}">상세</button></td>
														<c:if test="${va.vaStatus eq '대기중'}">
															<td style="vertical-align: middle"><div
																	style="background-color: green; border-radius: 50%; border: none; width: 15px; height: 15px;"></div></td>
														</c:if>
														<c:if test="${va.vaStatus eq '승인'}">
															<td style="vertical-align: middle"><div
																	style="background-color: blue; border-radius: 50%; border: none; width: 15px; height: 15px;"></div></td>
														</c:if>
														<c:if test="${va.vaStatus eq '반려'}">
															<td style="vertical-align: middle"><div
																	style="background-color: red; border-radius: 50%; border: none; width: 15px; height: 15px;"></div></td>
														</c:if>
														<td><button class="btn btn-danger vaCancle py-0 px-1">
																<i class="fas fa-times fa-xs"> </i>
															</button>
															<input type=hidden id="vaId" value="${va.vaId}"><input
															type=hidden id="vaStatus" value="${va.vaStatus}"></td>
													</tr>
													<div class="modal fade" id="exampleModal-${va.vaId}"
														tabindex="-1" aria-labelledby="exampleModalLabel"
														aria-hidden="true">
														<div class="modal-dialog">
															<div class="modal-content">
																<div class="modal-header">
																	<h5 class="modal-title" id="exampleModalLabel">휴가
																		상세보기</h5>

																</div>
																<div class="modal-body text-gray-900">${va.vaDes}</div>
																<div class="modal-footer">
																	<button type="button" class="btn btn-primary"
																		data-bs-dismiss="modal">확인</button>
																</div>
															</div>
														</div>
													</div>
												</c:forEach>
											</tbody>
										</table>
										</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="row">
					<div class="col-xl-12 col-md-12 mb-4">
						<div class="card border-left-info shadow h-100 py-2">
							<div class="card-body">
								<div class="row no-gutters align-items-center">
									<div class="col mr-2">
										<div class="text-s font-weight-bold text-primary">이번 주
											근무</div>
										<c:forEach var="att" items="${attTimeList}" varStatus="loop">
											<h4 class="small font-weight-bold">
												${att.keySet().toArray()[0]}</h4>

											<div class="progress mb-3">
												<div class="progress-bar bg-primary" role="progressbar"
													style="width: ${att.values().toArray()[0]*100/720}%;"
													aria-valuenow="${att.values().toArray()[0]}"
													aria-valuemin="0" aria-valuemax="720"></div>
												<div class="progress-bar bg-success" role="progressbar"
													style="width: ${totalOtList[loop.index]*100/720}%;"
													aria-valuenow="${totalOtList[loop.index]}"
													aria-valuemin="0" aria-valuemax="720"></div>
											</div>
										</c:forEach>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>




			</div>
		</div>
		<script src="/js/att.js"></script>
</body>
</html>