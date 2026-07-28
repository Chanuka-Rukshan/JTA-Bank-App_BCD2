<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: K.A.Chanuka Rukshan
  Date: 7/25/2026
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JTA-Bank | Transaction History</title>
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
                    <a href="deposit"
                       class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">Deposit</a>
                    <a href="withdraw"
                       class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">Withdraw</a>
                    <a href="transfer"
                       class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">Transfer</a>
                    <a href="create-account"
                       class="text-gray-300 hover:bg-slate-800 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition">New Account</a>

                    <div class="border-l border-slate-700 h-6 mx-2"></div>

                    <a href="logout"
                       class="text-red-400 hover:bg-red-500 hover:text-white px-3 py-2 rounded-lg text-sm font-medium transition flex items-center gap-2">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                        </svg>
                        Logout
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content Area -->
<main class="flex-grow max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-10 w-full">

    <!-- Header Section with Back Button -->
    <div class="mb-8 flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
            <h1 class="text-3xl font-extrabold text-gray-900 flex items-center gap-3">
                Transaction History
            </h1>
            <p class="mt-2 text-gray-500 font-medium">
                Account Number: <span class="text-blue-600 font-bold font-mono bg-blue-50 px-2 py-1 rounded-md ml-1">${requestScope.accountNo}</span>
            </p>
        </div>

        <!-- Back to Dashboard Button -->
        <a href="dashboard" class="inline-flex items-center px-4 py-2 bg-white border border-gray-300 rounded-lg shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition">
            <svg class="mr-2 -ml-1 w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
            Back to Dashboard
        </a>
    </div>

    <!-- Logic to check if transactions exist -->
    <c:choose>
        <c:when test="${empty requestScope.transactions}">
            <!-- Empty State -->
            <div class="bg-white rounded-2xl shadow-sm border border-dashed border-gray-300 p-16 text-center mt-4">
                <div class="bg-gray-50 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4">
                    <svg class="h-10 w-10 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                </div>
                <h3 class="text-lg font-bold text-gray-900">No Transactions Found</h3>
                <p class="mt-2 text-gray-500">There is no transaction history available for this account yet.</p>
            </div>
        </c:when>

        <c:otherwise>
            <!-- Transaction Table -->
            <div class="bg-white shadow-md rounded-2xl overflow-hidden border border-gray-200">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Date / Time</th>
                            <th scope="col" class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Type</th>
                            <th scope="col" class="px-6 py-4 text-right text-xs font-bold text-gray-500 uppercase tracking-wider">Amount (LKR)</th>
                            <th scope="col" class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Related Account</th>
                            <th scope="col" class="px-6 py-4 text-right text-xs font-bold text-gray-500 uppercase tracking-wider">Balance After (LKR)</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">

                        <c:forEach var="transaction" items="${requestScope.transactions}">
                            <tr class="hover:bg-gray-50 transition-colors duration-150">

                                <!-- Date/Time -->
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600 font-medium">
                                        ${transaction.timestamp}
                                </td>

                                <!-- Type -->
                                <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-50 text-blue-700 uppercase tracking-wide">
                                                ${transaction.type}
                                        </span>
                                </td>

                                <!-- Amount -->
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-right font-bold text-gray-900">
                                    <fmt:formatNumber value="${transaction.amount}" type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="true"/>
                                </td>

                                <!-- Related Account -->
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 font-mono">
                                        ${transaction.relatedAccountNo eq null ? "<span class='text-gray-300'>-</span>" : transaction.relatedAccountNo}
                                </td>

                                <!-- Balance After -->
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-right font-extrabold text-blue-600 bg-gray-50/50">
                                    <fmt:formatNumber value="${transaction.balanceAfter}" type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="true"/>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

</main>

</body>
</html>