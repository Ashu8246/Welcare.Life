import entities.Admin;
import model.VerificationAuthenticator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "VerificationChecker",urlPatterns = "/VerificationChecker")
public class VerificationChecker extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String d_id = req.getParameter("d_id");
        String verification = req.getParameter("verification");

        VerificationAuthenticator auth = new VerificationAuthenticator();
        boolean verified = auth.isVerify(d_id,verification);

        if(verified)
        {
            resp.sendRedirect("adminHome.jsp");
        }
        else
        {
            resp.sendRedirect("adminHome.jsp");
        }
    }
}
