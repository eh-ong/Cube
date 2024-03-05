let project = {
    init: function() {
        let _this = this;
        $("#btn-savePr").on("click", () => {
            _this.savePr();
        });
        $("#btn-updatePr").on("click", () => {
            _this.updatePr();
        });
        $("#btn-completePr").on("click", () => {
            _this.completePr();
        });
        $("#btn-terminatePr").on("click", () => {
            _this.terminatePr();
        });
        $("#btn-savePrProgress").on("click", () => {
            _this.savePrProgress();
        });
        $("#btn-updatePrProgress").on("click", function() {
            let prProgressId = $(this).data("prp-id");  
            _this.updatePrProgress(prProgressId);
        });	
         $("#btn-deletePrProgress").on("click", () => {
            _this.deletePrProgress();
        });

    },

    savePr: function() {
        let project = {
            projectTitle: $("#projectTitle").val(),
            projectStartDate: $("#projectStartDate").val(),
            projectEndDate: $("#projectEndDate").val(),
            projectCost: $("#projectCost").val(),
            projectContent: $("#projectContent").val()
            /*projectFile: $("#projectFile").val()*/
        }

        let usersNumStr = $("#usersNumStr").val()
		if(usersNumStr ==="" || usersNumStr === null) {
			usersNumStr = "-";
		}
		
        if (project.projectTitle === "" || project.projectTitle === null) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "프로젝트명을 입력해 주세요."
            });
            return;
        }

        if (project.projectStartDate === "" || project.projectStartDate === null) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "시작일을 입력해 주세요."
            });
            return;
        }

        if (project.projectEndDate === "" || project.projectEndDate === null) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "종료일을 입력해 주세요."
            });
            return;
        }

        if (project.projectCost === "" || project.projectCost === null) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "비용을 입력해 주세요."
            });
            return;
        }

        if (project.projectContent === "" || project.projectContent === null) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "내용을 입력해 주세요."
            });
            return;
        }

        if (project.projectStartDate > project.projectEndDate) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "프로젝트 종료일은 시작일 이후여야 합니다."
            });
            return;
        }

        $.ajax({
            type: "POST",
            url: "/pr_saveNewPr/" + usersNumStr,
            data: JSON.stringify(project),
            contentType: "application/json; charset=utf-8"
        }).done(function(response) {
            console.log(response);
            Swal.fire({
                icon: response.status === 200 ? "success" : "error",
                iconColor: response.status === 200 ? '#007bff' : '#dc3545',
                confirmButtonColor: '#007bff',
                text: "새 프로젝트 저장 완료",
            }).then((result) => {
                if (response.status === 200 && result.isConfirmed) {
                    location = "/pr_detail/" + response.data;
                }
            });

        }).fail(function(error) {
            console.log(error);
            alert(error);
        });
    },
    
    updatePr: function() {
        let project = {
            projectId: $("#projectId").val(),
            projectTitle: $("#projectTitle").val(),
            projectStartDate: $("#projectStartDate").val(),
            projectEndDate: $("#projectEndDate").val(),
            projectCost: $("#projectCost").val(),
            projectContent: $("#projectContent").val()
            /*projectFile: $("#projectFile").val()*/
        }

        let deleteUsersNumStr = $("#deleteUsersNumStr").val()
        if(deleteUsersNumStr ==="" || deleteUsersNumStr === null) {
			deleteUsersNumStr = "-";
		}
        let usersNumStr = $("#usersNumStr").val()
        if(usersNumStr ==="" || usersNumStr === null) {
			usersNumStr = "-";
		}
		
        if (project.projectTitle === "" || project.projectTitle === null) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "프로젝트명을 입력해 주세요."
            });
            return;
        }

        if (project.projectStartDate === "" || project.projectStartDate === null) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "시작일을 입력해 주세요."
            });
            return;
        }

        if (project.projectEndDate === "" || project.projectEndDate === null) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "종료일을 입력해 주세요."
            });
            return;
        }

        if (project.projectCost === "" || project.projectCost === null) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "비용을 입력해 주세요."
            });
            return;
        }

        if (project.projectContent === "" || project.projectContent === null) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "내용을 입력해 주세요."
            });
            return;
        }

        if (project.projectStartDate > project.projectEndDate) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "프로젝트 종료일은 시작일 이후여야 합니다."
            });
            return;
        }

        $.ajax({
            type: "POST",
            url: "/pr_updatePr/" + deleteUsersNumStr + "/" + usersNumStr,
            data: JSON.stringify(project),
            contentType: "application/json; charset=utf-8"
        }).done(function(response) {
            console.log(response);
            Swal.fire({
                icon: response.status === 200 ? "success" : "error",
                iconColor: response.status === 200 ? '#007bff' : '#dc3545',
                confirmButtonColor: '#007bff',
                text: "새 프로젝트 저장 완료",
            }).then((result) => {
                if (response.status === 200 && result.isConfirmed) {
                    location = "/pr_detail/" + response.data;
                }
            });

        }).fail(function(error) {
            console.log(error);
            alert(error);
        });
    },
    
    completePr: function() {
		let project = {
	       projectId: $("#projectId").val(),            
        }
		Swal.fire({
				text: "완료 처리 하시겠습니까?",
				icon: "warning",
				iconColor: 'red',
				showCancelButton: true,
				confirmButtonColor: '#007bff',
				cancelButtonColor: "#d33",
				confirmButtonText: "확인",
				cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
		            type: "POST",
		            url: "/pr_completePr",
		            data: JSON.stringify(project),
		            contentType: "application/json; charset=utf-8"
		        }).done(function(response) {
		            console.log(response);
		            Swal.fire({
		                icon: response.status === 200 ? "success" : "error",
		                iconColor: response.status === 200 ? '#007bff' : '#dc3545',
		                confirmButtonColor: '#007bff',
		                text: "프로젝트가 완료되었습니다.",
		            }).then((result) => {
		                if (response.status === 200 && result.isConfirmed) {
		                    location = "/pr_detail/" + response.data;
		                }
		            });
		
		        }).fail(function(error) {
		            console.log(error);
		            alert(error);
		        });
			} else {
				location.reload();
			}
		});
           	
    },
    
    terminatePr: function() {
		let project = {
	       projectId: $("#projectId").val(),            
        }
		Swal.fire({
				text: "중단 처리 하시겠습니까?",
				icon: "warning",
				iconColor: 'red',
				showCancelButton: true,
				confirmButtonColor: '#007bff',
				cancelButtonColor: "#d33",
				confirmButtonText: "확인",
				cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
		            type: "POST",
		            url: "/pr_terminatePr",
		            data: JSON.stringify(project),
		            contentType: "application/json; charset=utf-8"
		        }).done(function(response) {
		            console.log(response);
		            Swal.fire({
		                icon: response.status === 200 ? "success" : "error",
		                iconColor: response.status === 200 ? '#007bff' : '#dc3545',
		                confirmButtonColor: '#007bff',
		                text: "프로젝트가 중단되었습니다.",
		            }).then((result) => {
		                if (response.status === 200 && result.isConfirmed) {
		                    location = "/pr_detail/" + response.data;
		                }
		            });
		
		        }).fail(function(error) {
		            console.log(error);
		            alert(error);
		        });
			} else {
				location.reload();
			}
		});
           	
    },
    
    savePrProgress: function() {
        let prProgress = {
            prProgressContent: $("#prProgressContent").val()
            
        }
		let projectId = $("#projectId").val()
		
        if (prProgress.prProgressContent === "" || prProgress.prProgressContent === null) {
            Swal.fire({
                icon: "error",
                confirmButtonColor: '#007bff',
                text: "진행사황 내용을 입력해 주세요."
            });
            return;
        }
        $.ajax({
            type: "POST",
            url: "/pr_savePrProgress/" + projectId,
            data: JSON.stringify(prProgress),
            contentType: "application/json; charset=utf-8"
        }).done(function(response) {
            console.log(response);
            Swal.fire({
                icon: response.status === 200 ? "success" : "error",
                iconColor: response.status === 200 ? '#007bff' : '#dc3545',
                confirmButtonColor: '#007bff',
                text: "진행사항 저장 완료",
            }).then((result) => {
                if (response.status === 200 && result.isConfirmed) {
                    location = "/pr_detail/" + response.data;
                }
            });

        }).fail(function(error) {
            console.log(error);
            alert(error);
        });
    },
    
    updatePrProgress: function(prProgressId) {
		let projectId = $("#projectId").val()            
        
        let prProgress = {
			prProgressId: prProgressId,
			prProgressContent: $("#prpContent").val()
		}
		
		Swal.fire({
				text: "진행사항을 수정 하시겠습니까?",
				icon: "warning",
				iconColor: 'red',
				showCancelButton: true,
				confirmButtonColor: '#007bff',
				cancelButtonColor: "#d33",
				confirmButtonText: "확인",
				cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
		            type: "POST",
		            url: "/pr_updatePrProgress/" + projectId,
		            data: JSON.stringify(prProgress),
		            contentType: "application/json; charset=utf-8"
		        }).done(function(response) {
		            console.log(response);
		            Swal.fire({
		                icon: response.status === 200 ? "success" : "error",
		                iconColor: response.status === 200 ? '#007bff' : '#dc3545',
		                confirmButtonColor: '#007bff',
		                text: "수정 완료되었습니다.",
		            }).then((result) => {
		                if (response.status === 200 && result.isConfirmed) {
		                    location = "/pr_detail/" + response.data;
		                }
		            });
		
		        }).fail(function(error) {
		            console.log(error);
		            alert(error);
		        });
			} else {
				location.reload();
			}
		});
           	
    },
    
    deletePrProgress: function() {
		let projectId = $("#projectId").val()            
        
        let prProgress = {
			prProgressId: $("#prProgressId").val()
		}
		Swal.fire({
				text: "진행사항을 삭제 하시겠습니까?",
				icon: "warning",
				iconColor: 'red',
				showCancelButton: true,
				confirmButtonColor: '#007bff',
				cancelButtonColor: "#d33",
				confirmButtonText: "확인",
				cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
		            type: "POST",
		            url: "/pr_deletePrProgress/" + projectId,
		            data: JSON.stringify(prProgress),
		            contentType: "application/json; charset=utf-8"
		        }).done(function(response) {
		            console.log(response);
		            Swal.fire({
		                icon: response.status === 200 ? "success" : "error",
		                iconColor: response.status === 200 ? '#007bff' : '#dc3545',
		                confirmButtonColor: '#007bff',
		                text: "삭제가 완료되었습니다.",
		            }).then((result) => {
		                if (response.status === 200 && result.isConfirmed) {
		                    location = "/pr_detail/" + response.data;
		                }
		            });
		
		        }).fail(function(error) {
		            console.log(error);
		            alert(error);
		        });
			} else {
				location.reload();
			}
		});
           	
    },


};

project.init();