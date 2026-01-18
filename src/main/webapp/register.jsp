<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Open an Account - SecureBank</title>
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
        
        .register-container {
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        .btn-primary {
            background: linear-gradient(to right, #0066cc, #004c99);
            transition: all 0.2s;
        }
        
        .btn-primary:hover {
            background: linear-gradient(to right, #0052a3, #003d7a);
            box-shadow: 0 4px 8px rgba(0,102,204,0.2);
        }
        
        input:focus {
            border-color: #0066cc;
            outline: none;
            box-shadow: 0 0 0 3px rgba(0,102,204,0.1);
        }
        
        .step-indicator {
            background: #e8f0fe;
            color: #0066cc;
            font-weight: 600;
        }
        
        .benefit-item {
            border-left: 3px solid #0066cc;
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
                    <a href="#" class="text-gray-700 hover:text-blue-600 font-medium">Personal</a>
                    <a href="#" class="text-gray-700 hover:text-blue-600 font-medium">Business</a>
                    <a href="#" class="text-gray-700 hover:text-blue-600 font-medium">About Us</a>
                    <a href="#" class="text-gray-700 hover:text-blue-600 font-medium">Contact</a>
                </nav>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div class="grid lg:grid-cols-3 gap-8">
            
            <!-- Left Column - Benefits -->
            <div class="lg:col-span-1 space-y-6">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900 mb-3">Open Your Account</h1>
                    <p class="text-gray-600">Join thousands of satisfied customers who trust SecureBank for their financial needs.</p>
                </div>

                <!-- Account Benefits -->
                <div class="bg-white rounded-lg p-6 shadow-sm">
                    <h2 class="text-lg font-bold text-gray-900 mb-4">Account Benefits</h2>
                    <div class="space-y-4">
                        <div class="benefit-item pl-4 py-2">
                            <h3 class="font-semibold text-gray-900 text-sm">No Monthly Fees</h3>
                            <p class="text-sm text-gray-600 mt-1">Keep more of your money with zero account maintenance charges</p>
                        </div>
                        <div class="benefit-item pl-4 py-2">
                            <h3 class="font-semibold text-gray-900 text-sm">Free Online Banking</h3>
                            <p class="text-sm text-gray-600 mt-1">Access your account 24/7 from anywhere in the world</p>
                        </div>
                        <div class="benefit-item pl-4 py-2">
                            <h3 class="font-semibold text-gray-900 text-sm">Mobile App</h3>
                            <p class="text-sm text-gray-600 mt-1">Bank on-the-go with our award-winning mobile application</p>
                        </div>
                        <div class="benefit-item pl-4 py-2">
                            <h3 class="font-semibold text-gray-900 text-sm">FDIC Insured</h3>
                            <p class="text-sm text-gray-600 mt-1">Your deposits are insured up to $250,000</p>
                        </div>
                    </div>
                </div>

                <!-- Security Notice -->
                <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
                    <div class="flex items-start">
                        <svg class="w-5 h-5 text-blue-600 mr-3 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd"></path>
                        </svg>
                        <div>
                            <h3 class="font-semibold text-blue-900 text-sm">Your Security Matters</h3>
                            <p class="text-sm text-blue-800 mt-1">We use bank-level encryption to protect your personal information</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column - Registration Form -->
            <div class="lg:col-span-2">
                <div class="register-container rounded-lg p-8">
                    
                    <!-- Progress Indicator -->
                    <div class="mb-8">
                        <div class="flex items-center justify-between mb-2">
                            <span class="text-sm font-medium text-gray-700">Step 1 of 2</span>
                            <span class="text-sm text-gray-500">Account Information</span>
                        </div>
                        <div class="w-full bg-gray-200 rounded-full h-2">
                            <div class="bg-blue-600 h-2 rounded-full" style="width: 50%"></div>
                        </div>
                    </div>

                    <div class="mb-8">
                        <h2 class="text-2xl font-bold text-gray-900 mb-2">Create Your Account</h2>
                        <p class="text-gray-600">Please provide your information to get started</p>
                    </div>

                    <form action="RegisterServlet" method="POST" class="space-y-6">
                        
                        <!-- Email -->
                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                                Email Address <span class="text-red-500">*</span>
                            </label>
                            <input type="email" 
                                   id="email" 
                                   name="email" 
                                   required
                                   autocomplete="off"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-md text-gray-900"
                                   placeholder="Enter your email address">
                            <p class="mt-1 text-sm text-gray-500">We'll use this email for account notifications</p>
                        </div>

                        <!-- Password -->
                        <div>
                            <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
                                Password <span class="text-red-500">*</span>
                            </label>
                            <input type="password" 
                                   id="password" 
                                   name="password" 
                                   required
                                   autocomplete="off"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-md text-gray-900"
                                   placeholder="Create a secure password">
                            
                            <!-- Password Requirements -->
                            <div class="mt-3 bg-gray-50 border border-gray-200 rounded-md p-3">
                                <p class="text-xs font-medium text-gray-700 mb-2">Password must contain:</p>
                                <ul class="space-y-1 text-xs text-gray-600">
                                    <li class="flex items-center">
                                        <svg class="w-3 h-3 text-gray-400 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                        </svg>
                                        At least 8 characters
                                    </li>
                                    <li class="flex items-center">
                                        <svg class="w-3 h-3 text-gray-400 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                        </svg>
                                        One uppercase and one lowercase letter
                                    </li>
                                    <li class="flex items-center">
                                        <svg class="w-3 h-3 text-gray-400 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                        </svg>
                                        One number or special character
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <!-- Terms Agreement -->
                        <div>
                            <label class="flex items-start">
                                <input type="checkbox" 
                                       required
                                       class="w-4 h-4 text-blue-600 border-gray-300 rounded mt-1">
                                <span class="ml-3 text-sm text-gray-700">
                                    I agree to the <a href="#" class="text-blue-600 hover:text-blue-700 font-medium">Terms of Service</a> and <a href="#" class="text-blue-600 hover:text-blue-700 font-medium">Privacy Policy</a>
                                </span>
                            </label>
                        </div>

                        <div>
                            <label class="flex items-start">
                                <input type="checkbox" 
                                       class="w-4 h-4 text-blue-600 border-gray-300 rounded mt-1">
                                <span class="ml-3 text-sm text-gray-700">
                                    Send me updates about products, services, and exclusive offers
                                </span>
                            </label>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" 
                                class="btn-primary w-full py-3 px-4 rounded-md text-white font-semibold">
                            Continue to Next Step
                        </button>
                    </form>

                    <!-- Already Have Account -->
                    <div class="mt-8 pt-6 border-t border-gray-200 text-center">
                        <p class="text-sm text-gray-600">
                            Already have an account? 
                            <a href="login.jsp" class="text-blue-600 hover:text-blue-700 font-semibold ml-1">
                                Sign In
                            </a>
                        </p>
                    </div>
                </div>

                <!-- Help Text -->
                <div class="mt-6 text-center text-sm text-gray-600">
                    <p>Need help? Call us at <span class="font-semibold text-gray-900">1-800-SECURE-BANK</span></p>
                    <p class="mt-1">Monday - Friday, 8:00 AM - 8:00 PM EST</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast Message -->
    <%
        String message = request.getParameter("msg");
        if (message != null && !message.isEmpty()) {
            String displayMsg = "";
            try { 
                displayMsg = java.net.URLDecoder.decode(message, "UTF-8"); 
            } catch(Exception e) { 
                displayMsg = message; 
            }
            String lower = displayMsg.toLowerCase();
            boolean isError = lower.contains("error") || lower.contains("invalid") || 
                            lower.contains("failed") || lower.contains("exists") || 
                            lower.contains("already");
    %>
        <div id="message-toast" 
             class="fixed top-4 right-4 max-w-md p-4 rounded-lg shadow-lg <%= isError ? "bg-red-50 border-l-4 border-red-500" : "bg-green-50 border-l-4 border-green-500" %>"
             style="z-index: 9999;">
            <div class="flex items-start">
                <% if (isError) { %>
                    <svg class="w-5 h-5 text-red-500 mr-3 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                    </svg>
                <% } else { %>
                    <svg class="w-5 h-5 text-green-500 mr-3 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                    </svg>
                <% } %>
                <div class="flex-1">
                    <p class="<%= isError ? "text-red-800" : "text-green-800" %> font-medium">
                        <%= displayMsg %>
                    </p>
                </div>
                <button onclick="document.getElementById('message-toast').remove()" 
                        class="ml-4 <%= isError ? "text-red-500 hover:text-red-600" : "text-green-500 hover:text-green-600" %>">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                    </svg>
                </button>
            </div>
        </div>
        
        <script>
            setTimeout(function() {
                var toast = document.getElementById('message-toast');
                if (toast) {
                    toast.style.opacity = '0';
                    toast.style.transition = 'opacity 0.3s ease';
                    setTimeout(function() { toast.remove(); }, 300);
                }
            }, 5000);
        </script>
    <%
        }
    %>

</body>
</html>