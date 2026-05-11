<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<footer class="py-10 bg-white border-t border-gray-200 mt-10">
    <div class="max-w-6xl mx-auto px-4">
        <div class="flex flex-col md:flex-row justify-between items-start space-y-8 md:space-y-0">
            <div class="space-y-4">
                <div class="flex items-center text-linkedin-blue">
                    <i data-lucide="linkedin" class="w-8 h-8 fill-current"></i>
                    <span class="ml-2 font-bold text-xl">MiniLinkedIn</span>
                </div>
                <p class="text-gray-500 text-sm max-w-xs">Building the world's professional community for sharing knowledge and opportunities.</p>
            </div>
            
            <div class="grid grid-cols-2 md:grid-cols-4 gap-12">
                <div>
                    <h4 class="font-bold text-sm mb-4">General</h4>
                    <ul class="text-sm text-gray-500 space-y-2">
                        <li><a href="#" class="hover:underline">Sign Up</a></li>
                        <li><a href="#" class="hover:underline">Help Center</a></li>
                        <li><a href="#" class="hover:underline">About</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-bold text-sm mb-4">Browse</h4>
                    <ul class="text-sm text-gray-500 space-y-2">
                        <li><a href="#" class="hover:underline">Learning</a></li>
                        <li><a href="#" class="hover:underline">Jobs</a></li>
                        <li><a href="#" class="hover:underline">Salary</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-bold text-sm mb-4">Business</h4>
                    <ul class="text-sm text-gray-500 space-y-2">
                        <li><a href="#" class="hover:underline">Talent</a></li>
                        <li><a href="#" class="hover:underline">Marketing</a></li>
                        <li><a href="#" class="hover:underline">Sales</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-bold text-sm mb-4">Directories</h4>
                    <ul class="text-sm text-gray-500 space-y-2">
                        <li><a href="#" class="hover:underline">Members</a></li>
                        <li><a href="#" class="hover:underline">Jobs</a></li>
                        <li><a href="#" class="hover:underline">Companies</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="mt-12 pt-8 border-t border-gray-100 flex flex-col md:flex-row justify-between items-center text-xs text-gray-500">
            <div class="flex items-center space-x-6 mb-4 md:mb-0">
                <span>© 2024 MiniLinkedIn Corporation</span>
                <a href="#" class="hover:underline">Privacy Policy</a>
                <a href="#" class="hover:underline">User Agreement</a>
                <a href="#" class="hover:underline">Cookie Policy</a>
            </div>
            <div class="flex items-center space-x-4">
                <a href="#" class="hover:text-linkedin-blue transition-colors"><i data-lucide="facebook" class="w-4 h-4"></i></a>
                <a href="#" class="hover:text-linkedin-blue transition-colors"><i data-lucide="twitter" class="w-4 h-4"></i></a>
                <a href="#" class="hover:text-linkedin-blue transition-colors"><i data-lucide="instagram" class="w-4 h-4"></i></a>
            </div>
        </div>
    </div>
</footer>

<script src="<%= request.getContextPath() %>/assets/js/api.js"></script>
<script>
    // Initialize Lucide icons globally if not already done
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>
