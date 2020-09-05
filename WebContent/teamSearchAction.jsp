<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbsSearch.BbsSearch" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>
<jsp:useBean id="bbsSearch" class="bbsSearch.BbsSearch" scope="page" />
<jsp:setProperty name="bbsSearch" property="searchWord" />

	<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	
	BbsSearchDAO bbsSearchDAO = new BbsSearchDAO();
	int result = bbsSearchDAO.register(userID, "team", "-", bbsSearch.getSearchWord());
	
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
		script.println("location.replace('team.jsp?pageNumber=1');");
		script.println("</script>");
	}	
	%>