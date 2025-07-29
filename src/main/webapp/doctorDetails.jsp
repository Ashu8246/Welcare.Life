<%@ page import="dao.Display" %>
<%@ page import="entities.Doctor" %><%--
  Created by IntelliJ IDEA.
  User: ashug
  Date: 19-06-2025
  Time: 06:53 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>WelCare.Life</title>

  <!-- Bootstrap 5 & Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />

  <link rel="stylesheet" href="css/style.css"/>
  <link rel="stylesheet" href="css/doc_details-style.css"/>

</head>
<body class="bg-light">
<%
  String admin_id = (String) session.getAttribute("admin_id");
  String d_id = request.getParameter("d_id");
  String referer = request.getHeader("Referer");
  Display display = new Display();
  Doctor doc = null;
  if(admin_id == null)
  {
    response.sendRedirect(referer);
  }
  else {
    try
    {
      doc = display.getDoctordetails(d_id);
    }
    catch (Exception e)
    {
      System.out.println(e);
    }
  }
%>
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
          <a class="nav-link active" href="adminHome.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Profile</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#about">About</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#contact">Contact</a>
        </li>
      </ul>
      <div style="margin: 10px;" class="d-flex gap-2">
        <%
          if(admin_id != null)
          {
        %><%=admin_id%><%
        }
        else {
          response.sendRedirect(referer);
        }
      %>
      </div>
      <div class="d-flex gap-2">
        <a href="signOut.jsp"><button class="btn btn-primary" >Sign out</button></a>
      </div>
    </div>
  </div>
</nav>
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow rounded-4 p-3">
      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title fw-bold" id="signupModalLabel">Delete Doctor Profile</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body pt-0">
        <form action="DeleteChecker" method="post">
          <input type="hidden" name="admin_id" value="<%=admin_id%>">
          <input type="hidden" name="d_id" value="<%=doc.getD_id()%>">
          <input type="hidden" name="_for" value="adminDeleteDoc">
          <div class="row g-3 mb-3">
            <div class="mb-3">
              <label for="signupPassword" class="form-label">Password</label>
              <input type="password" name="password" class="form-control" id="signupPassword" placeholder="Enter admin password to Delete Doctor Profile" required>
            </div>
            <div class="d-grid mt-4">
              <button type="submit" class="btn btn-primary fw-semibold">Delete</button>
            </div>
        </form>
      </div>
    </div>
  </div>
  </div>
</div>
<div class="modal fade" id="verifyModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow rounded-4 p-3">
      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title fw-bold" id="signupModalLabel">Verify Doctor Profile</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body pt-0 mt-1">
        <form action="VerificationChecker" method="post">
          <input type="hidden" name="d_id" value="<%=d_id%>">
          <div class="mb-3">
            <label for="loginEmail" class="form-label">Change Verification type</label>
            <select class="form-control" name="verification" id="role">
              <option>Choose status</option>
              <option value="Verified">Verify</option>
              <option value="Declined">Decline</option>
            </select>
          </div>
            <div class="d-grid mt-4">
              <button type="submit" class="btn btn-primary fw-semibold">Change</button>
            </div>
        </form>
      </div>
    </div>
  </div>
</div>
</div>
<section style="background: linear-gradient(white,#ACB6E5,#91a4ff);margin-top: 5vh; padding: 5vh;">

  <div class="profile-container">
    <!-- Left Section -->
    <div class="profile-left">
      <img class="profile-image" src="ProfilePicChecker?user_id=<%=d_id%>" alt="Doctor Profile" />
      <h4>Dr. ExampleABC</h4><%
      if(doc.getVerified().equalsIgnoreCase("verified"))
      {
      %><div style="color: #198754;font-size: 14px; margin-top: 10px;">Verified Doctor</div><%
      }
      else {
      %><div style="color: #871919;font-size: 14px; margin-top: 10px;">Not-Verified Doctor</div><%
      }
      %>
      <p style="padding :2vh;">Experience compassionate, comprehensive healthcare designed around you. Connect with trusted professionals, manage your health records, and access care whenever you need it.</p>
    </div>

    <!-- Right Section -->
    <div class="profile-right">
      <h5 class="mb-3">Bio & Professional Details</h5>

      <div class="info-row">
        <div class="info-label">Doctor ID</div>
        <div class="info-value"><%=doc.getD_id()%></div>
      </div>

      <div class="info-row">
        <div class="info-label">Qualification</div>
      <div class="info-value"><%=doc.getQualification()%></div>
      </div>

      <div class="info-row">
        <div class="info-label">Specialization</div>
        <div class="info-value"><%=doc.getSpecialization()%></div>
      </div>

      <div class="info-row">
        <div class="info-label">City</div>
        <div class="info-value"><%=doc.getCity()%></div>
      </div>

      <div class="info-row">
        <div class="info-label">Address</div>
        <div class="info-value"><%=doc.getAddress()%></div>
      </div>

      <div class="info-row">
        <div class="info-label">Status</div>
        <div class="badge-section" style="margin-top: 0;">
          <% if(doc.getStatus() == 1) {
          %><div class="availability" >✅ Available for Appointment </div><%
        }
        else {
        %><div class="not-availability" >❌ Not Available for Appointment </div><%
          }%>
        </div>
      </div>

      <div class="info-row">
        <div class="info-label">Verification</div>
        <div class="info-value fw-semibold"><%=doc.getVerified()%></div>
      </div>
      <div class="d-flex justify-content-center gap-3 flex-wrap mt-3 mb-3">
        <button type="button" data-bs-toggle="modal" data-bs-target="#verifyModal" class="appointment-btn">
          Verify Profile
        </button>

        <button type="button" data-bs-toggle="modal" data-bs-target="#deleteModal" class="appointment-btn">
          Delete Profile
        </button>
      </div>

    </div>
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
<!-- Bootstrap + Icons -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
<script src="js/script.js"/>
<script>
  setTimeout(function() {
    location.reload();
  }, 2000); // Refresh after 5 seconds

</script>
</body>
</html>