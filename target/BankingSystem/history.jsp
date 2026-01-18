<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bank.Transaction" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.TimeZone" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userEmail = (String) session.getAttribute("user_email");
    if (userEmail != null) userEmail = userEmail.trim();

    @SuppressWarnings("unchecked")
    List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
    String error = (String) request.getAttribute("error");
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a");
    TimeZone istTimeZone = TimeZone.getTimeZone("Asia/Kolkata"); 
    dateFormat.setTimeZone(istTimeZone);
    
    int totalTransactions = 0;
    double totalDeposits = 0.0;
    double totalWithdrawals = 0.0;
    
    if (transactions != null) {
        totalTransactions = transactions.size();
        for (Transaction tx : transactions) {
            if ("Deposit".equals(tx.getTransactionType()) || "Transfer (Received)".equals(tx.getTransactionType())) {
                totalDeposits += tx.getAmount();
            } else if ("Withdrawal".equals(tx.getTransactionType()) || "Transfer (Sent)".equals(tx.getTransactionType())) {
                totalWithdrawals += tx.getAmount();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History - SecureBank</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;600;700&display=swap');
        
        body { 
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
        }
        
        .header-shadow {
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
        }
        
        .stat-card {
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.2s;
        }
        
        .stat-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transform: translateY(-2px);
        }
        
        .transaction-card {
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.2s;
        }
        
        .transaction-card:hover {
            box-shadow: 0 2px 6px rgba(0,0,0,0.12);
        }
        
        .action-card {
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.2s;
        }
        
        .action-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header class="bg-white header-shadow">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center">
                    <div class="flex-shrink-0 flex items-center">
                        <div class="w-10 h-10 bg-blue-600 rounded flex items-center justify-center mr-3">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 21v-4m0 0V5a2 2 0 012-2h6.5l1 1H21l-3 6 3 6h-8.5l-1-1H5a2 2 0 00-2 2zm9-13.5V9"></path>
                            </svg>
                        </div>
                        <span class="text-2xl font-bold text-gray-900">SecureBank</span>
                    </div>
                </div>
                <nav class="hidden md:flex space-x-8">
                    <a href="index.jsp" class="text-gray-700 hover:text-blue-600 font-medium">Dashboard</a>
                    <a href="transfer.jsp" class="text-gray-700 hover:text-blue-600 font-medium">Transfer</a>
                    <a href="withdraw.jsp" class="text-gray-700 hover:text-blue-600 font-medium">Withdraw</a>
                    <a href="HistoryServlet" class="text-blue-600 font-medium border-b-2 border-blue-600 pb-1">History</a>
                </nav>
                <div class="flex items-center space-x-4">
                    <div class="hidden md:flex items-center space-x-2">
                        <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center">
                            <svg class="w-4 h-4 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                            </svg>
                        </div>
                        <span class="text-sm text-gray-700"><%= (userEmail != null && !userEmail.isBlank()) ? userEmail : "Guest" %></span>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">

        <!-- Page Title -->
        <div class="mb-6">
            <h1 class="text-3xl font-bold text-gray-900">Transaction History</h1>
            <p class="text-gray-600 mt-1">View all your banking activities</p>
        </div>

        <!-- Error Message -->
        <% if (error != null) { %>
            <div class="mb-6 p-4 rounded-md bg-red-50 border border-red-200">
                <div class="flex items-start">
                    <svg class="w-5 h-5 text-red-500 mr-3 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                    </svg>
                    <span class="text-red-800 font-medium text-sm"><%= error %></span>
                </div>
            </div>
        <% } %>

        <!-- Statistics Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            
            <div class="stat-card rounded-lg p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-600">Total Transactions</p>
                        <p class="text-3xl font-bold text-gray-900 mt-2"><%= totalTransactions %></p>
                    </div>
                    <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="stat-card rounded-lg p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-600">Total Inflow</p>
                        <p class="text-3xl font-bold text-green-600 mt-2">₹<%= String.format("%.2f", totalDeposits) %></p>
                    </div>
                    <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="stat-card rounded-lg p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-600">Total Outflow</p>
                        <p class="text-3xl font-bold text-red-600 mt-2">₹<%= String.format("%.2f", totalWithdrawals) %></p>
                    </div>
                    <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>
                        </svg>
                    </div>
                </div>
            </div>

        </div>

        <!-- Transactions List -->
        <div class="mb-8">
            <h2 class="text-2xl font-bold text-gray-900 mb-6">Recent Transactions</h2>
            
            <% if (transactions != null && !transactions.isEmpty()) { %>
                <div class="space-y-3">
                    <% for (Transaction tx : transactions) { %>
                        <div class="transaction-card rounded-lg p-5">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center flex-1">
                                    <% if ("Deposit".equals(tx.getTransactionType()) || "Transfer (Received)".equals(tx.getTransactionType())) { %>
                                        <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mr-4">
                                            <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                            </svg>
                                        </div>
                                    <% } else { %>
                                        <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center mr-4">
                                            <svg class="w-6 h-6 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>
                                            </svg>
                                        </div>
                                    <% } %>
                                    
                                    <div class="flex-1">
                                        <h3 class="text-lg font-bold text-gray-900"><%= tx.getTransactionType() %></h3>
                                        <p class="text-sm text-gray-600"><%= dateFormat.format(tx.getTimestamp()) %> IST</p>
                                    </div>
                                </div>
                                
                                <div class="text-right">
                                    <% if ("Deposit".equals(tx.getTransactionType()) || "Transfer (Received)".equals(tx.getTransactionType())) { %>
                                        <p class="text-2xl font-bold text-green-600">+₹<%= String.format("%.2f", tx.getAmount()) %></p>
                                    <% } else { %>
                                        <p class="text-2xl font-bold text-red-600">-₹<%= String.format("%.2f", tx.getAmount()) %></p>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } else if (error == null) { %>
                <div class="transaction-card rounded-lg p-12 text-center">
                    <div class="flex flex-col items-center">
                        <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mb-4">
                            <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                        </div>
                        <p class="text-gray-500 font-medium text-lg">No transactions yet</p>
                        <p class="text-gray-400 text-sm mt-1">Your transaction history will appear here</p>
                    </div>
                </div>
            <% } %>
        </div>

        <!-- Logout Section -->
        <div class="border-t border-gray-200 pt-6">
            <a href="LogoutServlet" class="action-card rounded-lg p-4 group block">
                <div class="flex items-center justify-center">
                    <svg class="w-5 h-5 text-gray-600 mr-2 group-hover:text-gray-800" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                    </svg>
                    <span class="font-semibold text-gray-700 group-hover:text-gray-900">Logout</span>
                </div>
            </a>
        </div>

    </div>

    <!-- Footer -->
    <div class="text-center py-6 text-gray-600 text-sm">
        <p>© 2025 SecureBank. Your money is safe with us.</p>
    </div>

</body>
</html>