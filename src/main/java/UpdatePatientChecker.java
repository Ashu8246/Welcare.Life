import entities.Patient;
import model.UpdatePatientAuthenticator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdatePatientChecker",urlPatterns = "/UpdatePatientChecker")
public class UpdatePatientChecker extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("index.html");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

       String pid = req.getParameter("pid");
       String fname = req.getParameter("fname");
       String lname = req.getParameter("lname");
       String email = req.getParameter("email");
       String gender = req.getParameter("gender");
       String dob = req.getParameter("dob");
       String address = req.getParameter("address");
       String city = req.getParameter("city");
       String phone = req.getParameter("phone");
       String bloodgroup = req.getParameter("bloodgroup");
       String password =  req.getParameter("password");
       String referrer = req.getHeader("Referer");

       if(pid != null && fname != null && lname != null && email != null && gender != null && dob != null && address != null)
       {
            Patient patient = new Patient();
            patient.setPid(pid);
            patient.setFname(fname);
            patient.setLname(lname);
            patient.setEmail(email);
            patient.setGender(gender);
            patient.setDob(dob);
            patient.setAddress(address);
            patient.setCity(city);
            patient.setPhone(phone);
            patient.setBloodgroup(bloodgroup);
            patient.setPassword(password);

           UpdatePatientAuthenticator authenticator = new UpdatePatientAuthenticator();
           boolean update = authenticator.isUpdate(patient);

           if (update)
           {
               resp.sendRedirect(referrer);
           }
           else
           {
                resp.sendRedirect(referrer);
           }
       }
       else
       {
           resp.sendRedirect(referrer);
       }
    }
}
