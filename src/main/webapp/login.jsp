<%--
  Created by IntelliJ IDEA.
  User: K.A.Chanuka Rukshan
  Date: 7/25/2026
  Time: 10:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login to JTA-Bank</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen font-sans">

<!-- Login Card Container -->
<div class="bg-white p-8 rounded-xl shadow-lg w-full max-w-md border border-gray-200">

    <!-- Header -->
    <div class="text-center mb-6">
        <h1 class="text-3xl font-extrabold text-blue-600 mb-1">JTA-Bank</h1>
        <h2 class="text-gray-500 text-sm font-medium">Sign in to your account</h2>
    </div>

    <!-- Error Message Alert (Invalid login credentials etc.) -->
    <%
        if (request.getAttribute("error") != null) {
    %>
    <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded-md">
        <div class="flex">
            <div class="flex-shrink-0">
                <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                </svg>
            </div>
            <div class="ml-3">
                <p class="text-sm text-red-700 font-semibold">
                    <%= request.getAttribute("error") %>
                </p>
            </div>
        </div>
    </div>
    <%
        }
    %>

    <!-- Login Form -->
    <!-- Action eka "login" dila thiyenne, Servlet eke URL pattern ekata match wenna hadaganna -->
    <form action="login" method="post" class="space-y-5">

        <!-- Email Input -->
        <div>
            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
            <input type="email" id="email" name="email" placeholder="you@example.com" required
                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
        </div>

        <!-- Password Input -->
        <div>
            <div class="flex items-center justify-between mb-1">
                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                <!-- Optional Forgot password link -->
                <a href="#" class="text-xs text-blue-600 hover:text-blue-800 hover:underline">Forgot password?</a>
            </div>
            <input type="password" id="password" name="password" placeholder="••••••••" required
                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
        </div>

        <!-- Submit Button -->
        <button type="submit"
                class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-4 rounded-lg shadow-md hover:shadow-lg transition duration-200 mt-4">
            Sign In
        </button>
    </form>

    <!-- Register Link -->
    <p class="text-center text-sm text-gray-600 mt-6">
        Don't have an account?
        <a href="register.jsp" class="text-blue-600 hover:text-blue-800 font-semibold hover:underline transition">
            Create an account
        </a>
    </p>

</div>

</body>
</html>