# secure-web-app

Implementing a Prototype Secured Web Information System via Servlet and XML

## Project Overview

This project is a Java web application built using Servlet, JSP, XSL, XML, and DTD.
This website is a library system that features a robust authentication process to verify user identities, 
enforce session management policies, and restrict access to sensitive information.


## Project Structure

    website
      error.jsp
      Header.jsp
      index.html
      login.jsp
      page1.jsp
      page2.jsp
      page3.jsp
      welcome.jsp
  
      WEB-INF
          books.dtd
          books.xml
          books.xsl
          users.dtd
          users.xml
          web.xml
  
          images
              image files are stored here
  
          classes
              AuthFilter.java
              DisableActionsServlet.java
              LoginServlet.java
              LogoutServlet.java
              SecureImageServlet.java
              WelcomeServlet.java
            

## Prerequisites

Before running the project, ensure you have the following installed:

    JDK (Java Development Kit) 8 or later - Required for compiling and running Java programs.

    Apache Tomcat 9 or later - Required as the servlet container for deploying the web application.

    A Web Browser - Required to access and test the deployed web application.

    Command-Line Terminal - Required for compiling and running the application manually without an IDE.


## How to Compile and Run the Website Folder 

1. Deploy the project to Tomcat
    Copy the Grp5_website folder from your location.

    Paste it into Tomcat’s webapps/ directory:
    If Tomcat is in the default location it is in C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps

2. Compile all servlets to generate a .class file so that Tomcat can run it.

    For LogoutServlet.java

    Open the command prompt and run : 
    javac -cp "C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\servlet-api.jar" 
    -d "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\Grp5_website\WEB-INF\classes" 
    "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\Grp5_website\WEB-INF\classes\LogoutServlet.java"

    This command assumes Tomcat is in the default location
    Do this for all Servlets like LoginServlet.java

3. Restart Tomcat to see the changes

    Navigate to the Tomcat bin folder: 
    cd C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin>

    Start Tomcat: .\startup.bat

    Stop Tomcat: .\shutdown.bat 


## How to Access the Web Application

Open a browser and visit this link
http://localhost:8080/website


## How to Use the Web Application

    Login: Navigate to login.jsp and enter credentials.

    Dashboard: After successful login, welcome.jsp is displayed.

    Logout: Click the logout button to end the session.

    Unauthorized access redirection: If authentication fails, the page is redirected to login.jsp.

    Unauthorized action redirection: If unauthorized user actions are detected, the page is redirected to error.jsp

    Configuration Files:

        web.xml contains servlet mappings.

        XML files (e.g., books.xml, users.xml) store data.


## Troubleshooting

    Port Conflict: If 8080 is in use, change Tomcat's port.

    Errors in JSP/Servlets: Check Tomcat logs in TOMCAT_HOME/logs/catalina.out.
