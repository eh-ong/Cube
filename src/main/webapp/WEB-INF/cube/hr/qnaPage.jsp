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
.row {
    display: flex;
    flex-wrap: wrap;
    margin: auto;
}
input[readonly], textarea[readonly] {
    background-color: white !important; /* 배경색을 흰색으로 설정 */
}
</style>
<head>
  <title>Mail</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
</header>
<div class="container-fluid">
<div class="card shadow mb-4">
<div class="card-header py-3">
	<a class="m-0 text-secondary" href="/hrPage">HR</a>
	<i class="fas fa-chevron-right mx-1"></i>
	<a  class="m-0 text-secondary" href="/hr_qnaList">문의함</a>
</div>
<div class="card-body">
<div class="justify-content-end">

  <h2 class="h4 text-gray-900 font-weight-bold">문의 상세</h2>
  	 <hr class="border border-dark">
<div class="p-1">
  	 
  	 <div class="form-group row mt-4">
  	 	<div class="col-sm-1 mb-3 mb-sm-0">
			<p class="h8 text-gray-900">번호</p>
		</div>
		<div style="width: 5%;">
      		<input class="form-control" id="qnaId" type="text" value="${qna.qnaId }" readonly="readonly">
      	</div>
   	 </div>
   	 <div class="form-group row mt-4">
  	 	<div class="col-sm-1 mb-3 mb-sm-0">
			<p class="h8 text-gray-900">이메일</p>
		</div>
		<div style="width: 20%;">
      		<input class="form-control" id="qnaEmail" type="email" value="${qna.qnaEmail }" readonly="readonly">
      	</div>
   	 </div>
   	 <div class="form-group row mt-4">
  	 	<div class="col-sm-1 mb-3 mb-sm-0">
			<p class="h8 text-gray-900">수신일</p>
		</div>
		<div style="width: 20%;">
      		<input class="form-control" id="qnaCreated" value="${qna.qnaCreated.format(DateTimeFormatter.ofPattern('yyyy-MM-dd   HH:mm:ss'))}" readonly="readonly">
      	</div>
   	 </div>
   	 <div class="form-group row mt-4">
  	 	<div class="col-sm-1 mb-3 mb-sm-0">
			<p class="h8 text-gray-900">제목</p>
		</div>
		<div style="width: 50%;">
      		<input class="form-control" id="qnaTitle" type="text" value="${qna.qnaTitle }" readonly="readonly">
      	</div>
   	 </div>
   	 <div class="form-group row mt-4">
  	 	<div class="col-sm-1 mb-3 mb-sm-0">
			<p class="h8 text-gray-900">내용</p>
		</div>
		<div style="width: 50%;">
      		<textarea class="form-control form-control-user" rows="10" id="qnaContent" name="qnaContent" readonly="readonly">${qna.qnaContent }</textarea>
      	</div>
   	 </div>
   	 <div class="form-group row mt-4">
  	 	<div class="col-sm-1 mb-3 mb-sm-0">
			<p class="h8 text-gray-900">답변 작성자</p>
		</div>
		<div style="width: 20%;">
      		<input class="form-control" id="qnaReWriter" type="text" value="${sessionScope.login_user.userName}" readonly="readonly">
      	</div>
   	 </div>
   	 <div class="form-group row mt-4">
  	 	<div class="col-sm-1 mb-3 mb-sm-0">
			<p class="h8 text-gray-900">회신일</p>
		</div>
		<div style="width: 20%;">
      		<input class="form-control" id="qnaReplyed" value="${qna.qnaReplyed.format(DateTimeFormatter.ofPattern('yyyy-MM-dd   HH:mm:ss'))}" readonly="readonly">
      	</div>
   	 </div>
   	 <div class="form-group row mt-4">
  	 	<div class="col-sm-1 mb-3 mb-sm-0">
			<p class="h8 text-gray-900">답변</p>
		</div>
		<c:if test="${empty qna.qnaReply}">
			<div style="width: 50%;">
	      		<textarea class="form-control form-control-user" rows="3" id="qnaReply" name="qnaReply">${qna.qnaReply }</textarea>
	      	</div>		
		</c:if>
		<c:if test="${not empty qna.qnaReply}">
			<div style="width: 50%;">		
		    	<textarea class="form-control form-control-user" id="qnaReply" name="qnaReply" readonly="readonly">${qna.qnaReply }</textarea>
	    	</div>
		</c:if>
   	 </div>
   	 
   	<c:if test="${qna.qnaStatus eq '대기중' }">
		<div class="form group mt-4" style="margin-left: 25%;">
			<button id="btn-qnaReply"class="btn btn-primary" style="width:12%;">답변 회신</button>
		</div>
	</c:if>
   	 
</div>
</div>

</div>
</div>
</div>
<script src="/js/hr.js"></script>
</body>
</html>

