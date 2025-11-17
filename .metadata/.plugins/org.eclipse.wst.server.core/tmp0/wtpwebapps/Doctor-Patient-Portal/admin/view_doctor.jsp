<%@page import="com.hms.entity.Doctor"%>

<%@page import="com.hms.dao.DoctorDAO"%>

<%@page import="java.util.List"%>

<%@page import="com.hms.db.DBConnection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@page isELIgnored="false"%>



<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>View Doctors</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <%@include file="../component/allcss.jsp"%>



<style>

/* === CORE LAYOUT & BACKGROUND === */

body {

    background-color: #f0f4f8;

    min-height: 100vh;

    font-family: 'Poppins', sans-serif;

    position: relative;

 

    display: flex;

    flex-direction: column;

}



/* Background Image (Using a generic professional placeholder path) */

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



.action-btn {

    border-radius: 0.5rem;

    font-weight: 500;

}



/* === MOBILE STYLES (Switches from table to cards) === */

@media (max-width: 767.98px) {

    /* Hide the traditional table on mobile */

    .table-responsive {

        display: none;

    }



    /* Show the card layout on mobile */

    .mobile-cards {

        display: block !important;

    }



    .doctor-card {

        background: #fff;

        border-radius: 0.75rem;

        padding: 15px;

        margin-bottom: 15px;

        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);

        border-left: 5px solid #28a745; /* Green accent */

    }



    .card-detail {

        display: flex;

        justify-content: space-between;

        align-items: center;

        padding: 5px 0;

        border-bottom: 1px dashed #eee;

    }



    .card-detail:first-child {

        border-bottom: 2px solid #007bff; /* Highlight Name */

        margin-bottom: 10px;

        padding-bottom: 10px;

        font-size: 1.1em;

        font-weight: 700;

        color: #007bff;

    }

   

    .card-detail:last-child {

        border-bottom: none;

    }



    .card-label {

        font-weight: 600;

        color: #555;

        flex-basis: 45%;

    }



    .card-value {

        text-align: right;

        flex-basis: 55%;

        color: #333;

    }

   

    .card-action {

        display: flex;

        gap: 10px;

        padding-top: 15px;

        justify-content: space-around;

    }

    .card-action .btn {

        flex-grow: 1;

    }

}



/* Hide mobile cards on desktop */

@media (min-width: 768px) {

    .mobile-cards {

        display: none;

    }

}

</style>



</head>

<body>

    <!-- Navbar should be included here -->

    <%@include file="navbar.jsp"%>



    <div class="container-fluid p-4">

        <div class="row">

            <div class="col-md-12">

                <div class="card my-card">

                    <div class="card-body p-md-5 p-3">

                        <h3 class="text-center myP-color mb-4">List of Doctors</h3>

                       

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

                            DoctorDAO docDAO2 = new DoctorDAO(DBConnection.getConn());

                            List<Doctor> listOfDoc = docDAO2.getAllDoctor();

                        %>

                       

                        <% if (listOfDoc.isEmpty()) { %>

                            <div class="text-center text-muted py-4">No doctor records found in the system.</div>

                        <% } else { %>

                       

                            <!-- 1. DESKTOP/TABLET TABLE VIEW -->

                            <div class="table-responsive">

                                <table class="table table-striped table-hover align-middle">

                                    <thead>

                                        <tr>

                                            <th scope="col">Full Name</th>

                                            <th scope="col">DOB</th>

                                            <th scope="col">Qualification</th>

                                            <th scope="col">Specialist</th>

                                            <th scope="col">Email</th>

                                            <th scope="col">Phone</th>

                                            <th scope="col" class="text-center">Action</th>

                                        </tr>

                                    </thead>

                                    <tbody>

                                        <%

                                            for (Doctor doctorLst : listOfDoc) {

                                        %>

                                        <tr>

                                            <td><%=doctorLst.getFullName()%></td>

                                            <td><%=doctorLst.getDateOfBirth()%></td>

                                            <td><%=doctorLst.getQualification()%></td>

                                            <td><%=doctorLst.getSpecialist()%></td>

                                            <td><%=doctorLst.getEmail()%></td>

                                            <td><%=doctorLst.getPhone()%></td>

                                            <td class="text-center">

                                                <a class="btn btn-sm btn-primary action-btn" href="edit_doctor.jsp?id=<%=doctorLst.getId()%>">Edit</a>

                                                <a class="btn btn-sm btn-danger action-btn" href="../deleteDoctor?id=<%= doctorLst.getId() %>">Delete</a>

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

                                <% for (Doctor doctorLst : listOfDoc) { %>

                                <div class="doctor-card">

                                    <div class="card-detail">

                                        <%=doctorLst.getFullName()%>

                                    </div>

                                    <div class="card-detail">

                                        <div class="card-label">Specialist</div>

                                        <div class="card-value badge bg-info text-white"><%=doctorLst.getSpecialist()%></div>

                                    </div>

                                    <div class="card-detail">

                                        <div class="card-label">Qualification</div>

                                        <div class="card-value"><%=doctorLst.getQualification()%></div>

                                    </div>

                                    <div class="card-detail">

                                        <div class="card-label">DOB</div>

                                        <div class="card-value"><%=doctorLst.getDateOfBirth()%></div>

                                    </div>

                                    <div class="card-detail">

                                        <div class="card-label">Email</div>

                                        <div class="card-value"><%=doctorLst.getEmail()%></div>

                                    </div>

                                    <div class="card-detail">

                                        <div class="card-label">Phone</div>

                                        <div class="card-value"><%=doctorLst.getPhone()%></div>

                                    </div>

                                    <div class="card-action">

                                        <a class="btn btn-primary action-btn" href="edit_doctor.jsp?id=<%=doctorLst.getId()%>">

                                            <i class="fa-solid fa-edit me-1"></i> Edit

                                        </a>

                                        <a class="btn btn-danger action-btn" href="../deleteDoctor?id=<%= doctorLst.getId() %>">

                                            <i class="fa-solid fa-trash-alt me-1"></i> Delete

                                        </a>

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