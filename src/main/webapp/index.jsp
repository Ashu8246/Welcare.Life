<%@ page import="dao.Display" %><%--
  Created by IntelliJ IDEA.
  User: ashug
  Date: 12-06-2025
  Time: 03:03 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />

  <link href="css/style.css" rel="stylesheet"/>

  <title>WelCare.Life</title>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-md navbar-light bg-white shadow-sm fixed-top">
  <div class="container">
    <!-- Logo + Brand -->
    <a class="navbar-brand d-flex align-items-center" href="#">

      <span class="fw-bold text-dark">WelCare<span class="text-primary">.Life</span></span>
    </a>

    <!-- Toggler -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Navbar content -->
    <div class="collapse navbar-collapse" id="navbarMenu">
      <!-- Nav links -->
      <ul class="navbar-nav me-auto mb-2 mb-md-0 ms-md-4">
        <li class="nav-item">
          <a class="nav-link active" href="index.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" data-bs-toggle="modal" data-bs-target="#signupModal" href="#signupModal">Profile</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#about">About</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#contact">Contact</a>
        </li>
      </ul>

      <!-- Auth Buttons -->
      <div class="d-flex gap-2">
        <button class="btn btn-outline-primary d-flex align-items-center" data-bs-toggle="modal" data-bs-target="#loginModal">
          <i class="bi bi-box-arrow-in-right me-2"></i>Login
        </button>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#signupModal">Sign Up</button>
      </div>

    </div>
  </div>
</nav>
<!-- Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow rounded-4 p-3">
      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title fw-bold" id="loginModalLabel">Login</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body pt-0">
        <form action="LoginChecker" method="post">
          <div class="mb-3">
            <label for="loginEmail" class="form-label">UserId</label>
            <input type="text" name="u_id" class="form-control" id="loginEmail" placeholder="Doctor / Patient / Admin" required>
          </div>
          <div class="mb-3">
            <label for="loginPassword" class="form-label">Password</label>
            <input type="password" name="password" class="form-control" id="loginPassword" placeholder="Enter your password" required>
          </div>
          <div class="mb-3">
            <label for="loginEmail" class="form-label">Role</label>
            <select class="form-control" name="role" id="role">
              <option value="admin">Select Role</option>
              <option value="admin">Admin</option>
              <option value="doctor">Doctor</option>
              <option value="patient">Patient</option>
            </select>
          </div>
          <div class="d-grid mt-4">
            <button type="submit" class="btn btn-primary fw-semibold">Sign In</button>
          </div>
        </form>
        <div class="text-center mt-3 small">
          Don’t have an account? <a href="#" data-bs-toggle="modal" data-bs-target="#signupModal">Sign up</a>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Sign Up Modal -->
<div class="modal fade" id="signupModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow rounded-4 p-3">
      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title fw-bold" id="signupModalLabel">Sign Up</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body pt-0">
        <form action="RegisterChecker" method="post">
          <div class="row g-3 mb-3">
            <div class="col">
              <label for="firstName" class="form-label">First Name</label>
              <input type="text" name="fname" class="form-control" id="firstName" placeholder="First name" required>
            </div>
            <div class="col">
              <label for="lastName" class="form-label">Last Name</label>
              <input type="text" name="lname" class="form-control" id="lastName" placeholder="Last name" required>
            </div>
          </div>
          <div class="mb-3">
            <label for="signupEmail" class="form-label">Email Address</label>
            <input type="email" name="email" class="form-control" id="signupEmail" placeholder="your.email@example.com" required>
          </div>
          <div class="mb-3">
            <label for="signupPassword" class="form-label">Password</label>
            <input type="password" name="password" class="form-control" id="signupPassword" placeholder="Create a password" required>
          </div>

          <div class="mb-3">
            <label for="loginEmail" class="form-label">Role</label>
            <select class="form-control" name="role" id="role">
              <option value="admin">Select Role</option>
              <option value="doctor">Doctor</option>
              <option value="patient">Patient</option>
            </select>

          </div>
          <div class="d-grid mt-4">
            <button type="submit" class="btn btn-primary fw-semibold">Create Account</button>
          </div>
        </form>
        <div class="text-center mt-3 small">
          Already have an account?
          <a href="#" class="text-decoration-none" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Hero Section -->
<section class="hero-section">
  <div class="hero-overlay"></div>
  <div class="hero-content text-white px-3">
    <h1 class="hero-title">WelCare.<span class="text-info">Life</span></h1>
    <p class="hero-subtitle">
      Experience compassionate, comprehensive healthcare designed around you. Connect with trusted professionals,
      manage your health records, and access care whenever you need it.
    </p>
  </div>
</section>


<!-- Subscribe Section -->
<section id="contact" class="subscribe-section">
  <div class="contact-form">
    <h2>Contact Us</h2>
    <form id="contactForm" method="post" action="ContactUsChecker">
      <div class="row mb-3">
        <div class="col-md-6">
          <label for="name" class="form-label">Full Name</label>
          <input type="text" name="name" id="name" class="form-control" placeholder="Your name" required />
        </div>
        <div class="col-md-6">
          <label for="email" class="form-label">Email Address</label>
          <input type="email" name="email" id="email" class="form-control" placeholder="your@email.com" required />
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-md-6">
          <label for="phone" class="form-label">Phone Number</label>
          <input type="tel" name="phone" id="phone" class="form-control" placeholder="+91985648723" maxlength="13"/>
        </div>
        <div class="col-md-6">
          <label for="subject" class="form-label">Subject</label>
          <input type="text" id="subject" name="reason" class="form-control" placeholder="Query, Feedback, Support..." />
        </div>
      </div>
      <div class="mb-3">
        <label for="loginEmail" class="form-label">Who are you ?</label>
        <select class="form-control" name="role" id="role">
          <option value="">Select Role</option>
          <option value="Doctor">Doctor</option>
          <option value="Patient">Patient</option>
          <option value="Non-Registered User">Non-Registered User</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="message" class="form-label">Message</label>
        <textarea id="message" name="message" class="form-control" rows="5" placeholder="Write your message here..." required></textarea>
      </div>
      <button type="submit" class="btn btn-primary px-4">Send Message</button>
    </form>
  </div>
</section>

<!-- Footer -->
<footer id="about">
  <div class="container">
    <div class="row footer-section">
      <div class="col-md-4 mb-4">
        <div class="footer-logo">💙 WelCare.<span class="text-primary">Life</span></div>
        <p class="mt-3">
          Experience compassionate, comprehensive healthcare tailored to you.
          Manage your records, connect with professionals, and access care easily.
        </p>
      </div>
      <div class="col-md-4 mb-4">
        <h5>Contact</h5>
        <p><strong>Address:</strong> Indore, India</p>
        <p><strong>Phone:</strong> +91 98765 43210</p>
        <p><strong>Email:</strong> welcare.life@gmail.com</p>
      </div>
      <div class="col-md-4 mb-4">
        <h5>Useful Links</h5>
        <ul class="list-unstyled">
          <li><a href="#">Home</a></li>
          <li><a href="#">About us</a></li>
          <li><a href="#">Contact</a></li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">
      ©2025 WelCare.Life. All rights reserved | Made with ❤️ by Team WelCare
    </div>
  </div>
</footer>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/script.js" ></script>
<script>
  setTimeout(function() {
    location.reload();
  }, 60000); // Refresh after 5 seconds
</script>
</body>
</html>