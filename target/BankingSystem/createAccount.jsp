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
    <title>Create Account - SecureBank</title>
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
        
        .form-card {
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        .info-card {
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.2s;
        }
        
        .info-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transform: translateY(-2px);
        }
        
        .quick-amount-btn {
            transition: all 0.2s;
        }
        
        .quick-amount-btn:hover {
            background-color: #dbeafe;
            border-color: #3b82f6;
            transform: translateY(-1px);
        }
        
        .submit-btn {
            transition: all 0.2s;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
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
                    <a href="HistoryServlet" class="text-gray-700 hover:text-blue-600 font-medium">History</a>
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
            <h1 class="text-3xl font-bold text-gray-900">Create Account</h1>
            <p class="text-gray-600 mt-1">Set up your new banking account</p>
        </div>

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

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            
            <!-- Create Account Form -->
            <div class="lg:col-span-2">
                <div class="form-card rounded-lg p-6">
                    <div class="flex items-start mb-6">
                        <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mr-4">
                            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path>
                            </svg>
                        </div>
                        <div>
                            <h2 class="text-xl font-bold text-gray-900">Account Details</h2>
                            <p class="text-sm text-gray-600 mt-1">Fill in the information below to create your account</p>
                        </div>
                    </div>

                    <form action="AccountServlet" method="POST" class="space-y-6">
                        <input type="hidden" name="action" value="create"/>

                        <div>
                            <label for="name" class="block text-sm font-semibold text-gray-700 mb-2">
                                Account Holder Name
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                    </svg>
                                </div>
                                <input type="text" 
                                       id="name" 
                                       name="name" 
                                       required 
                                       placeholder="Enter your full name"
                                       class="block w-full pl-12 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            </div>
                            <p class="mt-2 text-xs text-gray-500">Your full legal name as per official documents</p>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                Account Email
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                                    </svg>
                                </div>
                                <input type="email" 
                                       value="<%= (userEmail != null && !userEmail.isBlank()) ? userEmail : "" %>" 
                                       readonly 
                                       class="block w-full pl-12 pr-12 py-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600 cursor-not-allowed">
                                <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                                    </svg>
                                </div>
                            </div>
                            <p class="mt-2 text-xs text-gray-500">Account will be linked to your logged-in email</p>
                        </div>

                        <div>
                            <label for="balance" class="block text-sm font-semibold text-gray-700 mb-2">
                                Initial Deposit
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <span class="text-gray-500 font-semibold text-lg">₹</span>
                                </div>
                                <input type="number" 
                                       id="balance" 
                                       name="balance" 
                                       step="0.01" 
                                       min="0" 
                                       required 
                                       placeholder="0.00"
                                       class="block w-full pl-12 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-lg">
                            </div>
                            <p class="mt-2 text-xs text-gray-500">Minimum deposit amount: ₹0.00</p>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-3">Quick Select Initial Deposit</label>
                            <div class="grid grid-cols-2 sm:grid-cols-4 gap-3">
                                <button type="button" 
                                        onclick="document.getElementById('balance').value='1000'" 
                                        class="quick-amount-btn py-3 px-4 border-2 border-gray-300 rounded-lg text-sm font-semibold text-gray-700">
                                    ₹1,000
                                </button>
                                <button type="button" 
                                        onclick="document.getElementById('balance').value='5000'" 
                                        class="quick-amount-btn py-3 px-4 border-2 border-gray-300 rounded-lg text-sm font-semibold text-gray-700">
                                    ₹5,000
                                </button>
                                <button type="button" 
                                        onclick="document.getElementById('balance').value='10000'" 
                                        class="quick-amount-btn py-3 px-4 border-2 border-gray-300 rounded-lg text-sm font-semibold text-gray-700">
                                    ₹10,000
                                </button>
                                <button type="button" 
                                        onclick="document.getElementById('balance').value='25000'" 
                                        class="quick-amount-btn py-3 px-4 border-2 border-gray-300 rounded-lg text-sm font-semibold text-gray-700">
                                    ₹25,000
                                </button>
                            </div>
                        </div>

                        <button type="submit" 
                                class="submit-btn w-full py-3 px-4 border border-transparent rounded-lg text-base font-semibold text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <span class="flex items-center justify-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                Create Account
                            </span>
                        </button>

                        <a href="index.jsp" 
                           class="block text-center w-full py-3 px-4 border-2 border-gray-300 rounded-lg text-base font-semibold text-gray-700 hover:bg-gray-50 transition-all duration-200">
                            Back to Dashboard
                        </a>
                    </form>
                </div>
            </div>

            <!-- Info Sidebar -->
            <div class="lg:col-span-1 space-y-4">
                
                <!-- Account Features -->
                <div class="info-card rounded-lg p-6">
                    <div class="flex items-center mb-4">
                        <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3">
                            <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"></path>
                            </svg>
                        </div>
                        <h3 class="text-lg font-bold text-gray-900">Account Features</h3>
                    </div>
                    <ul class="space-y-3 text-sm text-gray-600">
                        <li class="flex items-start">
                            <svg class="w-5 h-5 text-blue-600 mr-2 mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                            <span>Instant account activation</span>
                        </li>
                        <li class="flex items-start">
                            <svg class="w-5 h-5 text-blue-600 mr-2 mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                            <span>Zero account opening fees</span>
                        </li>
                        <li class="flex items-start">
                            <svg class="w-5 h-5 text-blue-600 mr-2 mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                            <span>Unlimited transactions</span>
                        </li>
                        <li class="flex items-start">
                            <svg class="w-5 h-5 text-blue-600 mr-2 mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                            <span>24/7 online access</span>
                        </li>
                    </ul>
                </div>

                <!-- Security Info -->
                <div class="info-card rounded-lg p-6">
                    <div class="flex items-center mb-3">
                        <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center mr-3">
                            <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                            </svg>
                        </div>
                        <h3 class="text-lg font-bold text-gray-900">Secure & Protected</h3>
                    </div>
                    <p class="text-sm text-gray-600">
                        Your account is protected with bank-level encryption and multi-factor authentication.
                    </p>
                </div>

                <!-- Support Info -->
                <div class="info-card rounded-lg p-6">
                    <div class="flex items-center mb-3">
                        <div class="w-10 h-10 bg-purple-100 rounded-lg flex items-center justify-center mr-3">
                            <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z"></path>
                            </svg>
                        </div>
                        <h3 class="text-lg font-bold text-gray-900">Need Assistance?</h3>
                    </div>
                    <p class="text-sm text-gray-600 mb-3">
                        Our support team is ready to help you with account setup.
                    </p>
                    <a href="#" class="text-sm font-semibold text-purple-600 hover:text-purple-700">
                        Contact Support →
                    </a>
                </div>

            </div>

        </div>

    </div>

    <!-- Footer -->
    <div class="text-center py-6 text-gray-600 text-sm">
        <p>© 2025 SecureBank. Your money is safe with us.</p>
    </div>

</body>
</html>