<%--
  Created by IntelliJ IDEA.
  User: ashug
  Date: 19-07-2025
  Time: 04:26 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Doctor" %>
<%@ page import="dao.Display" %>
<%@ page import="entities.ProfilePics" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="entities.Patient" %>
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
  String pid = (String) session.getAttribute("pid");

  Display display = new Display();
  Patient patient = null;

  if(pid == null)
  {
    response.sendRedirect("patientHome.jsp");
  }
  else {
    try
    {
      patient = display.getPatientdetails(pid);
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
          <a class="nav-link active" href="patientHome.jsp">Home</a>
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
        <%=pid%>
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
        <h5 class="modal-title fw-bold" id="signupModalLabel">Delete Patient Profile</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body pt-0">
        <form action="DeleteChecker" method="post">
          <input type="hidden" name="pid" value="<%=pid%>">
          <input type="hidden" name="_for" value="patient">
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
        <h5 class="modal-title fw-bold" id="signupModalLabel">Update Patient Profile</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body pt-0 mt-1">
        <form action="UpdatePatientChecker" method="post">
          <input type="hidden" name="type" value="details" />

          <div class="mb-3">
            <label for="pid" class="form-label">Patient ID</label>
            <input type="text" name="pid" id="pid" class="form-control" value="<%=pid%>" readonly required />
          </div>

          <div class="row g-3 mb-3">
            <div class="col">
              <label for="fname" class="form-label">First Name</label>
              <input type="text" name="fname" id="fname" class="form-control" value="<%=patient.getFname()%>" required />
            </div>
            <div class="col">
              <label for="lname" class="form-label">Last Name</label>
              <input type="text" name="lname" id="lname" class="form-control" value="<%=patient.getLname()%>" required />
            </div>
          </div>

          <div class="row g-3 mb-3">
            <div class="col">
              <label for="city" class="form-label">City</label>
              <input type="text" name="city" id="city" class="form-control" value="<%=patient.getCity()%>" required />
            </div>
            <div class="col">
              <label for="dob" class="form-label">Date of Birth</label>
              <input type="date" name="dob" id="dob" class="form-control" value="<%=patient.getDob()%>" required />
            </div>
          </div>

          <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" name="email" id="email" class="form-control" value="<%=patient.getEmail()%>" required />
          </div>

          <div class="row g-3 mb-3">
            <div class="col">
              <label for="gender" class="form-label">Gender</label>
              <select name="gender" id="gender" class="form-select" required>
                <option value="Male" <%= patient.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                <option value="Female" <%= patient.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                <option value="Other" <%= patient.getGender().equals("Other") ? "selected" : "" %>>Other</option>
              </select>
            </div>
            <div class="col">
              <label for="phone" class="form-label">Phone</label>
              <input type="text" name="phone" id="phone" class="form-control" value="<%=patient.getPhone()%>" required />
            </div>
          </div>

          <div class="col-md-12">
            <label for="gender" class="form-label">Blood Group</label>
            <select id="gender" name="bloodgroup" class="form-select" required>
              <option value="<%=patient.getBloodgroup()%>" selected disabled><%=patient.getBloodgroup()%></option>
              <option value="<%=patient.getBloodgroup()%>">-- Select Blood Group --</option>
              <option value="A+">A+</option>
              <option value="A-">A−</option>
              <option value="B+">B+</option>
              <option value="B-">B−</option>
              <option value="AB+">AB+</option>
              <option value="AB-">AB−</option>
              <option value="O+">O+</option>
              <option value="O-">O−</option>

            </select>
          </div>

          <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <textarea name="address" id="address" class="form-control" rows="2" required><%=patient.getAddress()%></textarea>
          </div>

          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="Enter password to confirm" required />
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
        <img id="profilePreview" class="rounded-circle mb-3 shadow" src="ProfilePicChecker?user_id=<%=pid%>" alt="Doctor Profile" style="width: 300px; height: 300px; object-fit: cover;" />
        <!-- Upload Form -->
        <div class="d-flex justify-content-center gap-2 mt-3">
          <form id="uploadForm" action="UpdateProfilePhotoChecker" method="post" enctype="multipart/form-data">
            <label class="btn btn-outline-primary mb-0">
              Add Photo
              <input type="hidden" name="user_id" value="<%= pid %>">
              <input type="file" name="image" id="uploadPhoto" accept="image/*" hidden onchange="document.getElementById('uploadForm').submit();" />
            </label>
          </form>

          <!-- Delete Photo -->
          <form action="DeleteProfilePhotoChecker" method="post" style="display:inline;">
            <input type="hidden" name="user_id" value="<%= pid %>">
            <input type="submit" onclick="location.reload()" value="Delete Photo" class="btn btn-outline-danger">
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<section style="background: linear-gradient(#91a4ff,#ACB6E5,#f6f7f8);margin-top: 5vh; padding: 5vh;">

  <div class="profile-container">
    <!-- Left Section -->
    <div class="profile-left">
      <img style="width: 300px;height: 300px;" class="profile-image" data-bs-toggle="modal" data-bs-target="#updatePhotoModal"
           src="ProfilePicChecker?user_id=<%=pid%>" alt="Doctor" />
      <h4><%=patient.getFname()+" "+patient.getLname()%></h4>
      <p style="padding :2vh;">Your health is your greatest wealth. We're here to support your journey with care, compassion, and commitment—every step of the way.</p>
    </div>

    <!-- Right Section -->
    <div class="profile-right">
      <h5 class="mb-3">Patient Details</h5>

      <div class="info-row">
        <div class="info-label">Patient ID</div>
        <div class="info-value"><%= pid %></div>
      </div>

      <div class="info-row">
        <div class="info-label">First Name</div>
        <div class="info-value"><%= patient.getFname() %></div>
      </div>

      <div class="info-row">
        <div class="info-label">Last Name</div>
        <div class="info-value"><%= patient.getLname() %></div>
      </div>

      <div class="info-row">
        <div class="info-label">Date of Birth</div>
        <div class="info-value"><%= patient.getDob() %></div>
      </div>

      <div class="info-row">
        <div class="info-label">Gender</div>
        <div class="info-value"><%= patient.getGender() %></div>
      </div>

      <div class="info-row">
        <div class="info-label">Email</div>
        <div class="info-value"><%= patient.getEmail() %></div>
      </div>

      <div class="info-row">
        <div class="info-label">Phone</div>
        <div class="info-value"><%= patient.getPhone() %></div>
      </div>

      <div class="info-row">
        <div class="info-label">Address</div>
        <div class="info-value"><%= patient.getAddress() %></div>
      </div>

      <div class="info-row">
        <div class="info-label">Blood Group</div>
        <div class="info-value"><%= patient.getBloodgroup() %></div>
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
          Your health is your greatest wealth. We're here to support your journey with care, compassion, and commitment—every step of the way.
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

  document.getElementById('uploadForm').submit();

  window.onload = function () {
    document.getElementById("myForm").submit();
  };

</script>
</body>
</html>