import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


// Servlet that generates Javascript to prevent users from performing restricted actions

@WebServlet("/DisableActions")
public class DisableActionsServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/javascript");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		// Display an alert and redirect to an error page when a restricted action is detected
        out.println("document.addEventListener('DOMContentLoaded', function() {");
        
        // Block the print function (Ctrl+P or Cmd + P)
		out.println("document.addEventListener('keydown', function (event) {");
		out.println("	if ((event.ctrlKey || event.metaKey) && event.key.toLowerCase() === 'p') {"); 
		out.println(" 		event.preventDefault();");
		out.println("		alert('Printing is disabled. Redirecting...');");
		// Redirect to error.jsp with an action parameter
		out.println("setTimeout(function() { window.location.href = '" + request.getContextPath() + "/error.jsp?action=Printing'; }, 1000);");

		out.println("	}");
		out.println("});");
		
		 // Disable right click
	    out.println("document.addEventListener(\"contextmenu\", function (event) {");
	    out.println("    event.preventDefault();");
		out.println("	alert('Right click is disabled. Redirecting...');");
		// Redirect to error.jsp with an action parameter
		out.println("setTimeout(function() { window.location.href = '" + request.getContextPath() + "/error.jsp?action=Right Click'; }, 1000);");
		out.println("});");

	    // Disable copy
	    out.println("document.addEventListener('copy', function (event) {");
	    out.println("    event.preventDefault();");
		out.println("	alert('Copying is disabled. Redirecting...');");
		// Redirect to error.jsp with an action parameter
		out.println("setTimeout(function() { window.location.href = '" + request.getContextPath() + "/error.jsp?action=Copying'; }, 1000);");
	    out.println("});");
	    
	    // Disable cut
	    out.println("document.addEventListener('cut', function (event) {");
	    out.println("    event.preventDefault();");
		out.println("	alert('Cutting is disabled. Redirecting...');");
		// Redirect to error.jsp with an action parameter
		out.println("setTimeout(function() { window.location.href = '" + request.getContextPath() + "/error.jsp?action=Cutting'; }, 1000);");
		out.println("});");
	    
	    // Disable paste
	    out.println("document.addEventListener('paste', function (event) {");
	    out.println("    event.preventDefault();");
		out.println("	alert('Pasting is disabled. Redirecting...');");
		// Redirect to error.jsp with an action parameter
		out.println("setTimeout(function() { window.location.href = '" + request.getContextPath() + "/error.jsp?action=Pasting'; }, 1000);");
		out.println("});");
		
	    // Disable text selection
	    out.println("document.addEventListener('selectstart', function (event) {");
	    out.println("    event.preventDefault();");
	    out.println("	alert('Text selection is disabled. Redirecting...');");
	 // Redirect to error.jsp with an action parameter
	    out.println("setTimeout(function() { window.location.href = '" + request.getContextPath() + "/error.jsp?action=Text Selection'; }, 1000);");
	    out.println("});");
		
		// Close DOMconternloaded event listener
		out.println("});");
		
		// Block selecting a print menu 
		// Trigger a redirect before print 
		out.println("window.onbeforeprint = function() {");
		out.println("	alert('Printing is disabled. Redirecting...'); ");
		// Redirect to error.jsp with an action parameter
		out.println("    setTimeout(function() {window.location.href = '" + request.getContextPath() + "/error.jsp';}, 10);");
		out.println("};");
		
		// Detect if the user enters print mode and redirect
		out.println("if (window.matchMedia) {");
        out.println("    var mediaQuery = window.matchMedia('print');");
        out.println("    mediaQuery.addEventListener('change', function(event) {");
        out.println("        if (event.matches) {");
        out.println("            alert('Printing is disabled. Redirecting...');");
        out.println("    setTimeout(function() {window.location.href = '" + request.getContextPath() + "/error.jsp';}, 10);");
        out.println("        }");
        out.println("    });");
        out.println("}");
	}

}
