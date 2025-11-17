<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Signup</title>
<%@include file="component/allcss.jsp"%>

<style>
/*Global Reset */
body, html {
	height: 100%;
	margin: 0;
	font-family: 'Poppins', sans-serif;
}

/*Background */
body {
	background: linear-gradient(rgba(0, 50, 150, 0.45),
		rgba(0, 50, 150, 0.45)), url('img/hospital4.png') no-repeat center
		center fixed;
	background-size: cover;
	backdrop-filter: blur(6px);
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

/*Navbar */
.navbar {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1000;
}

/*Signup Section */
.signup-section {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding-top: 80px; /* space below fixed navbar */
	padding-bottom: 40px;
}

/*Glassmorphic Card */
.signup-card {
	width: 100%;
	max-width: 420px;
	border-radius: 20px;
	backdrop-filter: blur(18px);
	background: rgba(255, 255, 255, 0.12);
	box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
	color: #fff;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.signup-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 10px 35px rgba(0, 0, 0, 0.5);
}

/*Input Fields*/
.form-control {
	background-color: rgba(255, 255, 255, 0.15);
	color: #fff;
	border: 1px solid rgba(255, 255, 255, 0.4);
	border-radius: 12px;
	transition: 0.3s;
}

.form-control::placeholder {
	color: rgba(255, 255, 255, 0.7);
}

.form-control:focus {
	background-color: rgba(255, 255, 255, 0.25);
	border-color: #00b4ff;
	box-shadow: 0 0 8px rgba(0, 180, 255, 0.6);
	color: #fff;
}

/*Buttons*/
.btn.my-bg-color {
	background: linear-gradient(135deg, #00c6ff, #0072ff);
	border: none;
	padding: 10px;
	font-weight: 600;
	border-radius: 12px;
	transition: 0.3s;
}

.btn.my-bg-color:hover {
	background: linear-gradient(135deg, #0072ff, #00c6ff);
	transform: scale(1.03);
}

/*Links*/
.myP-color {
	color: #00c6ff !important;
}

/*Alerts*/
.alert {
	border-radius: 10px;
	font-weight: 500;
}

/*Responsive*/
@media ( max-width : 768px) {
	.signup-card {
		margin: 20px;
	}
	h3 {
		font-size: 1.4rem;
	}
}

@media ( max-width : 480px) {
	.signup-card {
		max-width: 90%;
	}
	.btn {
		font-size: 0.9rem;
	}
}
</style>

<!-- Validation Scripts -->
<script>
	function validateEmail() {
		const emailInput = document.getElementById("email");
		const emailError = document.getElementById("emailError");
		const emailPattern = /^(?!.*\.\.)[a-zA-Z0-9._%+-]{2,64}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		const emailValue = emailInput.value.trim();

		emailError.textContent = "";
		emailInput.classList.remove("is-invalid", "is-valid");

		if (emailValue === "") {
			emailError.textContent = "Email address is required.";
			emailInput.classList.add("is-invalid");
			return false;
		}
		if (!emailPattern.test(emailValue)) {
			emailError.textContent = "Please enter a valid email address (e.g., user@example.com)";
			emailInput.classList.add("is-invalid");
			return false;
		}
		emailInput.classList.add("is-valid");
		return true;
	}

	function validatePassword() {
		const passwordInput = document.getElementById("password");
		const passwordError = document.getElementById("passwordError");
		const passwordValue = passwordInput.value.trim();
		const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

		passwordError.textContent = "";
		passwordInput.classList.remove("is-invalid", "is-valid");

		if (passwordValue === "") {
			passwordError.textContent = "Password is required.";
			passwordInput.classList.add("is-invalid");
			return false;
		}
		if (!passwordPattern.test(passwordValue)) {
			passwordError.textContent = "Password must include uppercase, lowercase, number, and special character.";
			passwordInput.classList.add("is-invalid");
			return false;
		}
		passwordInput.classList.add("is-valid");
		return true;
	}

	function validateConfirmPassword() {
		const password = document.getElementById("password").value.trim();
		const confirmPassword = document.getElementById("confirmPassword").value
				.trim();
		const confirmError = document.getElementById("confirmError");

		confirmError.textContent = "";

		if (confirmPassword === "") {
			confirmError.textContent = "Please confirm your password.";
			return false;
		}
		if (password !== confirmPassword) {
			confirmError.textContent = "Passwords do not match.";
			return false;
		}
		return true;
	}

	document.addEventListener("DOMContentLoaded", function() {
		const form = document.querySelector("form");
		const emailField = document.getElementById("email");
		const passwordField = document.getElementById("password");
		const confirmField = document.getElementById("confirmPassword");

		if (emailField)
			emailField.addEventListener("input", validateEmail);
		if (passwordField)
			passwordField.addEventListener("input", validatePassword);
		if (confirmField)
			confirmField.addEventListener("input", validateConfirmPassword);

		if (form) {
			form.addEventListener("submit", function(e) {
				if (!validateEmail() || !validatePassword()
						|| !validateConfirmPassword()) {
					e.preventDefault();
				}
			});
		}
	});
</script>
</head>

<body>
	<!-- Fixed Navbar -->
	<div class="navbar">
		<%@include file="component/navbar.jsp"%>
	</div>

	<!-- Centered Signup Section -->
	<div class="signup-section">
		<div class="card signup-card">
			<div class="card-body p-4 p-md-5">
				<h3 class="text-center mb-4">
					<i class="fa fa-user-plus me-2"></i> User Signup
				</h3>

				<!-- Message Handling -->
				<c:if test="${not empty successMsg}">
					<div class="alert alert-success text-center">${successMsg}</div>
					<c:remove var="successMsg" scope="session" />
				</c:if>
				<c:if test="${not empty errorMsg}">
					<div class="alert alert-danger text-center">${errorMsg}</div>
					<c:remove var="errorMsg" scope="session" />
				</c:if>

				<!-- Signup Form -->
				<form action="user_register" method="post">
					<div class="mb-3">
						<label class="form-label">Full Name</label> <input name="fullName"
							type="text" placeholder="Enter full name" class="form-control"
							requiredpattern="^[A-Za-z\s]{2,40}$" maxlength="40"
							oninput="this.value = this.value.replace(/[^A-Za-z ]/g, '')">
					</div>

					<div class="mb-3">
						<label class="form-label">Email address</label> <input required
							id="email" name="email" type="email" placeholder="Enter Email"
							class="form-control" maxlength="75">
						<div id="emailHelp" class="form-text text-light">We'll never
							share your email with anyone else.</div>
						<div id="emailError" class="text-danger mt-1"
							style="font-size: 0.9em;"></div>
					</div>

					<div class="mb-3">
						<label class="form-label">Password</label> <input required
							id="password" name="password" type="password"
							placeholder="Enter password" class="form-control" minlength="8">
						<div id="passwordError" class="text-danger mt-1"
							style="font-size: 0.9em;"></div>
					</div>

					<div class="mb-3">
						<label class="form-label">Confirm Password</label> <input required
							id="confirmPassword" name="confirmPassword" type="password"
							placeholder="Re-enter password" class="form-control"
							minlength="8">
						<div id="confirmError" class="text-danger mt-1"
							style="font-size: 0.9em;"></div>
					</div>

					<button type="submit" class="btn my-bg-color text-white w-100 mt-3">Register</button>
				</form>

				<div class="text-center mt-3">
					<small>Already have an account? <a href="user_login.jsp"
						class="text-decoration-none myP-color">Login</a>
					</small>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
