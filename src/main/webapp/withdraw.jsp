<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userEmail = (session != null) ? (String) session.getAttribute("user_email") : "";
    
    String msg = request.getParameter("msg");
    boolean isError = false;
    if (msg != null) {
        String lowerMsg = msg.toLowerCase();
        isError = lowerMsg.contains("error") 
               || lowerMsg.contains("failed") 
               || lowerMsg.contains("invalid")
               || lowerMsg.contains("insufficient");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Withdraw Funds - SecureBank</title>
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
        
        .withdraw-container {
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        .btn-withdraw {
            background: linear-gradient(to right, #ef4444, #dc2626);
            transition: all 0.2s;
        }
        
        .btn-withdraw:hover {
            background: linear-gradient(to right, #dc2626, #b91c1c);
            box-shadow: 0 4px 8px rgba(239,68,68,0.2);
        }
        
        input:focus {
            border-color: #ef4444;
            outline: none;
            box-shadow: 0 0 0 3px rgba(239,68,68,0.1);
        }
        
        .quick-btn {
            transition: all 0.2s;
        }
        
        .quick-btn:hover {
            border-color: #ef4444;
            background-color: #fef2f2;
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
                    <a href="#" class="text-blue-600 font-medium border-b-2 border-blue-600 pb-1">Withdraw</a>
                    <a href="#" class="text-gray-700 hover:text-blue-600 font-medium">Help</a>
                </nav>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <!-- Breadcrumb -->
        <div class="mb-6">
            <nav class="flex text-sm text-gray-600">
                <a href="index.jsp" class="hover:text-blue-600">Home</a>
                <span class="mx-2">/</span>
                <span class="text-gray-900 font-medium">Withdraw Funds</span>
            </nav>
        </div>

        <div class="grid lg:grid-cols-3 gap-8">
            
            <!-- Main Withdraw Form -->
            <div class="lg:col-span-2">
                <div class="withdraw-container rounded-lg p-8">
                    
                    <!-- Page Title -->
                    <div class="mb-6">
                        <h1 class="text-3xl font-bold text-gray-900 mb-2">Withdraw Funds</h1>
                        <p class="text-gray-600">Withdraw money from your account</p>
                        <p class="text-sm text-gray-500 mt-1">Account: <%= userEmail %></p>
                    </div>

                    <!-- Notification Message -->
                    <% if (msg != null) { %>
                        <div class="mb-6 p-4 rounded-md <%= isError ? "bg-red-50 border border-red-200" : "bg-green-50 border border-green-200" %>">
                            <div class="flex items-start">
                                <% if (isError) { %>
                                    <svg class="w-5 h-5 text-red-500 mr-3 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                                    </svg>
                                    <span class="text-red-800 font-medium text-sm"><%= java.net.URLDecoder.decode(msg, "UTF-8") %></span>
                                <% } else { %>
                                    <svg class="w-5 h-5 text-green-500 mr-3 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                    </svg>
                                    <span class="text-green-800 font-medium text-sm"><%= java.net.URLDecoder.decode(msg, "UTF-8") %></span>
                                <% } %>
                            </div>
                        </div>
                    <% } %>

                    <!-- Withdrawal Form -->
                    <form action="TransactionServlet" method="POST" class="space-y-6">
                        <input type="hidden" name="action" value="withdraw">
                        
                        <!-- Amount -->
                        <div>
                            <label for="amount" class="block text-sm font-medium text-gray-700 mb-2">
                                Withdrawal Amount <span class="text-red-500">*</span>
                            </label>
                            <div class="relative">
                                <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-500 font-medium">
                                    ₹
                                </span>
                                <input type="number" 
                                       id="amount" 
                                       name="amount" 
                                       step="0.01" 
                                       min="0.01" 
                                       required 
                                       placeholder="0.00"
                                       class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-md text-gray-900 text-lg">
                            </div>
                            <p class="mt-2 text-sm text-gray-500">
                                Enter the amount you wish to withdraw
                            </p>
                        </div>

                        <!-- Quick Amount Buttons -->
                        <div>
                            <p class="text-sm font-medium text-gray-700 mb-3">Quick Select</p>
                            <div class="grid grid-cols-4 gap-3">
                                <button type="button" 
                                        onclick="document.getElementById('amount').value='500'" 
                                        class="quick-btn py-3 px-4 border-2 border-gray-300 rounded-md text-sm font-semibold text-gray-700">
                                    ₹500
                                </button>
                                <button type="button" 
                                        onclick="document.getElementById('amount').value='1000'" 
                                        class="quick-btn py-3 px-4 border-2 border-gray-300 rounded-md text-sm font-semibold text-gray-700">
                                    ₹1,000
                                </button>
                                <button type="button" 
                                        onclick="document.getElementById('amount').value='2000'" 
                                        class="quick-btn py-3 px-4 border-2 border-gray-300 rounded-md text-sm font-semibold text-gray-700">
                                    ₹2,000
                                </button>
                                <button type="button" 
                                        onclick="document.getElementById('amount').value='5000'" 
                                        class="quick-btn py-3 px-4 border-2 border-gray-300 rounded-md text-sm font-semibold text-gray-700">
                                    ₹5,000
                                </button>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex gap-4 pt-4">
                            <button type="submit" 
                                    class="btn-withdraw flex-1 py-3 px-6 rounded-md text-white font-semibold">
                                Withdraw Now
                            </button>
                            <a href="index.jsp" 
                               class="flex-1 py-3 px-6 border-2 border-gray-300 rounded-md text-center text-gray-700 font-semibold hover:bg-gray-50 hover:border-gray-400 transition-colors">
                                Cancel
                            </a>
                        </div>
                    </form>

                </div>

                <!-- Important Information -->
                <div class="mt-6 bg-yellow-50 border border-yellow-200 rounded-lg p-4">
                    <div class="flex items-start">
                        <svg class="w-5 h-5 text-yellow-600 mr-3 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                        </svg>
                        <div>
                            <h3 class="font-semibold text-yellow-900 text-sm mb-1">Important Notice</h3>
                            <p class="text-sm text-yellow-800">
                                Please ensure you have sufficient funds before proceeding. Withdrawals are processed instantly.
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar Information -->
            <div class="lg:col-span-1 space-y-6">
                
                <!-- Withdrawal Guidelines -->
                <div class="bg-white rounded-lg p-6 shadow-sm">
                    <h3 class="font-bold text-gray-900 mb-4">Withdrawal Guidelines</h3>
                    <div class="space-y-3 text-sm text-gray-700">
                        <div class="flex items-start">
                            <svg class="w-5 h-5 text-red-600 mr-2 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                            <p>Withdrawals are processed instantly</p>
                        </div>
                        <div class="flex items-start">
                            <svg class="w-5 h-5 text-red-600 mr-2 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                            <p>No withdrawal fees or charges</p>
                        </div>
                        <div class="flex items-start">
                            <svg class="w-5 h-5 text-red-600 mr-2 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                            <p>Available 24 hours a day, 7 days a week</p>
                        </div>
                        <div class="flex items-start">
                            <svg class="w-5 h-5 text-red-600 mr-2 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                            <p>Ensure sufficient balance in your account</p>
                        </div>
                    </div>
                </div>

                <!-- Security Information -->
                <div class="bg-white rounded-lg p-6 shadow-sm">
                    <div class="flex items-center mb-3">
                        <svg class="w-6 h-6 text-green-600 mr-2" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd"></path>
                        </svg>
                        <h3 class="font-bold text-gray-900">Secure Withdrawal</h3>
                    </div>
                    <p class="text-sm text-gray-700">
                        All transactions are protected with bank-level encryption and multi-layer security protocols.
                    </p>
                </div>

                <!-- Need Help -->
                <div class="bg-blue-50 border border-blue-200 rounded-lg p-6">
                    <h3 class="font-bold text-gray-900 mb-2">Need Assistance?</h3>
                    <p class="text-sm text-gray-700 mb-4">
                        Our customer support team is here to help you with your withdrawals.
                    </p>
                    <div class="space-y-2 text-sm">
                        <div class="flex items-center text-gray-700">
                            <svg class="w-4 h-4 mr-2 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z"></path>
                            </svg>
                            <span class="font-medium">1-800-SECURE-BANK</span>
                        </div>
                        <div class="flex items-center text-gray-700">
                            <svg class="w-4 h-4 mr-2 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"></path>
                                <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"></path>
                            </svg>
                            <span class="font-medium">support@securebank.com</span>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>

</body>
</html>