<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Use the implicit session object
    String userEmail = (session != null) ? (String) session.getAttribute("user_email") : "";
    // Removed accountNumber retrieval as it's not passed to this page

    // Message handling from servlet redirects
    String msg = request.getParameter("msg");
    boolean isError = false;
    if (msg != null) {
        String lowerMsg = msg.toLowerCase();
        isError = lowerMsg.contains("error") 
               || lowerMsg.contains("failed") 
               || lowerMsg.contains("invalid")
               || lowerMsg.contains("insufficient"); // Added check for withdraw-specific error
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
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');
    body { font-family: 'Inter', sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
    .glass-effect { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.2); }
    .fade-in-up { animation: fadeInUp 0.6s ease-out; }
    @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
    .input-focus { transition: all 0.3s ease; }
    .input-focus:focus { transform: translateY(-2px); box-shadow: 0 10px 20px rgba(239, 68, 68, 0.2); }
    .withdraw-btn { position: relative; overflow: hidden; transition: all 0.3s ease; }
    .withdraw-btn::before {
        content: ''; position: absolute; top: 50%; left: 50%; width: 0; height: 0; border-radius: 50%;
        background: rgba(255, 255, 255, 0.3); transform: translate(-50%, -50%);
        transition: width 0.6s, height 0.6s;
    }
    .withdraw-btn:hover::before { width: 400px; height: 400px; }
    .withdraw-btn:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(239, 68, 68, 0.4); }
    .info-card { transition: all 0.3s ease; }
    .info-card:hover { transform: translateY(-3px); }
</style>
</head>
<body class="flex items-center justify-center min-h-screen p-4">

<div class="w-full max-w-5xl fade-in-up">
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        
        <!-- Main Withdraw Form -->
        <div class="lg:col-span-2">
            <div class="glass-effect p-8 rounded-3xl shadow-2xl">

                <!-- Header -->
                <div class="flex items-center justify-center mb-6">
                    <div class="w-16 h-16 bg-gradient-to-br from-red-500 to-pink-600 rounded-2xl flex items-center justify-center mr-4">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-3xl font-bold text-gray-800">Withdraw Funds</h1>
                        <%-- Display user email instead of account number --%>
                        <p class="text-gray-600 text-sm">Account: <%= userEmail %></p> 
                    </div>
                </div>

                <%-- Removed the separate Account Number Display block --%>

                <!-- Withdrawal Form -->
                <form action="TransactionServlet" method="POST" class="space-y-6">
                    <input type="hidden" name="action" value="withdraw">
                    <%-- Email is handled by the servlet via session --%>

                    <div>
                        <label for="amount" class="block text-sm font-semibold text-gray-700 mb-2">Withdrawal Amount</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <span class="text-gray-500 font-semibold text-lg">₹</span>
                            </div>
                            <input type="number" id="amount" name="amount" step="0.01" min="0.01" required
                                   placeholder="0.00"
                                   class="input-focus block w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-transparent text-lg font-semibold">
                        </div>
                        <p class="mt-2 text-xs text-gray-500">Enter the amount you wish to withdraw</p>
                    </div>

                    <!-- Quick Amount Buttons -->
                    <div>
                        <p class="text-sm font-semibold text-gray-700 mb-3">Quick Select</p>
                        <div class="grid grid-cols-4 gap-3">
                            <button type="button" onclick="document.getElementById('amount').value='500'" class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-red-50 hover:border-red-500 transition-all duration-200">₹500</button>
                            <button type="button" onclick="document.getElementById('amount').value='1000'" class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-red-50 hover:border-red-500 transition-all duration-200">₹1,000</button>
                            <button type="button" onclick="document.getElementById('amount').value='2000'" class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-red-50 hover:border-red-500 transition-all duration-200">₹2,000</button>
                            <button type="button" onclick="document.getElementById('amount').value='5000'" class="py-3 px-4 border-2 border-gray-300 rounded-xl text-sm font-semibold text-gray-700 hover:bg-red-50 hover:border-red-500 transition-all duration-200">₹5,000</button>
                        </div>
                    </div>

                    <button type="submit" class="withdraw-btn relative w-full py-4 px-4 border border-transparent rounded-xl text-base font-semibold text-white bg-gradient-to-r from-red-500 to-pink-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                        <span class="relative z-10 flex items-center justify-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"></path>
                            </svg>
                            Withdraw Now
                        </span>
                    </button>

                    <a href="index.jsp" class="block text-center w-full py-3 px-4 border-2 border-gray-300 rounded-xl text-base font-semibold text-gray-700 hover:bg-gray-50 hover:border-red-500 transition-all duration-200">
                        Back to Home
                    </a>
                </form>

            </div>
        </div>

        <!-- Sidebar Info Cards -->
        <div class="lg:col-span-1 space-y-4">
           <div class="glass info-card p-6 rounded-2xl shadow-xl">
                 <div class="flex items-center mb-4">
                    <div class="w-10 h-10 bg-red-100 rounded-lg flex items-center justify-center mr-3">
                        <svg class="w-5 h-5 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                           <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                    </div>
                     <h3 class="text-lg font-bold text-gray-800">Important Notes</h3>
                 </div>
                 <ul class="space-y-3 text-sm text-gray-600">
                     <li class="flex items-start"><span class="ml-1">Withdrawals are processed instantly.</span></li>
                     <li class="flex items-start"><span class="ml-1">Ensure sufficient funds before withdrawing.</span></li>
                     <li class="flex items-start"><span class="ml-1">Contact support for withdrawal limits.</span></li>
                 </ul>
             </div>
             <%-- You can add more info cards here if needed --%>
        </div>

    </div>
</div>

<!-- Toast Messages -->
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

