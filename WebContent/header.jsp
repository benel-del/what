<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

<header>
<%
	if(userID == null){
%>
            
	<div class="service">
    	<a class="link" href="login.jsp">로그인 </a>
    	|
    	<a class="link" href="register.jsp">회원가입</a>
	</div>
        
<% 
    } else if(userID.equals("admin") == true) {
%>

   	<div class="service">
    	<a class="link" href="logoutAction.jsp">로그아웃 </a>
  		|
    	<a class="link" href="admin_page/admin.jsp">관리자 페이지</a>
	</div>

<% 
    } else {
%>

	<div class="service">
    	<a class="link" href="logoutAction.jsp">로그아웃 </a>
    	|
    	<a class="link" href="mypage.jsp?userID=<%=userID %>"><%=userID %></a>
	</div>
	
<% 
	}
%>
    
    <br>
       	
    <div id="title">
    	<h1><a href="index.jsp">어쩌다 리그</a></h1>
	</div>
</header>