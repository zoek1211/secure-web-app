<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Page 2</title>

	<script src="security.js"></script>
	<style>
		/* Disable text selection */
		body {
			-webkit-user-select: none; /* Safari */
			-moz-user-select: none; /* Firefox */
			-ms-user-select: none; /* Edge */
			user-select: none; /* Standard */
			font-family: Arial, sans-serif; 
			margin: 20px;
		}

		/* Disable dragging images */
		img {
			pointer-events: none;
			-webkit-user-drag: none;
		}
	</style>
</head>
<body>

<!-- Setting cache control headers to prevent the browser from caching the page  -->
		<%
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, max-age=0");
		response.setHeader("Pragma", "no-cache");
    	response.setDateHeader("Expires", -1);	
			
    		// Checking if the session attribute "userid" is null
			if(session.getAttribute("userid")==null)
			{
				// If "userid" is null, redirect to the login page
				response.sendRedirect("login.jsp");
			}
		%>
		
</body>
</html>