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
<!-- <link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<script type="text/javascript" src="//code.jquery.com/jquery-1.12.3.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script> -->

<!-- cdn jquery and jquery-ui -->
<script type="text/javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<spring:url value="/resources/javascript/moment.js" var="momentjsUrl" />
<script type="text/javascript" src="${momentjsUrl}"></script>

<spring:url value="/resources/css/taskdetails.css" var="cssUrl" />
<link rel="stylesheet" href="${cssUrl}" type="text/css" />

<spring:url value="/resources/css/application.css" var="appcssUrl" />
<link rel="stylesheet" href="${appcssUrl}" type="text/css" />
<spring:url value="/resources/javascript/taskdetails.js"
	var="taskdetailsjsUrl" />
<script type="text/javascript" src="${taskdetailsjsUrl}"></script>

</head>
<body>
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
				<spring:url value="/application/searchTask" var="formUrl" />
				<form:form action="${formUrl}" method="POST"
					modelAttribute="userDetails">
					<div class="input-group">
						<input type="text" name="searchkey" placeholder="Search"
							class="form-control">
						<div class="input-group-btn">
							<button type="submit" class="btn btn-default">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
					</div>
				</form:form>
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
			<div class="col-md-2 col-sm-1"></div>
			<div class="col-md-8 col-sm-10 col-sx-12">
				<c:if
					test="${sessionScope.userid ne taskDetails.taskDetails.userid }">
					<div class="alert alert-info" id="alertInfo" role="alert">
						You won't be able to edit Status or Task Details, since you are
						not the creator of the task
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>
				<div class="well">
					<div class="col-xs-12" align="right">
						<c:choose>
							<c:when
								test="${sessionScope.userid eq taskDetails.taskDetails.userid }">
								<button type="button" class="btn btn-default" id="edit-btn"
									value="sedittask" onClick="openEditDiv()">
									<span class="glyphicon glyphicon-edit"></span>
								</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-default"
									disabled="disabled">
									<span class="glyphicon glyphicon-edit"></span>
								</button>
							</c:otherwise>
						</c:choose>
					</div>
					<div id="task-details">
						<fieldset>
							<legend>Task Details</legend>

							<div class="row" align="right">
								<div class="col-xs-10" align="left">
									<h1>${taskDetails.taskDetails.taskname}</h1>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<h6>
										<Strong>Start Time:</Strong>${fn:substring(taskDetails.taskDetails.starttime, 0, 10)}
									</h6>
								</div>
								<div class="col-sm-3">
									<h6>
										<Strong>End Time:</Strong>${fn:substring(taskDetails.taskDetails.endtime, 0, 10)}</h6>
								</div>
								<div class="col-sm-3 col-md-3"></div>
								<div class="col-sm-3 col-md-3">
								<input type="hidden" id="taskStatus" value="${taskDetails.taskDetails.status}" />
									<button class="btn btn-block btn-primary" id="completedstatus">
										<span></span>
									</button>
									<c:choose>
										<c:when
											test="${sessionScope.userid eq taskDetails.taskDetails.userid}">
											<c:choose>
												<c:when
													test="${taskDetails.taskDetails.status eq 'Completed'}">
													<button class="btn btn-block btn-primary">
														<span>${taskDetails.taskDetails.status}</span>
													</button>
												</c:when>
												<c:otherwise>
													<button class="btn btn-block btn-primary" id="task-status">
														<span>${taskDetails.taskDetails.status}</span>
													</button>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<button class="btn btn-block btn-primary">
												<span>${taskDetails.taskDetails.status}</span>
											</button>
										</c:otherwise>
									</c:choose>

								</div>
							</div>
							<hr />
							<h4>
								<strong>Task Description</strong>
							</h4>
							<p>${taskDetails.taskDescription.taskdesc}</p>
							<hr />
							<div class="row">
								<div class="col-xs-12">
									<div id="commentSection">
										<h4>
											<strong>Comments</strong>
										</h4>
										<c:forEach items="${taskDetails.commentsDetailsList}"
											var="comments">
											<P>
												<b>${comments.userid}</b> : ${comments.comments}
											</P>
										</c:forEach>
									</div>
								</div>
								<div class="col-sm-6">
									<textarea id="comments" name="commentArea"
										placeholder="Write a comment..."></textarea>
									<input type="hidden" name="taskid" id="taskid"
										value="${taskDetails.taskDetails.taskid}"> <input
										type="hidden" name="userid" id="userid"
										value="${taskDetails.taskDetails.userid}">
								</div>
								<div class="col-sm-3"></div>
								<div class="col-sm-3">
									<form
										action="<%=request.getContextPath()%>/application/displayTask">
										<button type="submit" class="btn btn-block btn-primary">Back
											to Main Page</button>
									</form>
								</div>
							</div>
						</fieldset>
					</div>
					<div id="task-edit">
						<fieldset>
							<legend>Edit Task</legend>
							<div class="alert alert-danger" id="editTaskAlert" role="alert">
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<spring:url value="/application/editTask" var="formUrl" />
							<form:form action="${formUrl}"
								onsubmit="return validatetaskDetails()" method="POST"
								modelAttribute="userDetails">
								<input type="hidden" class="form-control" name="taskid"
									id="taskid" value="${taskDetails.taskDetails.taskid}">
								<div class="row">
									<div class="col-sm-5">
										<div class="form-group">
											<label class="control-label" for="taskname">Title</label> <input
												type="text" class="form-control" name="taskname"
												id="taskname" value="${taskDetails.taskDetails.taskname}"
												onblur="titleFormatting()" required>
										</div>
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<label class="control-label" for="startdate">Start
												Date</label> <input type="text" class="form-control"
												name="starttime" id="starttime"
												value="${fn:substring(taskDetails.taskDetails.starttime, 0, 10)}"
												required readonly>
										</div>
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<label class="control-label" for="enddate">End Date</label> <input
												type="text" class="form-control" name="endtime" id="endtime"
												value="${fn:substring(taskDetails.taskDetails.endtime, 0, 10)}"
												required readonly>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-5">
										<div class="form-group">
											<label class="control-label" for="description">Description</label>
											<textarea rows="5" class="form-control desc-area"
												name="taskdesc" required>${taskDetails.taskDescription.taskdesc}</textarea>
										</div>
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<label class="control-label" for="status">Change
												Status</label> <select class="form-control" name="status"
												id="status">
												<option>Pending</option>
												<option>In Progress</option>
												<option>Completed</option>
											</select>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-2">
										<div class="form-group">
											<button type="submit" class="btn btn-block btn-info"
												id="createtaskbttn">Edit Task</button>
										</div>
									</div>
								</div>
							</form:form>
						</fieldset>
					</div>
				</div>

			</div>
			<div class="col-md-2 col-sm-1"></div>
		</div>
	</div>
</body>
</html>