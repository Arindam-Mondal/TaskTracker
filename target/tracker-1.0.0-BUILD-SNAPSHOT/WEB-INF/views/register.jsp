<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>New User</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<spring:url value="/resources/javascript/moment.js" var="momentjsUrl" />
<script type="text/javascript" src="${momentjsUrl}"></script>

<spring:url value="/resources/css/register.css" var="cssUrl" />
<link rel="stylesheet" href="${cssUrl}" type="text/css" />
<spring:url value="/resources/javascript/register.js"
	var="registerjsUrl" />
<script type="text/javascript" src="${registerjsUrl}"></script>

</head>
<body>
	<div class="pageheader">Task Tracker</div>
	<div class="container">
		<div class="row">
			<div class="col-md-2 col-sm-2"></div>
			<div class="col-md-8 col-sm-8 col-xs-12">
				<div class="panel panel-blue margin-bottom-40">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-tasks"></i> Create New Account
						</h3>
					</div>
					<div class="panel-body">
						<c:if test="${duplicateUser ne null}">
							<div class="alert alert-danger" id="alertInfo" role="alert">${duplicateUser}
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>

						</c:if>
						<spring:url value="/application/registerUser" var="formUrl" />
						<form:form name="registerForm" action="${formUrl}"
							modelAttribute="userDetails" onsubmit="return validateForm()"
							method="POST">
							<div class="form-group row">
								<label class="control-label" for="name">Name</label> <input
									type="text" class="form-control" name="name"
									placeholder="Enter name" required>
							</div>
							<div class="form-group row">
								<label class="control-label" for="email">Email</label> <input
									type="email" class="form-control" name="email"
									placeholder="Enter email" required>
							</div>
							<div class="form-group row">
								<label class="control-label" for="userid">User Name</label> <input
									type="text" class="form-control" name="userId"
									placeholder="Enter username" required>
							</div>
							<div class="form-group row">
								<label class="control-label" for="password">Password</label> <input
									type="password" class="form-control" name="password"
									placeholder="Enter password" required>
							</div>
							<div class="form-group row">
								<div class="alert alert-danger" id="passwordAlert" role="alert">
									<button type="button" class="close" data-dismiss="alert"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<label class="control-label" for="password">Confirm
									Password</label> <input type="password" class="form-control"
									name="confirmPassword" placeholder="Re-enter password" required>
							</div>
							<div class="form-group row">
								<div class="alert alert-danger" id="dobAlert" role="alert"></div>
								<label class="control-label" for="dob">Date Of Birth</label> <input
									type="text" class="form-control" id="dob" name="dateOfBirth"
									placeholder="Enter date of birth" required readonly="readonly">
							</div>
							<div class="form-group row">
								<div class="col-md-3 col-sm-3">
									<button type="submit" class="btn btn-primary">Sign Up</button>
								</div>
								<div class="col-md-3 col-sm-3">
									<a href="<%=request.getContextPath()%>/"
										class="btn btn-success">Back to login</a>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
			<div class="col-md-2 col-sm-2"></div>
		</div>
	</div>
</body>
</html>