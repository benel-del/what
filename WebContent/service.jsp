<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

<div class="service">
<%
	if(userID == null){
%>
        <a href="login.jsp">로그인 </a>
    	<a href="register.jsp">회원가입</a>
        
<% 
    } else if(userID.equals("admin") == true) {
%>

    	<a href="logoutAction.jsp">로그아웃 </a>
    	<a href="admin_page/admin.jsp">관리자 페이지</a>

<% 
    } else {
%>

    	<a href="logoutAction.jsp">로그아웃 </a>
    	<a href="mypage.jsp?userID=<%=userID %>"><%=userID %></a>
	
<% 
	}
%>
</div>
