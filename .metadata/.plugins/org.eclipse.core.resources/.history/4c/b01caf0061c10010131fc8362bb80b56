<%@page import="com.hms.entity.Appointment"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@page import="com.hms.db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Leave Comment</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="../component/allcss.jsp"%>
    
<style>
/* === CORE LAYOUT & BACKGROUND (Restored Blurred Image) === */
body {
    min-height: 100vh;
    font-family: 'Poppins', sans-serif;
    position: relative;
    padding-top: 70px; /* Space for fixed navbar */
    background-color: #e0f7fa; /* Fallback light blue color */
    display: flex;
    flex-direction: column;
}

/* Single Background Image and Blur */
body::before {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    /* This URL uses a common placeholder for a medical office environment */
    background-image: url('../img/hospital1.jpg');
    background-size: cover;
    background-position: center;
    filter: blur(8px) brightness(1.05); /* Apply blur and a slight brighten for better contrast */
    z-index: -1; /* Ensures content sits above the background */
    opacity: 0.9; /* Slightly transparent */
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

/* Clean Card Container - White with Shadow */
.my-card {
    background: rgba(255, 255, 255, 0.95); /* Slightly transparent white for a subtle depth effect */
    border-radius: 1rem;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15); 
    transition: box-shadow 0.3s ease;
    border: none;
}

.my-card:hover {
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
}

.card-body {
    padding: 2.5rem !important;
}

/* Form Styling */
.form-label {
    font-weight: 600;
    color: #343a40; 
    margin-bottom: 0.25rem;
    font-size: 0.9rem;
}

.form-control {
    border-radius: 0.5rem;
    border: 1px solid #ced4da;
    padding: 0.75rem 1rem;
    transition: border-color 0.3s, box-shadow 0.3s;
}

.form-control[readonly] {
    background-color: #f8f9fa; 
    opacity: 1; 
    font-weight: 500;
    color: #495057;
}

.form-control:not([readonly]):focus {
    border-color: #007bff;
    box-shadow: 0 0 0 0.15rem rgba(0, 123, 255, 0.25);
}

/* Custom Textarea for Comment */
textarea.form-control {
    min-height: 150px;
}

/* Submit Button Style */
.btn-submit {
    font-weight: 600;
    padding: 0.8rem 2.5rem;
    border-radius: 2rem;
    color: white;
    background-image: linear-gradient(to right, #007bff 0%, #00c6ff 100%);
    border: none;
    box-shadow: 0 4px 15px 0 rgba(0, 123, 255, 0.4);
    transition: all 0.3s ease;
    letter-spacing: 0.5px;
}

.btn-submit:hover {
    background-image: linear-gradient(to right, #00c6ff 0%, #007bff 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 20px 0 rgba(0, 123, 255, 0.6);
}

/* Responsive Adjustments */
@media (max-width: 767.98px) {
    .page-banner {
        height: 12vh;
        margin-bottom: 20px;
    }
    .page-banner h2 {
        font-size: 1.5rem;
    }
    .card-body {
        padding: 1.5rem !important;
    }
    .col-md-6 {
        margin-bottom: 15px; 
    }
    .btn-submit {
        width: 100% !important; 
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
        <h2><i class="fa fa-calendar-check me-2"></i> Leave a Treatment Comment</h2>
    </div>

    <div class="container p-4">
        <div class="row justify-content-center">
            <div class="col-12 col-md-10 col-lg-8">
                <div class="card my-card">
                    <div class="card-body">
                        
                        <!-- Message Handling -->
                        <c:if test="${not empty successMsg }">
                            <div class="alert alert-success text-center border-0 rounded-pill mb-4" role="alert"><i class="fa-solid fa-check-circle me-1"></i> ${successMsg}</div>
                            <c:remove var="successMsg" scope="session" />
                        </c:if>
                        <c:if test="${not empty errorMsg }">
                            <div class="alert alert-danger text-center border-0 rounded-pill mb-4" role="alert"><i class="fa-solid fa-times-circle me-1"></i> ${errorMsg}</div>
                            <c:remove var="errorMsg" scope="session" />
                        </c:if>

                        <%
                            // JSP Logic to fetch Appointment Details
                            int id = Integer.parseInt(request.getParameter("id"));
                            AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
                            Appointment appointment = appDAO.getAppointmentById(id);
                        %>
                        
                        <form class="g-3" action="../updateStatus" method="post">
                            <h5 class="text-center text-primary mb-4 pb-2 border-bottom">Patient Details</h5>
                            <div class="row g-3">
                                
                                <div class="col-12 col-md-6">
                                    <label class="form-label"><i class="fa-solid fa-user me-1"></i> Full Name</label> 
                                    <input name="fullName" type="text" class="form-control" readonly value="<%= appointment.getFullName()%>">
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="form-label"><i class="fa-solid fa-baby me-1"></i> Age</label> 
                                    <input name="age" type="text" class="form-control" readonly value="<%= appointment.getAge()%>">
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="form-label"><i class="fa-solid fa-phone me-1"></i> Phone</label> 
                                    <input name="phone" type="text" class="form-control" readonly value="<%= appointment.getPhone()%>">
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="form-label"><i class="fa-solid fa-virus-covid me-1"></i> Diseases</label> 
                                    <input name="diseases" type="text" class="form-control" readonly value="<%= appointment.getDiseases()%>">
                                </div>
                                
                                <div class="col-12 mt-4">
                                    <label class="form-label h5 text-primary"><i class="fa-solid fa-file-signature me-2"></i> Treatment/Prescription Notes</label>
                                    <textarea name="comment" placeholder="Enter your detailed diagnosis, prescribed medications, and follow-up instructions here..." class="form-control" rows="6" required></textarea>
                                </div>
                                
                                <!-- Hidden fields to pass IDs -->
                                <input type="hidden" name="id" value="<%= appointment.getId()%>">
                                <input type="hidden" name="doctorId" value="<%= appointment.getDoctorId()%>">
                                
                                <div class="col-12 text-center mt-5">
                                    <button type="submit" class="btn btn-submit w-md-50 w-75">
                                        <i class="fa-solid fa-paper-plane me-2"></i> Submit Treatment
                                    </button>
                                </div>
                            </div>
                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>