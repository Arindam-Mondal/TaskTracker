<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Status Tracker Logging</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet"
	href='<spring:url value="/resources/css/login.css"/>' type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="middlePage">
		<div class="page-header">
			<h1 class="logo">
				Task Tracker <small>Welcome to our place!</small>
			</h1>
		</div>

		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Please Sign In</h3>
			</div>
			<div class="panel-body">

				<div class="row">

					<div class="col-md-5">
						<!-- <a href="#"><img src="http://techulus.com/buttons/fb.png" /></a><br/>
							 <a href="#"><img src="http://techulus.com/buttons/tw.png" /></a><br/>
							 <a href="#"><img src="http://techulus.com/buttons/gplus.png" /></a> -->
					</div>

					<div class="col-md-7"
						style="border-left: 1px solid #ccc; height: 160px">

						<form class="form-horizontal"
							action='<spring:url value="/application/login"></spring:url>'
							method="post">
							<fieldset>
								<%-- <div class="spacing">
									<span class="errormsg"><c:out value="${errormsg}" /></span>
								</div> --%>
								<input id="textinput" name="username" type="text"
									placeholder="Enter User Name" class="form-control input-md">
								<div class="spacing">
									<input type="checkbox" name="checkboxes" id="checkboxes-0"
										value="1"><small> Remember me</small>
								</div>
								<input id="textinput" name="password" type="password"
									placeholder="Enter Password" class="form-control input-md">
								<div class="spacing">
									<a href="#"><small> Forgot Password?</small></a><br />
								</div>
								<button id="singlebutton" name="singlebutton"
									class="btn btn-info btn-sm pull-right">Sign In</button>


							</fieldset>
						</form>
					</div>

				</div>

			</div>
		</div>

		<div class="signup text-center">
			<h4>
				Not yet a member! <a href="<%=request.getContextPath()%>/register">Sign
					Up.</a>
			</h4>
		</div>

	</div>
</body>
</html>