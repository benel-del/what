<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="user.UserDAO" %>
<%@ page import="bbsSearch.BbsSearch" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbsSearch" class="bbsSearch.BbsSearch" scope="page" />
<jsp:setProperty name="bbsSearch" property="userID"/>
<jsp:setProperty name="bbsSearch" property="searchWord" />

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
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 접근 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		if(bbsSearch.getSearchWord() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이름을 입력하세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			BbsSearchDAO bbsSearchDAO = new BbsSearchDAO();
			int result = bbsSearchDAO.register(userID, "member", "-", bbsSearch.getSearchWord());
			
			if(result == -1){
				PrintWriter script = response.getWriter();
	            script.println("<script>");
	            script.println("alert('데이터베이스 오류')");
	            script.println("history.back()");
	            script.println("</script>");
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.replace='member_popup.jsp?bbsID=" + bbsID + "';");
				script.println("</script>");
			}
		}

	%>
</body>
</html>