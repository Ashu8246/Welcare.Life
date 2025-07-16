import entities.ContactUs;
import model.ContactUsAuthenticator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ContactUsChecker",urlPatterns = "/ContactUsChecker")
public class ContactUsChecker extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("index.html");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String reason = req.getParameter("reason");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String message = req.getParameter("message");
        String role = req.getParameter("role");
        String referer = req.getHeader("referer");

        if( reason != null && name != null && email != null && phone != null && message != null && role != null)
        {
            ContactUs contactUs = new ContactUs();
            contactUs.setName(name);
            contactUs.setEmail(email);
            contactUs.setPhone(phone);
            contactUs.setMessage(message);
            contactUs.setRole(role);
            contactUs.setReason(reason);

            ContactUsAuthenticator auth =  new ContactUsAuthenticator();
            boolean contact = auth.isContactUs(contactUs);

            if(contact)
            {
                resp.sendRedirect(referer);
            }
            else
            {
                resp.sendRedirect(referer);
            }
        }
        else {
            resp.sendRedirect(referer);
        }
    }
}
