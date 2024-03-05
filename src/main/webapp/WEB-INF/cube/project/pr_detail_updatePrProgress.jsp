<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ccnc.cube.user.Users"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%
java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
String currentDateTime = java.time.LocalDateTime.now().format(formatter);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>CUBE : 프로젝트</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<style>
    .custom-input {
        width: 100%; /* 원하는 너비로 조정 */       
    }
    
     .form-group.row {
        display: flex; /* Flexbox 설정 */
        align-items: center; /* 수직으로 중앙 정렬 */
        width: 60%        
    }
    
     .custom-content {
        width: 100%; /* 원하는 너비로 조정 */       
    }
    
     .center {
    text-align: center;
	}
	
	input[readonly], textarea[readonly] {
	    background-color: white !important; /* 배경색을 흰색으로 설정 */
	}
	    /* 테이블 셀의 패딩을 조정합니다. */
    .table-bordered td, .table-bordered th {
        text-align: center; /* 텍스트를 수평 중앙 정렬합니다. */
        vertical-align: middle; /* 텍스트를 수직 중앙 정렬합니다. */
    }
</style>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<a class="m-0 text-secondary" href="/pr_main">프로젝트</a>
			<i class="fas fa-chevron-right mx-1"></i>
			<label class="m-0 text-secondary">프로젝트 상세</label>
		</div>
		<div class="card-body">
		<h2 class="h4 text-gray-900 font-weight-bold">프로젝트 상세</h2>
		
		<div style="margin-top:5%; margin-left:2%;">		
             
               <div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="projectWriter" >작성자 </label>
					</div>
					<div class="col-sm-4">
					<input id="projectWriter" class="form-control custom-input" type="text" readonly="readonly" value="${project.projectWriter.userName}"/>
					</div>			
				</div>
				
				<hr>
               				
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="projectTitle" >프로젝트명 </label>
					</div>
					<div class="col-sm-10">
					<input id="projectTitle" class="form-control custom-input" type="text" readonly="readonly" value="${project.projectTitle}" />
					</div>			
				</div>				
				
				<hr>
				
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label>기    간</label>
					</div>
					<div class="col-sm-10 d-flex align-items-center">
						<label for="projectStartDate" style="margin-right: 4%;">시작일</label>
						<input type="date" class="form-control custom-input" style="width:28%;" readonly="readonly"
							id="projectStartDate" name="projectStartDate" value="<fmt:formatDate value="${project.projectStartDate}" pattern="yyyy-MM-dd"/>"/>
						<label style="margin-left: 6%; margin-right: 6%; font-weight: bold;">~</label>
						<label for="projectEndDate" style="margin-right: 4%;">종료일</label>
						<input type="date" class="form-control custom-input" style="width:28%;" readonly="readonly"
							id="projectEndDate" name="projectEndDate" value="<fmt:formatDate value="${project.projectEndDate}" pattern="yyyy-MM-dd"/>"/>
					</div>
				</div>
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="projectCost" >비    용</label>
					</div>
					<div class="col-sm-10 pl-0">
						<div class="col-sm-10 d-flex align-items-center">
						    <input id="projectCost" type="text" class="form-control custom-input" style="width: 40%; text-align: right;" readonly="readonly" value="${project.projectCost}">
						    <label style="margin-left: 2%;">원</label>
					    </div>
					    <div class="col-sm-10 mt-3" style="margin-bottom: -2%">
					    	<label id="koreanAmount"></label>
					    </div>
					    <script>
						    // 숫자에 천 단위마다 쉼표를 추가하는 함수
						    function numberWithCommas(x) {
						        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						    }
						    
						    function convertToKorean(num) {
					            var koreanNumbers = ['', '일', '이', '삼', '사', '오', '육', '칠', '팔', '구'];
					            var koreanUnits = ['', '십', '백', '천', '만 ', '십', '백', '천', '억 ', '십', '백', '천', '조 ', '십', '백', '천'];
					            var result = '';
					
					            num = num.toString();
					
					            for (var i = 0; i < num.length; i++) {
					                var digit = parseInt(num.charAt(i));
					                var unit = koreanUnits[num.length - 1 - i];
					
					                if (digit === 0) {
					                	if (unit === '만 ' && num.length < 9){
					                    	result += koreanNumbers[digit] + unit;
					                    } else if (unit === '억 ' && num.length >= 9 && num.length < 13){
					                    	result += koreanNumbers[digit] + unit;
					                    } else if (unit === '조 ' && num.length >= 13){
					                    	result += koreanNumbers[digit] + unit;
					                    } else if (i === num.length - 1 || (i < num.length - 1 && num.charAt(i + 1) !== '0')) {
					                        result += koreanNumbers[digit];
					                    } 
					                } else {
					                    result += koreanNumbers[digit] + unit;
					                }
					            }
					
					            return result + ' 원';
					        }
						
						    // 페이지가 로드될 때 실행되는 함수
						    window.onload = function() {
						        var projectCostInput = document.getElementById('projectCost');
						        var originalValue = projectCostInput.value;
						        var formattedValue = numberWithCommas(originalValue);
						        projectCostInput.value = formattedValue;
						        document.getElementById('koreanAmount').innerText = convertToKorean(originalValue);
						    };
						</script>								    
					</div>
				</div>
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="projectContent" >내    용</label>
					</div>
					<div class="col-sm-10">
						<textarea class="form-control custom-content" readonly="readonly" style="margin-bottom: -2%; width: 130%;"
							id="projectContent" name="projectContent" rows="4">${project.projectContent}</textarea>
					</div>
				</div>
				
				
				<!-- 첨부파일 보류
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="projectFile"">첨부파일</label>
					</div>
					<div  class="col-sm-10">					
						<input type="file" id="projectFile" >
					</div>
				</div> -->
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label>참가자</label>
					</div>
				    <div class="col-sm-10 d-flex align-items-center">
					    <c:forEach var="prMember" items="${prMemberList}">
					    	<c:if test="${project.projectWriter != prMember.prMemberUser}">
					    		<button class="btn btn-outline-dark btn-sm" style="margin-right: 10px;">${prMember.prMemberUser.userName }</button>
				    		</c:if>
    					</c:forEach>
					</div>
				</div>

            <hr>
			<input id="projectId" type="hidden" value="${project.projectId}"/>	               
			<div class="form-group row d-flex justify-content-end">
				<c:if test="${login_user == project.projectWriter && project.projectStatus eq '진행중'}">
					<a class="btn btn-primary" style="margin-top: 2%; margin-left: 50%; margin-right: 5%;" href="/pr_updatePrPage/${project.projectId }">수정하기</a>
					<button id="btn-completePr" class="btn btn-dark" style="margin-top: 2%; margin-right: 5%; width: 10%;">완료</button>				
					<button id="btn-terminatePr" class="btn btn-danger" style="margin-top: 2%; margin-right: -5%; width: 10%;">중단</button>	
				</c:if>				
            </div>
            		</div>			
		</div>
	</div>
</div>
<div class="container-fluid">
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<div class="col d-flex align-items-center justify-content-between">
				<h2 class="h4 text-gray-900 font-weight-bold">진행사항</h2>
				<!-- <button class="btn btn-primary" style="width: 7%;">+ 추가</button> -->
			</div>

		</div>
		<div class="card-body">
		<div class="card">
		<div class="form-group" style="margin-top:1.3%; margin-left:2%;">
			<div class="form-group">
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="prProgressWriter" >작성자 </label>
					</div>
					<div class="col-sm-4">
						<input id="prProgressWriter" class="form-control custom-input" type="text" value="${login_user.userName }"/>
					</div>			
				</div>
				
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="prProgressContent" >내 용 </label>
					</div>
					<div class="col-sm-10">
						<textarea class="form-control custom-content" style="margin-bottom: -2%; width: 130%;"
							id="prProgressContent" placeholder="내용을 입력하세요" name="prProgressContent" rows="4"></textarea>
					</div>			
				</div>
			</div>
			<div>
			</div>
		</div>
			
		</div>
		<br>
			<div class="form-group d-flex justify-content-center">
				<button id="btn-savePrProgress" class="btn btn-primary" style="width: 7%; margin-bottom: -1%;">등록</button>
			</div>
	</div>
	<c:if test="${not empty prProgressList}">
		<div style="margin-left:1.5%;">				
			<table class="table table-bordered text-gray-900" style="width: 98.5%; cellspacing: 0">
		    <thead>
		      <tr>
		        <th>작성자</th>
		        <th>내용</th>
		        <th>작성일</th>
		        <th>수정일</th>
		        <th>수정</th>
		        <th>삭제</th>
		      </tr>
		    </thead>
		    <tbody>
		    <c:forEach var="prProgress" items="${prProgressList}">
		    	<c:if test="${prProgress.prProgressId == requestScope.prProId}">
			        <input type="hidden" id="prProgressId" value="${prProgress.prProgressId}">
			        <tr>
			           <td>${prProgress.prProgressWriter.userName}    (${prProgress.prProgressWriter.userTeamId.teamName })</td>	           
			           <td style="width: 50%; text-align: left;">
			             <input type="text" class="form-control custom-input" id="prpContent" value="${prProgress.prProgressContent}">
			           </td>
			           <td>${prProgress.prProgressCreated.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))}</td>
			           <td>${prProgress.prProgressUpdated.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))}</td>
						        <td><button id="btn-updatePrProgress" data-prp-id="${prProgress.prProgressId}" class="btn btn-primary">완료</button></td>
						        <td><button id="btn-deletePrProgress" class="btn btn-center"><i class="fas fa-trash" style="color: gray;"></i></button></td>
			        </tr>
		        </c:if>
		        
		        <c:if test="${prProgress.prProgressId != requestScope.prProId}">
		        	<input type="hidden" id="prProgressId" value="${prProgress.prProgressId}">
			        <tr>
			           <td>${prProgress.prProgressWriter.userName}    (${prProgress.prProgressWriter.userTeamId.teamName })</td>	           
			           <td style="width: 50%; text-align: left;">${prProgress.prProgressContent}</td>
			           <td>${prProgress.prProgressCreated.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))}</td>
			           <td>${prProgress.prProgressUpdated.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))}</td>
			           <c:choose>
						    <c:when test="${login_user == prProgress.prProgressWriter}">						    
						        <td><a href="/pr_updatePrProgressPage/${project.projectId }/${prProgress.prProgressId}"><i class="fas fa-pen" style="color: gray;"></i></a></td>
						        <td><button id="btn-deletePrProgress" class="btn btn-center"><i class="fas fa-trash" style="color: gray;"></i></button></td>
						    </c:when>
						    <c:otherwise>
						        <td></td>
						        <td></td>
						    </c:otherwise>
						</c:choose>
			        </tr>
		        </c:if>
		    </c:forEach>
			</tbody>
			</table>
		</div>
	</c:if>
</div>
</div>
	
				
<script src="/js/project.js"></script>
</body>
</html>            