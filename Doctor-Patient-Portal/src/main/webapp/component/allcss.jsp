<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Bootstrap CSS -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
    crossorigin="anonymous">

<!-- Font Awesome CSS (for icons) -->
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
    integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- Bootstrap JS -->
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>

<!-- Global Custom Styles -->
<style type="text/css">
    /* ======================================
       THEME COLORS & VARIABLES
       ====================================== */
    :root {
        --primary-color: #4568dc;
        --primary-hover: #3654b3;
        --accent-color: #00c6ff;
        --light-bg: #f8f9fa;
        --dark-text: #2d2d2d;
        --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        --transition-speed: 0.3s;
    }

    body {
        font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        background-color: var(--light-bg);
        color: var(--dark-text);
        margin: 0;
        padding: 0;
        overflow-x: hidden;
    }

    /* ======================================
        REUSABLE CLASSES
       ====================================== */
    .my-bg-color { background-color: var(--primary-color) !important; }
    .myP-color { color: var(--primary-color) !important; }
    .my-hover:hover { color: var(--primary-hover) !important; }

    /* Button Enhancements */
    .btn.my-bg-color {
        background-color: var(--primary-color);
        border-color: var(--primary-color);
        font-weight: 500;
        transition: background-color var(--transition-speed);
    }
    .btn.my-bg-color:hover {
        background-color: var(--primary-hover);
        border-color: var(--primary-hover);
    }

    /* ======================================
       NAVBAR STYLING
       ====================================== */
    .navbar {
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
    }

    .navbar .navbar-brand {
        font-weight: 600;
        color: #fff !important;
    }

    .navbar .nav-link, .navbar .dropdown-toggle {
        color: #fff !important;
        font-weight: 500;
        transition: color var(--transition-speed);
    }

    .navbar .nav-link:hover {
        color: #e2e2e2 !important;
    }

    .dropdown-menu {
        border: none;
        box-shadow: var(--card-shadow);
        border-radius: 0.5rem;
    }

    /* ======================================
        FORMS & INPUTS
       ====================================== */
    .form-control, .form-select {
        border-radius: 0.5rem;
        transition: all var(--transition-speed);
    }

    .form-control:focus, .form-select:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 0.25rem rgba(69,104,220,0.25);
    }

    /* ======================================
        CARDS
       ====================================== */
    .my-card {
        border: none;
        border-radius: 0.75rem;
        background: #fff;
        box-shadow: var(--card-shadow);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .my-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 18px rgba(0, 0, 0, 0.12);
    }

    /* ======================================
        TABLE STYLING
       ====================================== */
    .table thead {
        background-color: var(--primary-color);
        color: #fff;
    }

    .table th {
        font-weight: 600;
    }

    /* ======================================
        BACKGROUND UTILITIES
       ====================================== */
    .my-bg-img {
        background: linear-gradient(rgba(0, 0, 0, .4), rgba(0, 0, 0, .4)),
                    url("img/hospital1.jpg") center/cover no-repeat;
        height: 25vh;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        text-shadow: 0 2px 4px rgba(0,0,0,0.6);
    }

    /* ======================================
       LOGIN & SIGNUP PAGES
       ====================================== */
    .login-container {
        min-height: 90vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem 1rem;
    }

    .login-card {
        width: 100%;
        max-width: 450px;
    }

    /* ======================================
       RESPONSIVENESS
       ====================================== */
    @media (max-width: 768px) {
        .navbar .nav-link { font-size: 0.95rem; }
        .my-bg-img { height: 20vh; background-position: top center; }
    }

    @media (max-width: 576px) {
        .login-card { padding: 1rem; }
        .my-bg-img { height: 18vh; }
    }

    /* ======================================
        ANIMATION HELPERS
       ====================================== */
    .fade-in {
        animation: fadeIn 0.8s ease-in-out forwards;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>
