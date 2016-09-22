$(document).ready(
			function() {
				$("#task-status").click(
						function(event) {
							var taskid = $('#taskid').val();
							$.ajax({
								url : "/tracker/application/updateStatus/",
								data : {
									"taskid" : taskid
								},
								type : "POST",
								success : function(res) {
									if (res) {
										console.log(res);
										$('#task-status').hide();
										$('#completedstatus').find('span')
												.text('Completed');
										$('#completedstatus').show();

									} else {
										console.log(res);
									}
								}
							});
						});

				$("#comments").keypress(
						function(event) {
							console.log(event.which);
							console.log($(this).val());
							if (event.which == 13) {

								//var userid = $('#userid').val();
								var taskid = $('#taskid').val();
								var comments = $('#comments').val();
								var userid = $('#userid').val();
								$.ajax({
									url : "/tracker/application/addComments/",
									data : {
										"taskid" : taskid,
										"comments" : comments
									},
									type : "POST",

									/* beforeSend : function(xhr) {
										xhr.setRequestHeader("Accept",
												"application/json");
										xhr.setRequestHeader("Content-Type",
												"application/json");
									}, */

									success : function(res) {
										if (res) {
											console.log(res);
											var content = "<P><b>"
													+ "${sessionScope.userid}"
													+ "</b> : " + comments
													+ "</P>";
											$('#commentSection')
													.append(content);
											$('#comments').val("");

										} else {
											console.log(res);
										}
									}
								});
							}
						});

				$('#task-status').hover(
						function() {
							$(this).find('span').text('Mark as Complete');
						},
						function() {
							$(this).find('span').text($('#taskStatus').val());
						});
				$('#task-edit').hide();
				$('#editTaskAlert').hide();
				$('#completedstatus').hide();
				$(function() {
					$("#starttime").datepicker();
				});
				$(function() {
					$("#endtime").datepicker();
				});
			});
	function openEditDiv() {
		//edit-btn task-details task-edit
		var elmnt = document.getElementById("edit-btn");
		var x = elmnt.value;
		if (x === "sedittask") {
			document.getElementById("task-details").style.display = "none";
			document.getElementById("task-edit").style.display = "block";
			//document.getElementById("create-task").innerHTML = "Hide";
			document.getElementById("edit-btn").value = "hedittask";
			//console.log(document.getElementById("cbutton").value);
			//changing the format of starttime and endtime
			document.getElementById("starttime").value = moment(
					document.getElementById("starttime").value).format(
					'MM/DD/YYYY');
			document.getElementById("endtime").value = moment(
					document.getElementById("endtime").value).format(
					'MM/DD/YYYY');
			document.getElementById("edit-btn").children[0].className = "glyphicon glyphicon-remove";
		}
		if (x === "hedittask") {
			document.getElementById("task-edit").style.display = "none";
			document.getElementById("task-details").style.display = "block";
			document.getElementById("edit-btn").value = "sedittask";
			document.getElementById("edit-btn").children[0].className = "glyphicon glyphicon-edit";
		}
	}
	function validatetaskDetails() {
		if (moment(document.getElementById("starttime").value).isAfter(
				document.getElementById("endtime").value)) {
			document.getElementById("editTaskAlert").innerHTML = "Start-Date cannot be greater than End-Date";
			$("#editTaskAlert").show();
			return false;
		}
	}