

let NoticeBoardObject = {

	init: function() {
		let _this = this;

		$("#btn-insertNotice").on("click", () => {
			_this.insertNotice();
		});
		$("#btn-updateNotice").on("click", () => {
			_this.updateNoticeBoard();
		});
		$("#btn-deleteNotice").on("click", () => {
			_this.deleteNotice();
		});
		$("#btn-nboardsearch").on("click", () => {
			_this.nboardsearch();
		});

	},
	//insertUser 함수 선언
	insertNotice: function() {
		alert("글등록 요청")
		//입력한 값
		let post = {
			nboardTitle: $("#nboardTitle").val(),
			nboardContent: $("#nboardContent").val()

		}


		$.ajax({
			type: "POST", //버튼을 눌렀을때 요청하는 방식
			url: "/insertNotice",
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
					location = "/listNotice"; //메인페이지로 이동 => index.jsp 메인페이지
				}
			});
		}).fail(function(error) {
			alert("실패")
			console.log(response);
		});
	},

	updateNoticeBoard: function() {
		alert("글수정 요청")
		let post = {
			nboardId: $("#nboardId").val(),
			nboardTitle: $("#nboardTitle").val(),
			nboardContent: $("#nboardContent").val()
		}

		$.ajax({
			type: "POST", //버튼을 눌렀을때 요청하는 방식
			url: "/updateNotice",
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
					location = "/listNotice"; //메인페이지로 이동 => index.jsp 메인페이지
				}
			});
		}).fail(function(error) {
			alert("실패")
			console.log(response);
		});
	},

	deleteNotice: function() {
		alert("삭제");

		let nboardId = $("#nboardId").val()


		$.ajax({
			type: "DELETE", //버튼을 눌렀을때 요청하는 방식
			url: "/deleteNotice/" + nboardId,

		}).done(function(response) {
			console.log(response)
			location = "/listNotice" //메인페이지로 이동 => index.jsp 메인페이지
		}).fail(function(error) {
		});
	},

	nboardsearch: function() {
		alert("검색 요청됨");

		let searchType = $("#searchType").val();
		let searchInput = $("#searchInput").val();

		$.ajax({
			type: "GET",
			url: "/listNotice/" + searchType + "/" + searchInput,
		}).done(function(response) {
			console.log(response);
			location = "/listNotice/" + searchType + "/" + searchInput;
		}).fail(function(error) {
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
}
NoticeBoardObject.init();