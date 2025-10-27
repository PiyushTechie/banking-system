package com.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/HistoryServlet")
public class HistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("user_email");

        // Fetch account number for this user
        String accountNumber = null;
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement psAcc = con.prepareStatement(
                "SELECT account_number FROM accounts WHERE email=?"
            );
            psAcc.setString(1, email);
            ResultSet rsAcc = psAcc.executeQuery();
            if (rsAcc.next()) {
                accountNumber = rsAcc.getString("account_number");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<Transaction> transactions = new ArrayList<>();

        if (accountNumber != null) {
            try (Connection con = DBConnection.getConnection()) {
                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM transactions WHERE account_number=? ORDER BY timestamp DESC"
                );
                ps.setString(1, accountNumber);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                transactions.add(new Transaction(
                    rs.getInt("id"),
                    rs.getString("user_email"),
                    rs.getString("account_number"),  // ✅ Include account_number
                    rs.getString("transaction_type"),
                    rs.getDouble("amount"),
                    rs.getTimestamp("timestamp")
                ));
            }

                request.setAttribute("transactions", transactions);
                request.getRequestDispatcher("history.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Could not retrieve transaction history: " + e.getMessage());
                request.getRequestDispatcher("history.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "No account found for this user.");
            request.getRequestDispatcher("history.jsp").forward(request, response);
        }
    }
}
