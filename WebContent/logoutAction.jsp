<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>

<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 되어있지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}//로그인 안한 사람은 로그아웃 페이지에 접근할 수 없음
		
	BbsSearchDAO search = new BbsSearchDAO();
	search.delete_all(userID);
		
  	session.invalidate();
  		
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href = 'index.jsp'");
	script.println("</script>");
 %>