import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    // Map for userid to password
    private Map<String, String> users = new HashMap<>();
    // Map for userid to user name
    private Map<String, String> userNames = new HashMap<>();

    @Override
    public void init() throws ServletException {
        try {
        	// Load users.xml from WEB-INF 
            File file = new File(getServletContext().getRealPath("/WEB-INF/users.xml"));
            System.out.println("Loading users from: " + file.getAbsolutePath());
            
            // Initialize XML parser
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(file);
            doc.getDocumentElement().normalize();
            
            // Get user elements from the XML file
            NodeList nodeList = doc.getElementsByTagName("user");
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element element = (Element) node;
                    
                    // Extract user information from the XML file
                    String userid = element.getElementsByTagName("userid").item(0).getTextContent();
                    String name = element.getElementsByTagName("name").item(0).getTextContent();
                    String password = element.getElementsByTagName("password").item(0).getTextContent();
                    
                    // Store user date 
                    users.put(userid, password);
                    userNames.put(userid, name);
                    // Print loaded user details for debugging
                    System.out.println("Loaded user: " + userid + " | Name: " + name + " | Password: " + password);
                }
            }
        } catch (Exception e) {
            System.out.println("Error loading user data: " + e.getMessage());
            throw new ServletException("Error loading user data", e);
        }
    }
    
    // Handle login 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	
    	// Retrieve user input from the login form 
        String userid = request.getParameter("uid");
        String password = request.getParameter("pass");
        
        // Validate user credentials
        if (users.containsKey(userid) && users.get(userid).equals(password)) {
            // Create a session for the authenticated user 
        	HttpSession session = request.getSession();
            session.setAttribute("userid", userid);
            // Store the user's name in the session so welcome.jsp can display it.
            session.setAttribute("name", userNames.get(userid));
            
         // Ensure a fresh JSESSIONID cookie is sent to the browser
            Cookie sessionCookie = new Cookie("JSESSIONID", session.getId());
            sessionCookie.setHttpOnly(true); // Prevents JavaScript from accessing the cookie
            sessionCookie.setSecure(false); // Allow the cookie to be sent over both HTTP and HTTPS
            sessionCookie.setPath(request.getContextPath());
            response.addCookie(sessionCookie);
            
            // Redirect to the welcome page upon successful login
            response.sendRedirect("Welcome");
        } else {
        	// Redirect back to the login page with an error message
            response.sendRedirect("login.jsp?error=Invalid+Credentials");
        }
    }
}



