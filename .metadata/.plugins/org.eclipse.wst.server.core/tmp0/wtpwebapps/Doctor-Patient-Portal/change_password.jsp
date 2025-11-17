<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
<%@include file="component/allcss.jsp"%>

<style>
/* ------------------------------
   GLOBAL & BACKGROUND
------------------------------ */
body, html {
    height: 100%;
    margin: 0;
    font-family: 'Poppins', sans-serif;
}

body {
    background: linear-gradient(
            rgba(0, 50, 150, 0.45),
            rgba(0, 50, 150, 0.45)
        ),
        url('img/hospital4.png') no-repeat center center fixed;
    background-size: cover;
    backdrop-filter: blur(6px);
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

/* Navbar */
.navbar {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1000;
}

/* Login Section */
.login-container {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding-top: 100px;
    padding-bottom: 50px;
}

/* Glassmorphic Card */
.login-card {
    width: 100%;
    max-width: 420px;
    border-radius: 20px;
    backdrop-filter: blur(18px);
    background: rgba(255, 255, 255, 0.12);
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
    color: #fff;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.login-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 10px 35px rgba(0, 0, 0, 0.5);
}

/* ------------------------------
   FORM INPUTS
------------------------------ */
.form-label {
    font-weight: 600;
    color: #eaf6ff;
}

.form-control {
    background-color: rgba(255, 255, 255, 0.15);
    color: #fff;
    border: 1px solid rgba(255, 255, 255, 0.4);
    border-radius: 12px;
    transition: 0.3s;
    padding: 10px 14px;
    font-size: 15px;
}

.form-control::placeholder {
    color: rgba(255, 255, 255, 0.7);
}

.form-control:focus {
    background-color: rgba(255, 255, 255, 0.25);
    border-color: #00b4ff;
    box-shadow: 0 0 8px rgba(0, 180, 255, 0.6);
    color: #fff;
    outline: none;
}

/* Validation states */
.is-invalid {
    border-color: #ff4d4d !important;
    box-shadow: 0 0 8px rgba(255, 77, 77, 0.7);
}

.is-valid {
    border-color: #00e676 !important;
    box-shadow: 0 0 8px rgba(0, 230, 118, 0.7);
}

/* ------------------------------
   BUTTON
------------------------------ */
.btn.my-bg-color {
    background: linear-gradient(135deg, #00c6ff, #0072ff);
    border: none;
    padding: 10px;
    font-weight: 600;
    border-radius: 12px;
    transition: 0.3s;
}

.btn.my-bg-color:hover {
    background: linear-gradient(135deg, #0072ff, #00c6ff);
    transform: scale(1.03);
    box-shadow: 0 0 10px rgba(0, 180, 255, 0.5);
}

/* ------------------------------
   ALERTS & COLORS
------------------------------ */
.alert {
    border-radius: 10px;
    font-weight: 500;
}

.myP-color {
    color: #00c6ff !important;
}

/* ------------------------------
   RESPONSIVE
------------------------------ */
@media (max-width: 768px) {
    .login-card {
        margin: 20px;
    }
    h3 {
        font-size: 1.4rem;
    }
}

@media (max-width: 480px) {
    .login-card {
        max-width: 90%;
    }
    .btn {
        font-size: 0.9rem;
    }
}
</style>

<!-- ✅ JS Validation -->
<script>
function validatePasswords() {
    const oldPass = document.getElementById("oldPassword");
    const newPass = document.getElementById("newPassword");
    const oldError = document.getElementById("oldError");
    const newError = document.getElementById("newError");

    const newPasswordPattern =
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

    let valid = true;

    // Reset states
    [oldPass, newPass].forEach(input => {
        input.classList.remove("is-invalid", "is-valid");
    });
    oldError.textContent = "";
    newError.textContent = "";

    // Old password validation
    if (oldPass.value.trim() === "") {
        oldError.textContent = "Old password is required.";
        oldPass.classList.add("is-invalid");
        valid = false;
    } else {
        oldPass.classList.add("is-valid");
    }

    // New password validation
    if (newPass.value.trim() === "") {
        newError.textContent = "New password is required.";
        newPass.classList.add("is-invalid");
        valid = false;
    } else if (!newPasswordPattern.test(newPass.value.trim())) {
        newError.textContent =
            "Password must be 8+ characters and include uppercase, lowercase, number, and special character.";
        newPass.classList.add("is-invalid");
        valid = false;
    } else {
        newPass.classList.add("is-valid");
    }

    return valid;
}

document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");
    const oldPass = document.getElementById("oldPassword");
    const newPass = document.getElementById("newPassword");

    // Live validation
    oldPass.addEventListener("input", validatePasswords);
    newPass.addEventListener("input", validatePasswords);

    form.addEventListener("submit", (e) => {
        if (!validatePasswords()) {
            e.preventDefault();
        }
    });
});
</script>
</head>

<body>
    <%@include file="component/navbar.jsp"%>

    <!-- Redirect if not logged in -->
    <c:if test="${empty userObj }">
        <c:redirect url="/user_login.jsp"></c:redirect>
    </c:if>

    <!-- Change Password Section -->
    <div class="container-fluid login-container">
        <div class="row">
            <div class="col-md-12">
                <div class="card my-card login-card">
                    <div class="card-body p-4 p-md-5">
                        <h3 class="fs-3 text-center myP-color mb-4">
                            <i class="fa fa-lock me-2"></i> Change Password
                        </h3>

                        <!-- Message Handling -->
                        <c:if test="${not empty successMsg }">
                            <div class="alert alert-success text-center" role="alert">${successMsg}</div>
                            <c:remove var="successMsg" scope="session" />
                        </c:if>
                        <c:if test="${not empty errorMsg }">
                            <div class="alert alert-danger text-center" role="alert">${errorMsg}</div>
                            <c:remove var="errorMsg" scope="session" />
                        </c:if>

                        <!-- Form -->
                        <form action="userChangePassword" method="post" novalidate>
                            <div class="mb-3">
                                <label class="form-label">Enter Old Password</label>
                                <input id="oldPassword" name="oldPassword" type="password"
                                    placeholder="Enter old password" class="form-control" required>
                                <div id="oldError" class="text-danger mt-1" style="font-size: 0.9em;"></div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Enter New Password</label>
                                <input id="newPassword" name="newPassword" type="password"
                                    placeholder="Enter new password" class="form-control" required>
                                <div id="newError" class="text-danger mt-1" style="font-size: 0.9em;"></div>
                            </div>

                            <input type="hidden" value="${userObj.id}" name="userId">
                            <button type="submit" class="btn my-bg-color text-white w-100 mt-3">
                                Change Password
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
