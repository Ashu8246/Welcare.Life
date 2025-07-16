import entities.Doctor;
import model.UpdateDoctorAuthenticator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "UpdateDoctorChecker", urlPatterns = "/UpdateDoctorChecker")
public class UpdateDoctorChecker extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("docHome.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String type = req.getParameter("type");
        String d_id = req.getParameter("d_id");
        String fname = req.getParameter("fname");
        String lname = req.getParameter("lname");
        String qualification = req.getParameter("qualification");
        String specialization = req.getParameter("specialization");
        String password = req.getParameter("password");
        String city = req.getParameter("city");
        String address = req.getParameter("address");

        UpdateDoctorAuthenticator auth  = new UpdateDoctorAuthenticator();
        Doctor doctor = new Doctor();
        HttpSession session = req.getSession(true);
        if(d_id != null && type != null)
        {
            if(type.equalsIgnoreCase("availability")) {

                doctor.setD_id(d_id);
                boolean status = auth.isAvailability(doctor);

                if(status)
                {
                    resp.sendRedirect("docHome.jsp");
                }
                else {
                    resp.sendRedirect("docHome.jsp");
                }
            }
            else if(type.equalsIgnoreCase("details"))
            {
                if(d_id != null && fname != null &&  lname != null && qualification != null && specialization != null && city != null && address != null)
                {
                    doctor.setD_id(d_id);
                    doctor.setFname(fname);
                    doctor.setLname(lname);
                    doctor.setQualification(qualification);
                    doctor.setSpecialization(specialization);
                    doctor.setCity(city);
                    doctor.setAddress(address);
                    doctor.setPassword(password);

                    boolean update = auth.isUpdateDetails(doctor);

                    if (update) {
                        resp.sendRedirect("doctorProfile.jsp");
                    } else {
                        resp.sendRedirect("docHome.jsp");
                    }
                }else {
                    resp.sendRedirect("docHome.jsp");
                }
            }
            else
            {
                resp.sendRedirect("docHome.jsp");
            }
        }
        else
        {
            resp.sendRedirect("docHome.jsp");
        }
    }
}
