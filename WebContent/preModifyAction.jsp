<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="frame.css">
    <title>어쩌다리그</title>
</head>

<body>
    <%
    String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용가능합니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	} //로그인 안 된 사람은 회원 탈퇴 페이지에 접근할 수 없음
	
	if(user.getUserPassword() == null){
	    PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('비밀번호를 입력해주세요.')");
		script.println("history.back()");
	    script.println("</script>");
    }
	else{
	    UserDAO userDAO = new UserDAO();
		int result = userDAO.preModify(userID, user.getUserPassword());
		
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
</body>
</html>