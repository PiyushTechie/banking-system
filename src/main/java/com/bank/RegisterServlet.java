package com.bank;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;
import org.mindrot.jbcrypt.BCrypt; // Import the hashing library

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // --- Basic Validation ---
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("register.jsp?msg=Error: Email and password are required");
            return;
        }

        // --- Hash the password ---
        // We never store the plain-text password.
        // We store a "hash" of it.
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users (email, password_hash) VALUES (?, ?)"
            );
            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            
            ps.executeUpdate();
            
            // On success, redirect to the login page
            response.sendRedirect("login.jsp?msg=Registration successful! Please log in.");

        } catch (java.sql.SQLIntegrityConstraintViolationException e) {
            // This error happens if the email (which is UNIQUE) already exists
            response.sendRedirect("register.jsp?msg=Error: An account with this email already exists");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?msg=Error: " + e.getMessage());
        }
    }
}
