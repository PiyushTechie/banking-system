<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Get the user's email from the session (used for display/context if needed, but NOT sent in form)
    String userEmail = (session != null) ? (String) session.getAttribute("user_email") : "";

    // Message handling from servlet redirects
    String msg = request.getParameter("msg");
    boolean isError = false;
    if (msg != null) {
        String lowerMsg = msg.toLowerCase();
        isError = lowerMsg.contains("error") 
               || lowerMsg.contains("failed") 
               || lowerMsg.contains("invalid")
               || lowerMsg.contains("must be positive"); // Added check for validation message
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Deposit Funds - SecureBank</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');
    body { font-family: 'Inter', sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
    .glass { background: rgba(255,255,255,0.95); backdrop-filter: blur(10px); border:1px solid rgba(255,255,255,0.2); }
    .fade-in-up { animation: fadeInUp 0.6s ease-out; }
    @keyframes fadeInUp { from {opacity:0; transform:translateY(30px);} to {opacity:1; transform:translateY(0);} }
    .input-focus { transition: all 0.3s ease; }
    .input-focus:focus { transform: translateY(-2px); box-shadow:0 10px 20px rgba(16,185,129,0.2); }
    .deposit-btn { position:relative; overflow:hidden; transition: all 0.3s ease; }
    .deposit-btn::before { content:''; position:absolute; top:50%; left:50%; width:0;height:0;border-radius:50%; background: rgba(255,255,255,0.3); transform:translate(-50%,-50%); transition: width 0.6s, height 0.6s; }
    .deposit-btn:hover::before { width:400px; height:400px; }
    .deposit-btn:hover { transform:translateY(-2px); box-shadow:0 10px 25px rgba(16,185,129,0.4); }
    .info-card { transition: all 0.3s ease; }
    .info-card:hover { transform:translateY(-3px); }
</style>
</head>
<body class="flex items-center justify-center min-h-screen p-4">

<div class="w-full max-w-5xl fade-in-up grid grid-cols-1 lg:grid-cols-3 gap-6">

    <!-- Deposit Form -->
    <div class="lg:col-span-2 glass p-8 rounded-3xl shadow-2xl">
        <div class="flex items-center justify-center mb-6">
            <div class="w-16 h-16 bg-gradient-to-br from-green-500 to-emerald-600 rounded-2xl flex items-center justify-center mr-4">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                </svg>
            </div>
            <div>
                <h1 class="text-3xl font-bold text-gray-800">Deposit Funds</h1>
                <p class="text-gray-600 text-sm">Add money to your account (<%= userEmail %>)</p>
            </div>
        </div>

        <form action="TransactionServlet" method="POST" class="space-y-6">
            <input type="hidden" name="action" value="deposit">
            <%-- The email field is removed - servlet gets it from session --%>

            <div>
                <label for="amount" class="block text-sm font-semibold text-gray-700 mb-2">Deposit Amount</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <span class="text-gray-500 font-semibold text-lg">₹</span>
                    </div>
                    <input type="number" id="amount" name="amount" step="0.01" min="0.01" required placeholder="0.00"
                           class="input-focus block w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent text-lg font-semibold">
                </div>
                <p class="mt-2 text-xs text-gray-500">Enter the amount you wish to deposit</p>
            </div>

            <div>
                <p class="text-sm font-semibold text-gray-700 mb-3">Quick Select</p>
                <div class="grid grid-cols-4 gap-3">
                    <button type="button" onclick="document.getElementById('amount').value='500'" class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-green-50 hover:border-green-500 transition-all duration-200">₹500</button>
                    <button type="button" onclick="document.getElementById('amount').value='1000'" class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-green-50 hover:border-green-500 transition-all duration-200">₹1,000</button>
                    <button type="button" onclick="document.getElementById('amount').value='2000'" class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-green-50 hover:border-green-500 transition-all duration-200">₹2,000</button>
                    <button type="button" onclick="document.getElementById('amount').value='5000'" class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-green-50 hover:border-green-500 transition-all duration-200">₹5,000</button>
                </div>
            </div>

            <button type="submit" class="deposit-btn relative w-full py-4 px-4 border border-transparent rounded-xl text-base font-semibold text-white bg-gradient-to-r from-green-500 to-emerald-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                <span class="relative z-10 flex items-center justify-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"></path>
                    </svg>
                    Deposit Now
                </span>
            </button>

            <a href="index.jsp" class="block text-center w-full py-3 px-4 border-2 border-gray-300 rounded-xl text-base font-semibold text-gray-700 hover:bg-gray-50 hover:border-green-500 transition-all duration-200">Back to Home</a>
        </form>
    </div>

    <!-- Sidebar Cards -->
    <div class="lg:col-span-1 space-y-4">
        <div class="glass info-card p-6 rounded-2xl shadow-xl">
            <div class="flex items-center mb-4">
                <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center mr-3">
                    <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                </div>
                <h3 class="text-lg font-bold text-gray-800">Deposit Benefits</h3>
            </div>
            <ul class="space-y-3 text-sm text-gray-600">
                <li class="flex items-start"><span class="ml-1">Instant credit to your account</span></li>
                <li class="flex items-start"><span class="ml-1">No deposit fees or charges</span></li>
                <li class="flex items-start"><span class="ml-1">Secure encrypted transactions</span></li>
                <li class="flex items-start"><span class="ml-1">Available for use immediately</span></li>
            </ul>
        </div>
    </div>

</div>

<%-- Toast Message --%>
<% if (msg != null) { %>
<div id="toast" class="fixed top-6 right-6 max-w-sm p-5 rounded-2xl shadow-2xl text-white <%= isError ? "bg-gradient-to-r from-red-500 to-red-600" : "bg-gradient-to-r from-green-500 to-green-600" %> fade-in-up" style="z-index:9999;">
    <div class="flex items-start">
        <svg class="w-6 h-6 mr-3 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
            <% if (isError) { %>
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
            <% } else { %>
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
            <% } %>
        </svg>
        <div class="flex-1">
            <p class="font-semibold text-base"><%= java.net.URLDecoder.decode(msg, "UTF-8") %></p>
        </div>
        <button onclick="document.getElementById('toast').style.display='none'" class="ml-4 text-white hover:text-gray-200 transition-colors">
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
        </button>
    </div>
</div>

<script>
// Auto-hide toast message after 5 seconds
setTimeout(function(){
    const t = document.getElementById('toast');
    if(t){ 
        t.style.transition = 'opacity 0.5s ease-out'; // Add transition for fade out
        t.style.opacity='0'; 
        setTimeout(()=>{ t.style.display='none'; },500); // Wait for fade out before hiding
    }
},5000);
</script>
<% } %>

</body>
</html>

