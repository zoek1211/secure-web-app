import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/Logout")
public class LogoutServlet extends HttpServlet {
	
	// Handle GET requests
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleLogout(request, response);
    }

	// Handle POST requests
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleLogout(request, response);
    }
    
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	// Retrieve the current session, and don't create a new one if it doesn't exist
    	HttpSession session = request.getSession(false); 
        if (session != null) {
    		// Invalidate session, log out the user
            session.invalidate(); 
        }
        
        // Delete the JSESSIONID cookie by setting its max-age to 0
        Cookie cookie = new Cookie("JSESSIONID", "");
        cookie.setPath("/"); // Ensure the correct path 
        cookie.setHttpOnly(true);  // Prevent JavaScript access
        cookie.setMaxAge(0); // Expire immediately
        response.addCookie(cookie);

        // Redirect the client to the login page after logging out
        response.sendRedirect("login.jsp"); 
    }
	

}
