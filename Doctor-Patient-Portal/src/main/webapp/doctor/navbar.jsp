<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!-- Doctor Navbar - Green Theme -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success fixed-top">
    <div class="container-fluid">
        <!-- Main site logo/name -->
        <a class="navbar-brand" href="index.jsp">
             <i class="fa-sharp fa-solid fa-hospital me-2"></i> Doctor Patient Portal
        </a>
        
        <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse" data-bs-target="#doctorNavbar"
            aria-controls="doctorNavbar" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="doctorNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index.jsp"><i class="fa fa-home me-1"></i> HOME</a>
                </li>
                
                <!-- Link to Appointment History page -->
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="patient.jsp">
                        <i class="fa-solid fa-calendar-alt me-1"></i> APPOINTMENTS
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <!-- Check if Doctor is logged in -->
                <c:if test="${not empty doctorObj }">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa-solid fa-circle-user me-1"></i> ${doctorObj.fullName}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="edit_profile.jsp"><i class="fa-solid fa-user-edit me-2"></i> Edit Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="../doctorLogout"><i class="fa-solid fa-right-from-bracket me-2"></i> Logout</a></li>
                        </ul>
                    </li>
                </c:if>
                
                <!-- If doctor is not in session, redirect to login -->
                <c:if test="${empty doctorObj }">
                    <c:redirect url="../doctor_login.jsp" />
                </c:if>
            </ul>
        </div>
    </div>
</nav>