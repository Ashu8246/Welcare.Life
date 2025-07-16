<%--
  Created by IntelliJ IDEA.
  User: ashug
  Date: 18-06-2025
  Time: 02:25 am
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
    String pid = request.getParameter("pid");
    String d_id = request.getParameter("d_id");
    String pname = request.getParameter("pname");
    String dname = request.getParameter("dname");
    String phone  = request.getParameter("phone");

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
                    <a class="nav-link active" href="index.jsp">Home</a>
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
                    if(pid != null)
                    {
                %><%=pid%><%
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

<section style="background: linear-gradient(#8dabff,#ACB6E5,rgb(246,247,248)); border-radius: 30px; justify-items: center; padding: 10vh;">
    <!-- Make Appointment -->
    <div class="col-md-4" style="min-width: 50vh;">
        <div class="info-box">
            <h5>Make an Appointment</h5>
            <form action="AppointmentChecker" method="post" class="mt-3">
                <input type="hidden" name="pid" value="<%=pid%>">
                <input type="hidden" name="d_id" value="<%=d_id%>">
                <div class="row g-2 mb-2">
                    <div class="row g-2 mb-2">
                    <div class="col">
                        <input type="text" class="form-control" name="reason" placeholder="Reason for Visit" required>
                    </div>
                    </div>
                    <div class="row g-2 mb-2">
                        <div class="col">
                            <input type="text" name="dname" class="form-control" placeholder="Name" value="Dr. <%=dname%>" required readonly>
                        </div>
                    </div>
                    <div class="row g-2 mb-2">
                        <div class="col">
                            <input type="text" name="pname" class="form-control" placeholder="Name" value="<%=pname%>" required readonly>
                        </div>
                    </div>
                    <div class="row g-2 mb-2">
                        <div class="col">
                            <input type="date" name="date" class="form-control" required>
                        </div>
                        <div class="col">
                            <select name="time" class="form-select" required>
                                <option value="">Select Time Slot</option>
                                <option>9:00 AM - 10:00 AM</option>
                                <option>10:00 AM - 11:00 AM</option>
                                <option>11:00 AM - 12:00 PM</option>
                                <option>12:00 PM - 1:00 PM</option>
                                <option>2:00 PM - 3:00 PM</option>
                                <option>3:00 PM - 4:00 PM</option>
                                <option>4:00 PM - 5:00 PM</option>
                            </select>
                        </div>
                    </div>

                    <div class="row g-2 mb-2">
                        <div class="col">
                            <input type="tel" name="phone" class="form-control" value="<%=phone%>" placeholder="Phone No" required pattern="[0-9]{10}" maxlength="10">
                        </div>
                    </div>

                    <div class="text-center mt-3">
                        <button type="submit" class="appointment-btn">Book Appointment</button>
                    </div>
                </div>
            </form>
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

</body>
</html>