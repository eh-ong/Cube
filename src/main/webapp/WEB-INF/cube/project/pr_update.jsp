<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ccnc.cube.user.Users"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>

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
        border-color: blue;
       
    }
     .form-group.row {
        display: flex; /* Flexbox 설정 */
        align-items: center; /* 수직으로 중앙 정렬 */
        border-color: blue;
        width: 60%
        
    }
     .custom-content {
        width: 100%; /* 원하는 너비로 조정 */
        border-color: blue;
       
    }
     .center {
    text-align: center;
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
					<input id="projectWriter" class="form-control custom-input" readonly="readonly" type="text" value="${project.projectWriter.userName}"/>
					</div>			
				</div>
				
				<hr>
               				
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="projectTitle" >프로젝트명 </label>
					</div>
					<div class="col-sm-10">
					<input id="projectTitle" class="form-control custom-input" type="text" value="${project.projectTitle}" />
					</div>			
				</div>				
				
				<hr>
				
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label>기    간</label>
					</div>
					<div class="col-sm-10 d-flex align-items-center">
						<label for="projectStartDate" style="margin-right: 4%;">시작일</label>
						<input type="date" class="form-control custom-input" style="width:28%;"
							id="projectStartDate" name="projectStartDate" value="<fmt:formatDate value="${project.projectStartDate}" pattern="yyyy-MM-dd"/>"/>
						<label style="margin-left: 6%; margin-right: 6%; font-weight: bold;">~</label>
						<label for="projectEndDate" style="margin-right: 4%;">종료예정일</label>
						<input type="date" class="form-control custom-input" style="width:28%;"
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
						    <input type="text" class="form-control custom-input" style="width: 40%; text-align: right;" oninput="addCommas(this)"
						    	id="prCost" value="${project.projectCost}">
						    <label style="margin-left: 2%;">원</label>
					    </div>			
					    <div class="col-sm-10 mt-3" style="margin-bottom: -2%">
					    	<label id="koreanAmount"></label>
					    </div>
					    <script>
						 	// 페이지가 로드될 때 실행되는 함수
						    window.onload = function() {
						        var projectCostInput = document.getElementById('prCost');
						        var originalValue = projectCostInput.value;
						        var formattedValue = numberWithCommas(originalValue);
						        projectCostInput.value = formattedValue;
						        document.getElementById('koreanAmount').innerText = convertToKorean(originalValue);
						    };	
						    
					        function addCommas(input) {
					            // 입력 값에서 모든 쉼표 제거
					            var value = input.value.replace(/,/g, '');
					            var intVal = input.value.replace(/,/g, '');
					            // 숫자만 남기고 다른 문자 제거
					            value = value.replace(/\D/g, '');
					            // 쉼표 추가
					            input.value = numberWithCommas(value);
					
					            // 입력된 숫자를 한글로 변환하여 아래에 표시
					            document.getElementById('koreanAmount').innerText = convertToKorean(value);
					            
					            // intVal 값을 hidden input에 할당
					            document.getElementById('projectCost').value = intVal;
					        }
					
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
					     	
					    </script>
					    <input type="hidden" id="projectCost" name="projectCost" value="${project.projectCost }">					    
					</div>
				</div>
				
				<hr>
				<div class="form-group row">
					<div class="col-sm-2 text-center">
						<label for="projectContent" >내    용</label>
					</div>
					<div class="col-sm-10">
						<textarea class="form-control custom-content" id="projectContent" name="projectContent" rows="5">${project.projectContent }</textarea>
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
					
					<div class="col-sm-10 pl-0">
				    <div class="col-sm-10 d-flex align-items-center">
					    <input list="userList" class="form-control custom-input" style="width: 40%;" name="user" id="user">
					    <datalist id="userList">
					        <c:forEach var="user" items="${requestScope.userList}">
					            <c:if test="${user.userStatus == '활성화' && user.userNum ne login_user.userNum}">
						                <option value="${user}"> | ${user.userTeamId.teamName}팀 ${user.userPosition}</option>					            
					            </c:if>
					        </c:forEach>
					    </datalist>
					    <button id="btn-addPrMember" class="btn btn-primary" style="margin-left: 5%; width: 15%;">추가</button>
					</div>
					<div class="col-sm-10 d-flex align-items-center mt-3">
					    <c:forEach var="prMember" items="${prMemberList}">
					    	<c:if test="${login_user != prMember.prMemberUser}">
						    	<button class="btn btn-outline-dark btn-sm delete-button" data-user-num="${prMember.prMemberUser.userNum}"
						    			style="margin-right: 10px;">${prMember.prMemberUser.userName}</button>
			    			</c:if>
    					</c:forEach>
    				</div>
    				<!-- 삭제할 사용자 목록 사번 문자열 생성 -->
    				<script>
					    // 클릭된 버튼들의 data-user-num 값을 저장할 배열
					    var userNumArr = [];
					
					    // 모든 버튼을 선택하여 각각에 대해 클릭 이벤트를 추가
					    var deleteButtons = document.querySelectorAll('.delete-button');
					    deleteButtons.forEach(function(button) {
					        button.addEventListener('click', function() {
					            var userNum = button.getAttribute('data-user-num');
					            // 이미 선택된 버튼인지 확인하고, 선택되지 않았다면 배열에 추가
					            if (!userNumArr.includes(userNum)) {
					            	userNumArr.push(userNum);
					            }
					         	// 버튼을 화면에서 숨김
					            button.style.display = 'none';
					            // 여기서 필요한 작업을 수행
					            console.log("삭제할 사용자 사번들:", userNumArr);
					            // 배열을 문자열로 변환하여 '&'으로 연결
					            var deleteUsersNumStr = userNumArr.join('&');
					            console.log("삭제할 사용자 사번 문자열:", deleteUsersNumStr);
					         	// usersNumStr 값을 hidden input에 할당
						        document.getElementById('deleteUsersNumStr').value = deleteUsersNumStr;
					        });
					    });
					</script>
					<input type="hidden" id="deleteUsersNumStr">
					
    				<!-- 사용자 목록을 표시할 요소 추가 -->
					<div class="col-sm-10 mt-3" id="userListDiv"></div>					
					<script>
					    var userArr = []; // userArr 배열 정의
					
					    document.getElementById('btn-addPrMember').addEventListener('click', function() {
					        var selectedUser = document.getElementById('user').value;
					        if(selectedUser.trim() !== "") { // 입력된 값이 있는지 확인
					            if (!userArr.includes(selectedUser)) { // 배열에 선택된 사용자가 이미 존재하는지 확인
					                userArr.push(selectedUser);
					                console.log(userArr); //콘솔 확인
					                document.getElementById('user').value = ''; // 입력 칸 비우기
					                updateUserList(); // 사용자 목록을 업데이트
					            } else {
					                Swal.fire({
					                    icon: "error",
					                    confirmButtonColor: '#007bff',
					                    text: "이미 선택된 참가자입니다."
					                }); // 이미 선택된 참가자인 경우 경고 메시지 표시
					                document.getElementById('user').value = ''; // 입력 칸 비우기
					            }
					        } else {
					            Swal.fire({
					                icon: "error",
					                confirmButtonColor: '#007bff',
					                text: "참가자를 입력 후 선택해 주세요."
					            }); // 선택된 참가자가 없는 경우 경고 메시지 표시
					        }
					    });
					
					    function updateUserList() {
					        var userListDiv = document.getElementById('userListDiv');
					        userListDiv.innerHTML = ''; // 기존의 사용자 목록 초기화
					
					        userArr.forEach(function(user) {
					            var userName = user.substring(0, user.length - 10); // 사용자 이름에서 뒤에서 10글자 제거
					            var button = document.createElement('button');
					            button.type = 'button';
					            button.className = 'btn btn-outline-dark btn-sm mr-2 mb-2';
					            button.textContent = userName;
					            button.addEventListener('click', function() {
					                var index = userArr.indexOf(user);
					                if (index !== -1) {
					                    userArr.splice(index, 1); // 사용자 제거
					                    console.log("추가할 사용자 사번들:", userArr); //콘솔 확인					                    
					                    updateUserList(); // 사용자 목록 업데이트
					                }
					            });
					            userListDiv.appendChild(button);
					        });
					        
					        // usersNumStr 생성 코드 수정
					    	var usersNumStr = userArr.map(function(user) {
					            return user.substring(user.length - 9, user.length - 1); // 각 사용자에서 오른쪽에서 첫 번째 글자를 제외한 8글자 추출
					        }).join('&');
					        console.log("추가할 사용자 사번 문자열:", usersNumStr); // 최종적으로 만들어진 문자열 출력
					        // usersNumStr 값을 hidden input에 할당
					        document.getElementById('usersNumStr').value = usersNumStr;
					    }
					</script>
					<input type="hidden" id="usersNumStr">
				</div>
				
		</div>

            <hr>
			<input id="projectId" type="hidden" value="${project.projectId}"/>	               
			<div class="form-group row d-flex justify-content-end">
				<button id="btn-updatePr" class="btn btn-primary" style="margin-top: 2%; margin-right: 11%; width: 15%;">저장</button>
            </div>
							
		</div>
	</div>
</div>
<script src="/js/project.js"></script>
</body>
</html>

