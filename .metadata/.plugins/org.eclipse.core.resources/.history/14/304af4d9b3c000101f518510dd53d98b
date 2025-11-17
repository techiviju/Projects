<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Doctor Login</title>
<%@include file="component/allcss.jsp"%>

<style>
/* Global Reset */
body, html {
	height: 100%;
	margin: 0;
	font-family: 'Poppins', sans-serif;
}

/* Background */
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

/* Navbar */
.navbar {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1000;
}

/* Login Section */
.login-section {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding-top: 80px; /* space below navbar */
	padding-bottom: 40px;
}

/* Glassmorphic Card */
.login-card {
	width: 100%;
	max-width: 420px;
	border-radius: 20px;
	backdrop-filter: blur(18px);
	background: rgba(255, 255, 255, 0.12);
	box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
	color: #fff;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.login-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 10px 35px rgba(0, 0, 0, 0.5);
}

/* Inputs */
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

/* Buttons */
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

/* Links */
.myP-color {
	color: #00c6ff !important;
}

/* Alerts */
.alert {
	border-radius: 10px;
	font-weight: 500;
}

/* Responsive */
@media ( max-width : 768px) {
	.login-card {
		margin: 20px;
	}
	h3 {
		font-size: 1.4rem;
	}
}

@media ( max-width : 480px) {
	.login-card {
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
			passwordError.textContent = "Password must be at least 8 characters and include uppercase, lowercase, number, and special character.";
			passwordInput.classList.add("is-invalid");
			return false;
		}
		passwordInput.classList.add("is-valid");
		return true;
	}

	document.addEventListener("DOMContentLoaded", function() {
		const form = document.querySelector("form");
		const emailField = document.getElementById("email");
		const passwordField = document.getElementById("password");

		if (emailField)
			emailField.addEventListener("input", validateEmail);
		if (passwordField)
			passwordField.addEventListener("input", validatePassword);

		if (form) {
			form.addEventListener("submit", function(e) {
				if (!validateEmail() || !validatePassword()) {
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

	<!-- Centered Login Section -->
	<div class="login-section">
		<div class="card login-card">
			<div class="card-body p-4 p-md-5">
				<h3 class="text-center mb-4">
					<i class="fa-solid fa-stethoscope me-2"></i> Doctor Login
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

				<!-- Login Form -->
				<form action="doctorLogin" method="post">
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

					<button type="submit" class="btn my-bg-color text-white w-100 mt-3">Login</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
