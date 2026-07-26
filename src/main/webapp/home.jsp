<%@ page import="lk.jiat.ee.bank.entity.Account" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: K.A.Chanuka Rukshan
  Date: 7/26/2026
  Time: 1:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JTA Bank | Dashboard</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800 font-sans min-h-screen flex flex-col">

<!-- Top Navigation Bar -->
<nav class="bg-slate-900 text-white shadow-lg sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">

            <!-- Logo area -->
            <div class="flex items-center flex-shrink-0">
                    <span class="font-black text-2xl tracking-wider text-white">
                        JTA<span class="text-blue-400">Bank</span>
                    </span>
            </div>

            <!-- Desktop Menu -->
            <div class="hidden md:block">
                <div class="ml-10 flex items-baseline space-x-2">
                    <a href="dashboard" class="bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-semibold shadow-sm transition">Dashboard</a>
                    <a href="deposit" class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">Deposit</a>
                    <a href="withdraw" class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">Withdraw</a>
                    <a href="transfer" class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">Transfer</a>
                    <a href="create-account" class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">New Account</a>

                    <div class="border-l border-slate-700 h-6 mx-2"></div>

                    <a href="logout" class="text-red-400 hover:bg-red-500 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition flex items-center gap-2">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path></svg>
                        Logout
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content Area -->
<main class="flex-grow max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 w-full">

    <!-- Welcome Header -->
    <div class="mb-10 flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div>
            <h1 class="text-3xl md:text-4xl font-extrabold text-gray-900">
                Welcome back, <span class="text-blue-600">${sessionScope.userName}</span> 👋
            </h1>
            <p class="mt-2 text-gray-500 font-medium text-lg">Here is an overview of your accounts.</p>
        </div>
    </div>

    <!-- Accounts Section -->
    <div class="mb-6 flex items-center justify-between border-b border-gray-200 pb-4">
        <h2 class="text-xl font-bold text-gray-800">Your Accounts</h2>
    </div>

    <%
        List<Account> accounts = (List<Account>) request.getAttribute("accounts");
        if (accounts == null || accounts.isEmpty()) {
    %>

    <!-- Empty State (Shows when no accounts exist) -->
    <div class="bg-white rounded-2xl shadow-sm border border-dashed border-gray-300 p-16 text-center max-w-2xl mx-auto mt-8">
        <div class="bg-blue-50 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg class="h-10 w-10 text-blue-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
            </svg>
        </div>
        <h3 class="text-lg font-bold text-gray-900">No Accounts Found</h3>
        <p class="mt-2 text-gray-500">You don't have any accounts set up yet. Create your first account to start managing your finances.</p>
        <div class="mt-8">
            <a href="create-account" class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-lg shadow-sm text-white bg-blue-600 hover:bg-blue-700 transition duration-200">
                <svg class="-ml-1 mr-2 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
                Create New Account
            </a>
        </div>
    </div>

    <% } else { %>

    <!-- Accounts Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

        <% for (Account account : accounts) { %>

        <!-- Individual Account Card -->
        <div class="bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-xl transition-all duration-300 overflow-hidden group flex flex-col">

            <!-- Card Header (Color Bar) -->
            <div class="h-2 w-full bg-gradient-to-r from-blue-500 to-indigo-600"></div>

            <div class="p-6 flex-grow">
                <div class="flex items-start justify-between mb-4">
                    <div>
                            <span class="inline-block px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider bg-blue-50 text-blue-700 mb-2">
                                <%= account.getAccountType() %>
                            </span>
                        <h3 class="text-gray-500 text-sm font-medium">Account Number</h3>
                        <p class="text-gray-900 font-bold text-lg font-mono tracking-tight"><%= account.getAccNo() %></p>
                    </div>

                    <div class="p-2 bg-gray-50 rounded-lg text-gray-400 group-hover:text-blue-500 transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path></svg>
                    </div>
                </div>

                <div class="mt-6">
                    <p class="text-sm font-medium text-gray-500 mb-1">Available Balance</p>
                    <div class="flex items-baseline">
                        <span class="text-lg font-semibold text-gray-500 mr-1">LKR</span>
                        <span class="text-3xl font-extrabold text-gray-900 tracking-tight"><%= account.getBalance() %></span>
                    </div>
                </div>
            </div>

            <!-- Card Footer (Action Link) -->
            <div class="bg-gray-50 px-6 py-4 border-t border-gray-100">
                <a href="history?accNo=<%= account.getAccNo() %>" class="text-sm font-semibold text-blue-600 hover:text-blue-800 flex items-center justify-between group-hover:translate-x-1 transition-transform">
                    <span>View Transaction History</span>
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
                </a>
            </div>
        </div>

        <% } %>

    </div>

    <% } %>

</main>

</body>
</html>