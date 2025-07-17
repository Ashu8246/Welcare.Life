import db.DbProvider;
import entities.ProfilePics;
import org.hibernate.Session;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet(name = "ProfilePicChecker",urlPatterns = "/ProfilePicChecker")
public class ProfilePicChecker extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("doctorProfile.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String userId = req.getParameter("user_id");
        Session session = DbProvider.getSession();
        try {
            ProfilePics pic = session.find(ProfilePics.class, userId);
            if (pic != null && pic.getProfilePic() != null) {
                resp.setContentType("image/jpeg");
                OutputStream out = resp.getOutputStream();
                out.write(pic.getProfilePic());
                out.flush();
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
