<%@ page import="javax.xml.transform.*, javax.xml.transform.stream.*, java.io.*" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome - All Books</title>
    <style>
        /* Disable text selection */
        body {
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
			font-family: Arial, sans-serif; 
			margin: 20px;
        }
        /* Disable dragging images */
        img {
            pointer-events: none;
            -webkit-user-drag: none;
        }
		/* Hero banner styles */
		        .hero-banner {
		            text-align: center;
		            margin-bottom: 30px;
		        }
		        .hero-banner img {
		            width: 100%;
		            max-height: 300px;
		            object-fit: cover;
		        }
		        .hero-banner h1 {
		            font-size: 28px;
		            margin-top: 10px;
		            color: #333;
		        }
		        .hero-banner p {
		            font-size: 16px;
		            color: #666;
		        }		
    </style>
</head>
<body>
<%
    // Set headers to prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, max-age=0");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1);
	
    HttpSession currentSession = request.getSession(false);
    // Check if user is logged in; if not, redirect to login.jsp
    if(currentSession == null || currentSession.getAttribute("userid") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
	
	%>

	<!-- Hero Banner Section -->
	<div class="hero-banner">
	    <!-- Banner image served via SecureImage servlet -->
	    <h1>Welcome to the Library Inventory Management Portal</h1>
	    <p>
	        You are now logged into the secure Library Management System. 
	        Please use the navigation menu to access the available tools and resources.
	    </p>
	</div>


	<%
        try {
            // Get the absolute paths for the XML and XSL files
            String xmlPath = application.getRealPath("/WEB-INF/books.xml");
            String xslPath = application.getRealPath("/WEB-INF/books.xsl");

            // Set up the XSLT transformation
            StreamSource xmlSource = new StreamSource(new File(xmlPath));
            StreamSource xslSource = new StreamSource(new File(xslPath));
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer(xslSource);

            // Pass the context path as a parameter (cast to HttpServletRequest)
            transformer.setParameter("contextPath", ((HttpServletRequest)pageContext.getRequest()).getContextPath());

            StringWriter sw = new StringWriter();
            StreamResult result = new StreamResult(sw);
            transformer.transform(xmlSource, result);

            // Output the transformed HTML (book listing)
            out.println(sw.toString());
        } catch(Exception e) {
            out.println("<p>Error transforming XML: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    
%>

<script>
	/* window.addEventListener("unload", function() {
	    navigator.sendBeacon("/Logout");
	}); */
	
	window.addEventListener("unload", function() {
	    fetch("/Logout", { method: "POST", keepalive: true });
	});
</script>
</body>
</html>
