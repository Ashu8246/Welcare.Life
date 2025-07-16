import entities.Doctor;
import entities.Patient;
import model.DoctorRegisterAuthenticator;
import model.PatientRegisterAuthenticator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name="DetailsChecker", urlPatterns = "/DetailsChecker")
public class DetailsChecker extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String d_id = req.getParameter("d_id");
        String p_id = req.getParameter("p_id");
        String dob = req.getParameter("dob");
        String gender = req.getParameter("gender");
        String address = req.getParameter("address");
        String bloodgroup = req.getParameter("bloodgroup");
        String city = req.getParameter("city");
        String phone = req.getParameter("phone");
        String experience = req.getParameter("experience");
        String specialization = req.getParameter("specialization");
        String qualification = req.getParameter("qualification");

        HttpSession session = req.getSession(true);

        if(d_id == null || d_id == "")
        {

            if (dob != null && gender != null && address != null && bloodgroup != null && city != null && phone != null)
            {
                Patient patient = new Patient();
                patient.setPid(p_id);
                patient.setDob(dob);
                patient.setGender(gender);
                patient.setAddress(address);
                patient.setCity(city);
                patient.setPhone(phone);
                patient.setBloodgroup(bloodgroup);

                PatientRegisterAuthenticator auth = new PatientRegisterAuthenticator();
                boolean details = auth.isDetails(patient);

                if (details)
                {
                    session.setAttribute("pid", patient.getPid());
                    resp.sendRedirect("patientHome.jsp");
                } else
                {
                    resp.sendRedirect("index.jsp");
                }
            }
            else
            {
                resp.sendRedirect("index.jsp");
            }
        }
        else
        {
            if (gender != null && address != null && city != null && phone != null && experience != null && specialization != null && qualification != null)
            {
                Doctor doctor = new Doctor();
                doctor.setD_id(d_id);
                doctor.setDob(dob);
                doctor.setGender(gender);
                doctor.setAddress(address);
                doctor.setCity(city);
                doctor.setPhone(phone);
                doctor.setQualification(qualification);
                doctor.setSpecialization(specialization);
                doctor.setExperience(experience);

                DoctorRegisterAuthenticator auth = new DoctorRegisterAuthenticator();
                boolean details = auth.isDetails(doctor);

                if (details) {
                    session.setAttribute("d_id", doctor.getD_id());
                    resp.sendRedirect("docHome.jsp");
                } else
                {
                    resp.sendRedirect("index.jsp");
                }
            }
            else
            {
                resp.sendRedirect("index.jsp");
            }
        }
    }
}
