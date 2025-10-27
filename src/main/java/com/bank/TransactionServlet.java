package com.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/TransactionServlet")
public class TransactionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("user_email");
        String accountNumber = (String) session.getAttribute("account_number");

        if (email == null || accountNumber == null) {
            response.sendRedirect("index.jsp?msg=Error: Session expired or account not found");
            return;
        }

        String action = request.getParameter("action");
        double amount = 0;

        // --- VALIDATE AMOUNT ---
        try {
            amount = Double.parseDouble(request.getParameter("amount"));
            if (amount <= 0) {
                response.sendRedirect(action + ".jsp?msg=Amount must be a positive number");
                return;
            }
        } catch (NumberFormatException | NullPointerException e) {
            response.sendRedirect(action + ".jsp?msg=Invalid or missing amount");
            return;
        }

        Connection con = null;
        String redirectPage = action + ".jsp";

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // --- Lock the account row for update using account_number ---
            PreparedStatement ps = con.prepareStatement(
                "SELECT balance FROM accounts WHERE account_number=? FOR UPDATE"
            );
            ps.setString(1, accountNumber);
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                response.sendRedirect(redirectPage + "?msg=Account Not Found");
                con.rollback();
                return;
            }

            double balance = rs.getDouble("balance");
            String transactionType = "";
            String redirectMessage = "";

            if ("deposit".equals(action)) {
                balance += amount;
                transactionType = "Deposit";
                redirectMessage = "Deposit Successful. New Balance: ₹" + String.format("%.2f", balance);
            } else if ("withdraw".equals(action)) {
                if (balance < amount) {
                    response.sendRedirect("withdraw.jsp?msg=Insufficient Balance");
                    con.rollback();
                    return;
                }
                balance -= amount;
                transactionType = "Withdrawal";
                redirectMessage = "Withdrawal Successful. New Balance: ₹" + String.format("%.2f", balance);
            } else {
                response.sendRedirect(redirectPage + "?msg=Invalid Action");
                con.rollback();
                return;
            }

            // --- Update account balance ---
            PreparedStatement update = con.prepareStatement(
                "UPDATE accounts SET balance=? WHERE account_number=?"
            );
            update.setDouble(1, balance);
            update.setString(2, accountNumber);
            update.executeUpdate();

            // --- Log transaction with account_number ---
            PreparedStatement log = con.prepareStatement(
                "INSERT INTO transactions (user_email, account_number, transaction_type, amount) VALUES (?, ?, ?, ?)"
            );
            log.setString(1, email);
            log.setString(2, accountNumber);
            log.setString(3, transactionType);
            log.setDouble(4, amount);
            log.executeUpdate();

            // --- Commit transaction ---
            con.commit();

            response.sendRedirect(redirectPage + "?msg=" + java.net.URLEncoder.encode(redirectMessage, "UTF-8"));

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (con != null) con.rollback();
            } catch (SQLException sqlEx) {
                sqlEx.printStackTrace();
            }
            response.sendRedirect(redirectPage + "?msg=" + java.net.URLEncoder.encode("Transaction Failed: " + e.getMessage(), "UTF-8"));
        } finally {
            try {
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
