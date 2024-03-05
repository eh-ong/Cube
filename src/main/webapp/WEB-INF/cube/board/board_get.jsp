<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
  java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
  String currentDateTime = java.time.LocalDateTime.now().format(formatter);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        .custom-input {
            width: 80%;
            border-color: blue;
        }

        .form-group.row {
            display: flex;
            align-items: center;
            width: 80%;
            border-color: blue;
        }

        .custom-content {
            width: 80%;
            border-color: blue;
            resize: none;
        }

        .card-body {
            width: 75%;
            border-color: white;
            
        }
        input[readonly],
    textarea[readonly] {
        background-color: white !important; /* 배경색을 흰색으로 설정하고 우선순위를 높임 */
    }
        
textarea{
	resize: none;
}

    </style>
</head>
<body id="page-top">
    <header class="index_header">
        <jsp:include page="../layout/header.jsp" />
    </header>
    <div class="container-fluid">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 text-gray-600">
                    팀게시글<i class="fas fa-chevron-right mx-1"></i>팀게시글 상세보기
                </h6>
            </div>
            <div class="card-body">
                
                    <hr>
                    <div class="form-group row">
                        <div class="col-sm-2 text-center">
                            <label for="boardTitle">번호</label>
                        </div>
                        <div class="col-sm-10">
                            ${Board.boardId}<input id="boardId" type=hidden value="${Board.boardId}">
                            <input id="teamId" type=hidden value="${teamId}">
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <div class="col-sm-2 text-center">
                            <label for="boardTitle">제목</label>
                        </div>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="boardTitle" name="boardTitle"
                                value="${Board.boardTitle}" readonly>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <div class="col-sm-2 text-center">
                            <label for="boardWriter">작성자</label>
                        </div>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="boardWriter" name="boardWriter"
                                value="${login_user.userName}" readonly>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <div class="col-sm-2 text-center">
                            <label for="boardContent">내용</label>
                        </div>
                        <div class="col-sm-10">
                            <label id="boardContent" name="boardContent" rows="15" style="resize=none;"
                                readonly >${Board.boardContent}</label>
                            <input type="hidden" id="boardId" value="${Board.boardId}">
                        </div>
                    </div>
                   <c:if test = "${teamId eq login_user.userTeamId.teamId}">
                    <div class= "col text-center my-3">
						<a href="/updateBoard/${boardId}" style="text-decoration: none;">
							<button class="btn btn-primary">
								<i class="fas fa-pen mr-2"></i>글수정
							</button>
						</a>
						<button id="btn-deleteBoard" class="btn btn-primary"
							style="margin-left: 10px;">글 삭제</button>
					</div>
                    </c:if>
                    
           <c:if test = "${teamId eq login_user.userTeamId.teamId}">         
      <table class="table table-bordered" width="100%" cellspacing="0">
    <thead>
        <tr align = center>
            <th width = 20%>작성자</th>
            <th width = 45%>내용</th>
            <th width = 25%>작성 시간</th>
            <th width = 10%>삭제하기</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="comment" items="${commentList}">
            <tr>
                <td>${comment.commentWriter.userName}<input type="hidden" value="${comment.commentId}" id="commentId"></td>
                <td>${comment.commentContent}</td>
                <td>${comment.commentCreated.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
                <td><button id="btn-deleteComment" class="btn btn-primary">댓글삭제</button></td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<label for="commentWriter">작성자</label>
<input type="text" id="commentWriter" value="${login_user.userName}" readonly="readonly"/>
<label for="commentContent">내용</label>
<input type="text" id="commentContent" placeholder="내용을 입력하세요">
<button id="btn-insertComment" class="btn btn-primary">댓글 등록</button>
</c:if>
</div>
</div>
</div>
	<script src="/js/tb.js"></script>

</body>
</html>