<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="DB.User" scope="page" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />

<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null){
		//로그인 한 사람 접근 불가
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	}
		
	UserDAO userDAO = new UserDAO();
	userID = userDAO.findID(user.getUserName(), user.getUserEmail());
		
	if(userID == null){
		//계정이 없는 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('계정이 존재하지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원님의 아이디는 "+userID+"입니다.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
%>