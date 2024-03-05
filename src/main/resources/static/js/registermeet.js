let revObject = {
    init: function() {
        let _this = this;

        $("#btn-insert").on("click", () => {
            _this.insertRev();
        });
    },

    insertRev: function() {
        let mrName = $("#mrName").val();
        let mrLocation = $("#mrLocation").val();

        let reservation = {
            mrName: mrName,
            mrLocation: mrLocation,
        };

        // 예약 요청 보내기
        $.ajax({
            type: "POST",
            url: "/meetRegister",
            data: JSON.stringify(reservation),
            contentType: "application/json; charset=utf-8"
        }).done(function(response) {
            // 성공 시
            alert("등록완료!");
            console.log(response);
            location.href = "/myRevpage"; // location 변경 시 올바른 방법으로 변경
        }).fail(function(jqXHR, textStatus, errorThrown) {
            // 실패 시
            alert("등록실패: " + textStatus); // 오류 메시지 출력
            console.log(jqXHR); // jqXHR 객체 로깅
            console.log(errorThrown); // 오류 원인 로깅
        });
    }
};

revObject.init(); // revObject 초기화
