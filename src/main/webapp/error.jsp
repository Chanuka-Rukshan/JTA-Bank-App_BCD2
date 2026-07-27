<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <title>Error | JTA-Bank</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen font-sans">

<!-- Error Card Container -->
<div class="bg-white p-10 rounded-2xl shadow-xl w-full max-w-lg text-center border border-gray-200">

    <!-- Error Warning Icon -->
    <div class="mx-auto flex items-center justify-center h-24 w-24 rounded-full bg-red-50 mb-6 border-4 border-red-100">
        <svg class="h-12 w-12 text-red-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
        </svg>
    </div>

    <!-- Heading & Description -->
    <h1 class="text-3xl font-extrabold text-gray-900 mb-2">Oops! Something went wrong.</h1>
    <p class="text-gray-500 mb-6">We encountered an unexpected issue while processing your request.</p>

    <!-- Exception Message Details -->
    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200 mb-8 text-left overflow-x-auto shadow-inner">
        <p class="text-xs font-bold text-gray-400 uppercase tracking-wide mb-2">Error Details:</p>
        <code class="text-sm text-red-600 break-words font-mono">
            <%= exception != null && exception.getMessage() != null ? exception.getMessage() : "An unexpected internal server error occurred." %>
        </code>
    </div>

    <!-- Action Button -->
    <button onclick="window.location.href='index.jsp'"
            class="inline-flex items-center justify-center w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3.5 px-4 rounded-xl shadow-md hover:shadow-lg transition-all duration-200">
        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
        </svg>
        Back to Homepage
    </button>

</div>

</body>
</html>