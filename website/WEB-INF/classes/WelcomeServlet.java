import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


@WebServlet("/Welcome")
public class WelcomeServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Check for a valid session
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userid") == null) 
        {
        	System.out.println("no session");
            // Redirect to login page if the user is not authenticated
            response.sendRedirect("login.jsp");
        } 
        
        else 
        {
            // Forward to welcome.jsp if the user is authenticated
            request.getRequestDispatcher("welcome.jsp").forward(request, response);
        }
	}

}
