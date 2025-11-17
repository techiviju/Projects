<%@page import="com.hms.entity.Doctor"%>
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
<title>Edit Profile | Doctor</title>
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
}

.my-card:hover {
	transform: translateY(-2px);
	box-shadow: 0 20px 55px rgba(0, 0, 0, 0.18);
}

/* --- THEME COLOR APPLICATION: VIBRANT BLUE (#1e88e5) --- */
.theme-primary-color {
	color: #1e88e5 !important; /* Vibrant Blue Theme */
}

/* Headings (now using theme blue) */
.my-card h3 {
	font-weight: 800;
	color: #1e88e5;
}

/* Alert Message Styling for visibility on card */
.alert {
	border-radius: 0.5rem;
	font-weight: 600;
	border: none;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* Success Alerts now styled with the Blue Theme */
.alert-success {
    background-color: #e3f2fd; /* Light blue background */
    color: #1565c0; /* Darker blue text */
    border-left: 5px solid #1e88e5; /* Theme color border */
}

/* Red Danger Alerts */
.alert-danger {
    background-color: #ffebee; /* Light red background */
    color: #d32f2f; /* Darker red text */
    border-left: 5px solid #f44336;
}

/* Form Element Styling */
.form-control, .form-select {
	border-radius: 0.75rem;
	border: 1px solid #e0e0e0;
	padding: 0.8rem 1rem;
	transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

/* Form Focus (Theme Blue) */
.form-control:focus, .form-select:focus {
	border-color: #1e88e5;
	box-shadow: 0 0 0 0.25rem rgba(30, 136, 229, 0.25);
}

.form-control:not([readonly]):hover {
    border-color: #90caf9; /* Light blue hover */
}

.form-label {
	font-weight: 600;
	color: #333;
	margin-bottom: 0.3rem;
}

/* Button Styling (Now Blue Theme, replacing btn-success look) */
.btn-theme {
	background-color: #1e88e5; /* Blue theme color */
	border-color: #1e88e5;
	font-weight: 700;
	border-radius: 0.75rem;
	letter-spacing: 0.5px;
	padding: 0.75rem 1rem;
	transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
	box-shadow: 0 4px 12px rgba(30, 136, 229, 0.4);
}

.btn-theme:hover {
	background-color: #1565c0; /* Darker blue on hover */
	border-color: #1565c0;
	transform: translateY(-1px);
	box-shadow: 0 6px 15px rgba(30, 136, 229, 0.6);
}

/* Validation Message Styling */
.text-danger {
    color: #e53935 !important;
}
.form-control.is-invalid {
    border-color: #e53935;
}
/* Validation Valid State (Theme Blue) */
.form-control.is-valid {
    border-color: #1e88e5;
}

/* Responsive adjustments for the row/card centering */
@media ( max-width : 768px) {
	.my-card {
		margin-top: 10px;
		margin-bottom: 10px;
		padding: 1.5rem !important;
	}
	.my-card h3 {
		font-size: 1.75rem;
	}
	.g-4 {
		gap: 1rem !important; /* Tighten up the gap between columns on mobile */
	}
}
</style>

<script>
// --- START: Validation Logic (Untouched) ---
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

function validatePasswords() {
    const oldPass = document.getElementById("oldPassword");
    const newPass = document.getElementById("newPassword");
    const oldError = document.getElementById("oldError");
    const newError = document.getElementById("newError");

    const newPasswordPattern =
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

    let valid = true;

    // Reset states
    [oldPass, newPass].forEach(input => {
        if(input) input.classList.remove("is-invalid", "is-valid");
    });
    if(oldError) oldError.textContent = "";
    if(newError) newError.textContent = "";

    // Old password validation
    if (oldPass && oldPass.value.trim() === "") {
        oldError.textContent = "Old password is required.";
        oldPass.classList.add("is-invalid");
        valid = false;
    } else if (oldPass) {
        oldPass.classList.add("is-valid");
    }

    // New password validation
    if (newPass && newPass.value.trim() === "") {
        newError.textContent = "New password is required.";
        newPass.classList.add("is-invalid");
        valid = false;
    } else if (newPass && !newPasswordPattern.test(newPass.value.trim())) {
        newError.textContent =
            "Password must be 8+ characters and include uppercase, lowercase, number, and special character.";
        newPass.classList.add("is-invalid");
        valid = false;
    } else if (newPass) {
        newPass.classList.add("is-valid");
    }

    return valid;
}

document.addEventListener("DOMContentLoaded", function() {
  // --- Profile Edit Form Validation Setup ---
  const profileForm = document.querySelector("form[action='../doctorEditProfile']");
  const dobField = document.getElementById("dateOfBirth");
  
  // Prevent selecting future dates
  if (dobField) {
    const today = new Date().toISOString().split("T")[0];
    dobField.setAttribute("max", today);
    dobField.addEventListener("change", validateDOB);
  }

  if (profileForm) {
    profileForm.addEventListener("submit", function(e) {
      const validDOB = validateDOB();
      if (!validDOB) {
        e.preventDefault();
        dobField.focus();
      }
    });
  }
  
  // --- Password Change Form Validation Setup ---
  const passwordForm = document.querySelector("form[action='../doctorChangePassword']");
  const oldPass = document.getElementById("oldPassword");
  const newPass = document.getElementById("newPassword");
  
  if (oldPass && newPass) {
      // Live validation
      oldPass.addEventListener("input", validatePasswords);
      newPass.addEventListener("input", validatePasswords);
  }

  if (passwordForm) {
      passwordForm.addEventListener("submit", (e) => {
          if (!validatePasswords()) {
              e.preventDefault();
          }
      });
  }
});
// --- END: Validation Logic (Untouched) ---
</script>

</head>
<body>
	<%@include file="navbar.jsp"%>

	<!-- Check if doctor is logged in -->
	<c:if test="${empty doctorObj }">
		<c:redirect url="../doctor_login.jsp"></c:redirect>
	</c:if>

	<div class="form-wrapper">
		<div class="container">
			<div class="row g-4">
				<!-- Column 1: Change Password -->
				<div class="col-12 col-md-5">
					<div class="card my-card h-100">
						<div class="card-body p-4 p-lg-5">
							<!-- Applied theme-primary-color class for blue headings -->
							<h3 class="fs-3 text-center theme-primary-color mb-4">Change Password</h3>

							<!-- Password Messages -->
							<c:if test="${not empty successMsg }">
								<!-- Class is still alert-success, but styled blue in CSS -->
								<div class="alert alert-success text-center" role="alert">${successMsg}</div>
								<c:remove var="successMsg" scope="session" />
							</c:if>
							<c:if test="${not empty errorMsg }">
								<div class="alert alert-danger text-center" role="alert">${errorMsg}</div>
								<c:remove var="errorMsg" scope="session" />
							</c:if>

							<form action="../doctorChangePassword" method="post" class="mt-2">
								<div class="mb-3">
									<label class="form-label">Enter Old Password</label> <input
										 id="oldPassword" name="oldPassword" type="password"
										placeholder="Enter old password" class="form-control" required>
										 <div id="oldError" class="text-danger mt-1" style="font-size: 0.9em;"></div>
								</div>
								<div class="mb-3">
									<label class="form-label">Enter New Password</label> <input
										id="newPassword" name="newPassword" type="password"
										placeholder="Enter new password" class="form-control"
										required="required">
										 <div id="newError" class="text-danger mt-1" style="font-size: 0.9em;"></div>
								</div>
								<input type="hidden" value="${doctorObj.id}" name="doctorId">
								<!-- Updated button class to btn-theme -->
								<button type="submit" class="btn btn-theme w-100 mt-3">Change
									Password</button>
							</form>
						</div>
					</div>
				</div>

				<!-- Column 2: Edit Profile -->
				<div class="col-12 col-md-7">
					<div class="card my-card h-100">
						<div class="card-body p-4 p-lg-5">
							<!-- Applied theme-primary-color class for blue headings -->
							<h3 class="fs-3 text-center theme-primary-color mb-4">Edit Doctor Profile</h3>

							<!-- Profile Messages -->
							<c:if test="${not empty successMsgForD }">
								<!-- Class is still alert-success, but styled blue in CSS -->
								<div class="alert alert-success text-center" role="alert">${successMsgForD}</div>
								<c:remove var="successMsgForD" scope="session" />
							</c:if>
							<c:if test="${not empty errorMsgForD }">
								<div class="alert alert-danger text-center" role="alert">${errorMsgForD}</div>
								<c:remove var="errorMsgForD" scope="session" />
							</c:if>

							<form action="../doctorEditProfile" method="post" class="mt-2">
								<div class="row g-3">
									<div class="col-12">
										<label class="form-label">Full Name</label> <input
											name="fullName" type="text" class="form-control"
											value="${doctorObj.fullName}" required
											pattern="^[A-Za-z\s]{2,40}$" maxlength="40"
											title="Full Name must be 2-40 letters and spaces only (no numbers or special characters)"
											oninput="this.value = this.value.replace(/[^A-Za-z ]/g, '')">
									</div>
									<div class="col-md-6">
										<label class="form-label">Date of Birth</label> <input
											id="dateOfBirth" name="dateOfBirth" type="date"
											class="form-control" value="${doctorObj.dateOfBirth}" required>
										<div id="dobError" class="text-danger mt-1"
											style="font-size: 0.9em;"></div>
									</div>
									<div class="col-md-6">
										<label class="form-label">Qualification</label> <input
											name="qualification" type="text" class="form-control"
											value="${doctorObj.qualification}" placeholder="e.g., MBBS, MD">
									</div>
									<div class="col-md-6">
										<label class="form-label">Specialist</label> <select
											class="form-select" name="specialist" required>
											<option selected>${doctorObj.specialist}</option>
											<%
											// Start Backend Logic: Initialization and fetching data
											SpecialistDAO spDAO = new SpecialistDAO(DBConnection.getConn());
											List<Specialist> spList = spDAO.getAllSpecialist();
											
											// FIX: Explicitly cast the session attribute to use it in scriptlets
											Doctor doctor = (Doctor)session.getAttribute("doctorObj"); 
											
											// Start Backend Logic: Loop through list and print options
											for (Specialist s : spList) {
											    // Prevent listing the current specialist twice (already 'selected' above)
											    // Use the retrieved Doctor object 'doctor' instead of EL variable 'doctorObj'
											    if (!s.getSpecialistName().equals(doctor.getSpecialist())) { 
											%>
											<option><%=s.getSpecialistName()%></option>
											<%
											    } // End if statement
											} // End for loop
											// End Backend Logic
											%>
										</select>
									</div>
									<div class="col-md-6">
										<label class="form-label">Phone</label> <input name="phone"
											type="tel" class="form-control" value="${doctorObj.phone}"
											required pattern="^\d{10}$" maxlength="10"
											title="Please enter a valid 10-digit mobile number"
											oninput="this.value = this.value.replace(/[^0-9]/g, '');">
									</div>
									<div class="col-12">
										<label class="form-label">Email address</label> <input
											name="email" type="email" class="form-control" readonly
											value="${doctorObj.email}">
										<small class="text-muted">Email cannot be changed.</small>
									</div>

									<input type="hidden" value="${doctorObj.id}" name="doctorId">

									<div class="col-12 mt-3">
										<!-- Updated button class to btn-theme -->
										<button type="submit" class="btn btn-theme w-100">Update
											Profile</button>
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