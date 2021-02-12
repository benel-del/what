/* 메뉴 반응형 토글 */
const toggleBtn = document.querySelector(".navbar__toggleBtn");
const menu = document.querySelector(".navbar__menu");
const icon = document.querySelector(".navbar__icon");
function menuClick(){
	menu.classList.toggle("active");
	icon.classList.toggle("active");
}

/* 사이드바 토글 */
const sideBtn = document.querySelector(".updown-btn");
const sideContent = document.querySelector(".sidebar_content");
const sideBar = document.querySelector(".sidebar")

function sidebarClick(){
	sideContent.classList.toggle("active");	
	sideBar.classList.toggle("active");
}





function init(){
	toggleBtn.addEventListener("click", menuClick);
	sideBtn.addEventListener("click", sidebarClick)
}

init();

