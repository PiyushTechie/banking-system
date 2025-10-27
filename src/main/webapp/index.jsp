<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Safe retrieval of user email
    String userEmail = (String) session.getAttribute("user_email");
    if (userEmail != null) userEmail = userEmail.trim();

    // Safe decoding of "msg" parameter
    String msg = request.getParameter("msg");
    String displayMsg = "";
    boolean isError = false;
    if (msg != null && !msg.isBlank()) {
        try {
            displayMsg = java.net.URLDecoder.decode(msg, "UTF-8");
        } catch (Exception e) {
            displayMsg = msg; // fallback
        }
        isError = displayMsg.contains("Error") 
               || displayMsg.contains("Failed") 
               || displayMsg.contains("Invalid") 
               || displayMsg.contains("Insufficient") 
               || displayMsg.contains("Not Found");
    }

    // Define Quick Actions
    class QuickAction {
        String title, desc, href, fromColor, toColor;
        String iconPath;
        QuickAction(String title, String desc, String href, String fromColor, String toColor, String iconPath){
            this.title=title; this.desc=desc; this.href=href; this.fromColor=fromColor; this.toColor=toColor; this.iconPath=iconPath;
        }
    }

    QuickAction[] quickActions = new QuickAction[] {
        new QuickAction("Deposit","Add funds to your account","deposit.jsp","green-500","emerald-600","M12 4v16m8-8H4"),
        new QuickAction("Withdraw","Take out money securely","withdraw.jsp","red-500","pink-600","M20 12H4"),
        new QuickAction("Transfer","Send money to others","transfer.jsp","blue-500","indigo-600","M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4")
    };

    // Define Account Management Cards
    class AccountCard {
        String title, desc, href, iconColor, bgColor, borderColor;
        String iconPath;
        AccountCard(String title,String desc,String href,String iconColor,String bgColor,String borderColor,String iconPath){
            this.title=title; this.desc=desc; this.href=href; this.iconColor=iconColor; this.bgColor=bgColor; this.borderColor=borderColor; this.iconPath=iconPath;
        }
    }

    AccountCard[] accountCards = new AccountCard[] {
        new AccountCard("View Balance","Check your current balance","AccountServlet?action=view","blue-600","blue-100","gray-200","M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"),
        new AccountCard("View History","Review your transactions","HistoryServlet","purple-600","purple-100","gray-200","M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01")
    };
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SecureBank - Your Trusted Banking Partner</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');
        body { font-family: 'Inter', sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .glass-effect { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.2); }
        .card-hover { transition: all 0.3s ease; }
        .card-hover:hover { transform: translateY(-5px); box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15); }
        .gradient-text { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
        @keyframes fadeInUp { from { opacity:0; transform:translateY(20px); } to { opacity:1; transform:translateY(0); } }
        .fade-in-up { animation: fadeInUp 0.6s ease-out; }
        .action-btn { position: relative; overflow: hidden; }
        .action-btn::before { content: ''; position: absolute; top:50%; left:50%; width:0; height:0; border-radius:50%; background: rgba(255,255,255,0.3); transform: translate(-50%,-50%); transition: width 0.6s, height 0.6s; }
        .action-btn:hover::before { width:300px; height:300px; }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4">

<div class="w-full max-w-6xl fade-in-up">

    <!-- Main Container -->
    <div class="glass-effect rounded-3xl shadow-2xl overflow-hidden">

        <!-- Header Section -->
        <div class="bg-gradient-to-r from-blue-600 via-indigo-600 to-purple-600 px-8 py-10 text-white">
            <div class="flex items-center justify-between flex-wrap gap-4">
                <div>
                    <h1 class="text-4xl font-bold mb-2">Welcome Back!</h1>
                    <p class="text-blue-100 text-lg"><span class="font-medium"><%= (userEmail != null && !userEmail.isBlank()) ? userEmail : "Guest" %></span></p>
                </div>
                <div class="flex items-center space-x-3">
                    <div class="h-12 w-12 rounded-full bg-white bg-opacity-20 flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                </div>
            </div>
        </div>

        <div class="p-8">

            <!-- Notification Message Area -->
            <% if (!displayMsg.isEmpty()) { %>
                <div class="mb-6 p-4 rounded-xl <%= isError ? "bg-red-50 border-l-4 border-red-500" : "bg-green-50 border-l-4 border-green-500" %>" role="alert">
                    <div class="flex items-center">
                        <% if (isError) { %>
                            <svg class="w-5 h-5 mr-3 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                            </svg>
                        <% } else { %>
                            <svg class="w-5 h-5 mr-3 text-green-500" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                        <% } %>
                        <span class="font-semibold <%= isError ? "text-red-800" : "text-green-800" %>"><%= displayMsg %></span>
                    </div>
                </div>
            <% } %>

            <!-- Quick Actions Section -->
            <div class="mb-8">
                <h2 class="text-2xl font-bold text-gray-800 mb-6">Quick Actions</h2>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <% for (QuickAction action : quickActions) { %>
                        <a href="<%= action.href %>" class="action-btn card-hover group block p-6 bg-gradient-to-br from-<%=action.fromColor%> to-<%=action.toColor%> rounded-2xl shadow-lg text-white relative">
                            <div class="relative z-10">
                                <div class="h-14 w-14 bg-white bg-opacity-20 rounded-xl flex items-center justify-center mb-4 group-hover:bg-opacity-30 transition-all">
                                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="<%=action.iconPath%>"></path>
                                    </svg>
                                </div>
                                <h3 class="text-xl font-bold mb-2"><%= action.title %></h3>
                                <p class="text-white text-opacity-80 text-sm"><%= action.desc %></p>
                            </div>
                        </a>
                    <% } %>
                </div>
            </div>

            <!-- Account Management Section -->
            <div class="mb-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-6">Account Management</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <% for (AccountCard card : accountCards) { %>
                        <a href="<%=card.href%>" class="card-hover group block p-6 bg-white border-2 border-<%=card.borderColor%> rounded-2xl hover:border-<%=card.iconColor%> transition-all">
                            <div class="flex items-start">
                                <div class="h-12 w-12 bg-<%=card.bgColor%> rounded-xl flex items-center justify-center mr-4 group-hover:bg-opacity-70 transition-colors">
                                    <svg class="w-6 h-6 text-<%=card.iconColor%>" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="<%=card.iconPath%>"></path>
                                    </svg>
                                </div>
                                <div>
                                    <h3 class="text-lg font-bold text-gray-800 mb-1"><%=card.title%></h3>
                                    <p class="text-gray-600 text-sm"><%=card.desc%></p>
                                </div>
                            </div>
                        </a>
                    <% } %>
                </div>
            </div>

            <!-- Logout Section -->
            <div class="border-t-2 border-gray-200 pt-6">
                <a href="LogoutServlet" class="card-hover group block p-4 bg-gray-50 border-2 border-gray-200 rounded-xl hover:bg-gray-100 hover:border-gray-300 transition-all">
                    <div class="flex items-center justify-center">
                        <svg class="w-5 h-5 text-gray-600 mr-2 group-hover:text-gray-800" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                        </svg>
                        <span class="font-semibold text-gray-700 group-hover:text-gray-900">Logout</span>
                    </div>
                </a>
            </div>

        </div>
    </div>

    <!-- Footer -->
    <div class="text-center mt-6 text-white text-sm">
        <p class="opacity-90">© 2025 SecureBank. Your money is safe with us.</p>
    </div>

</div>
</body>
</html>
