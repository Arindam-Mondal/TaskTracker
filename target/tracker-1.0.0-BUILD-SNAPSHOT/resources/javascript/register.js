$(document).ready(function() {
		$("#dobAlert").show();
		$(function() {
			$("#dob").datepicker();
		});
		$(function() {
			$("#passwordAlert").hide();
		});
		$(function() {
			$("#dobAlert").hide();
		});
	});
	function validateForm() {
		var pass = document.forms["registerForm"]["password"].value;
		var cnfrmpass = document.forms["registerForm"]["confirmPassword"].value;
		var n = pass.localeCompare(cnfrmpass);
		if (pass != cnfrmpass) {
			//alert("Password and Confirm password should be equal");
			document.getElementById("passwordAlert").innerHTML = "Password and confirm password doesnot match";
			$("#passwordAlert").show();
			return false;
		}
		if (pass == cnfrmpass) {
			$("#passwordAlert").hide();
		}
		if (moment(document.getElementById("dob").value).isAfter(moment.now())) {
			document.getElementById("dobAlert").innerHTML = "Enter a valid DoB";
			$("#dobAlert").show();
			return false;
		}
	}