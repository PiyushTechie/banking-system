package com.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT password_hash FROM users WHERE email = ?"
            );
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password_hash");

                if (BCrypt.checkpw(password, storedHash)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user_email", email);

                    // ✅ Fetch account number for this user and store in session
                    String accountNumber = null;
                    PreparedStatement psAcc = con.prepareStatement(
                        "SELECT account_number FROM accounts WHERE email = ?"
                    );
                    psAcc.setString(1, email);
                    ResultSet rsAcc = psAcc.executeQuery();
                    if (rsAcc.next()) {
                        accountNumber = rsAcc.getString("account_number");
                    }
                    session.setAttribute("account_number", accountNumber);

                    // Redirect to main banking page
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("login.jsp?msg=Error: Invalid email or password");
                }
            } else {
                response.sendRedirect("login.jsp?msg=Error: Invalid email or password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?msg=Error: " + e.getMessage());
        }
    }
}
