const toggleBtn = document.querySelector(".navbar__toggleBtn");
const menu = document.querySelector(".navbar__menu");
const icon = document.querySelector(".navbar__icon");

function menuClick(){
	menu.classList.toggle("active");
	icon.classList.toggle("active");
}

function init(){
	toggleBtn.addEventListener("click", menuClick);
}

init();

