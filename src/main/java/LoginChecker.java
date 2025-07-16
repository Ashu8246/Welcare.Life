import dto.DoctorDto;
import dto.PatientDto;
import entities.Admin;
import model.LoginAuthenticator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginChecker" ,urlPatterns = "/LoginChecker")
public class LoginChecker extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String u_id=req.getParameter("u_id");
        String password=req.getParameter("password");
        String role=req.getParameter("role");

        LoginAuthenticator auth = new LoginAuthenticator();
        HttpSession session = req.getSession(true);

        if(role.equalsIgnoreCase("admin"))
        {
            if(u_id !=  null && password != null)
            {
                Admin admin = new Admin();
                admin.setAdmin_id(u_id);
                admin.setPassword(password);

                boolean login = auth.isAdmin(admin);
                if(login)
                {
                    session.setAttribute("admin_id", u_id);
                    resp.sendRedirect("adminHome.jsp");
                }
                else
                {
                    resp.sendRedirect("index.jsp");
                }
            }
            else
            {
                resp.sendRedirect("index.jsp");
            }
        }
        else if(role.equalsIgnoreCase("patient"))
        {
            if(u_id !=  null && password != null)
            {
                PatientDto patient = new PatientDto();
                patient.setPid(u_id);
                patient.setPassword(password);

                boolean login = auth.isPatient(patient);

                if(login)
                {
                    session.setAttribute("pid", patient.getPid());
                    resp.sendRedirect("patientHome.jsp");
                }
                else
                {
                    resp.sendRedirect("index.jsp");
                }
            }
            else
            {
                resp.sendRedirect("index.jsp");
            }
        }
        else if(role.equalsIgnoreCase("doctor"))
        {
            if(u_id !=  null && password != null)
            {
                DoctorDto doctor = new DoctorDto();
                doctor.setD_id(u_id);
                doctor.setPassword(password);

                boolean login = auth.isDoctor(doctor);

                if(login)
                {
                    session.setAttribute("d_id", doctor.getD_id());
                    resp.sendRedirect("docHome.jsp");
                }
                else
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
            resp.sendRedirect("index.jsp");
        }
    }

}
