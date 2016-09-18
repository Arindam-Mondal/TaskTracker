<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Status Tracker Logging</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<spring:url value="/resources/css/login.css" var="cssUrl" />
<link rel="stylesheet" href="${cssUrl}" type="text/css" />

</head>
<body>
	<div class="pageheader">Task Tracker</div>
	<div class="container">
		<div class="row maindiv">
			<div class="col-md-4 col-sm-4"></div>
			<div class="col-md-4 col-sm-4 col-xs-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<strong>Sign in </strong>
						</h3>
					</div>
					<div class="panel-body">
						<c:if test="${not empty errormsg}">
   							<div class="alert alert-danger" role="alert">
   							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>${errormsg}</strong>
						</div>
						</c:if>
						<spring:url value="/application/login" var="actionUrl" />
						<form action="${actionUrl}" method="post">
							<div class="form-group input-group">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-user"></i></span> <input type="text"
									class="form-control" name="username"
									placeholder="Enter User Name" required="required">
							</div>
							<div class="form-group input-group">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-lock"></i></span> <input type="password"
									class="form-control" name="password"
									placeholder="Enter Password" required="required">
							</div>
							<button id="singlebutton" name="singlebutton"
								class="btn btn-primary btn-block">Login</button>
						</form>
						<hr />
						<!-- New Member -->
						<div class="row newmem">
							<div class="col-xs-12">
								<a href="<%=request.getContextPath()%>/register"
									class="btn btn-block btn-success">Sign Up</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4 col-sm-4"></div>
		</div>
	</div>
</body>
</html>