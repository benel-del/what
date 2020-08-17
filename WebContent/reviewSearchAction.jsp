<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="user.UserDAO" %>
<%@ page import="bbsSearch.BbsSearch" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbsSearch" class="bbsSearch.BbsSearch" scope="page" />
<jsp:setProperty name="bbsSearch" property="userID"/>
<jsp:setProperty name="bbsSearch" property="searchType"/>
<jsp:setProperty name="bbsSearch" property="searchWord" />
<jsp:setProperty name="bbsSearch" property="searchOption" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/htm; charset=utf-8">

    <title>어쩌다리그</title>
</head>

<body>
	<%
		if(bbsSearch.getSearchWord() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('검색어를 입력하세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			String userID = null;
			if(session.getAttribute("userID") != null){
				userID = (String) session.getAttribute("userID");
			}
			if(userID == null){
				userID = "방문자";
			}
			
			BbsSearchDAO bbsSearchDAO = new BbsSearchDAO();
			int result = bbsSearchDAO.register(userID, "review", bbsSearch.getSearchOption(), bbsSearch.getSearchWord());
			
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
				script.println("location.href='reviewSearch.jsp'");
				script.println("</script>");
			}
		}

	%>
</body>
</html>