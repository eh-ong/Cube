let revObject = {
    init: function() {
        let _this = this;

        $("#btn-insert").on("click", () => {
            _this.insertRev();
        });
        
        $("#btn-insert2").on("click", () => {
            _this.insertCar();
        });
    },

    insertRev: function() {
        let mrName = $("#mrName").val();
        let mrLocation = $("#mrLocation").val();
        let mrCapacity = $("#mrCapacity").val();

        // 필수 입력 필드가 비어 있는지 확인
        if (!mrName || !mrLocation || !mrCapacity ) {
            Swal.fire({
                icon: 'error',
                text: '모든 필수 입력 항목을 작성해주세요.',
                confirmButtonColor: '#007bff'
            });
            return; // 예약 등록 중단
        }
        
        let reservation = {
            mrName: mrName,
            mrLocation: mrLocation,
            mrCapacity: mrCapacity,
        };

        // 예약 요청 보내기
        $.ajax({
            type: "POST",
            url: "/meetRegister",
            data: JSON.stringify(reservation),
            contentType: "application/json; charset=utf-8"
        }).done(function(response) {
            // 성공 시
            Swal.fire({
                icon: response.status === 200 ? "success" : "error",
                text: '등록 완료!',
                iconColor: response.status === 200 ? '#007bff' : '#dc3545',
				showCloseButton: true,
				confirmButtonColor: '#007bff',
            }).then((result) => {
            if (response.status === 200 && result.isConfirmed) {
                location = "/myRevpage";//메인페이지로 이동 => index.jsp 메인페이지
            }
        });
        }).fail(function(error){
            // 실패 시
            Swal.fire({
                icon: 'error',
                text: '등록 실패: ' + error,
                confirmButtonColor: '#007bff'
            });
        });
    },
    
    insertCar: function() {
        let carName = $("#carName").val();
        let carNum = $("#carNum").val();
        let carCapacity = $("#carCapacity").val();

        // 필수 입력 필드가 비어 있는지 확인
        if (!carName || !carNum || !carCapacity) {
            Swal.fire({
                icon: 'error',
                text: '모든 필수 입력 항목을 작성해주세요.',
                confirmButtonColor: '#007bff'
            });
            return; // 예약 등록 중단
        }

        let putCar = {
            carName: carName,
            carNum : carNum,
            carCapacity : carCapacity,
        };

        // 예약 요청 보내기
        $.ajax({
            type: "POST",
            url: "/carRegister",
            data: JSON.stringify(putCar),
            contentType: "application/json; charset=utf-8"
        }).done(function(response) {
            // 성공 시
            Swal.fire({
                icon: 'success',
                text: '등록 완료!',
                confirmButtonColor: '#007bff'
            }).then(() => {
                location = "/myRevpage"; 
            });
        }).fail(function(error){
            // 실패 시
            Swal.fire({
                icon: 'error',
                text: '예약 실패: ' + error,
                confirmButtonColor: '#007bff'
            });
        });
    },
};

revObject.init(); // revObject 초기화
