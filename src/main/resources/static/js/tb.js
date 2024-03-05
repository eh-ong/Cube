

let BoardObject = {

	init: function() {
		let _this = this;

		$("#btn-insertBoard").on("click", () => {
			_this.insertBoard();
		});
		$("#btn-updateBoard").on("click", () => {
			_this.updateBoard();
		});
		$("#btn-deleteBoard").on("click", () => {
			_this.deleteBoard();
		});
		$("#btn-insertComment").on("click", () => {
			_this.insertComment();
		});
		$("#btn-deleteComment").on("click", () => {
			_this.deleteComment();
		});
		$("#btn-search").on("click", () => {
			_this.search();
		});
	},
	//insertUser 함수 선언
	insertBoard: function() {
		alert("글등록 요청")
		//입력한 값
		let post = {
			boardTitle: $("#boardTitle").val(),
			boardContent: $("#boardContent").val(),
		};
		let teamId = $("#team").val()

		$.ajax({
			type: "POST", //버튼을 눌렀을때 요청하는 방식
			url: "/insertBoard/" + teamId,
			data: JSON.stringify(post), //
			contentType: "application/json; charset=utf-8"
		}).done(function(response) {
			let message = response["data"];
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				text: message,
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				showCloseButton: true,
				confirmButtonColor: '#007bff',
			}).then((result) => {
				if (response.status === 200 && result.isConfirmed) {
					location = "/listBoard/" + teamId;
				}
			});
		}).fail(function(error) {
			alert("실패");
			console.log(response);
		});
	},

	updateBoard: function() {
		alert("글수정 요청")
		let teamId = $("#boardId").val();
		let post = {
			boardId: $("#boardId").val(),
			boardTitle: $("#boardTitle").val(),
			boardContent: $("#boardContent").val()
		}

		$.ajax({
			type: "POST", //버튼을 눌렀을때 요청하는 방식
			url: "/updateBoard/" + post.boardId,
			data: JSON.stringify(post), //
			contentType: "application/json; charset=utf-8"

		}).done(function(response) {
			let message = response["data"];
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				text: message,
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				showCloseButton: true,
				confirmButtonColor: '#007bff',
			}).then((result) => {
				if (response.status === 200 && result.isConfirmed) {


					location = "/getBoard/" + teamId + "/" + post.boardId;
				}//메인페이지로 이동 => index.jsp 메인페이지
				});
			}).fail(function(error) {
				alert("실패")
				console.log(response);
			});
		},

			deleteBoard: function() {
				alert("삭제");

				let boardId = $("#boardId").val()
				let teamId = $("#teamId").val()

				$.ajax({
					type: "DELETE", //버튼을 눌렀을때 요청하는 방식
					url: "/deleteBoard/" + boardId,

				}).done(function(response) {
					console.log(response)
					location = "/listBoard/" + teamId
				}).fail(function(error) {
				});
			},

			insertComment: function() {
				alert("댓글 요청")
				let boardId = $("#boardId").val();
				let teamId = $("#teamId").val();
				let comment = {
					commentContent: $("#commentContent").val()
				};

				$.ajax({
					type: "POST", //버튼을 눌렀을때 요청하는 방식
					url: "/insertComment/" + boardId,
					data: JSON.stringify(comment), //
					contentType: "application/json; charset=utf-8"
				}).done(function(response) {
					console.log(response)
					alert('성공');
					location = "/getBoard/" + teamId + "/" + boardId; //메인페이지로 이동 => index.jsp 메인페이지
				}).fail(function(error) {
					alert("실패");
					console.log(response);
				});
			},
			deleteComment: function() {
				alert("삭제");

				let boardId = $("#boardId").val();
				let teamId = $("#teamId").val();
				let commentId = $("#commentId").val();

				$.ajax({
					type: "DELETE", //버튼을 눌렀을때 요청하는 방식
					url: "/deleteComment/" + commentId,

				}).done(function(response) {
					console.log(response)
					location = "/getBoard/" + teamId + "/" + boardId;
				}).fail(function(error) {
				});
			},
			search: function() {
				alert("검색 요청됨");
				let teamId = $("#teamId").val();
				let searchType = $("#searchType").val();
				let searchInput = $("#searchInput").val();

				$.ajax({
					type: "GET",
					url: "/listBoard/" + teamId + "/" + searchType + "/" + searchInput,
				}).done(function(response) {
					console.log(response);
					location = "/listBoard/" + teamId + "/" + searchType + "/" + searchInput;
				}).fail(function(error) {
					console.log(error);
					alert("에러 발생: " + error);
				});
			},
}
BoardObject.init();