

let mailSearchObject = {

	init: function() {
		let _this = this;

		$("#btn-search").on("click", () => {
			_this.search();
		});

	},

	search: function() {
      alert("검색 요청")
      
      let mailType = $("#mailType").val();
	  let searchType = $("#searchType").val();
	  let searchInput = $("#searchInput").val();
	 		

		$.ajax({
			type: "GET",
			url: "/mail_main/"+mailType+"/"+searchType+"/"+searchInput,
		}).done(function(response) {
			console.log(response);
			alert("검색 완료")
			location = "/mail_main/"+mailType+"/"+searchType+"/"+searchInput;
			
		}).fail(function(error) {
			console.error(error);
			alert(error);
		});
	},
}
mailSearchObject.init();