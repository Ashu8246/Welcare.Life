<%@ page import="dao.Display" %>
<%@ page import="entities.Doctor" %>
<%@ page import="entities.Appointment" %>
<%@ page import="entities.Patient" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %><%--
  Created by IntelliJ IDEA.
  User: ashug
  Date: 24-06-2025
  Time: 03:50 am
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
    <link rel="stylesheet" href="css/patient-details.css"/>


</head>
<body class="bg-light">
<%
    //    String d_id = request.getParameter("d_id");
    String d_id = (String) session.getAttribute("d_id");
    String pid = request.getParameter("pid");

    Display display = new Display();
    Patient patient = null;
    List<Appointment> appoint = null;
    if(d_id == null)
    {
        response.sendRedirect("docHome.jsp");
    }
    else {
        try
        {
            patient = display.getPatientdetails(pid);
            appoint = display.getAppointmentDetailsWithPidD_id(pid,d_id);
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
                    <a class="nav-link" href="doctorProfile.jsp" onclick="submitProfileForm()">Profile</a>
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

<div class="modal fade" id="appointmentModal" tabindex="-1" aria-labelledby="appointmentModalLabel" aria-hidden="true">
    <div class="modal-dialog mt-5" style="max-width: 900px; width: 100%; height: 100%;"> <!-- UPDATED WIDTH -->
        <div class="row g-4 mt-5">
            <div class="info-box border-primary">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold" id="searchPatientModalLabel">Patient Appointment Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="table-responsive mt-3" style="max-height: 40vh; overflow-y: auto;">
                    <table class="table bg-transparent mb-0 no-vertical-borders">
                        <thead class="table-light">
                        <tr>
                            <th>Patient Name</th>
                            <th>Reason</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            if(appoint != null) {
                                Iterator<Appointment> app = appoint.iterator();
                                while(app.hasNext()) {
                                    Appointment a = app.next();
                                    if(a != null) {
                        %>
                        <tr>
                            <td><%=a.getPname()%></td>
                            <td><%=a.getReason()%></td>
                            <td><%=a.getDate()%></td>
                            <td><%=a.getTime()%></td>
                            <td>
                                <% if(a.getStatus().equalsIgnoreCase("Confirmed")) { %>
                                <h6 style="color: #20c997">Confirmed</h6>
                                <% } else if(a.getStatus().equalsIgnoreCase("Rejected")) { %>
                                <h6 style="color: red">Rejected</h6>
                                <% } else if(a.getStatus().equalsIgnoreCase("Visited")) { %>
                                <h6 style="color: #20c997">Visited</h6>
                                <% } else if(a.getStatus().equalsIgnoreCase("Not-Visited")) { %>
                                <h6 style="color: red">Not-Visited</h6>
                                <% } else { %>
                                <h6 style="color: orange">Pending</h6>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                    }
                                }
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<section style="background: linear-gradient(#91a4ff,#ACB6E5,#f6f7f8);margin-top: 5vh; padding: 5vh;">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="profile-card text-center p-4">
                    <img src="ProfilePicChecker?user_id=<%=patient.getPid()%>" alt="Patient Photo" class="profile-img">
                    <h4 class="mt-3">Patient Name: <span id="patient-name"><%=patient.getFname() +" "+ patient.getLname()%></span></h4>
                    <p>Patient ID: <span id="patient-id"><%=pid%></span></p>
                    <p>Date of Birth: <span id="patient-age"><%=patient.getDob()%></span></p>
                    <p>City: <span id="patient-city"><%=patient.getCity()%></span></p>
                    <p>Blood Group: <span id="patient-bloodgroup"><%=patient.getBloodgroup()%></span></p>
                    <div class="d-flex justify-content-center gap-3 mt-4">
                        <button class="btn btn-primary btn-custom">Prescriptions</button>
                        <button data-bs-toggle="modal" data-bs-target="#appointmentModal" class="btn btn-success btn-custom">Appointments</button>
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
        location.reload();
    }, 2000); // Refresh after 5 seconds

    function submitProfileForm() {
        document.getElementById('doctorProfile.jsp').submit();
    }
</script>
</body>
</html>