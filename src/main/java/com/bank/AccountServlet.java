package com.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AccountServlet")
public class AccountServlet extends HttpServlet {

    // Handles the "View My Balance" link (GET request)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            HttpSession session = request.getSession(false);
            String email = (String) session.getAttribute("user_email");

            if (email == null) {
                response.sendRedirect("login.jsp?msg=Error: Not logged in");
                return;
            }

            try (Connection con = DBConnection.getConnection()) {
                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM accounts WHERE email=?"
                );
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    request.setAttribute("accountName", rs.getString("name"));
                    request.setAttribute("balance", rs.getDouble("balance"));
                    request.setAttribute("accountNumber", rs.getString("account_number")); // ✅ Added

                    request.getRequestDispatcher("viewBalance.jsp").forward(request, response);
                } else {
                    response.sendRedirect("createAccount.jsp?email=" + email);
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("index.jsp?msg=Error: " + e.getMessage());
            }
        }
    }

    // Handles the "Create Account" form (POST request)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("user_email");

        if (email == null) {
            response.sendRedirect("login.jsp?msg=Error: Not logged in");
            return;
        }

        if ("create".equals(action)) {
            try (Connection con = DBConnection.getConnection()) {
                String name = request.getParameter("name");
                double balance = Double.parseDouble(request.getParameter("balance"));

                // ✅ Generate unique 10-digit account number
                String accountNumber = "ACC" + System.currentTimeMillis();

                // Insert into accounts table
                PreparedStatement psAccount = con.prepareStatement(
                    "INSERT INTO accounts(name, email, account_number, balance) VALUES(?,?,?,?)"
                );
                psAccount.setString(1, name);
                psAccount.setString(2, email);
                psAccount.setString(3, accountNumber);
                psAccount.setDouble(4, balance);
                psAccount.executeUpdate();

                // Insert initial transaction into transactions table
                PreparedStatement psTransaction = con.prepareStatement(
                    "INSERT INTO transactions(user_email, account_number, transaction_type, amount) VALUES(?,?,?,?)"
                );
                psTransaction.setString(1, email);
                psTransaction.setString(2, accountNumber);
                psTransaction.setString(3, "Deposit"); // initial deposit
                psTransaction.setDouble(4, balance);
                psTransaction.executeUpdate();

                response.sendRedirect("index.jsp?msg=Account created! Acc No: " + accountNumber);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("createAccount.jsp?msg=Error: Account creation failed. " + e.getMessage());
            }
        }
    }
}
