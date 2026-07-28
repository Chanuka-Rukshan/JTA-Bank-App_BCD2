<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="lk.jiat.ee.bank.entity.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.jiat.ee.bank.entity.AccountType" %>
<%--
  Created by IntelliJ IDEA.
  User: K.A.Chanuka Rukshan
  Date: 7/26/2026
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JTA Bank | Deposit Funds</title>
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
                    <a href="dashboard"
                       class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">Dashboard</a>

                    <!-- Active State for Deposit -->
                    <a href="deposit"
                       class="bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-semibold shadow-sm transition">Deposit</a>

                    <a href="withdraw"
                       class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">Withdraw</a>
                    <a href="transfer"
                       class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">Transfer</a>
                    <a href="create-account"
                       class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">New
                        Account</a>

                    <div class="border-l border-slate-700 h-6 mx-2"></div>

                    <a href="logout"
                       class="text-red-400 hover:bg-red-500 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition flex items-center gap-2">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                        </svg>
                        Logout
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<main class="flex-grow max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 w-full">

    <div class="max-w-md mx-auto">

        <!-- Header -->
        <div class="text-center mb-8">
            <h1 class="text-3xl font-extrabold text-gray-900">Deposit Funds</h1>
            <p class="mt-2 text-gray-500 font-medium">Select an account and enter the amount.</p>
        </div>

        <!-- Error Message Alert -->
        <% if (request.getAttribute("error") != null) {%>
        <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded-md shadow-sm">
            <div class="flex">
                <div class="flex-shrink-0">
                    <svg class="h-5 w-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path></svg>
                </div>
                <div class="ml-3">
                    <p class="text-sm text-red-700 font-semibold">
                        <%= request.getAttribute("error")%>
                    </p>
                </div>
            </div>
        </div>
        <%}%>

        <!-- Deposit Form Card -->
        <div class="bg-white p-8 rounded-2xl shadow-lg border border-gray-200">
            <form action="deposit" method="post" class="space-y-6">

                <!-- Account Selection -->
                <div>
                    <label for="accountNo" class="block text-sm font-semibold text-gray-700 mb-2">Select Account</label>
                    <div class="relative">
                        <select name="accountNo" id="accountNo" required
                                class="block w-full pl-4 pr-10 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 rounded-xl appearance-none bg-gray-50 cursor-pointer transition">
                            <option value="" disabled selected>-- Choose an account --</option>

                            <!-- JSTL Loop for Accounts -->
                            <c:forEach var="account" items="${requestScope.accounts}">
                                <option value="${account.accNo}">${account.accNo}</option>
                            </c:forEach>

                        </select>
                        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-4 text-gray-500">
                            <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                        </div>
                    </div>
                </div>

                <!-- Amount Input -->
                <div>
                    <label for="amount" class="block text-sm font-semibold text-gray-700 mb-2">Amount to Deposit</label>
                    <div class="relative rounded-xl shadow-sm">
                        <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4">
                            <span class="text-gray-500 font-semibold">LKR</span>
                        </div>
                        <input type="number" step="0.01" min="0.01" name="amount" id="amount" placeholder="0.00" required
                               class="block w-full pl-14 pr-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition text-lg font-semibold bg-gray-50">
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="pt-2">
                    <button type="submit"
                            class="w-full flex justify-center items-center py-3.5 px-4 border border-transparent rounded-xl shadow-sm text-base font-bold text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-all duration-200">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
                        Deposit Funds
                    </button>
                </div>

            </form>
        </div>
    </div>

</main>

</body>
</html>