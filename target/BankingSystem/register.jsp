<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - SecureBank</title>
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
        
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
        .fade-in-up { animation: fadeInUp 0.6s ease-out; }

        @keyframes slideInRight { from { opacity: 0; transform: translateX(100px); } to { opacity: 1; transform: translateX(0); } }
        .slide-in-right { animation: slideInRight 0.5s ease-out; }

        .input-focus { transition: all 0.3s ease; }
        .input-focus:focus { transform: translateY(-2px); box-shadow: 0 10px 20px rgba(102, 126, 234, 0.2); }

        .register-btn {
            position: relative; overflow: hidden; transition: all 0.3s ease;
        }
        .register-btn::before {
            content: ''; position: absolute; top: 50%; left: 50%;
            width: 0; height: 0; border-radius: 50%; background: rgba(255, 255, 255, 0.3);
            transform: translate(-50%, -50%); transition: width 0.6s, height 0.6s;
        }
        .register-btn:hover::before { width: 400px; height: 400px; }
        .register-btn:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(16, 185, 129, 0.4); }

        .floating { animation: floating 3s ease-in-out infinite; }
        @keyframes floating { 0%,100%{transform:translateY(0px);}50%{transform:translateY(-20px);} }

        .feature-card { transition: all 0.3s ease; }
        .feature-card:hover { transform: translateX(10px); }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen p-4">

<div class="w-full max-w-6xl flex items-center justify-center gap-8">

    <!-- Left Side - Decorative Section -->
    <div class="hidden lg:flex flex-col items-start justify-center w-1/2 text-white fade-in-up pr-8">
        <div class="mb-8">
            <div class="floating inline-block mb-6">
                <div class="w-20 h-20 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center backdrop-blur-sm">
                    <svg class="w-12 h-12" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path>
                    </svg>
                </div>
            </div>
            <h2 class="text-4xl font-bold mb-4">Join SecureBank Today</h2>
            <p class="text-xl text-blue-100 mb-8">Experience banking like never before with our secure and user-friendly platform</p>
        </div>

        <div class="space-y-4 w-full">
            <div class="feature-card flex items-start space-x-4 p-4 bg-white bg-opacity-10 rounded-xl backdrop-blur-sm">
                <div class="flex-shrink-0">
                    <div class="w-12 h-12 bg-green-500 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                        </svg>
                    </div>
                </div>
                <div>
                    <h3 class="font-semibold text-lg mb-1">Bank-Level Security</h3>
                    <p class="text-blue-100 text-sm">Your data is protected with military-grade encryption</p>
                </div>
            </div>

            <div class="feature-card flex items-start space-x-4 p-4 bg-white bg-opacity-10 rounded-xl backdrop-blur-sm">
                <div class="flex-shrink-0">
                    <div class="w-12 h-12 bg-blue-500 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path>
                        </svg>
                    </div>
                </div>
                <div>
                    <h3 class="font-semibold text-lg mb-1">Instant Transfers</h3>
                    <p class="text-blue-100 text-sm">Send and receive money in seconds, not days</p>
                </div>
            </div>

            <div class="feature-card flex items-start space-x-4 p-4 bg-white bg-opacity-10 rounded-xl backdrop-blur-sm">
                <div class="flex-shrink-0">
                    <div class="w-12 h-12 bg-purple-500 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                    </div>
                </div>
                <div>
                    <h3 class="font-semibold text-lg mb-1">Zero Hidden Fees</h3>
                    <p class="text-blue-100 text-sm">Transparent pricing with no surprises</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Right Side - Registration Form -->
    <div class="w-full lg:w-1/2 max-w-md slide-in-right">
        <div class="glass-effect p-10 rounded-3xl shadow-2xl">
            <!-- Header -->
            <div class="text-center mb-8">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-green-500 to-emerald-600 rounded-2xl mb-4">
                    <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path>
                    </svg>
                </div>
                <h1 class="text-3xl font-bold text-gray-800 mb-2">Create Account</h1>
                <p class="text-gray-600">Start your banking journey with us</p>
            </div>

            <!-- Registration Form -->
            <form action="RegisterServlet" method="POST" class="space-y-6">
                <div>
                    <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">Email Address</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"></path>
                            </svg>
                        </div>
                        <input type="email" id="email" name="email" required autocomplete="off"
                               placeholder="you@example.com"
                               class="input-focus block w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent">
                    </div>
                </div>

                <div>
                    <label for="password" class="block text-sm font-semibold text-gray-700 mb-2">Password</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                            </svg>
                        </div>
                        <input type="password" id="password" name="password" required autocomplete="off"
                               placeholder="Create a strong password" 
                               class="input-focus block w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent">
                    </div>
                    <p class="mt-2 text-xs text-gray-500">Must be at least 8 characters long</p>
                </div>

                <button type="submit"
                        class="register-btn relative w-full py-4 px-4 border border-transparent rounded-xl text-base font-semibold text-white bg-gradient-to-r from-green-500 to-emerald-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                    <span class="relative z-10">Create Account</span>
                </button>
            </form>

            <!-- Divider -->
            <div class="relative my-6">
                <div class="absolute inset-0 flex items-center">
                    <div class="w-full border-t border-gray-300"></div>
                </div>
                <div class="relative flex justify-center text-sm">
                    <span class="px-4 bg-white text-gray-500">Already have an account?</span>
                </div>
            </div>

            <!-- Link back to login -->
            <div class="text-center">
                <a href="login.jsp" 
                   class="inline-block w-full py-3.5 px-4 border-2 border-gray-300 rounded-xl text-base font-semibold text-gray-700 hover:bg-gray-50 hover:border-green-500 transition-all duration-200">
                    Sign In Instead
                </a>
            </div>

            <!-- Terms -->
            <div class="mt-6 text-center text-xs text-gray-600">
                By creating an account, you agree to our
                <a href="#" class="text-blue-600 hover:text-blue-500 font-medium">Terms of Service</a>
                and
                <a href="#" class="text-blue-600 hover:text-blue-500 font-medium">Privacy Policy</a>
            </div>
        </div>
    </div>
</div>

<%
    // Toast Handling
    String message = request.getParameter("msg");
    String displayMsg = "";
    boolean isError = false;
    if(message != null && !message.isEmpty()){
        try { displayMsg = java.net.URLDecoder.decode(message, "UTF-8"); } 
        catch(Exception e){ displayMsg = message; }
        String lower = displayMsg.toLowerCase();
        isError = lower.contains("error") || lower.contains("invalid") || lower.contains("failed") || lower.contains("exists") || lower.contains("already");
%>
<div id="message-toast" 
     class="fixed top-6 right-6 max-w-sm p-5 rounded-2xl shadow-2xl text-white <%= isError ? "bg-gradient-to-r from-red-500 to-red-600" : "bg-gradient-to-r from-green-500 to-green-600" %> slide-in-right"
     style="z-index:9999;">
    <div class="flex items-start">
        <svg class="w-6 h-6 mr-3 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="<%= isError 
                ? "M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" 
                : "M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" %>" clip-rule="evenodd"></path>
        </svg>
        <div class="flex-1"><p class="font-semibold text-base"><%= displayMsg %></p></div>
        <button onclick="document.getElementById('message-toast').style.display='none'" 
                class="ml-4 text-white hover:text-gray-200 transition-colors">
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
            toast.style.transition = 'opacity 0.5s ease';
            setTimeout(function(){ toast.style.display='none'; }, 500);
        }
    }, 5000);
</script>
<% } %>

</body>
</html>
