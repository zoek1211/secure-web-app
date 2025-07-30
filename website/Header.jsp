<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    /* Overall header container */
    .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        background-color: #f8f8f8;
        border-bottom: 1px solid #ddd;
		border-radius: 8px;
        padding: 10px 20px;
		font-family: Arial, sans-serif;
		margin-bottom: 50px;
    }

    /* Welcome message styling */
    .welcome-message {
        margin: 0;           /* remove default <h1> margin */
        font-size: 1.2em;
        color: #333;
    }

    /* Navigation container */
    .nav-bar {
        display: flex;
        gap: 20px;
    }

    /* Navigation links */
    .nav-bar a {
        text-decoration: none;
        color: #007bff;
        font-weight: 600;
        transition: color 0.2s ease;
    }
    .nav-bar a:hover {
        color: #0056b3;
    }

    /* Logout form container */
    .logout-form {
        margin: 0;
    }

    /* Logout button styling */
    .logout-form input[type="submit"] {
        padding: 8px 16px;
        border: 1px solid #007bff;
        border-radius: 4px; 
        background-color: #007bff;
        color: #fff;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.2s ease;
    }
    .logout-form input[type="submit"]:hover {
        background-color: #0056b3;
        border-color: #0056b3;
    }

    /* Prevent printing secured page */
    /* Hide the page content when a user attempts to print */
    @media print {
        body {
            display: none !important;
        }
    }
</style>
</head>
<body>

<div class="header">
    <!-- Left side: welcome message -->
    <h1 class="welcome-message">Welcome ${name}</h1>
    
    <!-- Middle: navigation bar -->
    <div class="nav-bar">
        <a href="welcome.jsp">Home</a>
        <a href="page1.jsp">Page 1</a>
        <a href="page2.jsp">Page 2</a>
        <a href="page3.jsp">Page 3</a>
    </div>
    
    <!-- Right side: logout form -->
    <form action="Logout" method="post" class="logout-form" autocomplete="off">
        <input type="submit" value="Logout" autocomplete="off">
    </form>
</div>

<!-- Load `DisableActions.js` from the server
    - Use`${pageContext.request.contextPath}` to ensure the correct relative path 
    - Append a version query parameter to control caching behavior.
 -->
<script src="${pageContext.request.contextPath}/DisableActions?v=1.0"></script>


</body>
</html>
