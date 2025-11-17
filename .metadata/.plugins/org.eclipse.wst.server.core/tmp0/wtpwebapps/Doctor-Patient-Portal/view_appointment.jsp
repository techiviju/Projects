<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.User"%>
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
    <title>My Appointments</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="component/allcss.jsp"%>

    <style>
    /* ------------------------------
       GLASS MORPHISM THEME
    ------------------------------ */
    
    body {
        min-height: 100vh;
        margin: 0;
        padding: 0;
        position: relative;
        overflow-x: hidden;
        background-color: #f0f8ff; 
        font-family: 'Poppins', sans-serif;
        display: flex;
        flex-direction: column;
    }

    /* --- BLURRED BACKGROUND IMAGE (Behind Content) --- */
    body::before {
        content: "";
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: url('img/hospital1.jpg');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        filter: blur(3px) brightness(1.1); 
        opacity: 0.6; 
        z-index: -1;
    }

    /* Navbar remains sharp on top */
    .navbar {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        z-index: 1000;
    }

    /* Page Banner (Slightly frosted glass header) */
    .page-banner {
        margin-top: 80px;
        padding: 50px 20px;
        text-align: center;
        /* Frosted Glass Effect */
        background: rgba(255, 255, 255, 0.7);
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.5);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        z-index: 10;
        position: relative;
    }

    .page-banner h2 {
        color: #2196F3; 
        font-weight: 700;
        font-size: 2.2rem;
        text-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    /* Appointment Container for Centering */
    .appointment-container {
        flex: 1;
        padding: 40px 20px;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        z-index: 10; 
    }

    /* Main Content Card (Strong Glass Effect) */
    .appointment-card {
        width: 100%;
        max-width: 1100px;
        background: rgba(255, 255, 255, 0.95); /* Slightly less transparent */
        backdrop-filter: blur(15px);
        border-radius: 20px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
        border: 1px solid rgba(255, 255, 255, 0.5);
        padding: 35px;
        color: #000;
        transition: all 0.3s ease;
    }

    .appointment-card h3 {
        color: #2196F3; 
        text-align: center;
        font-weight: 700;
        margin-bottom: 25px;
    }

    /* ------------------------------
       TABLE STYLING (Desktop/Tablet)
    ------------------------------ */
    .table-custom th {
        background: #2196F3; 
        color: #ffffff;
        font-weight: 600;
        white-space: nowrap;
    }

    .table-custom tbody tr {
        background: rgba(255, 255, 255, 0.98); 
        border-radius: 8px;
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
        margin-bottom: 10px;
        display: table-row;
    }
    
    /* Remove default table spacing and add custom spacing via margin-bottom */
    .table-custom {
        border-collapse: separate;
        border-spacing: 0 10px;
        width: 100%;
    }
    
    .table-custom td {
        vertical-align: middle;
        padding: 12px;
    }

    .badge {
        font-size: 0.85rem;
        border-radius: 12px;
        padding: 6px 14px;
        font-weight: 600;
        min-width: 80px;
        display: inline-block;
        text-align: center;
    }
    
    /* ------------------------------
       MOBILE CARD STYLING 
    ------------------------------ */
    /* Hide cards by default, show table */
    .mobile-cards {
        display: none; 
    }

    @media (max-width: 768px) {
        /* Hide table on mobile */
        .table-responsive {
            display: none;
        }
        /* Show cards on mobile */
        .mobile-cards {
            display: block !important;
        }

        .appointment-card {
            padding: 20px;
        }
        
        .appt-item-card {
            background: #fff;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #2196F3; /* Blue accent */
        }

        .card-detail {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px dashed #eee;
        }

        /* Highlight Name and Doctor at the top */
        .card-detail:nth-child(1) {
            border-bottom: 2px solid #2196F3;
            margin-bottom: 10px;
            padding-bottom: 10px;
            font-size: 1.1em;
            font-weight: 700;
            color: #2196F3;
            flex-direction: column; 
            align-items: flex-start;
        }
        
        .card-detail:nth-child(1) .card-value {
        	font-size: 0.8em;
        	font-weight: 500;
        	color: #6c757d;
        	margin-top: 5px;
        }

        .card-detail:last-child {
            border-bottom: none;
        }

        .card-label {
            font-weight: 600;
            color: #555;
            flex-basis: 40%;
            margin-right: 10px;
        }

        .card-value {
            text-align: right;
            flex-basis: 60%;
            color: #333;
            word-break: break-all;
        }
    }
    </style>
</head>

<body>
    <%@include file="component/navbar.jsp"%>

    <!-- Redirect if not logged in -->
    <c:if test="${empty userObj }">
        <c:redirect url="/user_login.jsp"></c:redirect>
    </c:if>

    <!-- Page Header -->
    <div class="page-banner">
        <h2><i class="fa fa-calendar-check me-2"></i> My Appointments</h2>
    </div>

    <!-- Appointment List -->
    <div class="appointment-container">
        <div class="appointment-card">
            <h3><i class="fa fa-list-ul me-2"></i> Appointment List</h3>

            <%
                User user = (User) session.getAttribute("userObj");
                DoctorDAO dDAO = new DoctorDAO(DBConnection.getConn());
                AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
                List<Appointment> list = appDAO.getAllAppointmentByLoginUser(user.getId());
            %>

            <% if (list.isEmpty()) { %>
                <div class="text-center text-muted py-4">You have no scheduled appointments.</div>
            <% } else { %>
            
                <!-- 1. DESKTOP/TABLET TABLE VIEW -->
                <div class="table-responsive">
                    <table class="table table-custom align-middle">
                        <thead>
                            <tr>
                                <th>Patient Name</th>
                                <th>Doctor</th>
                                <th>Date & Time</th>
                                <th>Gender/Age</th>
                                <th>Diseases</th>
                                <th>Phone</th>
                                <th class="text-center">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Appointment apptList : list) {
                                    Doctor doctor = dDAO.getDoctorById(apptList.getDoctorId());
                            %>
                            <tr>
                                <td><%=apptList.getFullName()%></td>
                                <td><i class="fa-solid fa-user-md me-1 text-info"></i> <%=doctor.getFullName()%></td>
                                <td><%=apptList.getAppointmentDate()%></td>
                                <td><%=apptList.getGender()%> / <%=apptList.getAge()%></td>
                                <td><%=apptList.getDiseases()%></td>
                                <td><%=apptList.getPhone()%></td>
                                <td class="text-center">
                                    <%
                                        if ("Pending".equals(apptList.getStatus())) {
                                    %> 
                                        <span class="badge bg-warning">Pending</span> 
                                    <%
                                        } else {
                                    %> 
                                        <span class="badge bg-success"><%=apptList.getStatus()%></span> 
                                    <%
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

                <!-- 2. MOBILE CARD VIEW -->
                <div class="mobile-cards">
                    <% for (Appointment apptList : list) {
                        Doctor doctor = dDAO.getDoctorById(apptList.getDoctorId());
                    %>
                    <div class="appt-item-card">
                        <!-- Name and Doctor (Header) -->
                        <div class="card-detail">
                            <%=apptList.getFullName()%>
                            <div class="card-value"><i class="fa-solid fa-user-md me-1"></i> Dr. <%= doctor.getFullName()%></div>
                        </div>
                        
                        <!-- Status -->
                        <div class="card-detail">
                            <div class="card-label">Status</div>
                            <div class="card-value">
                                <%
                                    if ("Pending".equals(apptList.getStatus())) {
                                %> <span class="badge bg-warning">Pending</span> <%
                                    } else {
                                %> <span class="badge bg-success"><%=apptList.getStatus()%></span> <%
                                    }
                                %>
                            </div>
                        </div>

                        <div class="card-detail">
                            <div class="card-label">Appointment Date</div>
                            <div class="card-value"><i class="fa-solid fa-calendar-alt me-1"></i> <%= apptList.getAppointmentDate()%></div>
                        </div>
                        <div class="card-detail">
                            <div class="card-label">Gender / Age</div>
                            <div class="card-value"><%= apptList.getGender() %> / <%= apptList.getAge() %></div>
                        </div>
                        <div class="card-detail">
                            <div class="card-label">Diseases</div>
                            <div class="card-value"><%= apptList.getDiseases()%></div>
                        </div>
                        <div class="card-detail">
                            <div class="card-label">Phone</div>
                            <div class="card-value"><i class="fa-solid fa-phone me-1"></i> <%= apptList.getPhone()%></div>
                        </div>
                    </div>
                    <% } %>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>