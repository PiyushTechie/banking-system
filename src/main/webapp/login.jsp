<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SecureBank - Online Banking Login</title>
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
        
        .login-container {
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
        
        .feature-card {
            transition: transform 0.2s;
        }
        
        .feature-card:hover {
            transform: translateY(-2px);
        }
        
        input:focus {
            border-color: #0066cc;
            outline: none;
            box-shadow: 0 0 0 3px rgba(0,102,204,0.1);
        }
        
        .hero-section {
            background: linear-gradient(135deg, #0066cc 0%, #003d7a 100%);
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
    <div class="min-h-screen flex">
        
        <!-- Left Hero Section -->
        <div class="hidden lg:flex lg:w-1/2 hero-section items-center justify-center p-12">
            <div class="max-w-lg text-white">
                <h1 class="text-5xl font-bold mb-6">Banking Made Simple</h1>
                <p class="text-xl mb-8 text-blue-100">Manage your finances securely with our award-winning online banking platform</p>
                
                <div class="space-y-4">
                    <div class="flex items-start">
                        <svg class="w-6 h-6 mr-3 mt-1 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                        </svg>
                        <div>
                            <h3 class="font-semibold text-lg">Instant Transfers</h3>
                            <p class="text-blue-100">Move money between accounts instantly</p>
                        </div>
                    </div>
                    
                    <div class="flex items-start">
                        <svg class="w-6 h-6 mr-3 mt-1 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                        </svg>
                        <div>
                            <h3 class="font-semibold text-lg">Bill Pay</h3>
                            <p class="text-blue-100">Schedule and automate bill payments</p>
                        </div>
                    </div>
                    
                    <div class="flex items-start">
                        <svg class="w-6 h-6 mr-3 mt-1 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                        </svg>
                        <div>
                            <h3 class="font-semibold text-lg">Mobile Banking</h3>
                            <p class="text-blue-100">Bank on-the-go with our mobile app</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Login Section -->
        <div class="w-full lg:w-1/2 flex items-center justify-center p-6">
            <div class="w-full max-w-md">
                
                <!-- Login Box -->
                <div class="login-container rounded-lg p-8">
                    <div class="text-center mb-8">
                        <h2 class="text-3xl font-bold text-gray-900 mb-2">Sign In</h2>
                        <p class="text-gray-600">Enter your credentials to access your account</p>
                    </div>

                    <form action="LoginServlet" method="POST" class="space-y-5">
                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                                Email Address
                            </label>
                            <input type="email" 
                                   id="email" 
                                   name="email" 
                                   required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-md text-gray-900"
                                   placeholder="Enter your email">
                        </div>

                        <div>
                            <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
                                Password
                            </label>
                            <input type="password" 
                                   id="password" 
                                   name="password" 
                                   required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-md text-gray-900"
                                   placeholder="Enter your password">
                        </div>

                        <div class="flex items-center justify-between">
                            <label class="flex items-center">
                                <input type="checkbox" class="w-4 h-4 text-blue-600 border-gray-300 rounded">
                                <span class="ml-2 text-sm text-gray-700">Remember me</span>
                            </label>
                            <a href="#" class="text-sm text-blue-600 hover:text-blue-700 font-medium">
                                Forgot password?
                            </a>
                        </div>

                        <button type="submit" class="btn-primary w-full py-3 px-4 rounded-md text-white font-semibold">
                            Sign In
                        </button>
                    </form>

                    <div class="mt-6 pt-6 border-t border-gray-200 text-center">
                        <p class="text-sm text-gray-600 mb-3">Don't have an account?</p>
                        <a href="register.jsp" class="text-blue-600 hover:text-blue-700 font-semibold">
                            Open an Account →
                        </a>
                    </div>
                </div>

                <!-- Security Info -->
                <div class="mt-6 text-center">
                    <div class="flex items-center justify-center text-sm text-gray-600">
                        <svg class="w-5 h-5 text-green-600 mr-2" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd"></path>
                        </svg>
                        <span>Your connection is secure and encrypted</span>
                    </div>
                </div>

                <!-- Trust Badges -->
                <div class="mt-8 flex justify-center items-center space-x-6 opacity-60">
                    <div class="text-center">
                        <p class="text-xs text-gray-500 font-semibold">FDIC INSURED</p>
                    </div>
                    <div class="h-6 w-px bg-gray-300"></div>
                    <div class="text-center">
                        <p class="text-xs text-gray-500 font-semibold">SSL SECURE</p>
                    </div>
                    <div class="h-6 w-px bg-gray-300"></div>
                    <div class="text-center">
                        <p class="text-xs text-gray-500 font-semibold">ISO CERTIFIED</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast Message -->
    <%
        String message = request.getParameter("msg");
        if (message != null && !message.isEmpty()) {
            boolean isError = message.toLowerCase().contains("error") 
                           || message.toLowerCase().contains("invalid") 
                           || message.toLowerCase().contains("failed");
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
                        <%= java.net.URLDecoder.decode(message, "UTF-8") %>
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