<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import = "util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>

<%
    String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용가능합니다.')");
		script.println("location.replace('login.jsp')");
		script.println("</script>");
	} //로그인 안 된 사람은 회원 탈퇴 페이지에 접근할 수 없음
	else if(userID.equals("admin") == true){
   		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자는 접근 불가.')");
		script.println("history.back()");
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
	    UserDAO userDAO = new UserDAO();
		int result = userDAO.preModify(userID, SHA256.getSHA256(user.getUserPassword()));
		
		if(result == 1){
	    	PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'myinfoModify.jsp'");
			script.println("</script>");
	    }
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	} 	
%>