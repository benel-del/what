<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="DB.User" scope="page"/>
<jsp:setProperty name="user" property="userPassword"/>

<%
    String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		//로그인 한 사람만 접근 가능
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용가능합니다.')");
		script.println("location.replace('login.jsp')");
		script.println("</script>");
	}
	
	if(user.getUserPassword() == null){
	    PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('비밀번호를 입력해주세요.')");
		script.println("history.back()");
	    script.println("</script>");
    }
	else{
		int result = new UserDAO().delete(userID, SHA256.getSHA256(user.getUserPassword()));
		
		if(result == 1){
	    	PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원 탈퇴되었습니다.')");
			session.invalidate();
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
	    }
		else if (result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	    else{
	    	PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원 탈퇴에 실패하였습니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
	    }
	}
%>