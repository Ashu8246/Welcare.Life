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

        String d_id = req.getParameter("d_id");
        String p_id = req.getParameter("p_id");
        String fname = req.getParameter("fname");
        String lname = req.getParameter("lname");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String gender = req.getParameter("gender");
        String dob = req.getParameter("dob");
        String bloodgroup = req.getParameter("bloodgroup");
        String date  = req.getParameter("date");
        String time  = req.getParameter("time");
        String reason = req.getParameter("reason");



    }
}
