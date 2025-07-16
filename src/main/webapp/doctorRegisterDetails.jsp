<%--
  Created by IntelliJ IDEA.
  User: ashug
  Date: 12-06-2025
  Time: 04:24 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Doctor Registration Form</title>


  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

  <style>


    .navbar {
      background-color: #007bff;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1rem 2rem;
      border-bottom-left-radius: 20px;
      border-bottom-right-radius: 20px;
    }

    .navbar-brand {
      color: #000;
      font-weight: 700;
      font-size: 1.5rem;
    }

    .navbar-brand span {
      color: #dfe9f3;
    }

    .nav-links {
      display: flex;
      gap: 1.5rem;
    }

    .nav-links a {
      color: white;
      text-decoration: none;
      padding: 0.4rem 1rem;
      border-radius: 10px;
      transition: background-color 0.3s;
    }

    .nav-links a:hover,
    .nav-links a.active {
      background-color: rgba(255, 255, 255, 0.2);
    }

    @media (max-width: 768px) {
      .nav-links {
        flex-direction: column;
        background-color: #007bff;
        position: absolute;
        top: 70px;
        right: 0;
        width: 200px;
        display: none;
        padding: 1rem;
      }

      .nav-links.show {
        display: flex;
      }

      .menu-toggle {
        display: block;
        font-size: 1.5rem;
        color: white;
        cursor: pointer;
      }
    }

    @media (min-width: 769px) {
      .menu-toggle {
        display: none;
      }
    }
    .main-div
    {
      background: linear-gradient(135deg, #ffffff, rgb(34, 242, 255));
      min-height: 93vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }


    .register-card {
      background: #ffffff;
      padding: 40px;
      border-radius: 16px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
      max-width: 700px;
      width: 100%;
    }

    .register-card h2 {
      font-weight: 700;
      margin-bottom: 20px;
      text-align: center;
      color: #333;
    }

    .form-control, .form-select {
      border-radius: 8px;
      padding: 12px;
    }

    .btn-primary {
      background-color: #4A90E2;
      border: none;
      padding: 12px;
      border-radius: 8px;
      font-weight: 600;
    }

    .btn-primary:hover {
      background-color: #357ABD;
    }


  </style>
</head>
<body>

<%
  String fname = (String)session.getAttribute("fname");
  String d_id = (String) session.getAttribute("d_id");
%>


<!-- Navbar -->
<nav class="navbar navbar-expand-md navbar-light bg-white shadow-sm fixed-top">
  <div class="container">
    <!-- Logo + Brand -->
    <a class="navbar-brand d-flex align-items-center" href="#">

      <span class="fw-bold text-dark">WelCare<span class="text-primary">.Life</span></span>
    </a>
  </div>
</nav>
<div class="main-div">
  <div class="register-card">
    <h2>Doctor Registration</h2>
    <form action="DetailsChecker" method="post" id="registerForm">
      <div class="row g-3">
        <div class="col-md-6">
          <label for="patientId" class="form-label">Doctor ID</label>
          <input type="text" name="d_id" value="<%=d_id%>" class="form-control" id="patientId" >
        </div>
        <div class="col-md-6">
          <label for="firstName" class="form-label">First Name</label>
          <input type="text" value="<%=fname%>" class="form-control" id="firstName" disabled>
        </div>
        <div class="col-md-6">
          <label for="dob" class="form-label">Date of Birth</label>
          <input type="date" name="dob" class="form-control" id="dob" required>
        </div>
        <div class="col-md-6">
          <label for="phone" class="form-label">Phone</label>
          <input type="tel" name="phone" class="form-control" id="phone" required>
        </div>
        <div class="col-md-6">
          <label for="address" class="form-label">Address</label>
          <input type="text" name="address" class="form-control" id="address" required>
        </div>
        <div class="col-md-6">
          <label for="city" class="form-label">City</label>
          <input type="text" name="city" class="form-control" id="city" required>
        </div>
        <div class="col-md-6">
          <label for="gender" class="form-label">Gender</label>
          <select id="gender" name="gender" class="form-select" required>
            <option value="" selected disabled>Select gender</option>
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="other">Other</option>
          </select>
        </div>
        <div class="col-md-6">
          <label for="gender" class="form-label">Experience</label>
          <select id="experience" name="experience" class="form-select" required>
            <option value="" disabled selected>Select experience</option>
            <option value="0-10">0 – 10 years</option>
            <option value="11-20">11 – 20 years</option>
            <option value="21-30">21 – 30 years</option>
            <option value="31-40">31 – 40 years</option>
            <option value="41-50">41 – 50 years</option>
            <option value="51+">51+ years</option>
          </select>

        </div>
        <div class="col-md-6">
          <label for="city" class="form-label">Qualification</label>
          <input type="text" name="qualification" class="form-control" id="city" required>
        </div>
        <div class="col-md-6">
          <label for="city" class="form-label">Specialization</label>
          <input type="text" name="specialization" class="form-control" id="city" required>
        </div>
        <div class="d-grid mt-4">
          <input type="submit" class="btn btn-primary" value="Register">
        </div>
      </div>
    </form>
  </div>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Simple Form Validation -->
<script>
</script>
</body>
</html>
