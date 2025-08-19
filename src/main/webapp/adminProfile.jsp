<%--
  Created by IntelliJ IDEA.
  User: ashug
  Date: 29-07-2025
  Time: 06:43 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Doctor" %>
<%@ page import="dao.Display" %>
<%@ page import="entities.Admin" %>
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
  <link rel="stylesheet" href="css/admin-style.css"/>
  <style>


  </style>
</head>
<body class="bg-light">
<%
  String admin_id = (String) session.getAttribute("admin_id");

  Display display = new Display();
  Admin admin = null;

  if(admin_id == null)
  {
    response.sendRedirect("index.jsp");
  }
  else {
    try
    {
      admin = display.getAdminDetails(admin_id);
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
        <%=admin_id%>
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
          <input type="hidden" name="_for" value="Admin">
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
        <form action="UpdateAdminChecker" method="post">
          <input type="hidden" name="type" value="admin">

          <div class="mb-3">
            <label for="adminId" class="form-label">Admin ID</label>
            <input type="text" name="admin_id" class="form-control" id="adminId" value="<%=admin_id%>" required readonly>
          </div>

          <div class="row g-3 mb-3">
            <div class="col">
              <label for="firstName" class="form-label">First Name</label>
              <input type="text" name="fname" class="form-control" id="firstName" value="<%=admin.getFname()%>" placeholder="First name" required>
            </div>
            <div class="col">
              <label for="lastName" class="form-label">Last Name</label>
              <input type="text" name="lname" class="form-control" id="lastName" value="<%=admin.getLname()%>" placeholder="Last name" required>
            </div>
          </div>

          <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <input type="text" name="role" class="form-control" id="role" value="<%=admin.getRole()%>" placeholder="e.g., Super Admin, Manager" required readonly>
          </div>

          <div class="mb-3">
            <label for="adminPassword" class="form-label">Password</label>
            <input type="password" name="password" class="form-control" id="adminPassword" placeholder="Enter password to update details" required>
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
        <img id="profilePreview" class="rounded-circle mb-3 shadow" src="ProfilePicChecker?user_id=<%=admin_id%>" alt="Doctor Profile" style="width: 300px; height: 300px; object-fit: cover;" />
        <!-- Upload Form -->
        <div class="d-flex justify-content-center gap-2 mt-3">
          <form id="uploadForm" action="UpdateProfilePhotoChecker" method="post" enctype="multipart/form-data">
            <label class="btn btn-outline-primary mb-0">
              Add Photo
              <input type="hidden" name="user_id" value="<%= admin_id %>">
              <input type="file" name="image" id="uploadPhoto" accept="image/*" hidden onchange="document.getElementById('uploadForm').submit();" />
            </label>
          </form>

          <!-- Delete Photo -->
          <form action="DeleteProfilePhotoChecker" method="post" style="display:inline;">
            <input type="hidden" name="user_id" value="<%= admin_id %>">
            <input type="submit" onclick="location.reload()" value="Delete Photo" class="btn btn-outline-danger">
          </form>

        </div>
      </div>
    </div>
  </div>
</div>

<section style="background: linear-gradient(#91a4ff,#ACB6E5,#f6f7f8);margin-top: 5vh; padding: 5vh;">
  <div class="container mt-5">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <div class="profile-card text-center p-4 shadow rounded-4 bg-white">
          <!-- Profile Image -->
          <img src="ProfilePicChecker?user_id=<%=admin_id%>" data-bs-toggle="modal" data-bs-target="#updatePhotoModal" alt="Admin Photo" class="profile-img rounded-circle shadow" style="width: 200px; height: 200px; object-fit: cover; border: 4px solid #007bff;">

          <!-- Name & Role -->
          <h4 class="mt-3 mb-1">Admin:
            <span id="admin-name"><%=admin.getFname() + " " + admin.getLname()%></span>
          </h4>
          <p class="text-muted mb-3" id="admin-role"><%=admin.getRole()%></p>

          <!-- Info Section -->
          <div class="info-row">
            <div class="info-label">Admin ID</div>
            <div class="info-value"><%=admin_id%></div>
          </div>

          <div class="info-row">
            <div class="info-label">First Name</div>
            <div class="info-value"><%=admin.getFname()%></div>
          </div>

          <div class="info-row">
            <div class="info-label">Last Name</div>
            <div class="info-value"><%=admin.getLname()%></div>
          </div>

          <!-- Buttons -->
          <div class="d-flex justify-content-center gap-3 mt-4">
            <button type="button" data-bs-toggle="modal" data-bs-target="#updateModal" class="appointment-btn">
              Update Profile
            </button>

            <button type="button" data-bs-toggle="modal" data-bs-target="#deleteModal" class="appointment-btn">
              Delete Profile
            </button>
          </div>
        </div>
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