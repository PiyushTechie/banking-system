<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userEmail = (String) session.getAttribute("user_email");
    if (userEmail != null) userEmail = userEmail.trim();

    String msg = request.getParameter("msg");
    String displayMsg = "";
    boolean isError = false;
    if (msg != null && !msg.isBlank()) {
        try {
            displayMsg = java.net.URLDecoder.decode(msg, "UTF-8");
        } catch (Exception e) {
            displayMsg = msg;
        }
        isError = displayMsg.contains("Error") 
               || displayMsg.contains("Failed") 
               || displayMsg.contains("Invalid") 
               || displayMsg.contains("Insufficient") 
               || displayMsg.contains("Not Found");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - SecureBank</title>
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
        
        .action-card {
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.2s;
        }
        
        .action-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transform: translateY(-2px);
        }
        
        .welcome-card {
            background: linear-gradient(135deg, #0066cc 0%, #004c99 100%);
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
                    <a href="index.jsp" class="text-blue-600 font-medium border-b-2 border-blue-600 pb-1">Dashboard</a>
                    <a href="transfer.jsp" class="text-gray-700 hover:text-blue-600 font-medium">Transfer</a>
                    <a href="withdraw.jsp" class="text-gray-700 hover:text-blue-600 font-medium">Withdraw</a>
                    <a href="#" class="text-gray-700 hover:text-blue-600 font-medium">Help</a>
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

        <!-- Notification Message -->
        <% if (!displayMsg.isEmpty()) { %>
            <div class="mb-6 p-4 rounded-md <%= isError ? "bg-red-50 border border-red-200" : "bg-green-50 border border-green-200" %>">
                <div class="flex items-start">
                    <% if (isError) { %>
                        <svg class="w-5 h-5 text-red-500 mr-3 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                        </svg>
                        <span class="text-red-800 font-medium text-sm"><%= displayMsg %></span>
                    <% } else { %>
                        <svg class="w-5 h-5 text-green-500 mr-3 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                        </svg>
                        <span class="text-green-800 font-medium text-sm"><%= displayMsg %></span>
                    <% } %>
                </div>
            </div>
        <% } %>

        <!-- Welcome Section -->
        <div class="welcome-card rounded-lg p-8 text-white shadow-lg mb-8">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-3xl font-bold mb-2">Welcome Back!</h1>
                    <p class="text-blue-100 text-lg">
                        <%= (userEmail != null && !userEmail.isBlank()) ? userEmail : "Guest" %>
                    </p>
                    <p class="text-blue-100 text-sm mt-1">Manage your account with ease and security</p>
                </div>
                <div class="hidden md:block">
                    <div class="w-20 h-20 bg-white bg-opacity-20 rounded-full flex items-center justify-center">
                        <svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions Section -->
        <div class="mb-8">
            <h2 class="text-2xl font-bold text-gray-900 mb-6">Quick Actions</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                
                <!-- Deposit Card -->
                <a href="deposit.jsp" class="action-card rounded-lg p-6 group">
                    <div class="flex items-start">
                        <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mr-4 group-hover:bg-green-200 transition-colors">
                            <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-lg font-bold text-gray-900 mb-1">Deposit</h3>
                            <p class="text-sm text-gray-600">Add funds to your account</p>
                        </div>
                    </div>
                </a>

                <!-- Withdraw Card -->
                <a href="withdraw.jsp" class="action-card rounded-lg p-6 group">
                    <div class="flex items-start">
                        <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center mr-4 group-hover:bg-red-200 transition-colors">
                            <svg class="w-6 h-6 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-lg font-bold text-gray-900 mb-1">Withdraw</h3>
                            <p class="text-sm text-gray-600">Take out money securely</p>
                        </div>
                    </div>
                </a>

                <!-- Transfer Card -->
                <a href="transfer.jsp" class="action-card rounded-lg p-6 group">
                    <div class="flex items-start">
                        <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mr-4 group-hover:bg-blue-200 transition-colors">
                            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"></path>
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-lg font-bold text-gray-900 mb-1">Transfer</h3>
                            <p class="text-sm text-gray-600">Send money to others</p>
                        </div>
                    </div>
                </a>

            </div>
        </div>

        <!-- Account Management Section -->
        <div class="mb-8">
            <h2 class="text-2xl font-bold text-gray-900 mb-6">Account Management</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                
                <!-- View Balance Card -->
                <a href="AccountServlet?action=view" class="action-card rounded-lg p-6 group">
                    <div class="flex items-start">
                        <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mr-4 group-hover:bg-blue-200 transition-colors">
                            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-lg font-bold text-gray-900 mb-1">View Balance</h3>
                            <p class="text-sm text-gray-600">Check your current balance</p>
                        </div>
                    </div>
                </a>

                <!-- View History Card -->
                <a href="HistoryServlet" class="action-card rounded-lg p-6 group">
                    <div class="flex items-start">
                        <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mr-4 group-hover:bg-purple-200 transition-colors">
                            <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path>
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-lg font-bold text-gray-900 mb-1">View History</h3>
                            <p class="text-sm text-gray-600">Review your transactions</p>
                        </div>
                    </div>
                </a>

            </div>
        </div>

        <!-- Security Notice -->
        <div class="bg-blue-50 border border-blue-200 rounded-lg p-6 mb-8">
            <div class="flex items-start">
                <svg class="w-6 h-6 text-blue-600 mr-3 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd"></path>
                </svg>
                <div>
                    <h3 class="font-bold text-gray-900 mb-1">Your Security Matters</h3>
                    <p class="text-sm text-gray-700">
                        All transactions are protected with bank-level encryption. Never share your password or account details with anyone.
                    </p>
                </div>
            </div>
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