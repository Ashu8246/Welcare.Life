import entities.Appointment;
import model.AppointmentAuthenticator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AppointmentChecker",urlPatterns = "/AppointmentChecker")
public class AppointmentChecker extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.sendRedirect("appointment.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String pid = req.getParameter("pid");
        String pname = req.getParameter("pname");
        String d_id = req.getParameter("d_id");
        String dname = req.getParameter("dname");
        String date =  req.getParameter("date");
        String time =  req.getParameter("time");
        String reason = req.getParameter("reason");
        String phone = req.getParameter("phone");
        String status = req.getParameter("status");
        String reason_id = req.getParameter("reason_id");
        String type = req.getParameter("type");
        System.out.println(reason_id +" "+ type +" "+ status);

        Appointment appointment = new Appointment();
        AppointmentAuthenticator auth =  new AppointmentAuthenticator();

        if(pid != null && pname != null && date != null && time != null && reason != null && d_id != null)
        {
            appointment.setPid(pid);
            appointment.setPname(pname);
            appointment.setD_id(d_id);
            appointment.setDate(date);
            appointment.setTime(time);
            appointment.setReason(reason);
            appointment.setPhone(phone);
            appointment.setDname(dname);

            boolean appoint = auth.isAppoint(appointment);

            if(appoint)
            {
                resp.sendRedirect("patientHome.jsp");
            }
            else
            {
                resp.sendRedirect("appointment.jsp");
            }
        }
        else if (status != null && reason_id != null && type.equalsIgnoreCase("availability"))
        {
            //Set details to appointment entity
            appointment.setReason_id(Integer.parseInt(reason_id));
            appointment.setStatus(status);

            //Appointment Authenticator
            boolean appoint = auth.isStatus(appointment);

            if(appoint)
            {
                resp.sendRedirect("docHome.jsp");
            }
            else
            {
                resp.sendRedirect("appointment.jsp");
            }
        }
        else
        {
            resp.sendRedirect("appointment.jsp");
        }
    }
}
