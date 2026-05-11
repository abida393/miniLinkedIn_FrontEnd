<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
    request.setAttribute("pageTitle", "Login | IGA Network");
    String errorMsg = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../partials/header.jsp" />
<!-- Tailwind already loaded in header.jsp — no duplicate -->
<body class="bg-[#0b0e14] min-h-screen">
    <div class="flex flex-col lg:flex-row min-h-screen">
    <!-- Left Section: Branding & Graphic -->
    <div class="hidden lg:flex w-1/2 relative bg-gradient-to-br from-[#1a237e] via-[#0d1117] to-[#0b0e14] p-12 flex-col justify-between">
        <!-- Logo -->
        <div class="flex items-center text-white/90">
            <span class="font-bold text-xl tracking-tight">IGA Network</span>
        </div>

        <!-- Graphic & Text Content -->
        <div class="relative z-10 max-w-lg">
            <h1 class="text-4xl font-bold text-white mb-6 leading-tight">Advancing Research Through Global Connection.</h1>
            <p class="text-lg text-blue-200/70 mb-12">The premier network for academic rigorous collaboration and technological innovation in the digital age.</p>
            
            <div class="grid grid-cols-2 gap-6">
                <!-- Stat Card 1 -->
                <div class="glass-card p-6 border border-white/10 bg-white/5 backdrop-blur-md rounded-2xl">
                    <div class="flex items-center space-x-3 mb-2">
                        <div class="p-2 bg-blue-500/20 rounded-lg text-blue-400">
                            <i data-lucide="microscope" class="w-5 h-5"></i>
                        </div>
                        <span class="text-xs font-bold text-blue-200/50 uppercase tracking-widest">Active Research</span>
                    </div>
                    <div class="text-2xl font-bold text-white">12.4k+</div>
                </div>
                <!-- Stat Card 2 -->
                <div class="glass-card p-6 border border-white/10 bg-white/5 backdrop-blur-md rounded-2xl">
                    <div class="flex items-center space-x-3 mb-2">
                        <div class="p-2 bg-green-500/20 rounded-lg text-green-400">
                            <i data-lucide="globe" class="w-5 h-5"></i>
                        </div>
                        <span class="text-xs font-bold text-green-200/50 uppercase tracking-widest">Network Nodes</span>
                    </div>
                    <div class="text-2xl font-bold text-white">184 Countries</div>
                </div>
            </div>
        </div>

        <!-- Abstract Globe Graphic (Simplified with CSS) -->
        <div class="absolute inset-0 flex items-center justify-center pointer-events-none opacity-30">
            <div class="relative w-[600px] h-[600px]">
                <div class="absolute inset-0 border-[1px] border-blue-500/20 rounded-full animate-pulse"></div>
                <div class="absolute inset-10 border-[1px] border-blue-400/10 rounded-full animate-reverse-spin"></div>
                <div class="absolute inset-20 border-[1px] border-blue-300/5 rounded-full animate-slow-spin"></div>
            </div>
        </div>

        <!-- Footer Text -->
        <div class="text-[10px] text-white/30 uppercase tracking-[0.2em]">
            © 2024 IGA NETWORK • DIGITAL RESEARCH INFRASTRUCTURE
        </div>
    </div>

    <!-- Right Section: Login Form -->
    <div class="w-full lg:w-1/2 bg-[#0b0e14] flex flex-col items-center justify-center p-8 md:p-16 min-h-screen">
        <div class="w-full max-w-md">
            <div class="mb-10">
                <h2 class="text-3xl font-bold text-white mb-3">Welcome back</h2>
                <p class="text-gray-400">Please enter your credentials to access the researcher portal.</p>
            </div>

            <% if (errorMsg != null && !errorMsg.isEmpty()) { %>
            <div class="mb-6 p-4 bg-red-500/10 border border-red-500/30 rounded-xl flex items-start space-x-3">
                <svg class="w-5 h-5 text-red-400 shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                <p class="text-sm text-red-400"><%= errorMsg %></p>
            </div>
            <% } %>



            <form action="<%= request.getContextPath() %>/auth/login" method="POST" class="space-y-6">

                <!-- Email Input -->
                <div class="relative group">
                    <input type="email" name="email" placeholder="Email Address" required
                        class="w-full bg-[#161b22] border border-white/10 rounded-xl px-5 py-4 text-white placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-blue-500/50 transition-all">
                </div>

                <!-- Password Input -->
                <div class="relative group">
                    <input type="password" name="password" id="password" placeholder="Password" required
                        class="w-full bg-[#161b22] border border-white/10 rounded-xl px-5 py-4 text-white placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-blue-500/50 transition-all">
                    <button type="button" onclick="togglePassword()" class="absolute right-5 top-1/2 -translate-y-1/2 text-gray-500 hover:text-white transition-colors">
                        <i data-lucide="eye" class="w-5 h-5"></i>
                    </button>
                </div>



                <div class="flex items-center justify-between">
                    <label class="flex items-center text-sm text-gray-400 cursor-pointer group">
                        <input type="checkbox" name="remember" value="true" class="hidden"
                               onchange="this.nextElementSibling.querySelector('i').classList.toggle('hidden')">
                        <div class="w-5 h-5 border border-white/10 bg-[#161b22] rounded mr-3 flex items-center justify-center group-hover:border-blue-500/50 transition-all">
                            <i data-lucide="check" class="w-3 h-3 text-blue-400 hidden"></i>
                        </div>
                        Remember me
                    </label>
                    <a href="#" onclick="this.nextElementSibling.classList.toggle('hidden'); return false;" class="text-sm text-blue-400 hover:underline">
                        Forgot password?
                    </a>
                    <p class="hidden text-xs text-white/30 mt-2 italic">
                        Please contact your administrator to reset your password.
                    </p>
                </div>

                <!-- Sign In Button -->
                <button type="submit" class="w-full bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white font-bold py-4 rounded-xl transition-all shadow-xl shadow-blue-500/20 active:scale-[0.98]">
                    Sign in
                </button>
            </form>

            <div class="mt-8 text-center text-gray-400">
                Don't have an account? <a href="<%= request.getContextPath() %>/pages/register.jsp" class="text-white font-bold hover:underline">Create account</a>
            </div>

            <!-- Social Logins -->
            <div class="mt-10 space-y-3">
                <button type="button" onclick="showToast && showToast('Social login coming soon', 'info')" class="w-full flex items-center justify-center py-4 bg-[#161b22] border border-white/5 rounded-xl text-gray-300 hover:bg-[#1c2128] transition-all">
                    <svg class="w-5 h-5 mr-3" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"></circle>
                        <path d="M12 8l4 4-4 4"></path>
                    </svg>
                    Continue with Google
                </button>
                <button type="button" onclick="showToast && showToast('Social login coming soon', 'info')" class="w-full flex items-center justify-center py-4 bg-[#161b22] border border-white/5 rounded-xl text-gray-300 hover:bg-[#1c2128] transition-all">
                    <svg class="w-5 h-5 mr-3" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M15 22v-4a4.8 4.8 0 0 0-1-3.5c3 0 6-2 6-5.5.08-1.25-.27-2.48-1-3.5.28-1.15.28-2.35 0-3.5 0 0-1 0-3 1.5-2.64-.5-5.36-.5-8 0C6 2 5 2 5 2c-.3 1.15-.3 2.35 0 3.5A5.403 5.403 0 0 0 4 9c0 3.5 3 5.5 6 5.5-.39.49-.68 1.05-.85 1.65-.17.6-.22 1.23-.15 1.85v4"></path>
                        <path d="M9 18c-4.51 2-5-2-7-2"></path>
                    </svg>
                    Continue with GitHub
                </button>
            </div>
        </div>
    </div>

    <style>
        @keyframes reverse-spin {
            from { transform: rotate(360deg); }
            to { transform: rotate(0deg); }
        }
        .animate-reverse-spin { animation: reverse-spin 20s linear infinite; }
        .animate-slow-spin { animation: spin 30s linear infinite; }
        
        /* Custom Checkbox */
        input:checked + div { border-color: rgb(96 165 250 / 0.5); }
        input:checked + div i { display: block; }
    </style>

    </div> <!-- End flex wrapper -->

    <script>
        try {
            if (typeof lucide !== 'undefined') {
                lucide.createIcons();
            }
        } catch (e) {
            console.warn("Lucide icons could not be initialized:", e);
        }
        
        if (typeof showToast === 'undefined') {
            function showToast(msg, type) {
                const t = document.createElement('div');
                t.className = 'fixed bottom-6 right-6 z-50 px-6 py-3 rounded-xl font-bold text-sm ' +
                    (type === 'error' ? 'bg-red-500' : 'bg-blue-600') + ' text-white shadow-xl animate-bounce-in';
                t.textContent = msg;
                document.body.appendChild(t);
                setTimeout(() => t.remove(), 3000);
            }
        }

        function togglePassword() {
            const pwd = document.getElementById('password');
            pwd.type = pwd.type === 'password' ? 'text' : 'password';
        }


    </script>
</body>
</html>
