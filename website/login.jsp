<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
    /* Center the page content */
    html, body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
        margin: 0;
        background-color: #f0f0f0;
    }
    
    /* Wrapper to center the container */
    .wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        height: 100vh;
    }

    /* Container for the login form */
    .container {
        background-color: white;
        padding: 60px;
        border-radius: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width: 440px; 
        text-align: center;
        border: 1px solid blue;
    }

    /* Header style */
    h1 {
        color: #007bff;
        margin-bottom: 10px;
    }

    /* Paragraph style */
    p {
        margin-bottom: 40px;
        color: #666;
    }

    /* Input field styles */
    input[type="text"], input[type="password"] {
        display: block;
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    /* Submit button styles */
    input[type="submit"] {
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        border: none;
        border-radius: 20px; 
        background-color: #007bff;
        color: white;
        font-size: 16px;
        cursor: pointer;
    }

    /* Submit button hover effect */
    input[type="submit"]:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
    <!-- Setting cache control headers to prevent the browser from caching the page -->
    <%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, max-age=0");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1);
    %>
    
    <div class="wrapper">
        <div class="container">
        
            <!-- Login form header -->
            <h1>Login</h1>
            <p>Please fill in your credentials to login.</p>
            
           <!-- Displays error message to user for incorrect login -->
          <% String error = request.getParameter("error"); %>
            <% if (error != null) { %>
                <p style="color:red;"><%= error %></p>
            <% } %>
            
            
                       
            <!-- Login form for users to enter credentials -->
            <form action="Login" method="POST" autocomplete="off">
                <input type="text" id="uid" name="uid" placeholder="UserID" autocomplete="off"><br>
                <input type="password" id="pass" name="pass" placeholder="Password" autocomplete="off"><br>
                <input type="submit" value="Login">
            </form>
        </div>
    </div>
</body>
</html>
