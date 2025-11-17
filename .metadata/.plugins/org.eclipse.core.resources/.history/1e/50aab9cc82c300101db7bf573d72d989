<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.Specialist"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.SpecialistDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Doctor</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@include file="../component/allcss.jsp"%>

<style>
/* === PAGE BASE AND BACKGROUND === */
body {
	background-color: #f8faff; /* Very light, clean base */
	min-height: 100vh;
	font-family: 'Poppins', sans-serif;
	position: relative;
	padding-top: 70px; /* CRUCIAL: Space for fixed navbar */
	display: flex; /* Flexbox for centering */
	flex-direction: column;
}

/* Ensure the included navbar is fixed */
.navbar {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1000;
}

/* Blurred Background Image (Matching the look of the shared image) */
body::before {
	content: "";
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	/* Assuming the path for the background image is correct */
	background: url('../img/hospital1.jpg') center center/cover no-repeat fixed;
	filter: blur(8px) brightness(1.05); /* Strong blur and slightly brighter */
	opacity: 0.9; /* Allows the white cards to pop */
	z-index: -1;
}

/* Main Content Wrapper (Container for form) */
.form-wrapper {
	flex-grow: 1; /* Allows it to take up available space */
	display: flex;
	align-items: center; /* Center vertically */
	justify-content: center; /* Center horizontally */
	padding: 20px;
}

/* The Killer UI Card Style (Glass Morphism) */
.my-card {
	/* Glass effect background */
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(15px);
	-webkit-backdrop-filter: blur(15px);
	border-radius: 1.5rem;
	border: 1px solid rgba(220, 220, 220, 0.7);
	box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
	transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
	width: 100%; /* Ensure it takes full column width */
	max-width: 650px; /* Limit max width for readability */
}

.my-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 25px 60px rgba(0, 0, 0, 0.2);
}

.my-card h3 {
	font-weight: 800;
	color: #1e88e5; /* Primary Blue */
	font-size: 2rem;
}

/* Form Element Styling */
.form-control, .form-select {
	border-radius: 0.75rem;
	border: 1px solid #e0e0e0;
	padding: 0.8rem 1rem;
	transition: border-color 0.3s ease;
}

.form-control:focus, .form-select:focus {
	border-color: #1e88e5;
	box-shadow: 0 0 0 0.25rem rgba(30, 136, 229, 0.25);
}

.form-label {
	font-weight: 600;
	color: #333;
	margin-bottom: 0.3rem;
}

/* Button Styling */
.btn-primary {
	background-color: #1e88e5;
	border-color: #1e88e5;
	font-weight: 700;
	border-radius: 0.75rem;
	letter-spacing: 0.5px;
	padding: 0.75rem 1rem;
	transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
	box-shadow: 0 4px 12px rgba(30, 136, 229, 0.4);
}

.btn-primary:hover {
	background-color: #1565c0;
	border-color: #1565c0;
	transform: translateY(-1px);
	box-shadow: 0 6px 15px rgba(30, 136, 229, 0.6);
}

/* Responsive adjustments for the row/card centering */
@media ( max-width : 768px) {
	.my-card {
		margin-top: 20px;
		margin-bottom: 20px;
		padding: 1.5rem !important;
	}
	.my-card h3 {
		font-size: 1.75rem;
	}
	/* Ensure all fields stack on mobile */
	.row.g-3 > div[class*="col-md-6"] {
		width: 100%;
	}
}
</style>

<script>
	function validateEmail() {
		const emailInput = document.getElementById("email");
		const emailError = document.getElementById("emailError");
		const emailPattern = /^(?!.*\.\.)[a-zA-Z0-9._%+-]{2,64}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

		const emailValue = emailInput.value.trim();
		emailError.textContent = ""; // clear previous error
		emailInput.classList.remove("is-invalid", "is-valid"); // reset styles

		// Check if empty
		if (emailValue === "") {
			emailError.textContent = "Email address is required.";
			emailInput.classList.add("is-invalid");
			return false;
		}

		// Check pattern validity
		if (!emailPattern.test(emailValue)) {
			emailError.textContent = "Please enter a valid email address (e.g., user@example.com)";
			emailInput.classList.add("is-invalid");
			return false;
		}

		// Valid email — green border
		emailInput.classList.add("is-valid");
		return true;
	}

	function validatePassword() {
		const passwordInput = document.getElementById("password");
		const passwordError = document.getElementById("passwordError");
		const passwordValue = passwordInput.value.trim();

		// Password regex pattern: Min 8 chars, at least one uppercase, one lowercase, one number, one special char
		const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

		// Reset messages and styles
		passwordError.textContent = "";
		passwordInput.classList.remove("is-invalid", "is-valid");

		// Empty check
		if (passwordValue === "") {
			passwordError.textContent = "Password is required.";
			passwordInput.classList.add("is-invalid");
			return false;
		}

		// Pattern check
		if (!passwordPattern.test(passwordValue)) {
			passwordError.textContent = "Password must be at least 8 chars and include upper, lower, number, and special character.";
			passwordInput.classList.add("is-invalid");
			return false;
		}

		// Valid case
		passwordInput.classList.add("is-valid");
		return true;
	}

	function validateDOB() {
		const dobInput = document.getElementById("dateOfBirth");
		const dobError = document.getElementById("dobError");
		const dobValue = dobInput.value;

		dobError.textContent = "";
		dobInput.classList.remove("is-invalid", "is-valid");

		if (!dobValue) {
			dobError.textContent = "Date of Birth is required.";
			dobInput.classList.add("is-invalid");
			return false;
		}

		const dob = new Date(dobValue);
		const today = new Date();
		let age = today.getFullYear() - dob.getFullYear();
		const monthDiff = today.getMonth() - dob.getMonth();
		const dayDiff = today.getDate() - dob.getDate();

		// Adjust for not yet reached birthday
		if (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) {
			age--;
		}

		if (age < 26) {
			dobError.textContent = "Doctor must be at least 26 years old.";
			dobInput.classList.add("is-invalid");
			return false;
		}

		if (age > 75) {
			dobError.textContent = "Doctor's age cannot be more than 75 years.";
			dobInput.classList.add("is-invalid");
			return false;
		}

		dobInput.classList.add("is-valid");
		return true;
	}

	document.addEventListener("DOMContentLoaded", function() {
		const form = document.querySelector("form");
		const emailField = document.getElementById("email");
		const dobField = document.getElementById("dateOfBirth");
		const passwordField = document.getElementById("password");

		// Prevent selecting future dates and attach DOB listener
		if (dobField) {
			const today = new Date().toISOString().split("T")[0];
			dobField.setAttribute("max", today);
			dobField.addEventListener("change", validateDOB);
		}
		
		if (emailField) {
			emailField.addEventListener("input", validateEmail);
		}
		
		// Password field already has oninput="validatePassword()"

		if (form) {
			// Consolidated form submission validation
			form.addEventListener("submit", function(e) {
				// Run all validations
				const validEmail = validateEmail();
				const validDOB = validateDOB();
				const validPassword = validatePassword(); // Check password on final submit

				if (!validEmail || !validDOB || !validPassword) {
					e.preventDefault();
					// Focus on the first invalid field
					if (!validDOB) dobField.focus();
					else if (!validEmail) emailField.focus();
					else if (!validPassword) passwordField.focus();
				}
			});
		}
	});
</script>
</head>
<body>
	<%@include file="navbar.jsp"%>

	<!-- Form Wrapper for Centering -->
	<div class="form-wrapper">
		<div class="container">
			<div class="row">
				<!-- Centered column layout, responsive collapse on mobile -->
				<div class="col-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
					<div class="card my-card">
						<div class="card-body p-4 p-lg-5">
							<h3 class="text-center mb-4">Edit Doctor Details</h3>

							<!-- Message Handling -->
							<c:if test="${not empty successMsg }">
								<div class="alert alert-success text-center" role="alert">${successMsg}</div>
								<c:remove var="successMsg" scope="session" />
							</c:if>
							<c:if test="${not empty errorMsg }">
								<div class="alert alert-danger text-center" role="alert">${errorMsg}</div>
								<c:remove var="errorMsg" scope="session" />
							</c:if>

							<%
							// --- START: Backend Logic (DO NOT DISTURB) ---
							int id = Integer.parseInt(request.getParameter("id"));
							DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
							Doctor doctor = docDAO.getDoctorById(id);
							// --- END: Backend Logic ---
							%>

							<!-- Edit Doctor Form -->
							<form action="../updateDoctor" method="post">
								<div class="row g-3">
									<div class="col-12">
										<label class="form-label">Full Name</label> <input
											name="fullName" type="text" class="form-control"
											value="<%=doctor.getFullName()%>" required
											pattern="^[A-Za-z\s]{2,40}$" maxlength="40"
											title="Full Name must be 2-40 letters and spaces only (no numbers or special characters)"
											oninput="this.value = this.value.replace(/[^A-Za-z ]/g, '')">
									</div>
									<div class="col-md-6 col-12">
										<label class="form-label">Date of Birth</label> <input
											id="dateOfBirth" name="dateOfBirth" type="date"
											class="form-control" value="<%=doctor.getDateOfBirth()%>"
											required>
										<div id="dobError" class="text-danger mt-1"
											style="font-size: 0.9em;"></div>
									</div>
									<div class="col-md-6 col-12">
										<label class="form-label">Qualification</label> <input
											name="qualification" type="text" class="form-control"
											value="<%=doctor.getQualification()%>" required
											placeholder="e.g., MBBS, MD">
									</div>
									<div class="col-md-6 col-12">
										<label class="form-label">Specialist</label> <select
											class="form-select" name="specialist" required>
											<option selected><%=doctor.getSpecialist()%></option>
											<%
											// --- START: Backend Logic (DO NOT DISTURB) ---
											SpecialistDAO spDAO = new SpecialistDAO(DBConnection.getConn());
											List<Specialist> spList = spDAO.getAllSpecialist();
											for (Specialist s : spList) {
												if (!s.getSpecialistName().equals(doctor.getSpecialist())) {
											// --- END: Backend Logic ---
											%>
											<option><%=s.getSpecialistName()%></option>
											<%
												}
											}
											%>
										</select>
									</div>
									<div class="col-md-6 col-12">
										<label class="form-label">Email address</label> <input
											id="email" name="email" type="email" class="form-control"
											value="<%=doctor.getEmail()%>" required maxlength="75"
											title="Please enter a valid email address (e.g., user@example.com)">
										<div id="emailError" class="text-danger mt-1"
											style="font-size: 0.9em;"></div>
									</div>
									<div class="col-md-6 col-12">
										<label class="form-label">Phone</label> <input name="phone"
											type="tel" class="form-control"
											value="<%=doctor.getPhone()%>" required pattern="^\d{10}$"
											maxlength="10"
											title="Please enter a valid 10-digit mobile number"
											oninput="this.value = this.value.replace(/[^0-9]/g, '');">
									</div>
									<div class="col-md-6 col-12">
										<label class="form-label">Password</label> <input id="password"
											name="password" type="password" class="form-control"
											value="<%=doctor.getPassword()%>" required
											oninput="validatePassword()"> <small
											id="passwordError" class="text-danger"></small>
									</div>

									<!-- Hidden ID for update -->
									<input name="id" type="hidden" value="<%=doctor.getId()%>">

									<div class="col-12 mt-4">
										<button type="submit" class="btn btn-primary w-100">Update Doctor Details</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>