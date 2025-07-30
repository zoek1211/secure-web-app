import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

import java.io.IOException;

@WebFilter("/*")  // Apply to all URLs 
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();

        // Allow login page, login servlet, and logout servlet to be accessed without authentication
        boolean isLoginPage = path.endsWith("login.jsp") || path.endsWith("/Login") || path.endsWith("/Logout");

        // Protect sensitive files like users.xml or userdata.xml
        boolean isSensitiveFile = path.endsWith("users.xml") || path.endsWith("userdata.xml");
        
        // Get the current session without creating a new one
        HttpSession session = req.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("userid") != null);
        
        // Allow access if the user is logged in or requesting a login page
        if (loggedIn || isLoginPage) {
        	// Block direct access to sensitive files
            if (isSensitiveFile) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            } else {
                chain.doFilter(request, response);  // Continue if allowed
            }
        } else {
        	// Redirect unauthorized users to the login page
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    public void init(FilterConfig filterConfig) throws ServletException {}
    public void destroy() {}
}

