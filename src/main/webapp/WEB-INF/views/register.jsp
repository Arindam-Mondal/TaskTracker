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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet"
	href='<spring:url value="/resources/css/register.css"/>'
	type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
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
			$("#datepicker1").datepicker();
		});
	});
</script>

</head>
<body>
	<div class="container-fluid">
		<div class="row signuparea">

			<spring:url value="/application/registerUser" var="formUrl" />
			<form:form action="${formUrl}" method="POST"
				modelAttribute="userDetails">
				<div class="row" style="background-color: #011624;">
					<div class="row text-center" style="color: #CCC;">
						<h4>Create an Account</h4>
					</div>
					<div class="row">
						<font color="red">${registermessage}</font>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label class="control-label" for="name">Name</label> <input
									type="text" class="form-control" name="name"
									placeholder="Enter name">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label class="control-label" for="email">Email</label> <input
									type="email" class="form-control" name="email"
									placeholder="Enter email">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label class="control-label" for="userid">User Name</label> <input
									type="text" class="form-control" name="userId"
									placeholder="Enter username">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label class="control-label" for="password">Password</label> <input
									type="password" class="form-control" name="password"
									placeholder="Enter password">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label class="control-label" for="dob">Date Of Birth</label> <input
									type="text" class="form-control" id="datepicker1"
									name="dateOfBirth" placeholder="Enter date of birth">
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-sm-12">
						<div class="form-group">
							<button type="submit" class="btn">Register</button>
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>