import model.DeleteProfilePhotoAuthenticaator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet(name = "DeleteProfilePhotoChecker" , urlPatterns = "/DeleteProfilePhotoChecker")
public class DeleteProfilePhotoChecker extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String referer = req.getHeader("Referer");
        String user_id = req.getParameter("user_id");

        if (user_id != null)
        {
            DeleteProfilePhotoAuthenticaator authenticator = new DeleteProfilePhotoAuthenticaator();
            boolean delete = authenticator.isDelete(user_id);
            if (delete)
            {
                resp.sendRedirect(referer);
            }
            else
            {
                resp.sendRedirect(referer);
            }
        }
        else  {
            resp.sendRedirect(referer);
        }
    }
}
