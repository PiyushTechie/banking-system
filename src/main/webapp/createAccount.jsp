<%@ page session="true" %> <%-- Assuming this page requires login --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String msg = request.getParameter("msg");
    boolean isError = false;
    if (msg != null) {
        isError = msg.contains("Error") 
               || msg.contains("Failed") 
               || msg.contains("Invalid") 
               || msg.contains("Insufficient") 
               || msg.contains("Not Found");
    }

    // Get session value - needed for the create account form
    String userEmail = session != null ? (String) session.getAttribute("user_email") : "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - SecureBank</title>
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

        .input-focus {
            transition: all 0.3s ease;
        }

        .input-focus:focus {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(59, 130, 246, 0.2);
        }

        .create-btn {
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .create-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .create-btn:hover::before {
            width: 400px;
            height: 400px;
        }

        .create-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(59, 130, 246, 0.4);
        }

        .info-card {
            transition: all 0.3s ease;
        }

        .info-card:hover {
            transform: translateY(-3px);
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen p-4">

<div class="w-full max-w-5xl fade-in-up">
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        
        <!-- Main Create Account Form -->
        <div class="lg:col-span-2">
            <div class="glass-effect p-8 rounded-3xl shadow-2xl">
                
                <!-- Header with Icon -->
                <div class="flex items-center justify-center mb-6">
                    <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-2xl flex items-center justify-center mr-4">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path>
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-3xl font-bold text-gray-800">Create Account</h1>
                        <p class="text-gray-600 text-sm">Set up your new banking account</p>
                    </div>
                </div>

                <!-- Notification Message Area -->
                <% if (msg != null) { %>
                    <div class="mb-6 p-4 rounded-xl <%= isError ? "bg-red-50 border-l-4 border-red-500" : "bg-green-50 border-l-4 border-green-500" %>" role="alert">
                        <div class="flex items-center">
                            <% if (isError) { %>
                                <svg class="w-5 h-5 mr-3 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="font-semibold text-red-800"><%= java.net.URLDecoder.decode(msg, "UTF-8") %></span>
                            <% } else { %>
                                <svg class="w-5 h-5 mr-3 text-green-500" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="font-semibold text-green-800"><%= java.net.URLDecoder.decode(msg, "UTF-8") %></span>
                            <% } %>
                        </div>
                    </div>
                <% } %>

                <!-- Create Account Form -->
                <form action="AccountServlet" method="POST" class="space-y-6">
                    <input type="hidden" name="action" value="create"/>
                    
                    <div>
                        <label for="name" class="block text-sm font-semibold text-gray-700 mb-2">Account Holder Name</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                </svg>
                            </div>
                            <input type="text" id="name" name="name" required 
                                   placeholder="Enter your full name"
                                   class="input-focus block w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                        <p class="mt-2 text-xs text-gray-500">Your full legal name as per official documents</p>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Account Email</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                                </svg>
                            </div>
                            <input type="email" value="<%= userEmail %>" readonly 
                                   class="block w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl bg-gray-50 text-gray-600 cursor-not-allowed">
                            <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                                </svg>
                            </div>
                        </div>
                        <p class="mt-2 text-xs text-gray-500">Account will be linked to your logged-in email</p>
                    </div>

                    <div>
                        <label for="balance" class="block text-sm font-semibold text-gray-700 mb-2">Initial Deposit</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <span class="text-gray-500 font-semibold text-lg">₹</span>
                            </div>
                            <input type="number" id="balance" step="0.01" min="0" name="balance" required 
                                   placeholder="0.00"
                                   class="input-focus block w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-lg font-semibold">
                        </div>
                        <p class="mt-2 text-xs text-gray-500">Minimum deposit amount: ₹0.00</p>
                    </div>

                    <!-- Quick Amount Buttons -->
                    <div>
                        <p class="text-sm font-semibold text-gray-700 mb-3">Quick Select Initial Deposit</p>
                        <div class="grid grid-cols-4 gap-3">
                            <button type="button" onclick="document.getElementById('balance').value='1000'"
                                    class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-blue-50 hover:border-blue-500 transition-all duration-200">
                                ₹1,000
                            </button>
                            <button type="button" onclick="document.getElementById('balance').value='5000'"
                                    class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-blue-50 hover:border-blue-500 transition-all duration-200">
                                ₹5,000
                            </button>
                            <button type="button" onclick="document.getElementById('balance').value='10000'"
                                    class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-blue-50 hover:border-blue-500 transition-all duration-200">
                                ₹10,000
                            </button>
                            <button type="button" onclick="document.getElementById('balance').value='25000'"
                                    class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-blue-50 hover:border-blue-500 transition-all duration-200">
                                ₹25,000
                            </button>
                        </div>
                    </div>

                    <button type="submit" 
                            class="create-btn relative w-full py-4 px-4 border border-transparent rounded-xl text-base font-semibold text-white bg-gradient-to-r from-blue-600 to-indigo-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        <span class="relative z-10 flex items-center justify-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            Create Account
                        </span>
                    </button>

                    <a href="index.jsp" 
                       class="block text-center w-full py-3 px-4 border-2 border-gray-300 rounded-xl text-base font-semibold text-gray-700 hover:bg-gray-50 hover:border-blue-500 transition-all duration-200">
                        Back to Home
                    </a>
                </form>

            </div>
        </div>

        <!-- Sidebar - Account Info -->
        <div class="lg:col-span-1 space-y-4">
            
            <!-- Benefits Card -->
            <div class="glass-effect p-6 rounded-2xl shadow-xl">
                <div class="flex items-center mb-4">
                    <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3">
                        <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"></path>
                        </svg>
                    </div>
                    <h3 class="text-lg font-bold text-gray-800">Account Features</h3>
                </div>
                <ul class="space-y-3 text-sm text-gray-600">
                    <li class="flex items-start">
                        <svg class="w-5 h-5 mr-2 text-blue-500 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                        </svg>
                        <span>Instant account activation</span>
                    </li>
                    <li class="flex items-start">
                        <svg class="w-5 h-5 mr-2 text-blue-500 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                        </svg>
                        <span>Zero account opening fees</span>
                    </li>
                    <li class="flex items-start">
                        <svg class="w-5 h-5 mr-2 text-blue-500 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                        </svg>
                        <span>Unlimited transactions</span>
                    </li>
                    <li class="flex items-start">
                        <svg class="w-5 h-5 mr-2 text-blue-500 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                        </svg>
                        <span>24/7 online access</span>
                    </li>
                </ul>
            </div>

            <!-- Security Info Card -->
            <div class="info-card glass-effect p-6 rounded-2xl shadow-xl">
                <div class="flex items-center mb-3">
                    <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center mr-3">
                        <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                        </svg>
                    </div>
                    <h3 class="text-lg font-bold text-gray-800">Secure & Protected</h3>
                </div>
                <p class="text-sm text-gray-600">
                    Your account is protected with bank-level encryption and multi-factor authentication.
                </p>
            </div>

            <!-- Support Card -->
            <div class="info-card glass-effect p-6 rounded-2xl shadow-xl">
                <div class="flex items-center mb-3">
                    <div class="w-10 h-10 bg-purple-100 rounded-lg flex items-center justify-center mr-3">
                        <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z"></path>
                        </svg>
                    </div>
                    <h3 class="text-lg font-bold text-gray-800">Need Assistance?</h3>
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

</body>
</html>