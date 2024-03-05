let my = {
	init: function() {
		let _this = this;
		$("#btn-profileCheckPw").on("click", ()=>{
			_this.profileCheckPw();
		});
		$("#btn-changePwcheckPw").on("click", ()=>{
			_this.changePwCheckPw();
		});
		$("#btn-uploadFile").on("click", ()=>{
			_this.uploadFile();
		});
		$("#btn-updateProfile").on("click", ()=>{
			_this.updateProfile();
		});
		$("#btn-changePw").on("click", ()=>{
			_this.changePw();
		});
		
	},
	
	profileCheckPw: function() {
		let user = {
			userPw: $("#userPw").val()
		}
		
		$.ajax({
			type: "POST",
			url: "/my_checkPw",
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
					location = "/my_profile"
				}			
		});
		
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},	
	
	uploadFile: function() {
		var userId = $("#userId").val();
		
		//input file 엘리먼트에 접근하여 파일 객체 가져오기
		var fileInput = document.getElementById('fileInput');
		var file = fileInput.files[0];
		
		if(file) {
			//FormData = new FormData();
			var formData = new FormData();
			formData.append('file', file);	
			
			//AJAX 요청 시 data 속성을 FormData로 설정
			$.ajax({
				type: "POST",
				url: "/my_uploadFile/" + userId,
				data: formData,
				//필수: processData와 contentType을 false로 설정하여 FormData 전송
				processData: false,
				contentType: false
			}).done(function(response){
				console.log(response);				
				Swal.fire({
					icon: response.status === 200 ? "success" : "error",
					iconColor: response.status === 200 ? '#007bff' : '#dc3545',
					confirmButtonColor: '#007bff',
					text: response.data,
				}).then((result) => {
					if (response.status === 200 && result.isConfirmed) {
						location = "/my_updateProfile";
					}
			});
			
			}).fail(function(error){
				console.log(error);
				alert("에러 발생: " + error);
			});
		} else {
			console.error('선택된 파일이 없습니다.');
		}
		
	},
	
	updateProfile: function() {
		let user = {
			userId: $("#userId").val(),
			userZipCode: $("#userZipCode").val(),
			userAddr: $("#userAddr").val(),
			userAddrDetail: $("#userAddrDetail").val(),
			userMobile: $("#userMobile").val(),
			userEmailEx: $("#userEmailEx").val()
		}
		
		//userAddrDetailError 값 가져오기
		var userAddrDetailErrorVal = document.getElementById("userAddrDetailError").innerHTML;
		//조건 확인
		if (userAddrDetailErrorVal.trim() === "상세주소를 입력해 주세요.") {
		    //idStatus 값이 "상세주소를 입력해주세요."일 때 수행할 동작
		    Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "상세주소를 입력해 주세요."
			});
		    return;
		}
		//mobileStatus 값 가져오기
		var mobileStatusVal = document.getElementById("mobileStatus").innerHTML;
		//조건 확인
		if (mobileStatusVal.trim() === "휴대전화 번호 중복확인 필요"
			|| mobileStatusVal.trim() === "사용 불가능한 휴대전화 번호"
			|| mobileStatusVal.trim() === "휴대전화 번호 11자리를 입력해 주세요.") {
		    //idStatus 값이 "휴대전화번호 중복확인 필요"일 때 수행할 동작
		    Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "휴대전화 번호 중복확인이 필요합니다."
			});
		    return;
		}
		//emailExStatus 값 가져오기
		var emailExStatusVal = document.getElementById("emailExStatus").innerHTML;
		//조건 확인
		if (emailExStatusVal.trim() === "외부 이메일 중복확인 필요"
			|| emailExStatusVal.trim() === "사용 불가능한 외부 이메일"
			|| emailExStatusVal.trim() === "이메일 형식으로 입력해 주세요.") {
		    //emailExStatus 값이 "외부 이메일 중복확인 필요"일 때 수행할 동작
		    Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "외부 이메일 중복확인이 필요합니다."
			});
		    return;
		}
		
		$.ajax({
			type: "POST",
			url: "/my_updateProfile",
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
					location = "/my_profile";
				}
		});
			
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
	
	changePwCheckPw: function() {
		let user = {
			userPw: $("#userPw").val()
		}
		$.ajax({
			type: "POST",
			url: "/my_checkPw",
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
					location = "/my_changePw";
				}
		});
		
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
	
	changePw: function() {		
		let user = {
			userId: $("#userId").val(),
			userPw: $("#userPw").val()
		}
		
		let checkPw = $("#checkPw").val()

		//비밀번호 검사
		if(!this.isValiduserPw(user.userPw)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "비밀번호는 8자 이상, 영문자, 숫자, 특수문자를 포함해야 합니다."
			});
			return;
		}
		//비밀번호 확인 검사
		if(checkPw !== user.userPw) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "비밀번호가 일치하지 않습니다."
			});
			return;
		}
		
		$.ajax({
			type: "POST",
			url: "/my_changePw",
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
					location = "/my_profileCheckPw";
				}
		});
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
	
	//비밀번호 유효성 검사 함수 추가
    isValiduserPw: function(userPw) {
		const userPwRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[a-z\d@$!%*?&]{8,}$/; // 8자 이상,영문자,숫자,특수문자 포함, 공백 허용 안함
		return userPwRegex.test(userPw);
	},
	
	
}
my.init();	