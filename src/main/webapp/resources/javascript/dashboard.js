$(document)
		.ready(
				function() {

					$('.editor_remove')
							.click(
									function(event) {
										var linkObj = $(this);
										var confirmed = confirm('Are you sure?');
										console.log(confirmed);

										if (confirmed) {
											console.log(linkObj.attr("href"));
											$
													.ajax({
														url : linkObj
																.attr("data-url"),
														type : "DELETE",

														beforeSend : function(
																xhr) {
															xhr
																	.setRequestHeader(
																			"Accept",
																			"application/json");
															xhr
																	.setRequestHeader(
																			"Content-Type",
																			"application/json");
														},

														success : function(res) {
															if (res) {
																linkObj
																		.closest(
																				"tr")
																		.remove();
															} else {
																$(
																		'#errorMessage')
																		.html(
																				showErrorMessage(
																						'alert-danger',
																						'Task cannot be deleted'));
															}
														}
													});
										}

									});
					$('#example').DataTable();
					$('#add-task').hide();
					$("#taskaddAlert").hide();
					$(function() {
						$("#starttime").datepicker();
					});
					$(function() {
						$("#endtime").datepicker();
					});
				});
function showErrorMessage(className, message) {
	var classes = 'alert ' + className;
	var content = "<div class='" + classes + "' role='alert'>" + message
			+ "<a href='#' class='close' id='add-task-close'>&times;</a></div>";
	return content;
}
function validatetaskDetails() {
	if (moment(document.getElementById("starttime").value).isAfter(
			document.getElementById("endtime").value)) {
		document.getElementById("taskaddAlert").innerHTML = "Start-Date cannot be greater than End-Date";
		$("#taskaddAlert").show();
		return false;
	}
}
function titleFormatting() {
	var taskName = document.getElementById("taskname");
	console.log(taskName.value);
	var taskTitle = taskName.value.split(" ");
	console.log(taskTitle);
	var titleCase = "";
	for (var i = 0; i < taskTitle.length; i++) {
		taskTitle[i] = taskTitle[i].replace(taskTitle[i].charAt(0),
				taskTitle[i].charAt(0).toUpperCase());
	}
	console.log(taskTitle);
	for (var i = 0; i < taskTitle.length; i++) {
		titleCase = titleCase + " " + taskTitle[i];
	}
	console.log(titleCase);
	taskName.value = titleCase;
	// document.getElementById("taskname").innerHTML = titleCase;
}
function toggleTask() {
	// create-task add-task
	var elmnt = document.getElementById("create-task");
	var x = elmnt.value;
	if (x === "ctask") {
		document.getElementById("add-task").style.display = "block";
		document.getElementById("create-task").innerHTML = "Hide";
		document.getElementById("create-task").value = "htask";
		// console.log(document.getElementById("cbutton").value);
	}
	if (x === "htask") {
		console.log(document.getElementById("create-task").value);
		document.getElementById("add-task").style.display = "none";
		document.getElementById("create-task").innerHTML = "Create Task";
		document.getElementById("create-task").value = "ctask";
	}
}