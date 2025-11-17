<%@page import="com.hms.db.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Home | Doctor Patient Portal</title>
	<%@include file="component/allcss.jsp"%>

	<!-- ===== Custom Styles ===== -->
	<style>
		body {
			background: #f8f9fa;
			color: #212529;
			font-family: 'Poppins', sans-serif;
		}

		.myP-color {
			color: #0d6efd;
		}

		.my-card {
			border: none;
			border-radius: 1rem;
			box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
			transition: transform 0.3s ease, box-shadow 0.3s ease;
			background: #fff;
		}

		.my-card:hover {
			transform: translateY(-5px);
			box-shadow: 0 6px 25px rgba(0, 0, 0, 0.12);
		}

		.card-body h4 {
			font-weight: 600;
			margin-bottom: 0.6rem;
		}

		h2.section-title {
			font-size: 2rem;
			font-weight: 700;
			text-align: center;
			color: #0d6efd;
			position: relative;
		}

		h2.section-title::after {
			content: "";
			display: block;
			width: 100px;
			height: 4px;
			background: #0d6efd;
			margin: 10px auto 0;
			border-radius: 2px;
		}

		/* ===== Carousel Fix ===== */
		.carousel-inner img {
			width: 100%;
			height: auto;
			max-height: 550px;
			object-fit: contain;
			border-radius: 0;
			background-color: #fff;
		}

		@media (max-width: 992px) {
			.carousel-inner img {
				max-height: 400px;
				object-fit: cover;
			}
		}

		.team-card {
			border: none;
			border-radius: 15px;
			overflow: hidden;
			box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
			transition: transform 0.3s ease, box-shadow 0.3s ease;
			background: #fff;
		}

		.team-card:hover {
			transform: translateY(-8px);
			box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
		}

		.team-card img {
			width: 100%;
			height: auto;
			object-fit: cover;
			transition: transform 0.4s ease;
		}

		.team-card:hover img {
			transform: scale(1.05);
		}

		.card-body {
			padding: 20px;
		}

		.footer {
			background: linear-gradient(135deg, #0d6efd, #6610f2);
			color: #fff;
			padding: 2rem 0;
			text-align: center;
		}

		/* ===== Responsive ===== */
		@media (max-width: 768px) {
			h2.section-title {
				font-size: 1.6rem;
			}
			.card-body h4 {
				font-size: 1rem;
			}
			.carousel-inner img {
				max-height: 300px;
			}
			.card-body h5 {
				font-size: 1.1rem;
			}
		}

		@media (max-width: 576px) {
			.card-body p {
				font-size: 0.9rem;
			}
			.card-body {
				padding: 15px;
			}
		}
	</style>
	<!-- ===== End Custom Styles ===== -->
</head>

<body>
	<%@include file="component/navbar.jsp"%>

	<!-- ===== Carousel ===== -->
	<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
				class="active" aria-current="true" aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
				aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
				aria-label="Slide 3"></button>
		
		</div>
		<div class="carousel-inner">
			<div class="carousel-item">
				<img src="img/doctor_1.png" class="d-block w-100" alt="Doctor">
			</div>
			<div class="carousel-item active">
				<img src="img/docktor_02.png" class="d-block w-100" alt="Doctor">
			</div>
			<div class="carousel-item">
				<img src="img/hospital4.png" class="d-block w-100" alt="Hospital">
			</div>
		</div>
		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
			data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
			data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>
	<!-- ===== End Carousel ===== -->

	<!-- ===== Key Features ===== -->
	<div class="container py-5">
		<h2 class="section-title mb-5">Key Features of Our Doctor Patient Portal</h2>
		<div class="row g-4 align-items-center">
			<div class="col-md-8">
				<div class="row g-4">
					<div class="col-md-6">
						<div class="card my-card h-100">
							<div class="card-body p-4">
								<h4 class="myP-color">11000+ Healing Hands</h4>
								<p class="text-secondary">Largest network of the world’s finest and brightest medical
									experts who provide compassionate care.</p>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="card my-card h-100">
							<div class="card-body p-4">
								<h4 class="myP-color">Most Advanced Healthcare</h4>
								<p class="text-secondary">We have pioneered ground-breaking healthcare technologies
									and innovative treatments nationwide.</p>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="card my-card h-100">
							<div class="card-body p-4">
								<h4 class="myP-color">Best Clinical Outcomes</h4>
								<p class="text-secondary">Leveraging medical expertise & technology for best-in-class
									clinical outcomes with personalized care.</p>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="card my-card h-100">
							<div class="card-body p-4">
								<h4 class="myP-color">500+ Pharmacies</h4>
								<p class="text-secondary">Our trusted pharmacy network has over 500+ outlets across
									the nation to ensure medicine availability.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Image Column -->
			<div class="col-md-4 text-center">
				<img src="img/doctor_3.jpg" class="img-fluid rounded shadow-sm"
					alt="Doctor Image" style="height: 100%; object-fit: cover;">
			</div>
		</div>
	</div>
	<!-- ===== End Key Features ===== -->

	<hr class="my-5">

	<!-- ===== Our Team ===== -->
	<div class="container pb-5 pt-3">
		<h2 class="section-title mb-5">Our Expert Team</h2>
		<div class="row g-4 justify-content-center">
			<div class="col-12 col-sm-6 col-md-4 col-lg-3">
				<div class="card my-card team-card text-center">
					<img src="img/doc1.png" class="card-img-top" alt="Dr. John">
					<div class="card-body">
						<h5 class="fw-bold myP-color">Dr. John</h5>
						<p class="text-secondary">(CEO & Chairman)</p>
					</div>
				</div>
			</div>

			<div class="col-12 col-sm-6 col-md-4 col-lg-3">
				<div class="card my-card team-card text-center">
					<img src="img/doc2.png" class="card-img-top" alt="Dr. Brad">
					<div class="card-body">
						<h5 class="fw-bold myP-color">Dr. Brad</h5>
						<p class="text-secondary">(Chief Doctor)</p>
					</div>
				</div>
			</div>

			<div class="col-12 col-sm-6 col-md-4 col-lg-3">
				<div class="card my-card team-card text-center">
					<img src="img/doc03.png" class="card-img-top" alt="Dr. Jennifer">
					<div class="card-body">
						<h5 class="fw-bold myP-color">Dr. Jennifer</h5>
						<p class="text-secondary">(Chief Surgeon)</p>
					</div>
				</div>
			</div>

			<div class="col-12 col-sm-6 col-md-4 col-lg-3">
				<div class="card my-card team-card text-center">
					<img src="img/doc4.png" class="card-img-top" alt="Dr. Maria">
					<div class="card-body">
						<h5 class="fw-bold myP-color">Dr. Maria</h5>
						<p class="text-secondary">(Dean)</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ===== End Our Team ===== -->

	<%@include file="component/footer.jsp"%>
</body>
</html>
