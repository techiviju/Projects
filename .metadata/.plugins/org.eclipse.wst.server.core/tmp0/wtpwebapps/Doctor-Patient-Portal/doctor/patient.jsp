<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
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
<title>Doctor: Patient Appointments</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@include file="../component/allcss.jsp"%>

<style>
/* === CORE LAYOUT & BACKGROUND === */
body {
	background-color: #f0f4f8;
	min-height: 100vh;
	font-family: 'Poppins', sans-serif;
	position: relative;
	padding-top: 70px; /* Space for fixed navbar */
	display: flex;
	flex-direction: column;
}

/* Background Image (Blurred Office - Using a placeholder path) */
body::before {
	content: "";
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	/* Ensure you replace this with your actual image path */
	background: url('../img/hospital1.jpg') center center/cover no-repeat
		fixed;
	filter: blur(8px) brightness(1.05);
	opacity: 0.95;
	z-index: -1;
}

/* Main Content Wrapper - Centered */
.content-wrapper {
	flex-grow: 1;
	padding: 30px 10px;
	display: flex;
	justify-content: center;
	align-items: flex-start;
}

/* Page Banner (Simplified) */
.page-banner {
	background: rgba(255, 255, 255, 0.7);
	height: 15vh;
	display: flex;
	align-items: center;
	justify-content: center;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 30px;
}

.page-banner h2 {
	color: #2196F3;
	font-weight: 700;
	font-size: 2.2rem;
	text-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* Header (My Appointments) */
.page-header {
	color: #007bff;
	font-weight: 700;
	margin-bottom: 40px;
}

/* Glass Morphism Card Container */
.my-card {
	/* Glass effect background */
	background: rgba(255, 255, 255, 0.9);
	backdrop-filter: blur(10px);
	-webkit-backdrop-filter: blur(10px);
	border-radius: 1.5rem;
	border: 1px solid rgba(255, 255, 255, 0.5);
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
	width: 100%;
	margin-top: 0;
}

/* === TABLE STYLING (Desktop/Tablet View) === */
.table th {
	background-color: #007bff; /* Bright Blue Header */
	color: white;
	font-weight: 600;
	border-color: #007bff;
	white-space: nowrap;
	vertical-align: middle;
}

.table tbody tr {
	transition: background-color 0.2s;
}

.table tbody tr:hover {
	background-color: rgba(0, 123, 255, 0.05);
}

/* Status Badges */
.badge {
	padding: 0.5em 0.75em;
	border-radius: 0.5rem;
	font-weight: 600;
	font-size: 0.85em;
	min-width: 80px;
	text-align: center;
	line-height: 1.5; /* Fix line height for better appearance */
}

.btn-comment {
	border-radius: 0.5rem;
	font-weight: 500;
}

/* === MOBILE STYLES (MATCHING IMAGE 1) === */
@media ( max-width : 767.98px) {
	/* Hide the traditional table on mobile */
	.table-responsive, .my-card h4 {
		display: none !important;
	}

	/* Ensure the main container is visible */
	.my-card {
		background: none;
		/* Remove glass effect wrapper on mobile, cards will handle background */
		box-shadow: none;
		border: none;
		border-radius: 0;
	}
	.card-body {
		padding: 0 !important;
		
	}
	
	h2 {
        color: #2196F3; 
        font-weight: 700;
        font-size: 2.2rem;
        text-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

	/* Show the card layout on mobile */
	.mobile-cards {
		display: block !important;
		width: 100%;
		max-width: 500px; /* Optional: Constrain width for better look */
		margin: 0 auto;
	}

	/* Individual Appointment Card Style (Matching Image) */
	.appointment-card {
		background: #fff;
		border-radius: 0.75rem;
		padding: 15px;
		margin-bottom: 20px;
		box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
		border: 1px solid #ddd;
	}
	.card-header-patient {
		padding-bottom: 10px;
		margin-bottom: 10px;
		border-bottom: 3px solid #007bff; /* Blue underline */
		position: relative;
		padding-left: 10px;
		border-top-left-radius: 0.75rem;
		border-top-right-radius: 0.75rem;
		margin-top: -15px; /* Pull up to the top border */
		margin-left: -15px;
		margin-right: -15px;
		padding-top: 15px;
		padding-right: 15px;
	}
	.patient-name {
		font-size: 1.25rem;
		font-weight: 700;
		color: #007bff; /* Blue text for patient name */
	}
	.doctor-name {
		font-size: 0.9rem;
		color: #6c757d;
	}
	.card-detail {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 8px 0;
		border-bottom: 1px dashed #e9ecef;
	}
	.card-detail:last-child {
		border-bottom: none;
	}
	.card-label {
		font-weight: 500;
		color: #495057;
		flex-basis: 50%;
		display: flex;
		align-items: center;
	}
	.card-value {
		text-align: right;
		flex-basis: 50%;
		color: #333;
		font-weight: 600;
	}

	/* Icons for date and phone */
	.fa-calendar-alt, .fa-phone {
		color: #007bff;
		margin-left: 10px;
	}
	.card-action {
		text-align: center;
		padding-top: 15px;
	}
}

/* Hide mobile cards on desktop */
@media ( min-width : 768px) {
	.mobile-cards {
		display: none;
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
	
		<!-- Page Banner -->
				<div class="container-fluid page-banner">
					<h2>
						<i class="fa fa-calendar-check me-2"></i> My Appointments
					</h2>
				</div>

	<div class="content-wrapper container-fluid">
		<div class="row w-100 justify-content-center">
			<div class="col-md-11 col-lg-10">

			

				<div class="card my-card">
					<div class="card-body p-md-5 p-3">
						<h4 class="text-center text-muted mb-4 border-bottom pb-3">
							<i class=" fa fa-calendar-check me-2"></i> Appointment List
						</h4>

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
						// Backend Logic Setup
						Doctor doctor = (Doctor) session.getAttribute("doctorObj");
						AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
						List<Appointment> list = appDAO.getAllAppointmentByLoginDoctor(doctor.getId());
						%>

						<%
						if (list.isEmpty()) {
						%>
						<div class="text-center text-muted py-4">No appointments
							scheduled yet.</div>
						<%
						} else {
						%>

						<!-- 1. DESKTOP/TABLET TABLE VIEW -->
						<div class="table-responsive">
							<table class="table table-striped table-hover align-middle">
								<thead>
									<tr>
										<th scope="col">Full Name</th>
										<th scope="col">Gender</th>
										<th scope="col">Age</th>
										<th scope="col">Appointment Date</th>
										<th scope="col">Phone</th>
										<th scope="col">Diseases</th>
										<th scope="col">Status</th>
										<th scope="col" class="text-center">Action</th>
									</tr>
								</thead>
								<tbody>
									<%
									for (Appointment applist : list) {
									%>
									<tr>
										<td><%=applist.getFullName()%></td>
										<td><%=applist.getGender()%></td>
										<td><%=applist.getAge()%></td>
										<td><%=applist.getAppointmentDate()%></td>
										<td><%=applist.getPhone()%></td>
										<td><%=applist.getDiseases()%></td>
										<td>
											<%
											String status = applist.getStatus();
											if ("Pending".equals(status)) {
											%> <span class="badge bg-warning text-dark"><%=status%></span>
											<%
											} else {
											%> <span class="badge bg-success"><%=status%></span> <%
 }
 %>
										</td>
										<td class="text-center">
											<%
											if ("Pending".equals(applist.getStatus())) {
											%> <a href="comment.jsp?id=<%=applist.getId()%>"
											class="btn btn-success btn-sm btn-comment">Comment</a> <%
 } else {
 %>
											<button class="btn btn-secondary btn-sm disabled btn-comment">
												<i class="fa fa-check me-1"></i> Completed
											</button> <%
 }
 %>
										</td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>

						<!-- 2. MOBILE CARD VIEW (Custom Design matching the image) -->
						<div class="mobile-cards d-none">
							<%
							for (Appointment applist : list) {
							%>
							<div class="appointment-card">

								<!-- Card Header Section -->
								<div class="card-header-patient">
									<div class="patient-name text-uppercase"><%=applist.getFullName()%></div>
									<div class="doctor-name">
										<i class="fa-solid fa-user-md me-1"></i> Dr.
										<%=doctor.getFullName()%></div>
								</div>

								<!-- Status Section (First, prominent detail) -->
								<div class="card-detail">
									<div class="card-label">Status</div>
									<div class="card-value">
										<%
										String status = applist.getStatus();
										if ("Pending".equals(status)) {
										%>
										<span class="badge bg-warning text-dark"><%=status%></span>
										<%
										} else {
										// Use the full status string if available, otherwise default to "Done" style
										String badgeClass = status.toLowerCase().contains("done") ? "bg-success" : "bg-info";
										%>
										<span class="badge <%=badgeClass%>"><%=status%></span>
										<%
										}
										%>
									</div>
								</div>

								<!-- Appointment Date -->
								<div class="card-detail">
									<div class="card-label">Appointment Date</div>
									<div class="card-value"><%=applist.getAppointmentDate()%><i
											class="fa-solid fa-calendar-alt ms-2"></i>
									</div>
								</div>

								<!-- Gender / Age -->
								<div class="card-detail">
									<div class="card-label">Gender / Age</div>
									<div class="card-value text-lowercase"><%=applist.getGender()%>
										/
										<%=applist.getAge()%></div>
								</div>

								<!-- Diseases -->
								<div class="card-detail">
									<div class="card-label">Diseases</div>
									<div class="card-value"><%=applist.getDiseases()%></div>
								</div>

								<!-- Phone -->
								<div class="card-detail border-bottom-0">
									<div class="card-label">Phone</div>
									<div class="card-value"><%=applist.getPhone()%><i
											class="fa-solid fa-phone ms-2"></i>
									</div>
								</div>

								<!-- Action Button (Removed from the card to simplify, but could be added back) -->
								<%--
                                    <div class="card-action">
                                        <% if ("Pending".equals(applist.getStatus())) { %> 
                                        <a href="comment.jsp?id=<%=applist.getId()%>" class="btn btn-success btn-sm btn-comment w-100">Comment / Update</a>
                                        <% } else { %>
                                        <button class="btn btn-secondary btn-sm disabled btn-comment w-100"><i class="fa fa-check me-1"></i> Completed</button>
                                        <% } %>
                                    </div>
                                    --%>
							</div>
							<%
							}
							%>
						</div>

						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>