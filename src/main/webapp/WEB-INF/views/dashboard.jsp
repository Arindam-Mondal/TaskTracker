<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Status Tracker Dashboard</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<!-- cdn datatables -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<script type="text/javascript" src="//code.jquery.com/jquery-1.12.3.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>

<!-- cdn jquery and jquery-ui -->
<!-- <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.0/themes/smoothness/jquery-ui.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.0/jquery-ui.min.js"></script> -->

<spring:url value="/resources/css/dashboard.css" var="cssUrl" />
<link rel="stylesheet" href="${cssUrl}" type="text/css" />

<spring:url value="/resources/css/application.css" var="appcssUrl" />
<link rel="stylesheet" href="${appcssUrl}" type="text/css" />

<script>
	$(document).ready(function() {
		$('#example').DataTable();
		$('#add-task').hide();
	});
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
		//document.getElementById("taskname").innerHTML = titleCase;
	}
	function toggleTask() {
		//create-task add-task
		var elmnt = document.getElementById("create-task");
		var x = elmnt.value;
		if (x === "ctask") {
			document.getElementById("add-task").style.display = "block";
			document.getElementById("create-task").innerHTML = "Hide";
			document.getElementById("create-task").value = "htask";
			//console.log(document.getElementById("cbutton").value);
		}
		if (x === "htask") {
			console.log(document.getElementById("create-task").value);
			document.getElementById("add-task").style.display = "none";
			document.getElementById("create-task").innerHTML = "Create Task";
			document.getElementById("create-task").value = "ctask";
		}
	}
</script>

</head>
<body>
	<!-- <div class="pageheader">Status Tracker</div> -->
	<nav class="navbar navbar-default navbar-fixed-top navbar-custom"
		role="navigation">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="<%=request.getContextPath()%>/">Task
				Tracker</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<div class="col-sm-3 col-md-3">
				<form role="search" class="navbar-form">
					<div class="input-group">
						<input type="text" name="q" placeholder="Search"
							class="form-control">
						<div class="input-group-btn">
							<button type="submit" class="btn btn-default">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
			<div>
				<ul class="nav navbar-nav navbar-right">
					<li>
						<p class="navbar-text">
							Signed in as <a
								href="<%=request.getContextPath()%>/application/displayTask"
								class="navbar-link">${name}</a>
						</p>
					</li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Options <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="#">Edit Profile</a></li>
							<li><a href="<%=request.getContextPath()%>/logout">Logout</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</div>
	</nav>
	<div class="container">
		<div class="row">
			<div class="col-md-2 col-sm-2 col-xs-12">
				<button class="btn btn-block btn-success" id="create-task" value="ctask" onClick="toggleTask()">Create
					Task</button>
			</div>
		</div>
		<hr />
		<div id="add-task">
			<div class="alert alert-info" role="alert">
				<!-- <a href="#" class="close" id="add-task-close">&times;</a> -->
				<spring:url value="/application/addTask" var="formUrl" />
				<form:form action="${formUrl}" method="POST"
					modelAttribute="userDetails">
					<div class="row">
						<div class="col-sm-5">
							<div class="form-group">
								<label class="control-label" for="taskname">Title</label> <input
									type="text" class="form-control" name="taskname" id="taskname"
									placeholder="Enter title" onblur="titleFormatting()" required>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class="control-label" for="startdate">Start Date</label>
								<input type="text" class="form-control" name="starttime"
									id="datepicker1" placeholder="Enter start date" required>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class="control-label" for="enddate">End Date</label> <input
									type="text" class="form-control" name="endtime"
									id="datepicker2" placeholder="Enter end date" required>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-5">
							<div class="form-group">
								<label class="control-label" for="description">Description</label>
								<textarea rows="5" class="form-control desc-area"
									name="taskdesc" placeholder="Enter brief description" required></textarea>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2">
							<div class="form-group">
								<button type="submit" class="btn btn-block btn-info"
									id="createtaskbttn">Add Task</button>
							</div>
						</div>
					</div>
				</form:form>
			</div>
			<hr />
		</div>
		<table id="example" class="display" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th>Task</th>
					<th>Start Date</th>
					<th>End Date</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<th>Task</th>
					<th>Start Date</th>
					<th>End Date</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
			</tfoot>
			<tbody>
				<c:if test="${fn:length(taskDetails) gt 0}">
					<c:forEach items="${taskDetails}" var="task">
						<tr>
							<td><a
								href="<%=request.getContextPath()%>/application/taskDetails/${task.taskDetails.taskid}">${task.taskDetails.taskname}</a></td>
							<td>${fn:substring(task.taskDetails.starttime, 0, 10)}</td>
							<td>${fn:substring(task.taskDetails.endtime, 0, 10)}</td>
							<td>${task.taskDetails.status}</td>
							<td><a href="#" class="editor_edit">Edit</a>/<a href="#"
								class="editor_remove">Delete</a></td>
						</tr>
					</c:forEach>
				</c:if>

			</tbody>
		</table>

	</div>
</body>
</html>