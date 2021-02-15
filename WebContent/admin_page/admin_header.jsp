<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
	
<script src="../main.js" defer></script>
<script src="https://kit.fontawesome.com/64471f6822.js" crossorigin="anonymous"></script>

	<!-- 로그아웃 버튼 -->
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
		<!-- 로고 & 사이트명 -->		
		<div class="navbar__logo">
			<i class="fas fa-table-tennis"></i>
			<a href="admin.jsp">어쩌다리그-관리자페이지</a>
		</div>
		
		<!-- 메뉴 -->
		<ul class="navbar__menu">
			<li><a href="admin_user.jsp">회원관리</a></li>
            <li><a href="admin_bbsNotice.jsp">게시물관리</a></li>
            <li><a href="admin_join.jsp">모임관리</a></li>
            <!-- <li><a href="#">콘텐츠관리</a></li>
            <li><a href="#">통계관리</a></li>-->
		</ul>
		
		<!-- 인스타 아이콘 -->
		<ul class="navbar__icon">
			<li><a href=""https://www.instagram.com/suddenly_pingpong/"><i class="fab fa-instagram"></i></a></li>
		</ul>
		
		<!-- 반응형 메뉴 토글 버튼 -->
		<a href="#" class="navbar__toggleBtn">
			<i class="fas fa-bars"></i>
		</a>
				
	</nav>
	
	