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

@WebServlet("/TransferServlet")
public class TransferServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession(false);
        String senderEmail = (String) session.getAttribute("user_email");
        String senderAccount = (String) session.getAttribute("account_number");
        String receiverEmail = request.getParameter("receiver_email");
        double amount = 0;

        if (senderEmail == null || senderAccount == null) {
            response.sendRedirect("transfer.jsp?msg=Error: Session expired or account not found");
            return;
        }

        // --- 1. VALIDATION ---
        try {
            amount = Double.parseDouble(request.getParameter("amount"));
            if (amount <= 0) {
                response.sendRedirect("transfer.jsp?msg=Amount must be a positive number");
                return;
            }
        } catch (NumberFormatException | NullPointerException e) {
            response.sendRedirect("transfer.jsp?msg=Invalid or missing amount");
            return;
        }

        if (senderEmail.equals(receiverEmail)) {
            response.sendRedirect("transfer.jsp?msg=You cannot send money to yourself.");
            return;
        }

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // --- 2. LOCK SENDER'S ACCOUNT ---
            double senderBalance = 0;
            PreparedStatement psSender = con.prepareStatement(
                "SELECT balance FROM accounts WHERE account_number=? FOR UPDATE"
            );
            psSender.setString(1, senderAccount);
            ResultSet rsSender = psSender.executeQuery();
            if (rsSender.next()) {
                senderBalance = rsSender.getDouble("balance");
            } else {
                response.sendRedirect("transfer.jsp?msg=Sender account not found.");
                con.rollback();
                return;
            }

            if (senderBalance < amount) {
                response.sendRedirect("transfer.jsp?msg=Insufficient Balance");
                con.rollback();
                return;
            }

            // --- 3. LOCK RECEIVER'S ACCOUNT ---
            String receiverAccount = null;
            double receiverBalance = 0;
            PreparedStatement psReceiver = con.prepareStatement(
                "SELECT account_number, balance FROM accounts WHERE email=? FOR UPDATE"
            );
            psReceiver.setString(1, receiverEmail);
            ResultSet rsReceiver = psReceiver.executeQuery();
            if (rsReceiver.next()) {
                receiverAccount = rsReceiver.getString("account_number");
                receiverBalance = rsReceiver.getDouble("balance");
            } else {
                response.sendRedirect("transfer.jsp?msg=Receiver account not found.");
                con.rollback();
                return;
            }

            // --- 4. UPDATE BALANCES ---
            PreparedStatement updateSender = con.prepareStatement(
                "UPDATE accounts SET balance=? WHERE account_number=?"
            );
            updateSender.setDouble(1, senderBalance - amount);
            updateSender.setString(2, senderAccount);
            updateSender.executeUpdate();

            PreparedStatement updateReceiver = con.prepareStatement(
                "UPDATE accounts SET balance=? WHERE account_number=?"
            );
            updateReceiver.setDouble(1, receiverBalance + amount);
            updateReceiver.setString(2, receiverAccount);
            updateReceiver.executeUpdate();

            // --- 5. LOG TRANSACTIONS ---
            PreparedStatement logSender = con.prepareStatement(
                "INSERT INTO transactions (user_email, account_number, transaction_type, amount) VALUES (?, ?, 'Transfer (Sent)', ?)"
            );
            logSender.setString(1, senderEmail);
            logSender.setString(2, senderAccount);
            logSender.setDouble(3, amount);
            logSender.executeUpdate();

            PreparedStatement logReceiver = con.prepareStatement(
                "INSERT INTO transactions (user_email, account_number, transaction_type, amount) VALUES (?, ?, 'Transfer (Received)', ?)"
            );
            logReceiver.setString(1, receiverEmail);
            logReceiver.setString(2, receiverAccount);
            logReceiver.setDouble(3, amount);
            logReceiver.executeUpdate();

            // --- 6. COMMIT ---
            con.commit();

            String successMsg = String.format("Successfully sent ₹%.2f to %s", amount, receiverEmail);
            response.sendRedirect("transfer.jsp?msg=" + java.net.URLEncoder.encode(successMsg, "UTF-8"));

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (con != null) con.rollback();
            } catch (SQLException sqlEx) {
                sqlEx.printStackTrace();
            }
            response.sendRedirect("transfer.jsp?msg=" + java.net.URLEncoder.encode("Transaction Failed: " + e.getMessage(), "UTF-8"));
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
