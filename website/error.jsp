<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Action Not Allowed</title>

<style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
            background-color: #f8f8f8;
        }
        h1 {
            font-size: 36px;
            color: #d9534f;
        }
        p {
            font-size: 18px;
            color: #333;
        }
    </style>


<script>
	// Get the restricted action type from url
	function getRestrictedAction() {
		const urlParams = new URLSearchParams(window.location.search);
		return urlParams.get('action') || "Restricted Action";
	}
	
	// Display the appropriate message
	document.addEventListener("DOMContentLoaded", function() {
		document.getElementById("error-message").innerText =
			getRestrictedAction() + " is not allowed on this page.";
	});
</script>
</head>

<body>
	<h1>Secure Page - Action Not Allowed</h1>
	<p id="error-message">This action is not allowed.</p>
    <p>You attempted to perform an action that is restricted on this page.</p>
    
    <%-- Display the requested URL dynamically --%>
    <a href="javascript:history.back()" class="button">Go Back</a>

    <p><a href="<%= request.getContextPath() %>/">Return to Home</a></p>
    
   

</html>