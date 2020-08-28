<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user_join.User_join" %>
<%@ page import="user_join.UserDAO_join" %>
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
		String reset = "0";	
		if(request.getParameter("reset") != null){
			reset = (String) request.getParameter("reset");
		}
		String type = "0";	// select / unselect
		if(request.getParameter("type") != null){
			type = (String) request.getParameter("type");
		}
		String id = "0";	// selected/unselected userID
		if(request.getParameter("id") != null){
			id = (String) request.getParameter("id");
		}
		
		String url = "member_popup.jsp?bbsID=" + bbsID + "&reset=" + reset;
		
		UserDAO_join userDAO = new UserDAO_join();
		PrintWriter script = response.getWriter();
		if(type.equals("1") == true){
			if(userDAO.select(bbsID, id) == -1){
	            script.println("<script>");
	            script.println("alert('데이터베이스 오류')");
	            script.println("history.back()");
	            script.println("</script>");
			}
			else{
				script.println("<script>");
				//script.println("location.href = '" + url + "';");
				script.println("this.location.replace('" + url + "');");
				script.println("</script>");
			}
		}
		else if(type.equals("0") == true){
			if(userDAO.unselect(bbsID, id) == -1){
	            script.println("<script>");
	            script.println("alert('데이터베이스 오류')");
	            script.println("history.back()");
	            script.println("</script>");
			}
			else{
				script.println("<script>");
				script.println("this.location.replace('" + url + "');");
				script.println("</script>");
			}
		}

	%>
</body>
</html>