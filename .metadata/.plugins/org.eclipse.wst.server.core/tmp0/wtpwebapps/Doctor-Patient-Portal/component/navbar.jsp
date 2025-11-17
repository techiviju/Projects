<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<style>
/* ====== KILLER BLUE THEME NAVBAR ====== */
.blue-navbar {
  background: linear-gradient(90deg, #007bff 0%, #0056b3 100%);
  box-shadow: 0 4px 18px rgba(0, 91, 255, 0.35);
  transition: all 0.3s ease;
  padding: 0.6rem 1rem;
}

.blue-navbar.scrolled {
  background: linear-gradient(90deg, #0056b3 0%, #003d99 100%);
  box-shadow: 0 6px 25px rgba(0, 0, 0, 0.4);
}

/* Brand Styling */
.blue-navbar .navbar-brand {
  font-weight: 800;
  font-size: 1.3rem;
  color: #ffffff !important;
  text-transform: uppercase;
  display: flex;
  align-items: center;
  gap: 8px;
  text-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}

/* Nav Links */
.blue-navbar .nav-link {
  color: #ffffff !important;
  font-weight: 600;
  letter-spacing: 0.5px;
  padding: 0.6rem 1.2rem;
  border-radius: 8px;
  margin: 0 2px;
  transition: all 0.3s ease;
  position: relative;
}

.blue-navbar .nav-link:hover {
  background: rgba(255, 255, 255, 0.15);
  box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

/* Animated underline effect */
.blue-navbar .nav-link::after {
  content: "";
  position: absolute;
  bottom: 6px;
  left: 50%;
  width: 0;
  height: 2px;
  background-color: #ffffff;
  transition: all 0.3s ease;
  transform: translateX(-50%);
}
.blue-navbar .nav-link:hover::after {
  width: 60%;
}

/* Dropdown */
.blue-navbar .dropdown-menu {
  background-color: #ffffff;
  border: none;
  border-radius: 10px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
  animation: fadeIn 0.25s ease-in-out;
}
.blue-navbar .dropdown-item {
  font-weight: 500;
  color: #333;
  border-radius: 6px;
  transition: all 0.3s ease;
}
.blue-navbar .dropdown-item:hover {
  background: linear-gradient(90deg, #007bff, #0056b3);
  color: #fff;
  transform: translateX(4px);
}

/* Toggler */
.navbar-toggler {
  border: none;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 6px;
  transition: all 0.3s ease;
}
.navbar-toggler:hover {
  background: rgba(255, 255, 255, 0.3);
}

/* Animation */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
}

/* Responsive */
@media (max-width: 992px) {
  .blue-navbar .nav-link {
    text-align: center;
    display: block;
    margin: 6px 0;
  }
}
</style>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top blue-navbar">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">
      <i class="fa-solid fa-hospital"></i> Doctor Patient Portal
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
      data-bs-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent" aria-expanded="false"
      aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">

        <!-- Guest -->
        <c:if test="${empty userObj and empty doctorObj and empty adminObj}">
          <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fa fa-home me-1"></i> Home</a></li>
          <li class="nav-item"><a class="nav-link" href="user_appointment.jsp"><i class="fa fa-book me-1"></i> Appointment</a></li>
          <li class="nav-item"><a class="nav-link" href="user_login.jsp"><i class="fas fa-sign-in-alt me-1"></i> User</a></li>
          <li class="nav-item"><a class="nav-link" href="doctor_login.jsp"><i class="fa-solid fa-user-doctor me-1"></i> Doctor</a></li>
          <li class="nav-item"><a class="nav-link" href="admin_login.jsp"><i class="fa-solid fa-user-shield me-1"></i> Admin</a></li>
        </c:if>

        <!-- User -->
        <c:if test="${not empty userObj}">
          <li class="nav-item"><a class="nav-link" href="user_appointment.jsp"><i class="fa fa-book me-1"></i> Appointment</a></li>
          <li class="nav-item"><a class="nav-link" href="view_appointment.jsp"><i class="fa fa-calendar-check-o me-1"></i> View</a></li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <i class="fa-solid fa-circle-user me-1"></i> ${userObj.fullName}
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
              <li><a class="dropdown-item" href="change_password.jsp">Change Password</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="userLogout">Logout</a></li>
            </ul>
          </li>
        </c:if>

        <!-- Doctor/Admin Redirect -->
        <c:if test="${not empty doctorObj}">
          <c:redirect url="doctor/index.jsp" />
        </c:if>
        <c:if test="${not empty adminObj}">
          <c:redirect url="admin/index.jsp" />
        </c:if>
      </ul>
    </div>
  </div>
</nav>

<script>
document.addEventListener("scroll", () => {
  const nav = document.querySelector(".blue-navbar");
  if (window.scrollY > 10) nav.classList.add("scrolled");
  else nav.classList.remove("scrolled");
});
</script>
