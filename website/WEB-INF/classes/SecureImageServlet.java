import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SecureImage")
public class SecureImageServlet extends HttpServlet{

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		// Check for a valid session
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userid") == null) 
        {
        	System.out.println("no session");
            // Redirect to login page if the user is not authenticated
            response.sendRedirect("login.jsp");
            return; //Stop execution after redirecting
        } 
        
        // Retrieve the protected image
        String imageName = request.getParameter("name");
        // If the image name does not exist, display an error 
        if (imageName == null || imageName.isEmpty()) {
        	response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid image name");
        	return;
        }
        
        // Define the image path 
        File imageFile = new File(getServletContext().getRealPath("/WEB-INF/images/") + File.separator + imageName);
        
        // Set headers to prevent caching 
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", -1);
        
        // Check if the image exists 
        // If the image file does not exist, return 404 not found error 
        if (!imageFile.exists()) {
        	response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
        	return;
        }
        
        // Set the image type 
        String contentType;
        if (imageName.endsWith(".jpg") || imageName.endsWith(".jpeg")) {
//            response.setContentType("image/jpeg");
        	contentType = "image/jpeg";
        } else if (imageName.endsWith(".png")) {
//            response.setContentType("image/png");
            contentType = "image/png";
        } else {
            response.sendError(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE, "Unsupported image type!");
            return;
        }
        
        // Convert image to Base64
        byte[] imageBytes = Files.readAllBytes(imageFile.toPath());
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);

        // Send Base64 image instead of raw binary
        response.setContentType("text/plain");  // Prevents browsers from treating it as an image
        response.getWriter().write("data:" + contentType + ";base64," + base64Image);
        

	}
	
}
