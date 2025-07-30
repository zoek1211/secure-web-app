<%@ page import="javax.xml.transform.*, javax.xml.transform.stream.*, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Listing</title>
    <style>
        /* Optional page-specific styling */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
    </style>
</head>
<body>
<%
    // Set headers to prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, max-age=0");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1);
    
    // Check if the user is logged in; if not, redirect to login page.
    if(session.getAttribute("userid") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
</body>
</html>
