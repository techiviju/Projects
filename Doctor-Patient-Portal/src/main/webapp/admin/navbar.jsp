<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!-- Admin Navbar - Dark Theme -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container-fluid">
        <!-- UPDATED: Restored main site logo -->
        <a class="navbar-brand" href="index.jsp">
            <i class="fa-sharp fa-solid fa-hospital me-2"></i> Doctor Patient Portal
        </a>
        
        <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse" data-bs-target="#adminNavbar"
            aria-controls="adminNavbar" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="adminNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link active"
                    aria-current="page" href="index.jsp"><i class="fa fa-home me-1"></i> HOME</a></li>
                <li class="nav-item"><a class="nav-link active"
                    aria-current="page" href="doctor.jsp"><i
                        class="fa-solid fa-user-doctor me-1"></i> DOCTOR</a></li>
                <li class="nav-item"><a class="nav-link active"
                    aria-current="page" href="view_doctor.jsp"><i
                        class="fa-solid fa-list me-1"></i> VIEW DOCTOR</a></li>
                <li class="nav-item"><a class="nav-link active"
                    aria-current="page" href="patient.jsp"><i
                        class="fa-solid fa-user-injured me-1"></i> PATIENT APPOINTMENTS</a></li>
            </ul>
            
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <!-- Check if Admin is logged in -->
                <c:if test="${not empty adminObj }">
                     <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                           <i class="fa-solid fa-user-shield me-1"></i> Admin
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="../adminLogout"><i class="fa-solid fa-right-from-bracket me-2"></i> Logout</a></li>
                        </ul>
                    </li>
                </c:if>
                
                <!-- If admin is not in session, redirect to login -->
                <c:if test="${empty adminObj }">
                    <c:redirect url="../admin_login.jsp" />
                </c:if>
            </ul>
        </div>
    </div>
</nav>