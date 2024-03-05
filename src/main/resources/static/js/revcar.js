let selectedValue; // 선택된 차량 번호를 저장할 변수

let carRevObject = {
	init: function() {
		let _this = this;

		$("#btn-insert").on("click", () => {
			_this.insertCarRev();
		});

		$("#btn-update").on("click", () => {
			_this.updateCarRev();
		});

		$(".btn-delete").on("click", function() {
			let creId = $(this).closest("tr").find(".creId").val();
			_this.deleteCarRev(creId);
		});

		$("#creNum").change(function() {
			selectedValue = $(this).val();
		});

		$("#btn-writer").on("click", () => {
			_this.writerdiary();
		});

		_this.sortReservationsByDate(); // 날짜를 기준으로 예약 목록 정렬
	},

	sortReservationsByDate: function() {
		// 예약 목록을 날짜 기준으로 정렬
		let rows = $("table tbody tr").get();
		rows.sort(function(a, b) {
			let dateA = new Date($(a).find("td").eq(4).text());
			let dateB = new Date($(b).find("td").eq(4).text());
			return dateA - dateB;
		});
		// 테이블에 정렬된 행 적용
		$.each(rows, function(index, row) {
			$("table").children("tbody").append(row);
		});
	},

	insertCarRev: function() {
		let creStart = $("#creStart").val();
		let creEnd = $("#creEnd").val();
		let creCount = $("#creCount").val();
		let creNum = selectedValue; // 선택된 차량의 값
		let creDate = $("#creDate").val();

    // 필수 입력 필드가 비어 있는지 확인
    if (!creStart || !creEnd || !creNum || !creDate || !creCount) {
        Swal.fire({
            icon: 'error',
            text: '모든 필수 입력 항목을 작성해주세요.',
            confirmButtonColor: '#007bff'
        });
        return; // 예약 등록 중단
    }

		// creCount가 숫자가 아닌 경우 알림창 표시
		if (isNaN(creCount)) {
			Swal.fire({
				icon: 'error',
				title: '입력 오류',
				text: '탑승 인원은 숫자로 입력해주세요.',
				confirmButtonColor: '#007bff'
			});
			return; // 예약 등록 중단
		}

		// 예약 요청 보내기 전에 이미 있는 예약과 겹치는지 확인
		// 겹치는 예약이 있는 경우 예약 등록 중단
		if (this.checkReservationOverlap(new Date(creDate + " " + creStart), new Date(creDate + " " + creEnd), creDate)) {
			Swal.fire({
				icon: 'error',
				title: '예약 실패',
				text: '이미 해당 시간대에 예약이 있습니다.',
				confirmButtonColor: '#007bff'
			});
			return;
		}

		// 시작 시간과 종료 시간을 JavaScript Date 객체로 변환
		let startTime = new Date(creDate + " " + creStart);
		let endTime = new Date(creDate + " " + creEnd);

		// 시작 시간이 종료 시간보다 이후인지 확인
		if (startTime >= endTime) {
			Swal.fire({
				icon: 'error',
				title: '시간기입 오류',
				text: '시작 시간은 종료 시간보다 이전이어야 합니다.',
				confirmButtonColor: '#007bff'
			});
			return; // 예약 등록 중단
		}

		let reservation = {
			creStart: creStart,
			creEnd: creEnd,
			creCount: creCount,
			creDate: creDate
		}

		// 예약 요청 보내기
		$.ajax({
			type: "POST",
			url: "/insertCar/" + creNum,
			data: JSON.stringify(reservation),
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
					location = "/myRevpage";//메인페이지로 이동 => index.jsp 메인페이지
				}
			});
		}).fail(function(error) {
			Swal.fire({
				icon: 'error',
				title: '예약 실패',
				text: '예약을 처리하는 동안 오류가 발생했습니다: ' + error,
				confirmButtonColor: '#007bff'
			});
		});
	},




	updateCarRev: function() {
		// 예약 ID를 가져옴
		let creId = $("#creId").val();
		let creDate = $("#creDate").val();
		let creStart = $("#creStart").val(); // 시작 시간을 선택한 값 그대로 가져옴
		let creEnd = $("#creEnd").val();

		// 필수 입력 필드가 비어 있는지 확인
		if (!creStart || !creEnd || !creDate) {
			Swal.fire({
				icon: 'error',
				title: '항목 미선택',
				text: '시작 시간, 종료 시간, 날짜, 차량 모두 선택해주세요.',
				confirmButtonColor: '#007bff'
			});
			return; // 예약 등록 중단
		}

		// 시작 시간과 종료 시간을 JavaScript Date 객체로 변환
		let startTime = new Date(creDate + " " + creStart);
		let endTime = new Date(creDate + " " + creEnd);

		// 시작 시간이 종료 시간보다 이후인지 확인
		if (startTime >= endTime) {
			Swal.fire({
				icon: 'error',
				title: '시간 기입 오류',
				text: '시작 시간은 종료 시간보다 이전이어야 합니다.',
				confirmButtonColor: '#007bff'
			});
			return; // 예약 변경 중단
		}

		// 예약 요청 보내기 전에 이미 있는 예약과 겹치는지 확인
		// 겹치는 예약이 있는 경우 예약 변경 중단
		if (this.checkReservationOverlap(startTime, endTime, creDate, creId)) {
			Swal.fire({
				icon: 'error',
				title: '예약 실패',
				text: '해당 시간대에 이미 예약이 있습니다.',
				confirmButtonColor: '#007bff'
			});
			return;
		}

		let creNum = selectedValue;
		let reservation = {
			creId: creId, // 예약 ID 설정
			creStart: creStart, // 시작 시간
			creEnd: creEnd,
			creDate: creDate
		}

		// 예약 요청 보내기
		$.ajax({
			type: "POST",
			url: "/updateCar/" + creNum,
			data: JSON.stringify(reservation),
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
					location = "/myRevpage"; //메인페이지로 이동 => index.jsp 메인페이지
				}
			});
		}).fail(function(error) {
			Swal.fire({
				icon: 'error',
				title: '예약 실패',
				text: '예약을 처리하는 동안 오류가 발생했습니다.',
				confirmButtonColor: '#007bff'
			});
		});
	},


	deleteCarRev: function(creId) {
		// 사용자에게 확인을 요청하는 간단한 확인 창을 표시
		if (confirm('정말로 예약을 삭제하시겠습니까?')) {
			// 사용자가 확인을 클릭한 경우에만 예약 삭제를 시도합니다.
			$.ajax({
				type: "DELETE",
				url: "/deleteCar/" + creId
			}).done(function(response) {
				// 예약 삭제 성공 시 메시지를 표시하고 페이지를 새로고침합니다.
				alert('예약이 삭제되었습니다.');
				location.reload(); // 페이지 새로고침
			}).fail(function(error) {
				// 예약 삭제 실패 시 에러 메시지를 표시합니다.
				alert('예약 삭제에 실패했습니다: ' + error);
			});
		}
	},
	
	
	checkReservationOverlap: function(startTime, endTime, creDate, currentReservationId) {
		// 예약 목록에서 시작 시간과 종료 시간, 예약 날짜를 비교하여 겹치는 예약이 있는지 확인
		let overlapping = false;
		$("table tbody tr").each(function() {
			let rowStartDate = new Date(creDate + " " + $(this).find("td").eq(4).text());
			let rowEndDate = new Date(creDate + " " + $(this).find("td").eq(5).text());
			let rowReservationId = $(this).find(".creId").val();

			// 현재 예약 ID와 동일한 예약은 중복 비교에서 제외
			if (currentReservationId && currentReservationId === rowReservationId) {
				return; // 다음 순회로 넘어감
			}

			if ((startTime >= rowStartDate && startTime < rowEndDate) ||
				(endTime > rowStartDate && endTime <= rowEndDate) ||
				(startTime <= rowStartDate && endTime >= rowEndDate)) {
				overlapping = true;
				return false; // 중복된 예약이 있음을 표시하고 루프 종료
			}
		});
		return overlapping;
	}
};

$(document).ready(function() {
	carRevObject.init(); // carRevObject 초기화
});
