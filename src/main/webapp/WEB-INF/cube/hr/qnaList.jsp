<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%
java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
String currentDateTime = java.time.LocalDateTime.now().format(formatter);
%>

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
	<a  class="m-0 text-secondary" href="/hr_qnaList">문의함</a>
	<i class="fas fa-star float-right" style="color: #FFD43B; cursor: pointer;" id="star"></i>
</div>
<div class="card-body">
<div class="table-responsive">
<div class="justify-content-end">

  <h2 class="h4 text-gray-900 font-weight-bold">문의함</h2>
  <!-- <table class="float-right"">
  	<tr>
  	  <td>
  	    <select class="custom-select custom-select-sm form-control form-control-sm mb-3 mr-1" style="height: 36px; width: 90px;" name="searchType" id="searchType">
  	      <option value="qnaTitle">제목</option>
  	      <option value="qnaContent">내용</option>
  	      <option value="qnaEmail">이메일</option>
  	      <option value="qnaCreated">수신일</option>
  	      <option value="qnaReplyed">회신일</option>
  	      <option value="qnaStatus">상태</option>
  	    </select>
  	  </td>
  	  <td>
  	  	<div class="input-group mb-3">  	  
  	  		<input type="text" class="form-control bg-light border-1" style="width: 300px"
				placeholder="검색" aria-label="Search" aria-describedby="basic-addon2" id="searchInput">
			<div class="input-group-append" id="btn-qnaSearch">
				<button class="btn btn-primary" type="button">
					<i class="fas fa-search fa-sm"></i>
				</button>
			</div>
		</div>
	  </td>
  	</tr>
  </table>
  <script src="/js/hr.js"></script> -->
</div>
<br>
  <table class="table table-bordered text-gray-900" style="width: 100%; cellspacing: 0">
    <thead>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>수신일</th>
        <th>회신일</th>
        <th>담당자</th>
        <th>상태</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach var="qna" items="${qnaList}">
        <input type="hidden" id="qnaId" value="${qna.qnaId}">
        <tr>
           <td>${qna.qnaId}</td>
           <td style="width: 30%;"><a href="/hr_qnaPage/${qna.qnaId}">${qna.qnaTitle}</a></td>
           <td>${qna.qnaCreated.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))}</td>
           <td>${qna.qnaReplyed.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))}</td>        
           <td>${qna.qnaReWriter.userName}</td>
           <c:if test="${qna.qnaStatus eq '대기중' }">
             <td><a style="width: 50%;" class="btn btn-primary" href="/hr_qnaPage/${qna.qnaId}">${qna.qnaStatus }</a></td>
           </c:if>
           <c:if test="${qna.qnaStatus eq '답변완료' }">
             <td><a class="btn btn-secondary" href="/hr_qnaPage/${qna.qnaId}">${qna.qnaStatus }</a></td>
           </c:if>
        </tr>
    </c:forEach>
</tbody>
</table>
<!-- 페이징 -->
<nav aria-label="Page navigation example">
    <ul class="pagination justify-content-center"> <!--가운데 -->
        <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
            <a class="page-link"
               href='<c:url value="/hr_qnaList"><c:param name="page" value="${currentPage - 1}"/></c:url>'>&laquo;</a>
        </li>
        <c:forEach var="pageNumber" begin="1" end="${totalPages}">
            <li class="page-item <c:if test='${pageNumber == currentPage}'>active</c:if>'">
                <a class="page-link"
                   href='<c:url value="/hr_qnaList"><c:param name="page" value="${pageNumber}"/></c:url>'>${pageNumber}</a>
            </li>
        </c:forEach>
        <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>'">
            <a class="page-link"
               href='<c:url value="/hr_qnaList"><c:param name="page" value="${currentPage + 1}"/></c:url>'>&raquo;</a>
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
