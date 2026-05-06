<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<% request.setAttribute("pageTitle", "Error | IGA Network"); %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../partials/header.jsp" />
<body class="bg-gray-50 flex flex-col min-h-screen">
    <jsp:include page="../partials/navbar.jsp" />

    <main class="flex-1 flex items-center justify-center p-4">
        <div class="text-center max-w-lg">
            <div class="mb-8 flex justify-center">
                <div class="p-6 bg-red-100 text-red-600 rounded-full">
                    <i data-lucide="alert-triangle" class="w-16 h-16"></i>
                </div>
            </div>
            <h1 class="text-4xl font-bold text-gray-900 mb-4">Something went wrong</h1>
            <p class="text-lg text-gray-600 mb-8">We're sorry, but the page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
            
            <div class="flex flex-col sm:flex-row items-center justify-center gap-4">
                <a href="<%= request.getContextPath() %>/pages/home.jsp" class="w-full sm:w-auto bg-linkedin-blue text-white px-8 py-3 rounded-full font-bold hover:bg-linkedin-darkBlue transition-colors shadow-md">
                    Go to Feed
                </a>
                <button onclick="history.back()" class="w-full sm:w-auto border border-linkedin-blue text-linkedin-blue px-8 py-3 rounded-full font-bold hover:bg-blue-50 transition-colors">
                    Go Back
                </button>
            </div>

            <div class="mt-12 p-6 bg-white rounded-xl border border-gray-200 shadow-sm text-left">
                <h3 class="font-bold text-gray-900 mb-2">Error Details:</h3>
                <p class="text-sm text-gray-500 font-mono bg-gray-50 p-3 rounded border border-gray-100">
                    Status Code: <%= response.getStatus() %><br>
                    Request URI: <%= request.getRequestURI() %>
                </p>
            </div>
        </div>
    </main>

    <jsp:include page="../partials/footer.jsp" />
</body>
</html>
