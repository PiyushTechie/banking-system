<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Balance - SecureBank</title>
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
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in-up { animation: fadeInUp 0.6s ease-out; }

        @keyframes countUp {
            from { opacity: 0; transform: scale(0.8); }
            to { opacity: 1; transform: scale(1); }
        }
        .count-up { animation: countUp 0.8s ease-out 0.3s both; }

        .balance-card {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            position: relative;
            overflow: hidden;
            color: white;
        }
        .balance-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }
        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .action-btn { transition: all 0.3s ease; }
        .action-btn:hover { transform: translateY(-2px); }

    </style>
</head>
<body class="flex items-center justify-center min-h-screen p-4">

<div class="w-full max-w-2xl fade-in-up">
    <div class="glass-effect rounded-3xl shadow-2xl overflow-hidden">

        <!-- Header Section -->
        <div class="bg-gradient-to-r from-blue-600 via-indigo-600 to-purple-600 px-8 py-6 text-white">
            <div class="flex items-center justify-between">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-white bg-opacity-20 rounded-xl flex items-center justify-center mr-4">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-2xl font-bold">Account Details</h1>
                        <p class="text-blue-100 text-sm">View your account information</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Servlet attributes -->
        <%
            String accountName = (String) request.getAttribute("accountName");
            // <<< CORRECTED VARIABLE NAME HERE >>>
            String accountNumber = (String) request.getAttribute("accountNumber"); 
            Double balance = (Double) request.getAttribute("balance");
        %>

        <!-- Content Section -->
        <div class="p-8 space-y-6">

            <!-- Account Holder Info -->
            <div class="bg-gradient-to-br from-gray-50 to-gray-100 rounded-2xl p-6 border border-gray-200">
                <div class="flex items-center mb-3">
                    <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3">
                        <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                    <span class="text-sm font-semibold text-gray-600 uppercase tracking-wide">Account Holder</span>
                </div>
                <p class="text-2xl font-bold text-gray-900 ml-13"><%= accountName != null ? accountName : "N/A" %></p>
                <%-- <<< UPDATED TO USE CORRECT VARIABLE NAME >>> --%>
                <p class="text-sm text-gray-500 mt-1">Account No: <span class="font-medium"><%= accountNumber != null ? accountNumber : "N/A" %></span></p>
            </div>

            <!-- Balance Card -->
            <div class="balance-card rounded-2xl p-8 text-white shadow-lg relative">
                <div class="relative z-10">
                    <div class="flex items-center mb-4">
                        <div class="w-12 h-12 bg-white bg-opacity-20 rounded-xl flex items-center justify-center mr-3">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-green-100 uppercase tracking-wide">Current Balance</p>
                            <p class="text-xs text-green-200">As of <%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(new java.util.Date()) %></p>
                        </div>
                    </div>
                    <div class="count-up">
                        <p class="text-6xl font-bold mb-2">
                            ₹<%= balance != null ? String.format("%.2f", balance) : "0.00" %>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Quick Stats Grid -->
            <div class="grid grid-cols-3 gap-4">
                <div class="bg-blue-50 rounded-xl p-4 text-center border border-blue-100">
                    <svg class="w-8 h-8 text-blue-600 mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <p class="text-xs text-gray-600 font-medium">Account</p>
                    <p class="text-sm font-bold text-gray-900">Active</p>
                </div>
                <div class="bg-green-50 rounded-xl p-4 text-center border border-green-100">
                    <svg class="w-8 h-8 text-green-600 mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                    </svg>
                    <p class="text-xs text-gray-600 font-medium">Security</p>
                    <p class="text-sm font-bold text-gray-900">Verified</p>
                </div>
                <div class="bg-purple-50 rounded-xl p-4 text-center border border-purple-100">
                    <svg class="w-8 h-8 text-purple-600 mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <p class="text-xs text-gray-600 font-medium">24/7</p>
                    <p class="text-sm font-bold text-gray-900">Support</p>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="pt-2 space-y-3">
                <a href="index.jsp" 
                   class="action-btn block w-full py-4 px-4 border border-transparent rounded-xl shadow-sm text-base font-semibold text-white bg-gradient-to-r from-blue-600 to-indigo-600 hover:shadow-lg focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-all duration-200">
                    <span class="flex items-center justify-center">
                        Back to Home
                    </span>
                </a>
                <a href="LogoutServlet" 
                   class="action-btn block w-full py-3 px-4 border-2 border-gray-300 rounded-xl shadow-sm text-base font-semibold text-gray-700 bg-white hover:bg-gray-50 hover:border-gray-400 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 transition-all duration-200">
                    <span class="flex items-center justify-center">
                        Logout
                    </span>
                </a>
            </div>

        </div>
    </div>
</div>

</body>
</html>

