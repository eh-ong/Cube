<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<style>    
    /* 테이블 셀의 패딩을 조정합니다. */
    .table-bordered td, .table-bordered th {
        text-align: center; /* 텍스트를 수평 중앙 정렬합니다. */
        vertical-align: middle; /* 텍스트를 수직 중앙 정렬합니다. */
    }
</style>
<head>
  <meta charset="utf-8">
  <title>CUBE : HR</title>
</head>
<body id="page-top">
<header class="index_header">
	<jsp:include page="../layout/header.jsp" />
</header>
<div class="container-fluid">
<div class="card shadow mb-4">
<div class="card-header py-3">
	<a class="m-0 text-secondary" href="/hrPage">HR</a>
	<i class="fas fa-chevron-right mx-1"></i>
	<a  class="m-0 text-secondary" href="/hr_employeePage">임직원 조회</a>
	<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
</div>
<div class="card-body">
<div class="table-responsive">
<div class="justify-content-end">

  <h2 class="h4 text-gray-900 font-weight-bold">임직원 조회</h2>
  <table class="float-right"">
  	<tr>
  	  <td>
  	    <select class="custom-select custom-select-sm form-control form-control-sm mb-3 mr-1" style="height: 36px; width: 90px;" name="searchType" id="searchType">
  	      <option value="userName">이름</option>
  	      <option value="userTeamId">팀</option>
  	    </select>
  	  </td>
  	  <td>
  	  	<div class="input-group mb-3">  	  
  	  		<input type="text" class="form-control bg-light border-1" style="width: 300px"
				placeholder="검색" aria-label="Search" aria-describedby="basic-addon2" id="searchInput">
			<div class="input-group-append" id="btn-search">
				<button class="btn btn-primary" type="button">
					<i class="fas fa-search fa-sm"></i>
				</button>
			</div>
		</div>
	  </td>
  	</tr>
  </table>
  <script src="/js/hr.js"></script>
</div>

  <table class="table table-bordered text-gray-900" style="width: 100%; cellspacing: 0">
    <thead>
      <tr>
        <th>사번</th>
        <th>이름</th>
        <th>팀</th>
        <th>직책</th>
        <th>휴대전화 번호</th>
        <th>메일</th>
        <th>입사일</th>
        <th>상태</th>
        <th>정보 수정</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${userList}">
        <input type="hidden" id="userId" value="${user.userId}">
        <tr>
           <td>${user.userNum}</td>
           <td>${user.userName}</td>
           <td>${user.userTeamId.teamName}</td>
           <td>${user.userPosition}</td>
           <td>${user.userMobile}</td>
           <td>${user.userEmail}</td>
           <td>${user.userHireDate}</td>
           <td>${user.userStatus}</td>
           <td><a class="btn btn-primary" href='<c:url value="/hr_updateEmployee/${user.userId }"><c:param name="page" value="${currentPage }"/></c:url>'>수정하기</a></td>
        </tr>
    </c:forEach>
</tbody>
</table>
<!-- 페이징 -->
<nav aria-label="Page navigation example">
    <ul class="pagination justify-content-center"> <!--가운데 -->
        <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
            <a class="page-link"
               href='<c:url value="/hr_employeePage"><c:param name="page" value="${currentPage - 1}"/></c:url>'>&laquo;</a>
        </li>
        <c:forEach var="pageNumber" begin="1" end="${totalPages}">
            <li class="page-item <c:if test='${pageNumber == currentPage}'>active</c:if>'">
                <a class="page-link"
                   href='<c:url value="/hr_employeePage"><c:param name="page" value="${pageNumber}"/></c:url>'>${pageNumber}</a>
            </li>
        </c:forEach>
        <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>'">
            <a class="page-link"
               href='<c:url value="/hr_employeePage"><c:param name="page" value="${currentPage + 1}"/></c:url>'>&raquo;</a>
        </li>
    </ul>
</nav>
</div>
</div>
</div>
</div>
 
  	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>
  
</body>
</html>
