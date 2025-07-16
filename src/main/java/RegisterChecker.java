import dto.PatientDto;
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

@WebServlet(name = "RegisterChecker",urlPatterns = "/RegisterChecker")
public class RegisterChecker extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String fname = req.getParameter("fname");
        String lname = req.getParameter("lname");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String role = req.getParameter("role");

        if(!fname.isEmpty() && !lname.isEmpty() && !password.isEmpty() && !email.isEmpty() && !role.isEmpty())
        {
            HttpSession session = req.getSession(true);

            if(role.equalsIgnoreCase("admin"))
            {

            }
            else if (role.equalsIgnoreCase("patient"))
            {
                Patient patient = new Patient();
                patient.setFname(fname);
                patient.setLname(lname);
                patient.setPassword(password);
                patient.setEmail(email);

                PatientRegisterAuthenticator authenticator = new PatientRegisterAuthenticator();
                boolean regis = authenticator.isRegister(patient);

                if(regis)
                {
                    session.setAttribute("fname", fname);
                    session.setAttribute("p_id", patient.getPid());
                    resp.sendRedirect("patientRegisterDetails.jsp");
                }
                else
                {
                    session.setAttribute("regis", false);
                    resp.sendRedirect("index.jsp");
                }
            }
            else if (role.equalsIgnoreCase("doctor"))
            {
                Doctor doctor = new Doctor();
                doctor.setFname(fname);
                doctor.setLname(lname);
                doctor.setPassword(password);
                doctor.setEmail(email);
                doctor.setRole(role);

                DoctorRegisterAuthenticator auth = new DoctorRegisterAuthenticator();
                boolean regis = auth.isRegister(doctor);

                if(regis)
                {
                    session.setAttribute("fname", fname);
                    session.setAttribute("d_id", doctor.getD_id());
                    resp.sendRedirect("doctorRegisterDetails.jsp");
                }
                else
                {
                    session.setAttribute("regis", false);
                    resp.sendRedirect("index.jsp");
                }
            }
            else
            {
                session.setAttribute("regis", false);
                resp.sendRedirect("index.jsp");
            }
        }
        else
        {

            resp.sendRedirect("index.jsp");
        }
    }
}
