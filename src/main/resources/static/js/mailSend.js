

let mailSendObject = {

	init: function() {
		let _this = this;

		$("#btn-mailSend").on("click", () => {
			_this.mailSend();
		});

	},

	mailSend: function() {
		let SendMail = {
			sendMailSenderEmail: $("#mailSenderEmail").val(),
			sendMailReceiverEmail: $("#mailReceiverEmail").val(),
			sendMailTitle: $("#mailTitle").val(),
			sendMailContent: $("#mailContent").val(),
			sendMailReservationDate: $("#sendMailReservationDate").val()
		}
		if (SendMail.sendMailReceiverEmail.trim() === "") {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "수신자를 입력해주세요"
			});
			return;
		}
		if (SendMail.sendMailTitle.trim() === "") {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "제목을 입력해주세요"
			});
			return;
		}
		if (SendMail.sendMailContent.trim() === "") {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "내용을 입력해주세요"
			});
			return;
		}
		



		$.ajax({
			type: "POST",
			url: "/mail_send",
			data: JSON.stringify(SendMail),
			contentType: "application/json; charset=utf-8"
		}).done(function(response) {
			console.log(response);
			Swal.fire({
					icon: "success",
					iconColor: '#007bff',
					confirmButtonColor: '#007bff',
					text: '메일을 보냈습니다.',
					showCloseButton: true
				}).then((result) => {
					if (result.isConfirmed) {
						location="/mailPage";
					}
				});


		}).fail(function(error) {
			console.error(error);
			alert("메일 보내기 실패")
		});
	},
}
mailSendObject.init();