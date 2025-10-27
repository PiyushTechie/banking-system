<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bank.Transaction" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.TimeZone" %> <%-- <<< 1. IMPORT TimeZone --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Get the list of transactions forwarded from the servlet
    @SuppressWarnings("unchecked")
    List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
    String error = (String) request.getAttribute("error");
    
    // Formatter for the timestamp
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a");
    
    // <<< 2. GET THE IST TIMEZONE >>>
    TimeZone istTimeZone = TimeZone.getTimeZone("Asia/Kolkata"); 
    
    // <<< 3. APPLY THE TIMEZONE TO THE FORMATTER >>>
    dateFormat.setTimeZone(istTimeZone); 
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History - SecureBank</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');
        body { 
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in-up {
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .transaction-row {
            animation: slideIn 0.4s ease-out;
            transition: all 0.2s ease;
        }

        .transaction-row:hover {
            background-color: rgba(249, 250, 251, 0.8);
            transform: translateX(4px);
        }

        .action-btn {
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            transform: translateY(-2px);
        }

        .stat-card {
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
        }
    </style>
</head>
<body class="min-h-screen p-4 sm:p-8">

    <div class="max-w-6xl mx-auto fade-in-up">
        <div class="glass-effect rounded-3xl shadow-2xl overflow-hidden">
            
            <!-- Header Section -->
            <div class="bg-gradient-to-r from-purple-600 via-indigo-600 to-blue-600 px-6 sm:px-8 py-8 text-white">
                <div class="flex items-center justify-between flex-wrap gap-4">
                    <div class="flex items-center">
                        <div class="w-14 h-14 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center mr-4 backdrop-blur-sm">
                            <svg class="w-7 h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path>
                            </svg>
                        </div>
                        <div>
                            <h1 class="text-3xl font-bold">Transaction History</h1>
                            <p class="text-blue-100 text-sm">View all your banking activities</p>
                        </div>
                    </div>
                    <div class="flex items-center space-x-2 text-sm">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <%-- Display current time in IST --%>
                        <span><%= new SimpleDateFormat("MMM dd, yyyy").format(new java.util.Date()) %></span> 
                    </div>
                </div>
            </div>

            <div class="p-6 sm:p-8 space-y-6">

                <!-- Statistics Cards -->
                <% 
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
                
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <div class="stat-card bg-gradient-to-br from-blue-50 to-blue-100 rounded-2xl p-5 border border-blue-200">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-sm font-semibold text-blue-600 uppercase tracking-wide">Total Transactions</p>
                                <p class="text-3xl font-bold text-blue-900 mt-2"><%= totalTransactions %></p>
                            </div>
                            <div class="w-12 h-12 bg-blue-200 rounded-xl flex items-center justify-center">
                                <svg class="w-6 h-6 text-blue-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <div class="stat-card bg-gradient-to-br from-green-50 to-green-100 rounded-2xl p-5 border border-green-200">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-sm font-semibold text-green-600 uppercase tracking-wide">Total Inflow</p>
                                <p class="text-3xl font-bold text-green-900 mt-2">₹<%= String.format("%.2f", totalDeposits) %></p>
                            </div>
                            <div class="w-12 h-12 bg-green-200 rounded-xl flex items-center justify-center">
                                <svg class="w-6 h-6 text-green-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <div class="stat-card bg-gradient-to-br from-red-50 to-red-100 rounded-2xl p-5 border border-red-200">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-sm font-semibold text-red-600 uppercase tracking-wide">Total Outflow</p>
                                <p class="text-3xl font-bold text-red-900 mt-2">₹<%= String.format("%.2f", totalWithdrawals) %></p>
                            </div>
                            <div class="w-12 h-12 bg-red-200 rounded-xl flex items-center justify-center">
                                <svg class="w-6 h-6 text-red-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Error Message Area -->
                <% if (error != null) { %>
                    <div class="p-4 rounded-xl bg-red-50 border-l-4 border-red-500" role="alert">
                        <div class="flex items-center">
                            <svg class="w-5 h-5 mr-3 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="font-semibold text-red-800"><%= error %></span>
                        </div>
                    </div>
                <% } %>

                <!-- Transaction Table -->
                <div class="bg-white rounded-2xl shadow-lg border border-gray-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gradient-to-r from-gray-50 to-gray-100">
                                <tr>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">
                                        <div class="flex items-center">
                                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                            </svg>
                                            Date & Time (IST) <%-- Indicate Timezone --%>
                                        </div>
                                    </th>
                                    <th scope="col" class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">
                                        <div class="flex items-center">
                                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path>
                                            </svg>
                                            Type
                                        </div>
                                    </th>
                                    <th scope="col" class="px-6 py-4 text-right text-xs font-bold text-gray-700 uppercase tracking-wider">
                                        <div class="flex items-center justify-end">
                                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                            </svg>
                                            Amount
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-100">
                                <% if (transactions != null && !transactions.isEmpty()) { %>
                                    <% for (Transaction tx : transactions) { %>
                                        <tr class="transaction-row">
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-10 rounded-lg bg-gray-100 flex items-center justify-center mr-3">
                                                        <svg class="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                                        </svg>
                                                    </div>
                                                    <%-- This now formats using the IST timezone set above --%>
                                                    <span class="text-sm text-gray-700 font-medium"><%= dateFormat.format(tx.getTimestamp()) %></span> 
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <% if ("Deposit".equals(tx.getTransactionType()) || "Transfer (Received)".equals(tx.getTransactionType())) { %>
                                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-semibold bg-green-100 text-green-800">
                                                        <svg class="w-4 h-4 mr-1.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                                        </svg>
                                                        <%= tx.getTransactionType() %>
                                                    </span>
                                                <% } else if ("Withdrawal".equals(tx.getTransactionType()) || "Transfer (Sent)".equals(tx.getTransactionType())) { %>
                                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-semibold bg-red-100 text-red-800">
                                                        <svg class="w-4 h-4 mr-1.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>
                                                        </svg>
                                                        <%= tx.getTransactionType() %>
                                                    </span>
                                                <% } else { %>
                                                     <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-semibold bg-blue-100 text-blue-800">
                                                        <svg class="w-4 h-4 mr-1.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"></path>
                                                        </svg>
                                                         <%= tx.getTransactionType() %>
                                                     </span>
                                                <% } %>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-right">
                                                <% if ("Deposit".equals(tx.getTransactionType()) || "Transfer (Received)".equals(tx.getTransactionType())) { %>
                                                    <span class="text-lg font-bold text-green-600">+₹<%= String.format("%.2f", tx.getAmount()) %></span>
                                                <% } else { %>
                                                    <span class="text-lg font-bold text-red-600">-₹<%= String.format("%.2f", tx.getAmount()) %></span>
                                                <% } %>
                                            </td>
                                        </tr>
                                    <% } %>
                                <% } else if (error == null) { %>
                                    <tr>
                                        <td colspan="3" class="px-6 py-12 text-center">
                                            <div class="flex flex-col items-center justify-center">
                                                <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mb-4">
                                                    <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                                    </svg>
                                                </div>
                                                <p class="text-gray-500 font-medium text-lg">No transactions yet</p>
                                                <p class="text-gray-400 text-sm mt-1">Your transaction history will appear here</p>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="pt-4 flex flex-col sm:flex-row gap-3">
                    <a href="index.jsp" 
                       class="action-btn w-full sm:w-auto text-center py-4 px-6 border border-transparent rounded-xl shadow-sm text-base font-semibold text-white bg-gradient-to-r from-blue-600 to-indigo-600 hover:shadow-lg focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-all duration-200">
                        <span class="flex items-center justify-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                            </svg>
                            Back to Home
                        </span>
                    </a>
                    <a href="LogoutServlet" 
                       class="action-btn w-full sm:w-auto text-center py-4 px-6 border-2 border-gray-300 rounded-xl shadow-sm text-base font-semibold text-gray-700 bg-white hover:bg-gray-50 hover:border-gray-400 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 transition-all duration-200">
                        <span class="flex items-center justify-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                            </svg>
                            Logout
                        </span>
                    </a>
                </div>

            </div>
        </div>
    </div>

</body>
</html>

