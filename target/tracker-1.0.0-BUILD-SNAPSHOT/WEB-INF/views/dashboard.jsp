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
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"
	rel="stylesheet" />
<spring:url value="/resources/css/dashboard.css" var="cssUrl" />
<link rel="stylesheet" href="${cssUrl}" type="text/css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>

<!-- Compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">

<!-- Compiled and minified JavaScript -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
<script>
	$(document).ready(function() {
		$(function() {
			var value = $('#checkmessage').val();
			if(value.length >1){
				$("#createtaskdiv").show();
			}else{
				$("#createtaskdiv").hide();
			}
			
		});
		$(function() {
			$("#datepicker1").datepicker();
		});
		$(function() {
			$("#datepicker2").datepicker();
		});
		$("#createtaskbttn").click(function() {
			$("#createtaskdiv").show();
		});
		$("#comments").keypress(function(event) {
			if (event.which == 13) {
				event.preventDefault();
				$("#commentsform").submit();
			}
		});
		/* $(".editstatus").click(function() {
			$(".taskstatus").hide();
		}); */
		$("body").on("click", "button[class=editstatus]", function() {
			$(".taskstatus").hide();
		});
	});
</script>

</head>
<body>
	<div class="container-fluid">
		<div class="row"
			style="background-color: #011624; border-width: 0px; margin-left: -15px; margin-right: -15px; height: 60px;">
			<div class="row" style="margin-left: 0px; margin-top: 10px;">
				<div class="col-sm-4 search" style="width: 300px;">
					<spring:url value="/application/searchTask" var="formUrl" />
					<form:form action="${formUrl}" method="POST"
						modelAttribute="userDetails">
						<div class="col-sm-3 search" style="width: 200px;">
							<input type="text" name="searchkey" placeholder="Search">
						</div>
						<div class="col-sm-1 search" style="padding-left: 0px;">
							<button type="submit" class="btn"
								style="padding-right: 10px; padding-left: 10px;">
								<i class="fa fa-search"></i>
							</button>
						</div>
					</form:form>
				</div>
				<div class="col-sm-2" style="width: 180px;">
					<button type="submit" class="btn" id="createtaskbttn">New
						Task</button>
				</div>
				<div class="col-sm-2" style="font-size: 25px; color: #CCC;">
					<b>Task Tracker</b>
				</div>
				<div class="col-sm-2">
					<a href="<%=request.getContextPath()%>/application/displayTask">
						<button class="btn">
							<c:out value="${name}" />
						</button>
					</a>
				</div>
				<div class="dropdown col-sm-2" style="width: 70px;">
					<button class="btn dropdown-toggle" type="button"
						data-toggle="dropdown">
						<i class="fa fa-list" aria-hidden="true"></i> <span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li><a href="#">Edit Profile</a></li>
						<li><a href="<%=request.getContextPath()%>/logout">Logout</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- div to add new task -->
		<div class="row">
		<input type="hidden" id="checkmessage" value="${message}" >
		</div>
			<div class="row crtdiv" id="createtaskdiv"
				style="display: block; margin-right: 600px; margin-left: 200px;">
				<spring:url value="/application/addTask" var="formUrl" />
				<form:form action="${formUrl}" method="POST"
					modelAttribute="userDetails">
					<div class="row">
						<font color="red">${message}</font>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<div class="form-group">
								<label class="control-label" for="taskname">Title</label> <input
									type="text" class="form-control" name="taskname"
									placeholder="Enter title">
							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<label class="control-label" for="startdate">Start Date</label>
								<input type="text" class="form-control" name="starttime"
									id="datepicker1" placeholder="Enter start date">
							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<label class="control-label" for="enddate">End Date</label> <input
									type="text" class="form-control" name="endtime"
									id="datepicker2" placeholder="Enter end date">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-8">
							<div class="form-group">
								<label class="control-label" for="description">Description</label>
								<textarea rows="5" class="form-control" name="taskdesc"
									placeholder="Enter brief description"></textarea>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<div class="form-group">
								<button type="submit" class="btn" id="createtaskbttn">
									Create New Task</button>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		
		<!-- if there is no message -->
				
		<!-- if there is no message block ends -->
		<div class="row"
			style="margin-left: 200px; margin-top: 20px; border-style: solid; border-width: 0px; margin-right: 200px; padding-bottom: 0px; padding-right: 0px;">
			<div class="col-sm-12">
				<c:if test="${fn:length(taskDetails) gt 0}">
					<c:forEach items="${taskDetails}" var="task">
						<div class="row well">
							<h2>${task.taskDetails.taskname}</h2>
							<h6>By ${task.taskDetails.userid}</h6>
							<jsp:useBean id="now" class="java.util.Date" />
							<fmt:formatDate var="date" value="${now}" pattern="yyyy-MM-dd" />
							<c:if test="${task.taskDetails.endtime lt date }">
								<h6>
									<font color="red">Schedule date to complete the task is
										over.</font>
								</h6>
								<h6>
									<font color="red">Please complete and close the task.</font>
								</h6>
							</c:if>
							<h6>To be completed by
								${fn:substring(task.taskDetails.endtime, 0, 10)}</h6>
							<p class="taskstatus">${task.taskDetails.status}
								<c:if test="${sessionScope.userid eq task.taskDetails.userid}">
								&nbsp;<button class="editstatus" class="btn">
										<i class="fa fa-pencil" aria-hidden="true"></i>
									</button>
								</c:if>
							<p>
							<div class="row well">
								<h4>${task.taskDescription.taskdesc}</h4>
							</div>
							<div class="row">
								<%-- <c:if test="${fn:length(taskDetails.commentsDetailsList) gt 0}"> --%>
								<c:forEach items="${task.commentsDetailsList}" var="comments">
									<P>
										<b>${comments.userid}</b> : ${comments.comments}
									</P>
								</c:forEach>
								<%-- </c:if> --%>
								<div class="row">
									<div class="col-sm-12">
										<spring:url value="/application/addComments" var="formUrl" />
										<form:form action="${formUrl}" method="POST" id="commentsform">
											<div class="form-group" style="margin-right: 500px;">
												<input type="text" class="form-control" name="comments"
													id="comments" placeholder="Write a comment..."> <input
													type="hidden" name="taskid" id="taskid"
													value="${task.taskDetails.taskid}"> <input
													type="hidden" name="userid" id="userid"
													value="${task.taskDetails.userid}">
											</div>
										</form:form>
									</div>
								</div>
							</div>

						</div>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(taskDetails) eq 0 }">
				No Task To Display....
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>