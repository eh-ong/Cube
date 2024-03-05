let certification = {
	init: function() {
		let _this = this;
		$("#btn-login").on("click", ()=>{
			_this.login();
		});
		$("#btn-checkId").on("click", ()=>{
			_this.checkId();
		});
		$("#btn-checkMobile").on("click", ()=>{
			_this.checkMobile();
		});
		$("#btn-checkEmailEx").on("click", ()=>{
			_this.checkEmailEx();
		});
		$("#btn-signUp").on("click", ()=>{
			_this.signUp();
		});
		$("#btn-findId").on("click", ()=>{
			_this.findId();
		});
		$("#btn-findPwCheckUser").on("click", ()=>{
			_this.findPwCheckUser();
		});
		$("#btn-findPwCheckCode").on("click", ()=>{
			_this.findPwCheckCode();
		});
		$("#btn-changePw").on("click", ()=>{
			_this.changePw();
		});
	},
	
	login: function() {
		let user = {
			userId: $("#userId").val(),
			userPw: $("#userPw").val()
		}
		$.ajax({
			type: "POST",
			url: "/login",
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
					location = "/index";
				}
		});
			
		}).fail(function(error){
			console.log(error);
			alert("오류가 발생했습니다." + error);
		});
	},
	
	checkId: function() {
		let user = {
			userId: $("#userId").val()
		}
		//아이디 검사
		if(!this.isValiduserId(user.userId)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "아이디를 입력해 주세요."
			});
			return;
		}
		$.ajax({
			type: "POST",
			url: "/checkId",
			data: JSON.stringify(user),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				text: response.data,
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				confirmButtonColor: '#007bff',
			});
			if(response.status === 200) {
				document.getElementById("idStatus").innerHTML = "사용 가능한 아이디";
                document.getElementById("idStatus").style.color = "blue";			
			} else {
				document.getElementById("idStatus").innerHTML = "사용 불가능한 아이디";
                document.getElementById("idStatus").style.color = "red";
			}
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
				
	},
	
	checkMobile: function() {		
		let user = {
			userMobile: $("#userMobile").val()
		}
		//휴대전화번호 검사
		if(!this.isValiduserMobile(user.userMobile)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "휴대전화 번호 11자리를 입력해 주세요."
			});
			return;
		}
		$.ajax({
			type: "POST",
			url: "/checkMobile",
			data: JSON.stringify(user),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				text: response.data,
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				confirmButtonColor: '#007bff',
			});
			if(response.status === 200) {
				document.getElementById("mobileStatus").innerHTML = "사용 가능한 휴대전화 번호";
                document.getElementById("mobileStatus").style.color = "blue";			
			} else {
				document.getElementById("mobileStatus").innerHTML = "사용 불가능한 휴대전화 번호";
                document.getElementById("mobileStatus").style.color = "red";
			}
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
				
	},
	
	checkEmailEx: function() {
		let user = {
			userEmailEx: $("#userEmailEx").val()
		}
		//외부 이메일 검사
		if(!this.isValiduserEmailEx(user.userEmailEx)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "이메일 형식으로 입력해 주세요."
			});
			return;
		}
		$.ajax({
			type: "POST",
			url: "/checkEmailEx",
			data: JSON.stringify(user),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				text: response.data,
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				confirmButtonColor: '#007bff',
			});
			if(response.status === 200) {
				document.getElementById("emailExStatus").innerHTML = "사용 가능한 외부 이메일";
                document.getElementById("emailExStatus").style.color = "blue";			
			} else {
				document.getElementById("emailExStatus").innerHTML = "사용 불가능한 외부 이메일";
                document.getElementById("emailExStatus").style.color = "red";
			}
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
				
	},
	
	signUp: function() {
    	let user = {
			userId: $("#userId").val(),
			userPw: $("#userPw").val(),
			userNum: $("#userNum").val(),
			userName: $("#userName").val(),
			userGender: $(":input:radio[name=gender]:checked").val(),
			userZipCode: $("#userZipCode").val(),
			userAddr: $("#userAddr").val(),
			userAddrDetail: $("#userAddrDetail").val(),
			userMobile: $("#userMobile").val(),
			userEmailEx: $("#userEmailEx").val()
		}
		
		let checkPw = $("#checkPw").val()
		
		//아이디 중복 검사
		//idStatus 값 가져오기
		var idStatusVal = document.getElementById("idStatus").innerHTML;
		//조건 확인
		if (idStatusVal.trim() !== "사용 가능한 아이디") {
		    //idStatus 값이 "사용 가능한 아이디"일 때 수행할 동작
		    Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "아이디 중복확인이 필요합니다. (5자 이상 입력)"
			});
		    return;
		}
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
		//사번 검사
		if(!this.isValiduserNum(user.userNum)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "지급받은 사번을 입력해 주세요. (숫자 8자리)"
			});
			return;
		}
		//이름 검사
		if(!this.isValiduserName(user.userName)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "이름을 입력해 주세요."
			});
			return;
		}
		//성별 검사
		if(!user.userGender) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "성별을 선택해 주세요."
			});
			document.getElementById("userGenderError").innerHTML = "성별을 선택해 주세요.";
            document.getElementById("userGenderError").style.color = "red";
			return;
		}
		//우편번호 검사
		if(!user.userZipCode) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "우편번호를 입력해 주세요."
			});
			return;
		}
		//도로명 주소 검사
		if(!user.userAddr) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "도로명 주소를 입력해 주세요."
			});
			return;
		}
		//상세 주소 검사
		if(!this.isValiduserAddrDetail(user.userAddrDetail)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "상세 주소를 입력해 주세요."
			});
			return;
		}
		//휴대전화번호 중복 검사
		//mobileStatus 값 가져오기
		var mobileStatusVal = document.getElementById("mobileStatus").innerHTML;
		//조건 확인
		if (mobileStatusVal.trim() !== "사용 가능한 휴대전화 번호") {
		    // mobileStatus 값이 "사용 가능한 휴대전화번호"일 때 수행할 동작
		    Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "휴대전화 번호 중복확인이 필요합니다."
			});
		    return;
		}
		//외부 이메일 중복 검사
		//emailExStatus 값 가져오기
		var emailExStatusVal = document.getElementById("emailExStatus").innerHTML;
		//조건 확인
		if (emailExStatusVal.trim() !== "사용 가능한 외부 이메일") {
		    // emailExStatus 값이 "사용 가능한 외부 이메일"일 때 수행할 동작
		    Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "외부 이메일 중복확인이 필요합니다."
			});
		    return;
		}
		$.ajax({
			type: "POST",
			url: "/signUp",
			data: JSON.stringify(user),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				text: response.data,
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				showCloseButton: true,
				confirmButtonColor: '#007bff',
			}).then((result) => {
				if (response.status === 200 && result.isConfirmed) {
					location = "/login";
				}
			});
			
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
    },
    
    findId: function() {
    	let user = {
			userName: $("#userName").val(),
			userNum: $("#userNum").val(),
			userMobile: $("#userMobile").val()
		}
		//사번 검사
		if(!this.isValiduserNum(user.userNum)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "지급받은 사번을 입력해 주세요. (숫자 8자리)"
			});
			return;
		}
		//이름 검사
		if(!this.isValiduserName(user.userName)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "이름을 입력해 주세요."
			});
			return;
		}
		//휴대전화번호 검사
		if(!this.isValiduserMobile(user.userMobile)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "휴대전화 번호 11자리를 입력해 주세요."
			});
			return;
		}
		$.ajax({
			type: "POST",
			url: "/findId",
			data: JSON.stringify(user),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				text: response.data,
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				confirmButtonColor: '#007bff',
			}).then((result) => {
				if (response.status === 200 && result.isConfirmed) {
					location = "/findIdComplete";
				}
			});
			
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
    },
//비밀번호찾기 사용자 인증    
    findPwCheckUser: function() {			
    	let user = {
			userId: $("#userId").val(),
			userNum: $("#userNum").val(),
			userName: $("#userName").val(),
			userMobile: $("#userMobile").val(),
		}
		//아이디 검사
		if(!this.isValiduserId(user.userId)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "아이디를 입력해 주세요."
			});
			return;
		}
		//사번 검사
		if(!this.isValiduserNum(user.userNum)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "지급받은 사번을 입력해 주세요. (숫자 8자리)"
			});
			return;
		}
		//이름 검사
		if(!this.isValiduserName(user.userName)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "이름을 입력해 주세요."
			});
			return;
		}
		//휴대전화번호 검사
		if(!this.isValiduserMobile(user.userMobile)) {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "휴대전화 번호 11자리를 입력해 주세요."
			});
			return;
		}
		$.ajax({
			type: "POST",
			url: "/findPwCheckUser",
			data: JSON.stringify(user),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				text: response.data,
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				confirmButtonColor: '#007bff',
			}).then((result) => {
				if (response.status === 200 && result.isConfirmed) {
					location = "/findPwCheckCode";
				}
			});
			
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
    },
//비밀번호찾기 코드 인증    
    findPwCheckCode: function() {
		let code = $("#code").val();	
		$.ajax({
			type: "POST",
			url: "/findPwCheckCode",
			data: { code: code }			
		}).done(function(response){
			console.log(response);
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				text: response.data,
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				confirmButtonColor: '#007bff',
			}).then((result) => {
				if (response.status === 200 && result.isConfirmed) {
					location = "/changePw";
				}
			});
			
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
    },
//비밀번호 변경
	changePw: function() {
    	let user = {
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
			url: "/changePw",
			data: JSON.stringify(user),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				text: response.data,
				iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				confirmButtonColor: '#007bff',
			}).then((result) => {
				if (response.status === 200 && result.isConfirmed) {
					location = "/login";
				}
			});
			
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
    },
    
    //아이디 유효성 검사 함수 추가
    isValiduserId: function(userId) {
		const userIdRegex = /^[a-zA-Z0-9]{5,}$/; // 5글자 이상, 공백 허용 안함, 한글 허용 안함
		return userIdRegex.test(userId);
	},
    
    //비밀번호 유효성 검사 함수 추가
    isValiduserPw: function(userPw) {
		const userPwRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[a-z\d@$!%*?&]{8,}$/; // 8자 이상,영문자,숫자,특수문자 포함, 공백 허용 안함
		return userPwRegex.test(userPw);
	},
	
	//사번 유효성 검사 함수 추가
	isValiduserNum: function(userNum) {
		const userNumRegex = /^\d{8}$/; // 8자리 숫자
		return userNumRegex.test(userNum);
	},
	
	//이름 유효성 검사 함수 추가
	isValiduserName: function(userName) {
		const userNameRegex =  /^[가-힣a-zA-Z_]+$/; // 1글자 이상, 공백/특수문자/숫자 허용 안함, 한글 허용
		return userNameRegex.test(userName);
	},
	
	//주소상세 유효성 검사 함수 추가
	isValiduserAddrDetail: function(userAddrDetail) {
		const userAddrDetailRegex = /^\S.*$/; // 1글자 이상, 공백 허용, 공백만 입력은 불가
		return userAddrDetailRegex.test(userAddrDetail);
	},
    
    //휴대전화번호 유효성 검사 함수 추가
    isValiduserMobile: function(userMobile) {
		const userMobileRegex = /^\d{11}$/; //11자리 숫자
		return userMobileRegex.test(userMobile);
	},
    
	//외부 이메일 유효성 검사 함수 추가
	isValiduserEmailEx: function(userEmailEx) {
		//간단한 이메일 형식 정규식을 사용하여 유효성을 검사
		const userEmailExRegex = /^\S+@\S+\.\S+$/;
		return userEmailExRegex.test(userEmailEx);
	}
	
	
};

certification.init();