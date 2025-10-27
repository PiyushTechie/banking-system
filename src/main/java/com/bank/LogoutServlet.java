package com.bank;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Get the current session
        HttpSession session = request.getSession(false); // 'false' means don't create a new one
        
        if (session != null) {
            // Invalidate the session, clearing all attributes (like "user_email")
            session.invalidate();
        }
        
        // Redirect the user to the login page with a success message
        response.sendRedirect("login.jsp?msg=You have been logged out successfully.");
    }
}
