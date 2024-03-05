$(document).ready(function() {

	$('#save').click(function() {
		save();
	});

	$('#saveAll').click(function() {
		saveAll();
	});

	$('#ot_insert').click(function() {
		otInsert();
	});

	$('#ot_end').click(function() {
		otEnd();
	});

	$('#insertVa').click(function() {
		insertVa();
	});

	$('.vaCancle').click(function() {
		let vaId = $(this).closest('tr').find('#vaId').val();
		let vaStatus = $(this).closest('tr').find('#vaStatus').val();
		vaCancle(vaId, vaStatus);
	});

	$('.appbtn').click(function() {
		let attId = $(this).closest('tr').find('#attId').val();
		approve(attId);
	});

	$('.rejectbtn').click(function() {
		let attId = $(this).closest('tr').find('#attId').val();
		reject(attId);
	});

	$('.APappbtn').click(function() {
		let apId = $(this).closest('tr').find('#apId').val();
		APapprove(apId);
	});

	$('.APrejectbtn').click(function() {
		let apId = $(this).closest('tr').find('#apId').val();
		APreject(apId);
	});

	function save() {
		var data = [];

		$('tbody #attTr').each(function() {
			var apId = $(this).find('#apId').val();
			var apDate = $(this).find('td:eq(0)').text();
			var apStart = $(this).find('.attStartTime').text();
			var apEnd = $(this).find('.attEndTime').text();
			var apType = $(this).find('#attApType').val();

			apStart = (apStart === '-') ? null : apStart;
			apEnd = (apEnd === '-') ? null : apEnd;

			data.push({
				apId: apId,
				apDate: apDate,
				apStart: apStart,
				apEnd: apEnd,
				apType: apType
			});
		});

		$.ajax({
			type: 'POST',
			url: '/attplanUpdate',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify(data),
			success: function(response) {
				Swal.fire({
					icon: "success",
					iconColor: '#007bff',
					confirmButtonColor: '#007bff',
					text: '근태계획이 등록되었습니다.',
					showCloseButton: true
				}).then((result) => {
					if (result.isConfirmed) {
						location.reload();
					}
				});
			},
			error: function(error) {
				alert('오류가 발생했습니다.', error);
			}
		});
	}

	function otInsert() {
		let otDes = $('#otDes').val();
		var otDesValue = $("#otDes").val();
		if (otDesValue.trim() === "") {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "초과근무 사유를 입력해주세요"
			});
			return;
		}
		$.ajax({
			type: 'POST',
			url: '/otInsert',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify(otDes),
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
					location.reload();
				}
			});

		}).fail(function(error) {
			console.log(error);
			alert('에러');
		});
	}

	function otEnd() {
		let att = {
			attOtStart: $('#otstart').val(),
			attOtEnd: $('#otend').val()
		}

		$.ajax({
			type: 'POST',
			url: '/otEnd',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify(att),
		}).done(function(response) {
			let message = response["data"];
			Swal.fire({
				icon: "success",
				iconColor: '#007bff',
				confirmButtonColor: '#007bff',
				text: message
			}).then((result) => {
				if (result.isConfirmed) {
					location = "/att_Ot_FindPage";
				}
			});

		}).fail(function(error) {
			console.log(error);
			alert('에러');
		});
	}

	function insertVa() {
		let va = {
			vaStartDate: $('#startDate').val(),
			vaEndDate: $('#endDate').val(),
			vaDes: $('#vaDes').val(),
			vaDesValue: $('#vaDes').val()
		}
		if (va.vaDesValue.trim() === "") {
			Swal.fire({
				icon: "error",
				confirmButtonColor: '#007bff',
				text: "휴가 사유를 입력해주세요"
			});
			return;
		}
		var selectedOptions = [];
		var startDate = new Date(va.vaStartDate);
		var endDate = new Date(va.vaEndDate);
		while (startDate <= endDate) {
			var option = $('input[name="radioGroup' + startDate.getTime() + '"]:checked').val();
			selectedOptions.push(option);
			startDate.setDate(startDate.getDate() + 1);
		}
		var vaStr = selectedOptions.join(',');
		va.vaType = vaStr;

		$.ajax({
			type: 'POST',
			url: '/insertVacation',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify(va),
		}).done(function(response) {
			let message = response["data"];
			Swal.fire({
				icon: response.status === 200 ? "success" : "error",
				iconColor: '#007bff',
				confirmButtonColor: '#007bff',
				text: message
			}).then((result) => {
				if (result.isConfirmed) {
					if (response.status === 200) {
						location = "/att_Va_FindPage";
					} else {
						location = "/att_Va_InsertPage"
					}
				}
			});

		}).fail(function(error) {
			console.log(error);
			alert('에러');
		});
	}

	function vaCancle(vaId, vaStatus) {

		if (vaStatus === '승인') {
			Swal.fire({
				title: "승인된 휴가 입니다.",
				text: "취소하시겠습니까?",
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
						type: 'DELETE',
						url: '/deleteVa/' + vaId,
						contentType: 'application/json;charset=UTF-8',
						data: JSON.stringify(),
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
								location.reload();
							}
						});

					}).fail(function(error) {
						console.log(error);
						alert('에러');
					});
				} else {
					location.reload();
				}
			});
		} else {
			Swal.fire({
				title: "휴가 취소",
				text: "휴가를 취소하시겠습니까?",
				icon: "warning",
				showCancelButton: true,
				confirmButtonColor: '#007bff',
				cancelButtonColor: "#d33",
				confirmButtonText: "확인",
				cancelButtonText: "취소"
			}).then((result) => {
				if (result.isConfirmed) {
					$.ajax({
						type: 'DELETE',
						url: '/deleteVa/' + vaId,
						contentType: 'application/json;charset=UTF-8',
						data: JSON.stringify(),
					}).done(function(response) {
						Swal.fire({
							text: "휴가를 취소하였습니다.",
							confirmButtonColor: '#007bff',
							iconColor: '#007bff',
							icon: "success"
						}).then((result) => {
							if (result.isConfirmed) {
								location = "/att_Va_FindPage";
							}
						});
					}).fail(function(error) {
						console.log(error);
						alert('에러');
					});
				} else {
					location.reload();
				}
			});
		}
	}


	$('#endDate').prop('disabled', true);
	$('#insertVa').prop('disabled', true);
	$('#startDate').change(function() {
		var startDate = new Date($('#startDate').val());
		$('#endDate').prop('disabled', false);
		$('#endDate').attr('min', startDate.toISOString().split('T')[0]);
	});

	$('#endDate').change(function() {
		var startDate = new Date($('#startDate').val());
		var endDate = new Date($('#endDate').val());
		$('#insertVa').prop('disabled', false);
		var day = calculateday(startDate, endDate);
		$('#calDate').text(day + '일');
		let dates = dateRange(startDate, endDate);
		$('#dateTable').empty();
		dates.forEach(date => {
			var tr = $('<tr>').addClass('hovertr').css('width', '100%');
			var dateTd = $('<td>').text(date.toISOString().split('T')[0]).css({
				'text-align': 'center',
				'white-space': 'nowrap'
			});

			var radioTd = $('<td>').css({
				'width': '100%',
				'text-align': 'center',
				'white-space': 'nowrap'
			});

			if (date.getDay() === 0 || date.getDay() === 6) {
				radioTd.text('주말').css('background-color', 'lightgrey');
			} else {
				var labels = ['연차', '공가', '오전반차', '오후반차'];
				for (var i = 0; i < labels.length; i++) {
					var radio = $('<input>').attr({
						'type': 'radio',
						'name': 'radioGroup' + date.getTime(),
						'id': 'radio' + i + date.getTime(),
						'value': labels[i]
					}).addClass('form-check-input ml-3');
					var label = $('<label>').attr('for', 'radio' + i + date.getTime()).text(labels[i]).addClass('form-check-label mr-3');
					var div = $('<div>').addClass('form-check form-check-inline');
					div.append(radio).append(label);
					radioTd.append(div);
				}
			}
			radioTd.find('input[value="연차"]').prop('checked', true);

			tr.append(dateTd).append(radioTd);
			$('#dateTable').append(tr);
		});
	});


	function dateRange(startDate, endDate) {
		let dates = [];
		let date = new Date(startDate);

		while (date <= endDate) {
			dates.push(new Date(date));
			date.setDate(date.getDate() + 1);
		}
		return dates;
	}
	function calculateday(startDate, endDate) {
		var days = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24)) + 1;
		var weekdays = 0;
		for (var i = 0; i < days; i++) {
			var currentDate = new Date(startDate);
			currentDate.setDate(startDate.getDate() + i);
			if (currentDate.getDay() !== 0 && currentDate.getDay() !== 6) {
				weekdays++;
			}
		}
		return weekdays;
	}

	function approve(attId) {
		Swal.fire({
			title: '근태를 승인하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#007bff',
			confirmButtonText: '승인',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type: 'PUT',
					url: '/approveAtt?attId=' + attId,
					contentType: 'application/json;charset=UTF-8',
				}).done(function(response) {
					Swal.fire({
						text: "근태를 승인하였습니다.",
						confirmButtonColor: '#007bff',
						iconColor: '#007bff',
						icon: "success"
					}).then((result) => {
						if (result.isConfirmed) {
							location.reload();
						}
					});
				}).fail(function(error) {
					console.log(error);
					alert('에러');
				});
			} else {
				location.reload();
			}
		});
	}

	function reject(attId) {
		Swal.fire({
			title: '근태를 반려하시겠습니까?',
			icon: 'warning',
			confirmButtonColor: 'red',
			showCancelButton: true,
			confirmButtonText: '반려',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type: 'PUT',
					url: '/rejectAtt?attId=' + attId,
					contentType: 'application/json;charset=UTF-8',
				}).done(function(response) {
					Swal.fire({
						text: "근태를 반려하였습니다.",
						confirmButtonColor: '#007bff',
						iconColor: 'red',
						icon: "success"
					}).then((result) => {
						if (result.isConfirmed) {
							location.reload();
						}
					});
				}).fail(function(error) {
					console.log(error);
					alert('에러');
				});
			} else {
				location.reload();
			}
		});
	}

	function APapprove(apId) {
		Swal.fire({
			title: '근태계획을 승인하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#007bff',
			confirmButtonText: '승인',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type: 'PUT',
					url: '/approveAp?apId=' + apId,
					contentType: 'application/json;charset=UTF-8',
				}).done(function(response) {
					Swal.fire({
						text: "근태계획을 승인하였습니다.",
						confirmButtonColor: '#007bff',
						iconColor: '#007bff',
						icon: "success"
					}).then((result) => {
						if (result.isConfirmed) {
							location.reload();
						}
					});
				}).fail(function(error) {
					console.log(error);
					alert('에러');
				});
			} else {
				location.reload();
			}
		});
	}

	function APreject(apId) {
		Swal.fire({
			title: '근태계획을 반려하시겠습니까?',
			icon: 'warning',
			confirmButtonColor: 'red',
			showCancelButton: true,
			confirmButtonText: '반려',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type: 'PUT',
					url: '/rejectAp?apId=' + apId,
					contentType: 'application/json;charset=UTF-8',
				}).done(function(response) {
					Swal.fire({
						text: "근태계획을 반려하였습니다.",
						confirmButtonColor: '#007bff',
						iconColor: 'red',
						icon: "success"
					}).then((result) => {
						if (result.isConfirmed) {
							location.reload();
						}
					});
				}).fail(function(error) {
					console.log(error);
					alert('에러');
				});
			} else {
				location.reload();
			}
		});
	}

	function saveAll() {
		var data = [];
		$('tbody #apTr').each(function() {
			var apId = $(this).find('#apId').val();
			var apStatus = $(this).find('#apStatus').val();
			var isApproveDisabled = $(this).find('.APappbtn').prop('disabled');
			var isRejectDisabled = $(this).find('.APrejectbtn').prop('disabled');
			if (!isApproveDisabled || !isRejectDisabled) {
				data.push({
					apId: apId,
					apStatus: apStatus
				});
			}
		});

		Swal.fire({
			title: '전체 근태계획을 승인하시겠습니까?',
			text: '승인/반려 할 수 없는 날은 제외됩니다.',
			icon: 'info',
			showCancelButton: true,
			confirmButtonColor: '#007bff',
			confirmButtonText: '승인',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type: 'POST',
					url: '/apSaveAll',
					contentType: 'application/json;charset=UTF-8',
					data: JSON.stringify(data),
					success: function(response) {
						Swal.fire({
							icon: "success",
							iconColor: '#007bff',
							confirmButtonColor: '#007bff',
							text: '전체 근태계획을 승인하였습니다.',
							showCloseButton: true
						}).then((result) => {
							if (result.isConfirmed) {
								location.reload();
							}
						});
					},
					error: function(error) {
						alert('오류가 발생했습니다.', error);
					}
				});
			}
		});
	}
});