let selectedValue; // 이 부분 추가

let revObject = {
	init: function() {
		let _this = this;

		$("#btn-insert").on("click", () => {
			_this.insertRev();
		});

		$("#btn-update").on("click", () => {
			_this.updateRev();
		});

		$(".btn-delete").on("click", function() {
			let reId = $(this).closest("tr").find(".reId").val();
			_this.deleteRev(reId);
		});

		$("#mrSelect").change(function() {
			selectedValue = $(this).val();
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



insertRev: function() {
    let reStart = $("#reStart").val();
    let reEnd = $("#reEnd").val();
    let reCount = $("#reCount").val(); // 입력된 참석 인원
    let reNum = selectedValue; // 선택된 회의실의 값
    let reDate = $("#selectedDate").val();

    // 필수 입력 필드가 비어 있는지 확인
    if (!reStart || !reEnd || !reNum || !reDate || !reCount) {
        Swal.fire({
            icon: 'error',
            text: '모든 필수 입력 항목을 작성해주세요.',
            confirmButtonColor: '#007bff'
        });
        return; // 예약 등록 중단
    }

    // reCount가 숫자가 아닌 경우 알림창 표시
    if (isNaN(reCount)) {
        Swal.fire({
            icon: 'error',
            text: '참석 인원은 숫자로 입력해주세요.',
            confirmButtonColor: '#007bff'
        });
        return; // 예약 등록 중단
    }

    // 시작 시간과 종료 시간을 JavaScript Date 객체로 변환
    let startTime = new Date(reDate + " " + reStart);
    let endTime = new Date(reDate + " " + reEnd);

    // 시작 시간이 종료 시간보다 이후인지 확인
    if (startTime >= endTime) {
        Swal.fire({
            icon: 'error',
            text: '시작 시간은 종료 시간보다 이전이어야 합니다.',
            confirmButtonColor: '#007bff'
        });
        return; // 예약 등록 중단
    }

    let reservation = {
        reStart: reStart,
        reEnd: reEnd,
        reCount: reCount, // 수정된 부분: reCount를 reservation 객체에 추가
        reDate: reDate
    }

    // 예약 요청 보내기
    $.ajax({
        type: "POST",
        url: "/insertRev/" + reNum,
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
        alert("예약 실패: " + error);
    });
},



	updateRev: function() {
		// 예약 ID를 가져옴
		let reId = $("#reId").val();
		let reDate = $("#selectedDate").val(); // 이 부분 수정
		let reStart = $("#reStart").val(); // 시작 시간을 선택한 값 그대로 가져옴
		let reEnd = $("#reEnd").val();

		// 필수 입력 필드가 비어 있는지 확인
		if (!reStart || !reEnd || !reDate || !reId) {
			Swal.fire({
				icon: 'error',
				title: '예약 실패',
				text: '시작 시간, 종료 시간, 날짜, 회의실을 선택해주세요.',
				confirmButtonColor: '#007bff'
			});
			return; // 예약 등록 중단
		}

		// 시작 시간과 종료 시간을 JavaScript Date 객체로 변환
		let startTime = new Date(reDate + " " + reStart);
		let endTime = new Date(reDate + " " + reEnd);

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
		if (this.checkReservationOverlap(startTime, endTime, reDate, reId)) {
			Swal.fire({
				icon: 'error',
				title: '예약 실패',
				text: '해당 시간대에 이미 예약이 있습니다.',
				confirmButtonColor: '#007bff'
			});
			return;
		}

		let reNum = selectedValue;
		let reservation = {
			reId: reId, // 예약 ID 설정
			reStart: reStart, // 시작 시간
			reEnd: reEnd,
			reDate: reDate
		}

		// 예약 요청 보내기
		$.ajax({
			type: "POST",
			url: "/updateRev/" + reNum,
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



deleteRev: function(reId) {
    // 사용자에게 확인 여부를 묻는 알림창 표시
    if (confirm('정말로 예약을 취소하시겠습니까?')) {
        $.ajax({
            type: "DELETE",
            url: "/deleteRev/" + reId
        }).done(function(response) {
            // 예약 삭제 완료 알림 표시
            alert('예약이 성공적으로 취소되었습니다.');
            // 페이지 새로고침
            location = "/myRevpage";
        }).fail(function(error) {
            // 예약 삭제 실패 알림 표시
            alert('예약 취소에 실패했습니다: ' + error);
        });
    }
},



	checkReservationOverlap: function(startTime, endTime, reDate, currentReservationId) {
		// 예약 목록에서 시작 시간과 종료 시간, 예약 날짜를 비교하여 겹치는 예약이 있는지 확인
		let overlapping = false;
		$("table tbody tr").each(function() {
			let rowStartDate = new Date(reDate + " " + $(this).find("td").eq(4).text());
			let rowEndDate = new Date(reDate + " " + $(this).find("td").eq(5).text());
			let rowReservationId = $(this).find(".reId").val();

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
	revObject.init(); // revObject 초기화
});
