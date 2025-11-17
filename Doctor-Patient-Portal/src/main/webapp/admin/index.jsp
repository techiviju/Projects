<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="../component/allcss.jsp"%>

    <style>
        /* === PAGE BASE AND BACKGROUND === */
        body {
            background-color: #f8faff; /* Very light, clean base */
            min-height: 100vh;
            font-family: 'Poppins', sans-serif;
            position: relative;
            padding-top: 70px; /* Crucial: Space for fixed navbar */
        }
        
        /* Ensure the included navbar is fixed */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
        }

        /* Blurred Background Image (Matches shared visual style) */
        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            /* Assuming the path for the background image */
            background: url('../img/hospital1.jpg') center center/cover no-repeat fixed;
            filter: blur(10px) brightness(1.05); /* Strong blur and slightly brighter */
            opacity: 0.85; /* Allows the white cards to pop */
            z-index: -1;
        }

        /* Main Dashboard Wrapper */
        .dashboard-wrapper {
            padding: 20px;
            max-width: 1300px;
            margin: 30px auto;
            position: relative;
            z-index: 10;
        }

        /* Main Heading Style */
        .dashboard-wrapper h2 {
            font-weight: 800;
            color: #1e88e5; /* Primary Blue */
            margin-bottom: 40px;
            padding-bottom: 10px;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.05);
            /* A subtle underglow/border effect */
            border-bottom: 4px solid #1e88e5;
            display: inline-block;
        }
        
        /* The Killer Stat Card Style (Glass Morphism) */
        .my-card {
            /* Glass effect */
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            border-radius: 1.5rem;
            border: 1px solid rgba(220, 220, 220, 0.7);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            overflow: hidden; /* Ensures child elements don't poke out */
            min-height: 250px; /* Ensure visual consistency */
            display: flex;
            flex-direction: column;
        }

        .my-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.25);
        }

        .my-card .card-body {
            flex-grow: 1;
            padding: 2.5rem 1.5rem 1.5rem 1.5rem;
        }

        .my-card i {
            color: #1e88e5; /* Icon color */
            transition: color 0.3s ease;
        }

        .my-card h4 {
            font-weight: 600;
            color: #333;
            margin-top: 15px;
            font-size: 1.35rem;
        }

        .my-card h5.fs-1 {
            font-weight: 900;
            color: #2c3e50; /* Darker number for impact */
            margin-bottom: 0;
            line-height: 1.2;
        }
        
        .my-card .card-footer {
            padding: 0.75rem 1.5rem;
            border-top: 1px solid rgba(0, 0, 0, 0.05);
            background: rgba(255, 255, 255, 0.8);
        }
        
        /* Button Styling */
        .btn-primary {
            background-color: #1e88e5;
            border-color: #1e88e5;
            font-weight: 600;
            border-radius: 0.5rem;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        
        .btn-primary:hover {
            background-color: #1565c0;
            border-color: #1565c0;
            transform: translateY(-1px);
        }

        /* Modal Styling */
        .modal-content {
            border-radius: 1rem;
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.98);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
            border: none;
        }

        /* Responsive Grid Adjustments */
        /* Default: 1 column on extra small screens */
        /* sm: 2 columns, lg: 4 columns */
        @media (min-width: 576px) and (max-width: 991px) {
            /* Tablet/Small Desktop: 2 columns */
            .row.g-4 > div[class*="col-"] {
                flex: 0 0 auto;
                width: 50%;
            }
        }
        
        @media (max-width: 575px) {
            /* Mobile: 1 column */
            .row.g-4 > div[class*="col-"] {
                width: 100%;
            }
            .dashboard-wrapper h2 {
                font-size: 1.8rem;
                text-align: center;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@include file="navbar.jsp"%>

    <div class="dashboard-wrapper">
        <div class="row">
            <div class="col-12 text-center">
                <h2 class="myP-color text-center">Admin Dashboard</h2>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <!-- Message Handling -->
                <c:if test="${not empty successMsg }">
                    <div class="alert alert-success text-center" role="alert">${successMsg}</div>
                    <c:remove var="successMsg" scope="session" />
                </c:if>
                <c:if test="${not empty errorMsg }">
                    <div class="alert alert-danger text-center" role="alert">${errorMsg}</div>
                    <c:remove var="errorMsg" scope="session" />
                </c:if>
            </div>
        </div>

        <%
            // --- BACKEND LOGIC START (DO NOT DISTURB) ---
            DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
            int totalNumberOfDoctor = docDAO.countTotalDoctor();
            int totalNumberOfUser = docDAO.countTotalUser();
            int totalNumberOfAppointment = docDAO.countTotalAppointment();
            int totalNumberOfSpecialist = docDAO.countTotalSpecialist();
            // --- BACKEND LOGIC END (DO NOT DISTURB) ---
        %>

        <!-- Stat Cards Row 1: Responsive Grid (4 columns on large screens, 2 on tablet, 1 on mobile) -->
        <div class="row g-4 mt-2">
            
            <!-- Card 1: Doctor Count -->
            <div class="col-12 col-sm-6 col-md-6 col-lg-3">
                <div class="card my-card">
                    <div class="card-body text-center">
                        <i class="fa-solid fa-user-doctor fa-3x"></i>
                        <h4 class="mt-3">Doctors</h4>
                        <h5 class="fs-1"><%= totalNumberOfDoctor %></h5>
                    </div>
                </div>
            </div>
            
            <!-- Card 2: User Count -->
            <div class="col-12 col-sm-6 col-md-6 col-lg-3">
                <div class="card my-card">
                    <div class="card-body text-center">
                        <i class="fas fa-user-circle fa-3x"></i>
                        <h4 class="mt-3">Users</h4>
                        <h5 class="fs-1"><%= totalNumberOfUser %></h5>
                    </div>
                </div>
            </div>

            <!-- Card 3: Appointment Count -->
            <div class="col-12 col-sm-6 col-md-6 col-lg-3">
                <div class="card my-card">
                    <div class="card-body text-center">
                        <i class="fa-solid fa-calendar-check fa-3x"></i>
                        <h4 class="mt-3">Appointments</h4>
                        <h5 class="fs-1"><%= totalNumberOfAppointment %></h5>
                    </div>
                </div>
            </div>
            
            <!-- Card 4: Specialist Count (with Modal Trigger) -->
            <div class="col-12 col-sm-6 col-md-6 col-lg-3">
                <div class="card my-card">
                    <div class="card-body text-center">
                        <i class="fa-solid fa-stethoscope fa-3x"></i>
                        <h4 class="mt-3">Specialists</h4>
                        <h5 class="fs-1"><%= totalNumberOfSpecialist %></h5>
                    </div>
                    <div class="card-footer bg-transparent border-0 text-center">
                        <button class="btn btn-primary w-100" data-bs-toggle="modal"
                            data-bs-target="#specialistModal">Add Specialist</button>
                    </div>
                </div>
            </div>
        </div>

    </div> <!-- End Dashboard Wrapper -->


    <!-- Specialist Modal -->
    <div class="modal fade" id="specialistModal" tabindex="-1"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel" style="color: #1e88e5; font-weight: 700;">Add Specialist</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="../addSpecialist" method="post">
                        <div class="form-group mb-4">
                            <label class="form-label" style="font-weight: 600;">Enter Specialist Name</label> 
                            <input type="text" name="specialistName" placeholder="e.g., General Physician" class="form-control" required style="border-radius: 0.5rem; padding: 0.75rem;" />
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary w-50">Add</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
</body>
</html>