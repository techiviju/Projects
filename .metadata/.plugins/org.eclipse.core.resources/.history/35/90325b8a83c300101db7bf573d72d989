<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Details | Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="../component/allcss.jsp"%>

<style>
/* === CORE LAYOUT & BACKGROUND === */
body {
    background-color: #f0f4f8; 
    min-height: 100vh;
    font-family: 'Poppins', sans-serif;
    position: relative;
    /* Space for the fixed-top navbar */
     
    display: flex;
    flex-direction: column;
}

/* Background Image */
body::before {
    content: "";
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    /* Ensure you replace this with your actual image path for the Admin portal */
    background: url('../img/hospital1.jpg') center center/cover no-repeat fixed;
    filter: blur(8px) brightness(1.05);
    opacity: 0.95;
    z-index: -1;
}

/* Glass Morphism Card Container */
.my-card {
    /* Glass effect background */
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-radius: 1.5rem;
    border: 1px solid rgba(255, 255, 255, 0.5);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    width: 100%;
    margin-top: 0;
}

/* Header Styling */
.myP-color {
    color: #007bff; /* Primary blue color */
    font-weight: 700;
}

/* Table Styling (Desktop/Tablet) */
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

/* Badge Fix for status column */
.table td .badge {
    padding: 0.5em 0.8em;
    font-size: 0.9em;
    min-width: 80px;
    display: inline-block;
}


/* === MOBILE STYLES (Switches from table to cards) === */
@media (max-width: 991.98px) { /* Changed breakpoint slightly for wider table on medium screens */
    /* Hide the traditional table on mobile */
    .table-responsive {
        display: none;
    }

    /* Show the card layout on mobile */
    .mobile-cards {
        display: block !important;
    }

    .patient-card {
        background: #fff;
        border-radius: 0.75rem;
        padding: 15px;
        margin-bottom: 20px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        border-left: 5px solid #007bff; /* Blue accent */
    }

    .card-detail {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        padding: 8px 0;
        border-bottom: 1px dashed #eee;
    }

    /* Highlight Name and Doctor */
    .card-detail:nth-child(1) {
        border-bottom: 2px solid #007bff;
        margin-bottom: 10px;
        padding-bottom: 10px;
        font-size: 1.2em;
        font-weight: 700;
        color: #007bff;
        flex-direction: column; /* Stacks name and doctor */
    }
    
    .card-detail:nth-child(1) .card-value {
    	font-size: 0.8em;
    	font-weight: 400;
    	color: #6c757d;
    	margin-top: 5px;
    }

    .card-detail:last-child {
        border-bottom: none;
    }

    .card-label {
        font-weight: 600;
        color: #555;
        flex-basis: 45%;
        margin-right: 10px;
    }

    .card-value {
        text-align: right;
        flex-basis: 55%;
        color: #333;
        word-break: break-all;
    }
}

/* Hide mobile cards on desktop */
@media (min-width: 992px) {
    .mobile-cards {
        display: none;
    }
}
</style>

</head>
<body>
    <%@include file="navbar.jsp"%>

    <div class="container-fluid p-4">
        <div class="row">
            <div class="col-md-12">
                <div class="card my-card">
                    <div class="card-body p-md-5 p-3">
                        <h3 class="text-center myP-color mb-4">Patient Details</h3>
                        
                        <%
                            AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
                            DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
                            List<Appointment> list = appDAO.getAllAppointment();
                        %>
                        
                        <% if (list.isEmpty()) { %>
                            <div class="text-center text-muted py-4">No patient appointment records found in the system.</div>
                        <% } else { %>

                            <!-- 1. DESKTOP/TABLET TABLE VIEW (Visible on larger screens) -->
                            <div class="table-responsive">
                                <table class="table table-striped table-hover align-middle">
                                    <thead>
                                        <tr>
                                            <th scope="col">Full Name</th>
                                            <th scope="col">Doctor Name</th>
                                            <th scope="col">Date & Time</th>
                                            <th scope="col">Gender/Age</th>
                                            <th scope="col">Diseases</th>
                                            <th scope="col">Email/Phone</th>
                                            <th scope="col">Address</th>
                                            <th scope="col" class="text-center">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (Appointment appList : list) {
                                                Doctor doctor = docDAO.getDoctorById(appList.getDoctorId());
                                        %>
                                        <tr>
                                            <td><%= appList.getFullName() %></td>
                                            <td><i class="fa-solid fa-user-md me-1 text-info"></i> <%= doctor.getFullName()%></td>
                                            <td><%= appList.getAppointmentDate()%></td>
                                            <td><%= appList.getGender() %> / <%= appList.getAge() %></td>
                                            <td><%= appList.getDiseases()%></td>
                                            <td>
                                                <i class="fa-solid fa-envelope"></i> <%= appList.getEmail()%><br>
                                                <i class="fa-solid fa-phone"></i> <%= appList.getPhone()%>
                                            </td>
                                            <td><%= appList.getAddress()%></td>
                                            <td class="text-center">
                                                <%
                                                    if ("Pending".equals(appList.getStatus())) {
                                                %> <span class="badge bg-warning text-dark">Pending</span> <%
                                                    } else {
                                                %> <span class="badge bg-success"><%=appList.getStatus()%></span> <%
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
                            
                            <!-- 2. MOBILE CARD VIEW (Initially hidden on desktop) -->
                            <div class="mobile-cards d-none">
                                <% for (Appointment appList : list) {
                                    Doctor doctor = docDAO.getDoctorById(appList.getDoctorId());
                                %>
                                <div class="patient-card">
                                    <!-- Name and Doctor (Header) -->
                                    <div class="card-detail">
                                        <%=appList.getFullName()%>
                                        <div class="card-value"><i class="fa-solid fa-user-md me-1"></i> Dr. <%= doctor.getFullName()%></div>
                                    </div>
                                    
                                    <!-- Status -->
                                    <div class="card-detail">
                                        <div class="card-label">Status</div>
                                        <div class="card-value">
                                            <%
                                                if ("Pending".equals(appList.getStatus())) {
                                            %> <span class="badge bg-warning text-dark">Pending</span> <%
                                                } else {
                                            %> <span class="badge bg-success"><%=appList.getStatus()%></span> <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                    
                                    <div class="card-detail">
                                        <div class="card-label">Appointment Date</div>
                                        <div class="card-value"><i class="fa-solid fa-calendar-alt me-1"></i> <%= appList.getAppointmentDate()%></div>
                                    </div>
                                    <div class="card-detail">
                                        <div class="card-label">Gender / Age</div>
                                        <div class="card-value"><%= appList.getGender() %> / <%= appList.getAge() %></div>
                                    </div>
                                    <div class="card-detail">
                                        <div class="card-label">Diseases</div>
                                        <div class="card-value"><%= appList.getDiseases()%></div>
                                    </div>
                                    <div class="card-detail">
                                        <div class="card-label">Email</div>
                                        <div class="card-value"><i class="fa-solid fa-envelope me-1"></i> <%= appList.getEmail()%></div>
                                    </div>
                                    <div class="card-detail">
                                        <div class="card-label">Phone</div>
                                        <div class="card-value"><i class="fa-solid fa-phone me-1"></i> <%= appList.getPhone()%></div>
                                    </div>
                                    <div class="card-detail">
                                        <div class="card-label">Address</div>
                                        <div class="card-value text-wrap text-break"><%= appList.getAddress()%></div>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>