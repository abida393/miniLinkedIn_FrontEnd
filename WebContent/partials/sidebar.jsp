<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="space-y-4">
    <!-- User Card -->
    <div class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm">
        <div class="h-16 bg-gradient-to-r from-linkedin-blue to-linkedin-darkBlue"></div>
        <div class="px-4 pb-4 -mt-8 flex flex-col items-center">
            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Felix" alt="User" class="w-16 h-16 rounded-full border-2 border-white mb-2 bg-white">
            <h2 class="font-semibold text-lg hover:underline cursor-pointer">John Doe</h2>
            <p class="text-xs text-gray-500 text-center">Software Engineer at TechCorp</p>
        </div>
        <div class="border-t border-gray-100 py-3 space-y-3">
            <div class="px-4 flex justify-between text-xs font-semibold">
                <span class="text-gray-500">Profile viewers</span>
                <span class="text-linkedin-blue">142</span>
            </div>
            <div class="px-4 flex justify-between text-xs font-semibold">
                <span class="text-gray-500">Post impressions</span>
                <span class="text-linkedin-blue">2,854</span>
            </div>
        </div>
        <div class="border-t border-gray-100 p-3 hover:bg-gray-50 cursor-pointer transition-colors group">
            <p class="text-[10px] text-gray-500 uppercase font-bold">Access exclusive tools & insights</p>
            <div class="flex items-center text-xs font-semibold mt-1">
                <i data-lucide="award" class="w-3 h-3 text-yellow-600 mr-1"></i>
                <span class="group-hover:text-linkedin-blue">Try Premium for free</span>
            </div>
        </div>
        <div class="border-t border-gray-100 p-3 hover:bg-gray-50 cursor-pointer transition-colors flex items-center">
            <i data-lucide="bookmark" class="w-4 h-4 text-gray-500 mr-2"></i>
            <span class="text-xs font-semibold">My items</span>
        </div>
    </div>

    <!-- Community Card -->
    <div class="bg-white rounded-xl border border-gray-200 p-3 shadow-sm sticky top-[72px]">
        <div class="flex justify-between items-center mb-3">
            <h3 class="text-xs font-semibold">Recent</h3>
        </div>
        <div class="space-y-3">
            <a href="#" class="flex items-center text-xs text-gray-500 hover:bg-gray-100 p-1 rounded font-semibold">
                <i data-lucide="users" class="w-3 h-3 mr-2"></i>
                #javascript
            </a>
            <a href="#" class="flex items-center text-xs text-gray-500 hover:bg-gray-100 p-1 rounded font-semibold">
                <i data-lucide="calendar" class="w-3 h-3 mr-2"></i>
                Tech Meetup 2024
            </a>
            <a href="#" class="flex items-center text-xs text-linkedin-blue hover:underline font-semibold pt-2 block">
                Groups
            </a>
            <a href="#" class="flex items-center text-xs text-linkedin-blue hover:underline font-semibold block">
                Events
            </a>
        </div>
    </div>
</aside>
