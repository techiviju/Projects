<%@page import="com.hms.entity.Doctor"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Appointment Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@include file="component/allcss.jsp"%>

<style>
/* === PAGE BASE === */
body {
	background: linear-gradient(135deg, #e8f1fc 0%, #ffffff 100%);
	min-height: 100vh;
	margin: 0;
	font-family: 'Poppins', sans-serif;
}

/* === BACKGROUND IMAGE & BLUR ADJUSTMENT (Less Blue/Opaque) === */
.appointment-bg {
	position: relative;
	width: 100%;
	min-height: 100vh;
	background: url('img/hospital1.jpg') center center/cover no-repeat;
	display: flex;
	align-items: center;
	justify-content: center;
}

.appointment-bg::before {
	content: "";
	position: absolute;
	inset: 0;
	/* Adjusted: Changed to a neutral, slightly lower opacity white overlay */
	background: rgba(255, 255, 255, 0.7); 
	backdrop-filter: blur(1px); /* Reduced blur for subtle effect */
	-webkit-backdrop-filter: blur(1px);
}

/* === GLASS FORM === */
.glass-form {
	position: relative;
	z-index: 2;
	width: 90%;
	max-width: 700px;
	/* Form background remains mostly white with strong blur */
	background: rgba(255, 255, 255, 0.85); 
	border-radius: 1.2rem;
	box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
	backdrop-filter: blur(12px);
	-webkit-backdrop-filter: blur(12px);
	padding: 2.5rem;
	animation: fadeInUp 0.7s ease;
}

/* === HEADINGS === */
.glass-form h3 {
	text-align: center;
	color: #007bff;
	font-weight: 700;
	margin-bottom: 1.5rem;
}

/* === FORM ELEMENTS === */
input.form-control, select.form-select, textarea.form-control {
	border-radius: 0.6rem;
	border: 1px solid #e0e7f1;
	padding: 0.7rem 0.9rem;
	transition: 0.3s ease;
}

input.form-control:focus, select.form-select:focus, textarea.form-control:focus
	{
	border-color: #007bff;
	box-shadow: 0 0 0 0.18rem rgba(0, 123, 255, 0.2);
}

label.form-label {
	font-weight: 600;
	color: #2b3742;
}

.btn.my-bg-color {
	background-color: #007bff;
	border: none;
	border-radius: 0.6rem;
	font-weight: 600;
	letter-spacing: 0.5px;
	transition: background-color 0.3s ease;
}

.btn.my-bg-color:hover {
	background-color: #0056b3;
}

/* === ANIMATIONS === */
@
keyframes fadeInUp {
	from {opacity: 0;
	transform: translateY(30px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* === RESPONSIVE === */
@media ( max-width : 768px) {
	.glass-form {
		padding: 2rem;
	}
	h3 {
		font-size: 1.6rem;
	}
}

@media ( max-width : 576px) {
	.glass-form {
		padding: 1.5rem;
		border-radius: 0.8rem;
	}
	h3 {
		font-size: 1.4rem;
	}
}
</style>

<script>
	document
			.addEventListener(
					'DOMContentLoaded',
					function() {
						// Min date
						const today = new Date().toISOString().split('T')[0];
						const apptEl = document
								.getElementById("appointmentDate");
						if (apptEl)
							apptEl.setAttribute('min', today);

						// Email validation
						const emailInput = document.getElementById("email");
						const emailError = document
								.getElementById("emailError");
						const emailPattern = /^(?!.*\.\.)[a-zA-Z0-9._%+-]{2,64}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

						function validateEmail() {
							if (!emailInput)
								return true;
							const value = emailInput.value.trim();
							emailError.textContent = "";
							emailInput.classList.remove("is-valid",
									"is-invalid");

							if (value === "") {
								emailError.textContent = "Email is required.";
								emailInput.classList.add("is-invalid");
								return false;
							}

							if (!emailPattern.test(value)) {
								emailError.textContent = "Invalid email format (e.g., user@example.com)";
								emailInput.classList.add("is-invalid");
								return false;
							}

							emailInput.classList.add("is-valid");
							return true;
						}

						if (emailInput)
							emailInput.addEventListener("input", validateEmail);

						const form = document.querySelector("form");
						if (form) {
							form.addEventListener("submit", function(e) {
								if (!validateEmail()) {
									e.preventDefault();
									emailInput.focus();
								}
							});
						}
					});
</script>
</head>

<body>
	<%@include file="component/navbar.jsp"%>

	<!-- ===== Appointment Background Section ===== -->
	<div class="appointment-bg">
		<div class="glass-form">
			<h3>User Appointment</h3>

			<!-- Success / Error Messages -->
			<c:if test="${not empty successMsg}">
				<div class="alert alert-success text-center">${successMsg}</div>
				<c:remove var="successMsg" scope="session" />
			</c:if>
			<c:if test="${not empty errorMsg}">
				<div class="alert alert-danger text-center">${errorMsg}</div>
				<c:remove var="errorMsg" scope="session" />
			</c:if>

			<!-- === FORM === -->
			<form class="row g-3" action="addAppointment" method="post">
				<input type="hidden" name="userId" value="${userObj.id}">

				<div class="col-md-6">
					<label class="form-label">Full Name</label> <input required
						name="fullName" type="text" placeholder="Enter full name"
						class="form-control" pattern="^[A-Za-z\\s]{2,40}$" maxlength="40"
						oninput="this.value = this.value.replace(/[^A-Za-z ]/g, '')"
						title="2-40 letters only, no numbers/symbols">
				</div>

				<div class="col-md-6">
					<label class="form-label">Gender</label> <select
						class="form-select" name="gender" required>
						<option selected disabled value="">Select Gender</option>
						<option value="male">Male</option>
						<option value="female">Female</option>
					</select>
				</div>

				<div class="col-md-6">
					<label class="form-label">Age</label> <input name="age" required
						type="number" placeholder="Enter your Age" class="form-control"
						min="1" max="115" oninput="if(this.value < 1) this.value='';"
						title="Valid age: 1 to 115">
				</div>

				<div class="col-md-6">
					<label class="form-label">Appointment Date</label> <input required
						name="appointmentDate" type="date" class="form-control"
						id="appointmentDate">
				</div>

				<div class="col-md-6">
					<label class="form-label">Email</label> <input required id="email"
						name="email" type="email" placeholder="Enter Email"
						class="form-control" maxlength="75">
					<div id="emailError" class="mt-1 text-danger"></div>
				</div>

				<div class="col-md-6">
					<label class="form-label">Phone</label> <input name="phone"
						required type="tel" placeholder="Enter 10-digit number"
						class="form-control" pattern="^\d{10}$" maxlength="10"
						oninput="this.value = this.value.replace(/[^0-9]/g, '');"
						title="Enter valid 10-digit phone number (e.g., 9999999999)">
				</div>


				<div class="col-md-6">
					<label class="form-label">Diseases</label> <input required
						name="diseases" type="text" placeholder="Enter diseases"
						class="form-control">
				</div>

				<div class="col-md-6">
					<label class="form-label">Doctor</label> <select required
						class="form-select" name="doctorNameSelect">
						<option selected disabled value="">Select Doctor</option>
						<%
						DoctorDAO doctorDAO = new DoctorDAO(DBConnection.getConn());
						List<Doctor> listOfDoctor = doctorDAO.getAllDoctor();
						for (Doctor d : listOfDoctor) {
						%>
						<option value="<%=d.getId()%>"><%=d.getFullName()%> (<%=d.getSpecialist()%>)
						</option>
						<%
						}
						%>
					</select>
				</div>

				<div class="col-12">
					<label class="form-label">Full Address</label>
					<textarea name="address" required class="form-control" rows="3"
						placeholder="Enter full address"></textarea>
				</div>

				<!-- Submit Button -->
				<c:if test="${empty userObj}">
					<div class="col-12 mt-3">
						<a href="user_login.jsp"
							class="btn my-bg-color text-white w-100 py-2"> Login to Book
							Appointment </a>
					</div>
				</c:if>

				<c:if test="${not empty userObj}">
					<div class="col-12 mt-3">
						<button type="submit"
							class="btn my-bg-color text-white w-100 py-2">Submit
							Appointment</button>
					</div>
				</c:if>
			</form>
		</div>
	</div>

	<%@include file="component/footer.jsp"%>
</body>
</html>