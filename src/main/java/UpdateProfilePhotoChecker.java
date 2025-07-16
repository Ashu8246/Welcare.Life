import entities.ProfilePics;
import model.UpdateProfilePhotoAuthenticator;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;

@WebServlet(name = "UpdateProfilePhotoChecker", urlPatterns = "/UpdateProfilePhotoChecker")
@MultipartConfig
public class UpdateProfilePhotoChecker extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("doctorProfile.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String user_id = req.getParameter("user_id");
        Part profilepic = req.getPart("image");

        if(user_id != null && profilepic != null)
        {
            try
            {
                InputStream picstream = profilepic.getInputStream();
                byte[] picData = picstream.readAllBytes();

                ProfilePics profile = new ProfilePics();
                profile.setUser_id(user_id);
                profile.setProfilePic(picData);

                UpdateProfilePhotoAuthenticator authenticator = new UpdateProfilePhotoAuthenticator();
                boolean update = authenticator.isprofilepic(profile);

                if (!update)
                {
                    resp.sendRedirect("doctorProfile.jsp");
                }
                else {
                    resp.sendRedirect("doctorProfile.jsp");
                }
            }
            catch (Exception e)
            {
                System.out.println(e);
            }
        }
        else
        {
            resp.sendRedirect("doctorProfile.jsp");
        }
    }
}
