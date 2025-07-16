import dto.DeleteDto;
import model.DeleteAuthenticator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name ="DeleteChecker",urlPatterns = "/DeleteChecker")
public class DeleteChecker extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("index.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String admin_id = req.getParameter("admin_id");
        String d_id = req.getParameter("d_id");
        String pid = req.getParameter("pid");
        String password = req.getParameter("password");
        String _for =  req.getParameter("_for");
        String referer = req.getHeader("referer");


        DeleteDto deleteDto = new DeleteDto();
        deleteDto.setAdmin_id(admin_id);
        deleteDto.setPassword(password);

        if(admin_id != null && password != null && _for.equalsIgnoreCase("adminDeleteDoc"))
        {
            deleteDto.setD_id(d_id);

            DeleteAuthenticator auth = new DeleteAuthenticator();
            boolean delete = auth.isDeleteDocByAdmin(deleteDto);

            if(delete)
            {
                resp.sendRedirect("adminHome.jsp");
            }
            else
            {
                resp.sendRedirect(referer);
            }
        }
        else if(d_id != null && password != null && _for.equalsIgnoreCase("doctor"))
        {

        }
        else if(pid != null && password != null && _for.equalsIgnoreCase("patient"))
        {

        }
        else
        {
            resp.sendRedirect(referer);
        }
    }
}
