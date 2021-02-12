<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
	
<script src="main.js" defer></script>
<script src="https://kit.fontawesome.com/64471f6822.js" crossorigin="anonymous"></script>


	<div class="service">
	<%
		if(userID == null || userID.equals("admin") == false){
        	PrintWriter script = response.getWriter();
     		script.println("<script>");
    		script.println("alert('접근 권한이 없습니다.')");
      		script.println("location.href = '../index.jsp'");
       		script.println("</script>");
        } else{
    %>
            <a href="../logoutAction.jsp">로그아웃 </a>
            <a href="../index.jsp">사용자 페이지</a>
    <%
        }
    %>
	</div>
	
	<nav class="navbar">			
		<div class="navbar__logo">
			<i class="fas fa-table-tennis"></i>
			<a href="admin.jsp">어쩌다리그-관리자페이지</a>
		</div>
		
		<ul class="navbar__menu">
			<li><a href="admin_user.jsp">회원관리</a></li>
            <li><a href="admin_bbs.jsp">게시물관리</a></li>
            <li><a href="admin_join.jsp">모임관리</a></li>
            <li><a href="#">콘텐츠관리</a></li>
            <li><a href="#">통계관리</a></li>
		</ul>
		
		<ul class="navbar__icon">
			<li><a href="#"><i class="fab fa-instagram"></i></a></li>
		</ul>
		
		<a href="#" class="navbar__toggleBtn">
			<i class="fas fa-bars"></i>
		</a>
				
	</nav>
	
	