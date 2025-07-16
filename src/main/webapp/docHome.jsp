<%@ page import="entities.Doctor" %>
<%@ page import="dao.Display" %>
<%@ page import="entities.Appointment" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %><%--
  Created by IntelliJ IDEA.
  User: ashug
  Date: 12-06-2025
  Time: 02:58 am
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
    <link rel="stylesheet" href="css/doc-style.css"/>
</head>
<body class="bg-light">

<%
    String d_id = (String) session.getAttribute("d_id");
    if(d_id == null)
    {
        response.sendRedirect("index.jsp");
    }
    else {
    Doctor doctor = null;
    List<Appointment> appoint = null;
    try {

        Display display = new Display();
        doctor = display.getDoctordetails(d_id);
        appoint = display.getAppointmentDetails(d_id);
    } catch (Exception e) {
        System.out.println(e);
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
            <div style="margin-right: 10px;" class="d-flex gap-2">
                <%
                    if(doctor != null)
                    {
                        %><%=doctor.getD_id()%><%
                    }
                    else {
                        response.sendRedirect("index.jsp");
                    }
            %>
            </div>
            <div class="d-flex gap-2">
                <a href="signOut.jsp"><button class="btn btn-primary" >Sign out</button></a>
            </div>
        </div>
    </div>
</nav>

<!-- Hidden data -->
<form id="profileForm" action="doctorProfile.jsp" method="post" style="display: none;">
    <input type="hidden" name="d_id" value="<%=d_id%>">
</form>

<div class="modal fade" id="searchPatientModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4 p-3">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold" id="signupModalLabel">Search Patient</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
                <form class="mt-3" action="patientDetails.jsp" method="post">
                    <div class="row g-2 mb-2">
                        <div class="col">
                            <input type="text" class="form-control" name="pid" placeholder="Patient Id" required>
                        </div>
                    </div>
                    <div class="text-center mt-3">
                        <button type="submit" class="appointment-btn">Search</button>
                    </div>
                </form>
        </div>
    </div>
</div>
</div>

<!-- Hero Section -->
<section class="hero-section">

</section>

<section style="background: linear-gradient(white,#ACB6E5,#91a4ff);">
<div class="container py-5 ">
    <div class="row g-4">
        <div class="container py-4" style=" max-width: 80vh;">
            <div class="row g-4">
                <div class="info-box border-primary"  >
                    <h5>Appointments</h5>
                    <div class="table-responsive mt-3" style="max-height: 40vh; overflow-y: auto;" >
                        <table class="table bg-transparent mb-0 no-vertical-borders">
                            <thead class="table-light">
                            <tr>
                                <th>Patient Name</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody  >
                            <%
                                if(appoint != null)
                                {
                                    Iterator<Appointment> app = appoint.iterator();
                                    while(app.hasNext())
                                    {
                                        Appointment a = app.next();
                                        if(a != null)
                                        {
                            %>
                            <tr>
                                <td><%=a.getPname()%></td>
                                <td><%=a.getReason()%></td>
                                <td><%if(a.getStatus().equalsIgnoreCase("Confirmed"))
                            {
                            %><h6 style="color: #20c997">Confirmed</h6><%
                            }
                            else if (a.getStatus().equalsIgnoreCase("Rejected"))
                            {
                            %><h6 style="color: red">Rejected</h6><%
                            }
                            else if (a.getStatus().equalsIgnoreCase("Visited"))
                            {
                                %><h6 style="color: #20c997">Visited</h6><%
                            }
                            else if (a.getStatus().equalsIgnoreCase("Not-Visited"))
                            {
                                %><h6 style="color: red">Not-Visited</h6><%
                            }
                            else
                            {
                            %><h6 style="color: orange">Pending</h6><%
                                }
                            %>
                            </td>
                                <td>
                                    <form action="appointmentDetails.jsp" method="post" >
                                        <input type="hidden" name="reason_id" value="<%=a.getReason_id()%>">
                                        <button type="submit" class="appointment-btn">See Details</button>
                                    </form>
                                </td>
                            </tr><%
                                        }
                                    }
                                }
                            %>
                            <!-- Add more rows as needed -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

    <div class="container py-5">
        <div class="row text-center justify-content-center">

            <div class="col-md-3">
                    <div class="block-box">

                        <div class="block-icon"><i class="bi bi-calendar-check"></i></div>
                        <div class="block-title">Update Availability</div>

                        <%
                            if(doctor.getStatus() == 0)
                            {
                        %><h5 style="color: red">Not Available</h5><%
                    }
                    else
                    {
                    %><h5 style="color: #20c997">Available</h5><%
                        }
                    %>
                        <form action="UpdateDoctorChecker" method="post">
                            <input type="hidden" name="d_id" value="<%=doctor.getD_id()%>">
                            <input type="hidden" name="type" value="availability">
                            <button class="emergency-btn" type="submit" >
                                <i class="bi"></i>
                                <%
                                    if(doctor.getStatus() == 0)
                                    {
                                %>Available<%
                            }
                            else {
                            %>Not-Available<%
                                }
                            %>
                            </button >
                        </form>
                    </div>
            </div>
            <div class="col-md-3">
                <a data-bs-toggle="modal" data-bs-target="#searchPatientModal" class="text-decoration-none text-dark">
                    <div class="block-box">
                        <div class="block-icon"><i class="bi bi-search"></i></div>
                        <div class="block-title">Search Patient</div>
                        <div class="block-text">To Search patient,<br> Enter Patient Id</div>
                    </div>
                </a>
            </div>
            <div class="col-md-3">
                <a data-bs-toggle="modal" data-bs-target="#searchPatientModal" class="text-decoration-none text-dark">
                    <div class="block-box">
                        <div class="block-icon"><i class="bi bi-signpost"></i></div>
                        <div class="block-title">Address</div>
                        <div class="block-text">198 West 21th Street,<br> Suite 721 New York NY 10016</div>
                    </div>
                </a>
            </div>
        </div>
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
<% }%>
<!-- Bootstrap + Icons -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
<script>
    setTimeout(function() {
        location.reload();
    }, 20000); // Refresh after 20 seconds

    function submitProfileForm() {
        document.getElementById('profileForm').submit();
    }
</script>
</body>
</html>
