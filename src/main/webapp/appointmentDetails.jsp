<%@ page import="dao.Display" %>
<%@ page import="entities.Doctor" %>
<%@ page import="entities.Appointment" %><%--
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
    <link rel="stylesheet" href="css/appointment-style.css"/>


</head>
<body class="bg-light">
<%
//
    String d_id = (String) session.getAttribute("d_id");
    String pid  = (String) session.getAttribute("pid");
    if(d_id == null)
    {
        d_id = request.getParameter("d_id");
    }
    String reason_id = request.getParameter("reason_id");

    Display display = new Display();
    Appointment appoint = null;
    if(d_id == null)
    {
        response.sendRedirect("docHome.jsp");
    }
    else {
        try
        {
            appoint = display.getAppointmentDetailsReason_id(reason_id);
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
                    <%if(pid!=null) {
                    %>
                    <a class="nav-link" href="patientHome.jsp" ">Home</a>
                    <%
                    }
                    else{
                    %>
                    <a class="nav-link" href="doctorHome.jsp" >Home</a>

                    <%}%>
                </li>
                <li class="nav-item">
                    <%if(pid!=null) {
                %>
                    <a class="nav-link" href="patientProfile.jsp" onclick="submitProfileForm()">Profile</a>
                    <%
                    }
                    else{
                    %>
                    <a class="nav-link" href="doctorProfile.jsp" onclick="submitProfileForm()">Profile</a>

                    <%}%>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contact">Contact</a>
                </li>
            </ul>
            <div style="margin: 10px;" class="d-flex gap-2">
                <%if(pid!=null) {
                    %>
                    <%=pid%>
                    <%
                }
                else{
                %><%=d_id%>
                <%}%>
            </div>
            <div class="d-flex gap-2">
                <a href="signOut.jsp"><button class="btn btn-primary" >Sign out</button></a>
            </div>
        </div>
    </div>
</nav>
<div class="modal fade" id="appointStatusModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4 p-3">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold" id="signupModalLabel">Appointment Status</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body pt-0">
                <form action="AppointmentChecker" method="post">
                    <input type="hidden" name="reason_id" value="<%=reason_id%>">
                    <input type="hidden" name="type" value="availability">
                    <div class="row g-3 mb-3 mt-1">
                        <div class="mb-1">
                            <select class="form-control " name="status" id="role">
                                <option>Choose status</option>
                                <option value="Confirmed">Confirm</option>
                                <option value="Rejected">Reject</option>
                                <option value="Visited">Visited</option>
                                <option value="Not-Visited">Not-Visited</option>
                            </select>
                        </div>
                            <div class="d-grid mt-4">
                                <button type="submit" class="btn btn-primary fw-semibold">Update</button>
                            </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>

<section style="background: linear-gradient(#91a4ff,#ACB6E5,#f6f7f8);margin-top: 5vh; padding: 5vh;">
    <div class="appointment-container">
        <div class="header">
            <h4>Patient Appointment Details</h4>
        </div>

        <div class="info-row">
            <div class="info-label">Patient Name</div>
            <div class="info-value"><%=appoint.getPname()%></div>
        </div>

        <div class="info-row">
            <div class="info-label">Reason for Visit</div>
            <div class="info-value"><%=appoint.getReason()%></div>
        </div>

        <div class="info-row">
            <div class="info-label">Appointment Date</div>
            <div class="info-value"><%=appoint.getDate()%></div>
        </div>

        <div class="info-row">
            <div class="info-label">Time</div>
            <div class="info-value"><%=appoint.getTime()%></div>
        </div>

        <div class="info-row">
            <div class="info-label">City</div>
            <div class="info-value"><%=appoint.getCity()%></div>
        </div>

        <div class="info-row">
            <div class="info-label">Status</div>
            <div class="info-value">
                <%
                    if(appoint.getStatus().equalsIgnoreCase("confirmed"))
                    {
                        %><span class="status-badge status-confirmed">Confirmed</span><%
                    }
                    else if(appoint.getStatus().equalsIgnoreCase("Rejected"))
                    {
                        %><span class="status-badge status-cancelled">Rejected</span><%
                    }
                    else if(appoint.getStatus().equalsIgnoreCase("visited"))
                    {
                        %><span class="status-badge status-confirmed">Visited</span><%
                    }
                    else if(appoint.getStatus().equalsIgnoreCase("not-visited"))
                    {
                        %><span class="status-badge status-pending">Not-Visited</span><%
                    }
                    else {
                        %><span class="status-badge status-pending">Pending</span><%

                    }
                %>
            </div>
        </div>
        <!-- Update Status Button -->
        <%
            if(pid!=null)
            {}
            else
            {
        %>
        <div class="text-end mt-4">
            <button class="update-btn" data-bs-toggle="modal" data-bs-target="#appointStatusModal" >Update Status</button>
        </div
        <%
            }
        %>

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