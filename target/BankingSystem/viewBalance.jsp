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
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;600;700&display=swap');
        
        body { 
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
        }
        
        .header-shadow {
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
        }
        
        .balance-card {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            position: relative;
            overflow: hidden;
        }
        
        .balance-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
        }
        
        .stats-card {
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.2s;
        }
        
        .stats-card:hover {
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        
        .btn-primary {
            background: linear-gradient(to right, #0066cc, #004c99);
            transition: all 0.2s;
        }
        
        .btn-primary:hover {
            background: linear-gradient(to right, #0052a3, #003d7a);
            box-shadow: 0 4px 8px rgba(0,102,204,0.2);
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
                    <a href="#" class="text-blue-600 font-medium border-b-2 border-blue-600 pb-1">Accounts</a>
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
                <span class="text-gray-900 font-medium">Account Balance</span>
            </nav>
        </div>

        <%
            String accountName = (String) request.getAttribute("accountName");
            String accountNumber = (String) request.getAttribute("accountNumber"); 
            Double balance = (Double) request.getAttribute("balance");
        %>

        <div class="grid lg:grid-cols-3 gap-8">
            
            <!-- Main Content Area -->
            <div class="lg:col-span-2 space-y-6">
                
                <!-- Page Title -->
                <div class="bg-white rounded-lg shadow-sm p-8">
                    <h1 class="text-3xl font-bold text-gray-900 mb-2">Account Overview</h1>
                    <p class="text-gray-600">View your current account balance and details</p>
                </div>

                <!-- Balance Card -->
                <div class="balance-card rounded-lg p-8 text-white shadow-lg relative">
                    <div class="relative z-10">
                        <div class="flex items-center mb-4">
                            <div class="w-12 h-12 bg-white bg-opacity-20 rounded-lg flex items-center justify-center mr-3">
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
                        <p class="text-5xl font-bold mb-2">
                            ₹<%= balance != null ? String.format("%.2f", balance) : "0.00" %>
                        </p>
                        <p class="text-sm text-green-100 mt-4">Available for transactions</p>
                    </div>
                </div>

                <!-- Account Details -->
                <div class="bg-white rounded-lg shadow-sm p-6">
                    <h2 class="text-xl font-bold text-gray-900 mb-4">Account Information</h2>
                    <div class="space-y-4">
                        <div class="flex justify-between items-center py-3 border-b border-gray-200">
                            <div class="flex items-center">
                                <svg class="w-5 h-5 text-blue-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                </svg>
                                <span class="text-sm font-medium text-gray-600">Account Holder</span>
                            </div>
                            <span class="text-base font-semibold text-gray-900"><%= accountName != null ? accountName : "N/A" %></span>
                        </div>
                        <div class="flex justify-between items-center py-3 border-b border-gray-200">
                            <div class="flex items-center">
                                <svg class="w-5 h-5 text-blue-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01"></path>
                                </svg>
                                <span class="text-sm font-medium text-gray-600">Account Number</span>
                            </div>
                            <span class="text-base font-semibold text-gray-900"><%= accountNumber != null ? accountNumber : "N/A" %></span>
                        </div>
                        <div class="flex justify-between items-center py-3">
                            <div class="flex items-center">
                                <svg class="w-5 h-5 text-blue-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                                </svg>
                                <span class="text-sm font-medium text-gray-600">Account Status</span>
                            </div>
                            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                Active
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="space-y-3">
                    <a href="index.jsp" 
                       class="btn-primary block py-3 px-6 rounded-md text-white font-semibold text-center">
                        Back to Dashboard
                    </a>
                    <a href="LogoutServlet" 
                       class="block py-3 px-6 border-2 border-gray-300 rounded-md text-center text-gray-700 font-semibold hover:bg-gray-50 hover:border-gray-400 transition-colors">
                        Logout
                    </a>
                </div>

            </div>

            <!-- Sidebar -->
            <div class="lg:col-span-1 space-y-6">
                
                <!-- Quick Stats -->
                <div class="grid grid-cols-1 gap-4">
                    <div class="stats-card rounded-lg p-5">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-xs text-gray-600 font-medium uppercase tracking-wide mb-1">Account Type</p>
                                <p class="text-lg font-bold text-gray-900">Savings</p>
                            </div>
                            <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <div class="stats-card rounded-lg p-5">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-xs text-gray-600 font-medium uppercase tracking-wide mb-1">Security Level</p>
                                <p class="text-lg font-bold text-gray-900">Verified</p>
                            </div>
                            <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center">
                                <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <div class="stats-card rounded-lg p-5">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-xs text-gray-600 font-medium uppercase tracking-wide mb-1">Support</p>
                                <p class="text-lg font-bold text-gray-900">24/7 Available</p>
                            </div>
                            <div class="w-10 h-10 bg-purple-100 rounded-lg flex items-center justify-center">
                                <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Security Information -->
                <div class="bg-white rounded-lg p-6 shadow-sm">
                    <div class="flex items-center mb-3">
                        <svg class="w-6 h-6 text-green-600 mr-2" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd"></path>
                        </svg>
                        <h3 class="font-bold text-gray-900">Secure Banking</h3>
                    </div>
                    <p class="text-sm text-gray-700">
                        Your account is protected with bank-level encryption and multi-layer security protocols.
                    </p>
                </div>

                <!-- Need Help -->
                <div class="bg-blue-50 border border-blue-200 rounded-lg p-6">
                    <h3 class="font-bold text-gray-900 mb-2">Need Assistance?</h3>
                    <p class="text-sm text-gray-700 mb-4">
                        Our customer support team is here to help you.
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