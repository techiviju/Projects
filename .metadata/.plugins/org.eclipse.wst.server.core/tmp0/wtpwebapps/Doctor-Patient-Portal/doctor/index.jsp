<%@page import="com.hms.dao.AppointmentDAO"%>
<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Dashboard</title>
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
	display: flex;
	flex-direction: column;
}

/* Blurred Background Image */
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
	opacity: 0.9;
	z-index: -1;
}

/* Main Content Wrapper (Container for form) */
.dashboard-wrapper {
	flex-grow: 1; /* Allows it to take up available space */
	padding: 30px 20px;
}

/* The Killer UI Card Style (Glass Morphism) */
.my-card {
	/* Glass effect background */
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(15px);
	-webkit-backdrop-filter: blur(15px);
	border-radius: 1.5rem;
	border: 1px solid rgba(220, 220, 220, 0.7);
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
	transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
	cursor: pointer;
	height: 100%; /* Important for equal height in flex layout */
}

.my-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
}

/* Dashboard Header Styling */
.dashboard-header {
	color: #1e88e5; /* Primary blue for main title */
	font-weight: 800;
	letter-spacing: 0.5px;
}

.welcome-message {
	font-weight: 500;
	color: #555;
	margin-top: 5px;
	margin-bottom: 30px;
}

/* Card Content Styling */
.my-card h4 {
	font-weight: 700;
	color: #333;
	margin-top: 15px;
	font-size: 1.3rem;
}

.my-card .fs-1 {
	font-weight: 900;
	margin-top: 5px;
}

/* Custom Card Colors (Tailored for dashboard status) */
.card-appointments i, .card-appointments .fs-1 {
	color: #1e88e5; /* Primary Blue */
}

.card-pending i, .card-pending .fs-1 {
	color: #ff9800; /* Orange/Warning */
}

.card-success i, .card-success .fs-1 {
	color: #4CAF50; /* Success Green */
}

/* Responsive adjustments */
@media ( max-width : 768px) {
	.dashboard-wrapper {
		padding: 10px;
	}
	.my-card {
		padding: 1.5rem !important;
	}
	.dashboard-header {
		font-size: 1.8rem;
	}
	.welcome-message {
		font-size: 1rem;
	}
}
</style>

</head>
<body>
	<%@include file="navbar.jsp"%>

	<!-- Check if doctor is logged in -->
	<c:if test="${empty doctorObj }">
		<c:redirect url="../doctor_login.jsp"></c:redirect>
	</c:if>

	<div class="dashboard-wrapper">
		<div class="container">
			<div class="row">
				<div class="col-md-12 text-center mb-5">
					<h2 class="dashboard-header">Doctor Dashboard</h2>
					<%
						// Get logged-in Doctor object
						Doctor currentLoginDoctor = (Doctor) session.getAttribute("doctorObj");
						// Initialize DoctorDAO (kept for existing structure)
						DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
					%>
					<h4 class="welcome-message">Welcome, ${doctorObj.fullName}</h4>

					<%
						// --- START: Logic for Appointment Counts (New/Updated logic) ---
						int totalCount = 0;
						int pendingCount = 0;
						int successCount = 0;
						
						// Check if doctor is logged in before proceeding with DB calls
						if (currentLoginDoctor != null) {
							// 1. Initialize AppointmentDAO for counting
							AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
							int doctorId = currentLoginDoctor.getId();
							
							// 2. Calculate the counts using the new methods
							totalCount = appDAO.countTotalAppointmentByDoctorId(doctorId);
							pendingCount = appDAO.countPendingAppointmentByDoctorId(doctorId);
							successCount = appDAO.countSuccessfulAppointmentByDoctorId(doctorId);
						}
						// --- END: Logic for Appointment Counts ---
					%>
				</div>
			</div>

			<div class="row g-4 d-flex justify-content-center">
			
				<!-- CARD 1: Total Appointments -->
				<div class="col-12 col-sm-6 col-md-4">
					<div class="card my-card card-appointments p-3">
						<div class="card-body text-center">
							<i class="fa-solid fa-calendar-check fa-3x"></i>
							<h4>Total Appointments</h4>
							<h5 class="fs-1">
								<%= totalCount %>
							</h5>
						</div>
					</div>
				</div>
				
				<!-- CARD 2: Pending Appointments -->
				<div class="col-12 col-sm-6 col-md-4">
					<div class="card my-card card-pending p-3">
						<div class="card-body text-center">
							<i class="fa-solid fa-clock fa-3x"></i>
							<h4>Pending Appointments</h4>
							<h5 class="fs-1">
								<%= pendingCount %>
							</h5>
						</div>
					</div>
				</div>
				
				<!-- CARD 3: Successful Consults -->
				<div class="col-12 col-sm-6 col-md-4">
					<div class="card my-card card-success p-3">
						<div class="card-body text-center">
							<i class="fa-solid fa-heart-circle-check fa-3x"></i>
							<h4>Successful Consults</h4>
							<h5 class="fs-1">
								<%= successCount %>
							</h5>
						</div>
					</div>
				</div>
				
			</div>
			
			<!-- Added a quick link for navigation -->
			<div class="row mt-5">
			    <div class="col-12 text-center">
			        <a href="patient.jsp" class="btn btn-lg btn-outline-primary"
			           style="border-radius: 1rem; font-weight: 600;">
			            View All Appointments
			        </a>
			    </div>
			</div>
		</div>
	</div>
</body>
</html>