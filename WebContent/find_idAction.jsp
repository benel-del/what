<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/htm; charset=utf-8">

    <title>어쩌다리그</title>
</head>

<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}//로그인 된 사람은 로그인 페이지에 접근할 수 없음
		
		UserDAO userDAO = new UserDAO();
		userID = userDAO.findID(user.getUserName(), user.getUserEmail());
		
		if(userID == null){//계정이 없는 경우
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
</body>
</html>