<%@ page import="entities.Doctor" %>
<%@ page import="dao.Display" %>
<%@ page import="entities.ProfilePics" %>
<%@ page import="java.io.OutputStream" %>
<%--
  Created by IntelliJ IDEA.
  User: ashug
  Date: 21-06-2025
  Time: 03:09 am
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
  String d_id = (String) session.getAttribute("d_id");

  Display display = new Display();
  Doctor doc = null;

  if(d_id == null)
  {
    response.sendRedirect("docHome.jsp");
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
          <a class="nav-link active" href="docHome.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#" onclick="submitProfileForm()">Profile</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#about">About</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#contact">Contact</a>
        </li>
      </ul>
      <div style="margin: 10px;" class="d-flex gap-2">
          <%=d_id%>
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
            <input type="hidden" name="d_id" value="<%=d_id%>">
            <input type="hidden" name="_for" value="Doctor">
            <div class="row g-3 mb-3">
              <div class="mb-3">
                <label for="signupPassword" class="form-label">Password</label>
                <input type="password" name="password" class="form-control" id="signupPassword" placeholder="Enter your password to Delete Profile" required>
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
<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow rounded-4 p-3">
      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title fw-bold" id="signupModalLabel">Update Doctor Profile</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body pt-0 mt-1">
        <form action="UpdateDoctorChecker" method="post">
          <input type="hidden" name="type" value="details">
          <div class="mb-3">
            <label for="signupEmail" class="form-label">Doctor Id</label>
            <input type="text" name="d_id" class="form-control" id="signupEmail" placeholder="" value="<%=d_id%>" required readonly>
          </div>
          <div class="row g-3 mb-3">
            <div class="col">
              <label for="firstName" class="form-label">First Name</label>
              <input type="text" name="fname" class="form-control" id="firstName" value="<%=doc.getFname()%>" placeholder="First name" required>
            </div>
            <div class="col">
              <label for="lastName" class="form-label">Last Name</label>
              <input type="text" name="lname" class="form-control" id="lastName" value="<%=doc.getLname()%>" placeholder="Last name" required>
            </div>
          </div>
          <div class="mb-3">
            <label for="signupEmail" class="form-label">Qualification</label>
            <input type="text" name="qualification" class="form-control" id="signupEmail" value="<%=doc.getQualification()%>" placeholder="MBBS, MD, PHD" required>
          </div>
          <div class="mb-3">
            <label for="signupEmail" class="form-label">Specialization</label>
            <input type="text" name="specialization" class="form-control" id="signupEmail" value="<%=doc.getSpecialization()%>" placeholder="Cardiologist / Dermetologist" required>
          </div>
          <div class="row g-3 mb-3">
            <div class="col">
              <label for="firstName" class="form-label">City</label>
              <input type="text" name="city" class="form-control" id="firstName" value="<%=doc.getCity()%>" placeholder="First name" required>
            </div>
            <div class="col">
              <label for="lastName" class="form-label">Address</label>
              <input type="text" name="address" class="form-control" id="lastName" value="<%=doc.getAddress()%>" placeholder="Last name" required>
            </div>
          </div>
          <div class="mb-3">
            <label for="signupPassword" class="form-label">Password</label>
            <input type="password" name="password" class="form-control" id="signupPassword"  placeholder="Enter password to update details" required>
          </div>
          <div class="d-grid mt-4">
            <button type="submit" class="btn btn-primary fw-semibold">Update</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</div>
<!-- Modal -->
<div class="modal fade" id="updatePhotoModal" tabindex="-1" aria-labelledby="updatePhotoLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow rounded-4 p-3">

      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title fw-bold" id="updatePhotoLabel">Update Profile Photo</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body text-center">
        <!-- Rounded Profile Image -->
        <img id="profilePreview" class="rounded-circle mb-3 shadow" src="ProfilePicChecker?user_id=<%=d_id%>" alt="Doctor Profile" style="width: 300px; height: 300px; object-fit: cover;" />
        <!-- Upload Form -->
          <div class="d-flex justify-content-center gap-2 mt-3">
            <form id="uploadForm" action="UpdateProfilePhotoChecker" method="post" enctype="multipart/form-data">
              <label class="btn btn-outline-primary mb-0">
                Add Photo
                <input type="hidden" name="user_id" value="<%= d_id %>">
                <input type="file" name="image" id="uploadPhoto" accept="image/*" hidden onchange="document.getElementById('uploadForm').submit();" />
              </label>
            </form>

            <!-- Delete Photo -->
            <button type="button" class="btn btn-outline-danger" >Delete Photo</button>
          </div>
      </div>
    </div>
  </div>
</div>

<section style="background: linear-gradient(#91a4ff,#ACB6E5,#f6f7f8);margin-top: 5vh; padding: 5vh;">

  <div class="profile-container">
    <!-- Left Section -->
    <div class="profile-left">
      <img class="profile-image" data-bs-toggle="modal" data-bs-target="#updatePhotoModal"
           src="ProfilePicChecker?user_id=<%=d_id%>" alt="Doctor Profile" />

      <h4>Dr. <%=doc.getFname()+" "+doc.getLname()%></h4><%
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
        <button type="button" data-bs-toggle="modal" data-bs-target="#updateModal" class="appointment-btn">
          Update Profile
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
    document.getElementById("myForm").submit();
    location.reload();

  }, 2000); // Refresh after 5 seconds

  document.getElementById('uploadForm').submit();

  window.onload = function () {
    document.getElementById("myForm").submit();
  };

</script>
</body>
</html>