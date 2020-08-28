<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user_join.User_join" %>
<%@ page import="user_join.UserDAO_join" %>
<%@ page import="bbsSearch.BbsSearch" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbsSearch" class="bbsSearch.BbsSearch" scope="page" />
<jsp:setProperty name="bbsSearch" property="userID"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/htm; charset=utf-8">

    <title>어쩌다리그</title>
</head>

<body>
	<%
		int bbsID = 0;	
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		int reset = 0;	
		if(request.getParameter("reset") != null){
			reset = Integer.parseInt(request.getParameter("reset"));
		}
		int btn = 0;	
		if(request.getParameter("btn") != null){
			btn = Integer.parseInt(request.getParameter("btn"));
		}

		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		UserDAO_join userDAO = new UserDAO_join();
		BbsSearchDAO bbsSearchDAO = new BbsSearchDAO();
		PrintWriter script = response.getWriter();
		String url;
		if(btn != 0)	// 확인
			url = "join.jsp?bbsID="+bbsID+"&reset=" + (reset + 1);
		else	// 취소
			url = "join.jsp?bbsID="+bbsID;
		script.println("<script>");
		script.println("opener.location.replace('" + url + "');");
		script.println("close();");
		script.println("</script>");
		

	%>
</body>
</html>