let hr = {
	init: function() {
		let _this = this;
		$("#btn-search").on("click", ()=>{
			_this.search();
		});
		$("#btn-updateEmployee").on("click", function() {
            let userId = $(this).data("user-id");  //버튼의 data-user-id 속성을 사용할 때는 JavaScript에서는 data("user-id")로 읽고, data-userId 속성을 사용할 때는 data("userid")로 읽어야 합니다. 각 속성 이름의 대소문자를 주의
            _this.updateEmployee(userId);
        });	
        $("#btn-qna").on("click", ()=>{
			_this.qna();
		});	
		$("#btn-qnaReply").on("click", ()=>{
			_this.qnaReply();
		});		
	},
	search: function() {
		let searchType = $("#searchType").val()
		let searchInput = $("#searchInput").val()
		$.ajax({
			type: "GET",
			url: "/hr_searchEmployee/" + searchType + "/" + searchInput,
		}).done(function(response){
			console.log(response);
			location = "/hr_searchEmployee/" + searchType + "/" + searchInput;
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
	
	updateEmployee: function(userId) {
		let user = {
			userId: userId,
			userPosition: $("#userPosition").val(),
			userStatus: $("#userStatus").val()
		}
		let teamId = $("#teamId").val()
		let page = $("#page").val()
		$.ajax({
			type: "POST",
			url: teamId === "" ? "/hr_updateEmployee" : "/hr_updateEmployee/" + teamId,
			data: JSON.stringify(user),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				confirmButtonColor: '#007bff',
				text: response.data,
			}).then((result) => {
				if (response.status === 200 && result.isConfirmed) {
					location = "/hr_employeePage?page=" + page;
				}
		});
				
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
	
	qna: function() {
		let qna = {
			qnaId: $("#qnaId").val(),
			qnaEmail: $("#qnaEmail").val(),
			qnaTitle: $("#qnaTitle").val(),
			qnaContent: $("#qnaContent").val()
		}
		if(!this.isValidqnaEmail(qna.qnaEmail)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "이메일 형식으로 입력해 주세요."
			});
			return;
		}
		if(qna.qnaTitle === "" || qna.qnaTitle === null) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "문의 제목을 입력해 주세요."
			});
			return;
		}
		if(qna.qnaContent === "" || qna.qnaContent === null) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "문의 내용을 입력해 주세요."
			});
			return;
		}
		$.ajax({
			type: "POST",
			url: "/hr_qna",
			data: JSON.stringify(qna),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				confirmButtonColor: '#007bff',
				text: response.data,
			}).then((result) => {
				if (response.status === 200 && result.isConfirmed) {
					location = "/";
				}
		});
				
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
	
	qnaReply: function() {
		let qna = {
			qnaId: $("#qnaId").val(),
			qnaEmail: $("#qnaEmail").val(),
			qnaTitle: $("#qnaTitle").val(),
			qnaContent: $("#qnaContent").val(),
			qnaReply: $("#qnaReply").val()
		}
		
		if(qna.qnaReply === "" || qna.qnaReply === null) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "답변을 입력해 주세요."
			});
			return;
		}
		
		$.ajax({
			type: "POST",
			url: "/hr_qnaReply",
			data: JSON.stringify(qna),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				confirmButtonColor: '#007bff',
				text: response.data,
			}).then((result) => {
				if (response.status === 200 && result.isConfirmed) {
					location = "/hr_qnaPage/" + qna.qnaId;
				}
		});
				
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
	
	//이메일 유효성 검사 함수 추가
	isValidqnaEmail: function(qnaEmail) {
		//간단한 이메일 형식 정규식을 사용하여 유효성을 검사
		const qnaEmailRegex = /^\S+@\S+\.\S+$/;
		return qnaEmailRegex.test(qnaEmail);
	}
}
hr.init();	